# Optimizing your BigQuery Queries for Performance

# 1. Minimizing I/O

## Be purposeful in SELECT

```sql
SELECT  bike_id, duration
FROM `bigquery-public-data`.london_bicycles.cycle_hire
ORDER BY duration DESC
LIMIT 1
```

```sql
SELECT *
FROM `bigquery-public-data`.london_bicycles.cycle_hire
ORDER BY duration DESC
LIMIT 1
```

## Reduce data being read

```sql
SELECT MIN(start_station_name) AS start_station_name, MIN(end_station_name) AS end_station_name, APPROX_QUANTILES(duration, 10)[OFFSET (5)] AS typical_duration, COUNT(duration) AS num_trips
FROM `bigquery-public-data`.london_bicycles.cycle_hire
WHERE start_station_id != end_station_id
GROUP BY start_station_id, end_station_id
ORDER BY num_trips DESC
LIMIT 10
```

```sql
SELECT start_station_name, end_station_name, APPROX_QUANTILES(duration, 10)[OFFSET(5)] AS typical_duration, COUNT(duration) AS num_trips
FROM `bigquery-public-data`.london_bicycles.cycle_hire
WHERE start_station_name != end_station_name
GROUP BY start_station_name, end_station_name
ORDER BY num_trips DESC
LIMIT 10
```

## Reduce number of expensive computations

```sql
WITH trip_distance AS (
SELECT bike_id, ST_Distance(ST_GeogPoint(s.longitude, s.latitude), ST_GeogPoint(e.longitude, e.latitude)) AS distance
FROM `bigquery-public-data`.london_bicycles.cycle_hire, `bigquery-public-data`.london_bicycles.cycle_stations s, `bigquery-public-data`.london_bicycles.cycle_stations e
WHERE start_station_id = s.id AND end_station_id = e.id )
SELECT bike_id, SUM(distance)/1000 AS total_distance
FROM trip_distance
GROUP BY bike_id
ORDER BY total_distance DESC
LIMIT 5
```

```sql
WITH stations AS (
SELECT s.id AS start_id, e.id AS end_id, ST_Distance(ST_GeogPoint(s.longitude, s.latitude), ST_GeogPoint(e.longitude, e.latitude)) AS distance
FROM `bigquery-public-data`.london_bicycles.cycle_stations s, `bigquery-public-data`.london_bicycles.cycle_stations e ),
trip_distance AS (
SELECT bike_id, distance
FROM `bigquery-public-data`.london_bicycles.cycle_hire, stations
WHERE start_station_id = start_id AND end_station_id = end_id)
SELECT bike_id, SUM(distance)/1000 AS total_distance
FROM trip_distance
GROUP BY bike_id
ORDER BY total_distance DESC
LIMIT 5
```

# 2. Caching results of previous queries

```sql
CREATE OR REPLACE TABLE mydataset.typical_trip AS
SELECT start_station_name, end_station_name, APPROX_QUANTILES(duration, 10)[OFFSET (5)] AS typical_duration, COUNT(duration) AS num_trips
FROM `bigquery-public-data`.london_bicycles.cycle_hire
GROUP BY start_station_name, end_station_name
```

```sql
SELECT EXTRACT (DATE FROM start_date) AS trip_date, APPROX_QUANTILES(duration / typical_duration, 10)[OFFSET(5)] AS ratio,  COUNT(*) AS num_trips_on_day
FROM `bigquery-public-data`.london_bicycles.cycle_hire AS hire
JOIN mydataset.typical_trip AS trip
ON hire.start_station_name = trip.start_station_name
AND hire.end_station_name = trip.end_station_name
AND num_trips > 10
GROUP BY trip_date
HAVING num_trips_on_day > 10
ORDER BY ratio DESC
LIMIT 10
```

