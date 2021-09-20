```sql
SELECT fhoffa.x.radians(180) is_this_pi;
CREATE OR REPLACE FUNCTION `x.radians`(x ANY TYPE) AS (ACOS(-1) * x / 180);

SELECT fhoffa.x.int(1) int1
  , fhoffa.x.int(2.5) int2
  , fhoffa.x.int('7') int3
  , fhoffa.x.int('7.8') int4;

CREATE OR REPLACE FUNCTION `x.int`(v ANY TYPE) AS (CAST(FLOOR(CAST(v AS FLOAT64)) AS INT64));

SELECT fhoffa.x.random_int(0,10) randint, COUNT(*) c
FROM UNNEST(GENERATE_ARRAY(1,1000))
GROUP BY 1
ORDER BY 1;

CREATE OR REPLACE FUNCTION `x.random_int`(min ANY TYPE, max ANY TYPE) AS (fhoffa.x.int(min + RAND()*(max-min)));

SELECT fhoffa.x.median([1,1,1,2,3,4,5,100,1000]) median_1
  , fhoffa.x.median([1,2,3]) median_2
  , fhoffa.x.median([1,2,3,4]) median_3;

CREATE OR REPLACE FUNCTION `fhoffa.x.median`(arr ANY TYPE) AS ((
  SELECT IF (
MOD(ARRAY_LENGTH(arr), 2) = 0,
(arr[OFFSET(DIV(ARRAY_LENGTH(arr), 2) - 1)] + arr[OFFSET(DIV(ARRAY_LENGTH(arr), 2))]) / 2,
arr[OFFSET(DIV(ARRAY_LENGTH(arr), 2))]
  )
  FROM (SELECT ARRAY_AGG(x ORDER BY x) AS arr FROM UNNEST(arr) AS x)
));

SELECT fhoffa.x.parse_number('one hundred fifty seven')
  , fhoffa.x.parse_number('three point 5')
  , fhoffa.x.parse_number('2 hundred')
  , fhoffa.x.parse_number('minus 8')
  , fhoffa.x.parse_number('5 million 3 hundred 25 point zero 1');

CREATE OR REPLACE FUNCTION x.nlp_compromise_number(str STRING)
RETURNS NUMERIC LANGUAGE js AS '''
   return nlp(str).values(0).toNumber().out()
'''
OPTIONS (
  library="gs://fh-bigquery/js/compromise.min.11.14.0.js");

SELECT fhoffa.x.nlp_compromise_people(
  "hello, I'm Felipe Hoffa and I work with Elliott Brossard - who thinks Jordan Tigani will like this post?"
) names;

SELECT name, COUNT(*) c
FROM (
  SELECT fhoffa.x.nlp_compromise_people(title) names
  FROM `fh-bigquery.reddit_posts.2019_02`
  WHERE subreddit = 'movies'
), UNNEST(names) name
WHERE name LIKE '% %'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

CREATE FUNCTION x.nlp_compromise_people(str STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
   return nlp(str).people().out('topk').map(x=>x.normal)
'''
OPTIONS (
  library="gs://fh-bigquery/js/compromise.min.11.14.0.js");



SELECT SUM(y), COUNT(*) FROM
js(
  (SELECT FLOOR(RAND()*100000) group, NEST(requests) as x FROM 
(SELECT requests FROM [fh-bigquery:wikipedia.pagecounts_201205] ) 
   GROUP BY group),
  group, x,
  "[{name:'y', type: 'float'}]",
  "function(row, emit) {
const x = row.x;
const memory = new WebAssembly.Memory({ initial: 256, maximum: 256 });
const env = {
   'abortStackOverflow': _ => { throw new Error('overflow'); },
   'table': new WebAssembly.Table({ initial: 0, maximum: 0, element: 'anyfunc' }),
   'tableBase': 0,
   'memory': memory,
   'memoryBase': 1024,
   'STACKTOP': 0,
   'STACK_MAX': memory.buffer.byteLength,
};
const importObject = { env };
var bytes = new Uint8Array([0, 97, 115, 109, 1, 0, 0, 0, 1, 139, 128, 128, 128, 0, 2, 96, 1, 127, 0, 96, 2, 127, 127, 1, 127, 2, 254, 128, 128, 128, 0, 7, 3, 101, 110, 118, 8, 83, 84, 65, 67, 75, 84, 79, 80, 3, 127, 0, 3, 101, 110, 118, 9, 83, 84, 65, 67, 75, 95, 77, 65, 88, 3, 127, 0, 3, 101, 110, 118, 18, 97, 98, 111, 114, 116, 83, 116, 97, 99, 107, 79, 118, 101, 114, 102, 108, 111, 119, 0, 0, 3, 101, 110, 118, 6, 109, 101, 109, 111, 114, 121, 2, 1, 128, 2, 128, 2, 3, 101, 110, 118, 5, 116, 97, 98, 108, 101, 1, 112, 1, 0, 0, 3, 101, 110, 118, 10, 109, 101, 109, 111, 114, 121, 66, 97, 115, 101, 3, 127, 0, 3, 101, 110, 118, 9, 116, 97, 98, 108, 101, 66, 97, 115, 101, 3, 127, 0, 3, 130, 128, 128, 128, 0, 1, 1, 6, 147, 128, 128, 128, 0, 3, 127, 1, 35, 0, 11, 127, 1, 35, 1, 11, 125, 1, 67, 0, 0, 0, 0, 11, 7, 136, 128, 128, 128, 0, 1, 4, 95, 115, 117, 109, 0, 1, 9, 129, 128, 128, 128, 0, 0, 10, 196, 128, 128, 128, 0, 1, 190, 128, 128, 128, 0, 1, 7, 127, 2, 64, 35, 4, 33, 8, 35, 4, 65, 16, 106, 36, 4, 35, 4, 35, 5, 78, 4, 64, 65, 16, 16, 0, 11, 32, 0, 33, 2, 32, 1, 33, 3, 32, 2, 33, 4, 32, 3, 33, 5, 32, 4, 32, 5, 106, 33, 6, 32, 8, 36, 4, 32, 6, 15, 0, 11, 0, 11,])
WebAssembly.instantiate(bytes, importObject).then(wa => {
   const exports = wa.instance.exports;
   var sum = exports._sum;
   for (var i = 0, len = x.length; i < len; i++) {
emit({y: sum(x[0], x[0])});
   }
});
  }
")
```


```python

```
