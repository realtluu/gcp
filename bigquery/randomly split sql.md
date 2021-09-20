```sql
with test as (
    select cast(floor(100000*rand()) as int64) as id
    from unnest(generate_array(1, 30000))
)
,
tab as (
    select id
    , farm_fingerprint(cast(id as string))
    , mod(abs(farm_fingerprint(cast(id as string))), 2) as ab_test_flag
    from test
)
select
    ab_test_flag
    , count(ab_test_flag)
    , count(ab_test_flag)/30000
from tab
group by (ab_test_flag)
```

```sql
select 
    day
    , extract(dayofweek from day) as dayofweek
from unnest(generate_date_array(date('2020-01-01'), current_date(), interval 1 day)) as day
```


```python

```