```sql
WITH typical_trip AS (
SELECT start_station_name, end_station_name, APPROX_QUANTILES(duration, 10)[OFFSET (5)] AS typical_duration, COUNT(duration) AS num_trips
FROM `bigquery-public-data`.london_bicycles.cycle_hire
GROUP BY start_station_name, end_station_name )
SELECT EXTRACT (DATE FROM start_date) AS trip_date, APPROX_QUANTILES(duration / typical_duration, 10)[OFFSET(5)] AS ratio, COUNT(*) AS num_trips_on_day
FROM `bigquery-public-data`.london_bicycles.cycle_hire AS hire
JOIN typical_trip AS trip ON hire.start_station_name = trip.start_station_name
AND hire.end_station_name = trip.end_station_name
AND num_trips > 10
GROUP BY trip_date
HAVING num_trips_on_day > 10
ORDER BY ratio DESC
LIMIT 10
```

## Accelerate queries with BI Engine

## Denormalization

```sql
CREATE OR REPLACE TABLE mydataset.london_bicycles_denorm AS
SELECT start_station_id, s.latitude AS start_latitude, s.longitude AS start_longitude, end_station_id,  e.latitude AS end_latitude, e.longitude AS end_longitude
FROM `bigquery-public-data`.london_bicycles.cycle_hire AS h
JOIN `bigquery-public-data`.london_bicycles.cycle_stations AS s
ON h.start_station_id = s.id
JOIN `bigquery-public-data`.london_bicycles.cycle_stations AS e
ON h.end_station_id = e.id
```

## Avoid self-joins of large tables

```sql
SELECT name, number AS num_babies
FROM `bigquery-public-data`.usa_names.usa_1910_current
WHERE gender = 'M'
AND year = 2015
AND state = 'MA'
ORDER BY num_babies DESC
LIMIT 5
```

```sql
WITH male_babies AS (
SELECT name, number AS num_babies
FROM `bigquery-public-data`.usa_names.usa_1910_current
WHERE gender = 'M' ),
female_babies AS (
SELECT name, number AS num_babies
FROM `bigquery-public-data`.usa_names.usa_1910_current
WHERE gender = 'F' ),
both_genders AS (
SELECT name, SUM(m.num_babies) + SUM(f.num_babies) AS num_babies, SUM(m.num_babies) / (SUM(m.num_babies) + SUM(f.num_babies)) AS frac_male
FROM male_babies AS m
JOIN female_babies AS f
USING (name)
GROUP BY name )
SELECT *
FROM both_genders
WHERE frac_male BETWEEN 0.3 AND 0.7
ORDER BY num_babies DESC
LIMIT 5
```

```sql
WITH
all_babies AS (
SELECT name, SUM(IF (gender = 'M', number, 0)) AS male_babies, SUM( IF (gender = 'F', number, 0)) AS female_babies
FROM `bigquery-public-data.usa_names.usa_1910_current`
GROUP BY name ),
both_genders AS (
SELECT name, (male_babies + female_babies) AS num_babies, SAFE_DIVIDE(male_babies, male_babies + female_babies) AS frac_male
FROM all_babies
WHERE male_babies > 0 AND female_babies > 0 )
SELECT *
FROM both_genders
WHERE frac_male BETWEEN 0.3 AND 0.7
ORDER BY num_babies DESC
LIMIT 5
```

## Reduce data being joined

```sql
WITH
all_names AS (
SELECT name, gender, SUM(number) AS num_babies
FROM `bigquery-public-data`.usa_names.usa_1910_current
GROUP BY name, gender ),
male_names AS (
SELECT name, num_babies
FROM all_names
WHERE gender = 'M' ),
female_names AS (
SELECT name, num_babies
FROM all_names
WHERE gender = 'F' ),
ratio AS (
SELECT  name, (f.num_babies + m.num_babies) AS num_babies, m.num_babies / (f.num_babies + m.num_babies) AS frac_male
FROM male_names AS m
JOIN female_names AS f
USING (name) )
SELECT *
FROM ratio
WHERE frac_male BETWEEN 0.3 AND 0.7
ORDER BY num_babies DESC
LIMIT 5

```

3. Performing efficient joins
4. Avoid over-whelming single workers
5. Using approximate aggregation functions

