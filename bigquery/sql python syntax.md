# Where 
```sql
select name_contract_type
from pd_data
where gender = 'm'
```

```python
pd[pd_data['gender'] == 'm'][['name_contract_type']]
```

# Distinct
```sql
select distinct name_contract_type
from pd_data
```
```python
pd_data['name_contract_type'].unique()
```

# Condition
```sql
select name_income_type, gender, amt_income_total
from pd_data
where gender = 'm' and amt_income_total > 200000.0
```

```python
condition = (pd_data['gender'] == 'm') & (pd_data['amt_income_total'] > 200000.0)
pd_data[condition][['name_income_type', 'gender', 'amt_income_total']]
```

#Order by
```sql
select name_income_type, amt_income_total
from pd_data
order by amt_income_total
```

```python
pd_data[['name_income_type', 'amt_income_total']].sort_values('amt_income_total')
```

# Order by with desc
```sql
select name_income_type, amt_income_total
from pd_data
order by amt_income_total desc
```

```python
pd_data[['name_income_type', 'amt_income_total']].sort_values('amt_income_total', ascending=false)
```

# In
```sql
select *
from pd_data
where sk_id_curr in (1, 2, 3)
```

```python
condition = pd_data['sk_id_curr'].isin([1, 2, 3])
pd_data[condition]
```

# Not in
```sql
select *
from pd_data
where sk_id_curr not in (100002, 100010, 100011)
```

```python
condition = ~pd_data['sk_id_curr'].isin([1, 2, 3])
pd_data[condition]
```

# Group by
```sql
select gender, count(target) as num_target
from pd_data
group by gender
order by num_target
```

```python
pd_data.groupby('gender').agg({'target': 'count'}).sort_values('target')
```

# Get 5 maximum elements
```sql
select amt_income_total
from pd_data
order by num_target desc
limit 5
```

```python
pd_data.nlargest(5, columns='amt_income_total')
```

# Get 5 minimum elements in 10 maximum elements
```sql
select amt_income_total
from pd_data
order by num_target desc
limit 10
offset 5
```

```python
pd_data.nlargest(10, columns='amt_income_total').tail(5)
```

# Get max, min, mean
```sql
select max(amt_income_total), min(amt_income_total), mean(amt_income_total)
from pd_data
```

```python
pd_data.agg({'amt_income_total': ['max', 'min', 'mean']}).transpose()
```

# inner join
```sql
select *
from pd1
inner join pd2
on pd1.sk_id_curr = pd2.sk_id_curr
```

```python
pd1 = pd_data[['sk_id_curr', 'amt_income_total']]
pd2 = pd_data[['sk_id_curr', 'gender', 'flag_own_car']]
pd1.merge(pd2, on='sk_id_curr', how='inner')
```

# Union and union all
```sql
select * from pd1
union all
select * from pd2
```

```python
pd1 = pd_data[['gender', 'flag_own_car']]
pd2 = pd_data[['gender', 'flag_own_car']]

'union all:' pd.concat([pd1, pd2])
'union:' pd.concat([pd1, pd2]).drop_duplicates())
```

# Insert
```sql
insert into table_name (column1, column2, column3, ...)
values (value1, value2, value3, ...)
```

```python
df1 = pd.dataframe({'id': [1, 2], 'name': ['harry potter', 'ron weasley']})
df2 = pd.dataframe({'id': [3], 'name': ['hermione granger']})
df3 = pd.concat([df1, df2]).reset_index(drop=true)
```

# Update
```sql
update table_name
set column1 = value1, column2 = value2, ...
where condition;
```

```python
df3.loc[df3["id"] == 2, "name"] = "Ron"
```

# Delete
```sql
delete from table_name where condition
```

```python
df3.drop(df3[df3["name"] == "Ron"].index, inplace=True)
```


```python

```
