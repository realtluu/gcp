# Building Resilient Streaming Analytics Systems on GCP


### Introduction to Processing Streaming Data

1.Question 1. Dataflow offers the following that makes it easy to create resilient streaming pipelines when working with unbounded data:
(Select all 2 correct responses)
- Ability to flexibly reason about time
- Controls to ensure correctness
- Global message bus to buffer messages
- SQL support to query in-process results

2.Question 2. Match the GCP product with its role when designing streaming systems

|Product|Role|
|--|--|
|__ 1. Pub/Sub|A. Controls to handle late-arriving and out-of-order data|
|__ 2. Dataflow|B. Global message queue|
|__ 3. BigQuery|C. Latency in the order of milliseconds when querying against overwhelming volume|
|__ 4. Bigtable|D. Query data as it arrives from streaming pipelines|

- ABDC
- BADC
- CADB
- DABC

### Serverless Messaging with Cloud Pub/Sub

1.Question 1. Which of the following about Cloud Pub/Sub is NOT true?

- Pub/Sub simplifies systems by removing the need for every component to speak to every component
- Pub/Sub connects applications and services through a messaging infrastructure
- *Pub/Sub stores your messages indefinitely until you request it*

2.Question 2. True or False? Cloud Pub/Sub guarantees that messages delivered are in the order they were received

- True
- *False*

3.Question 3. Which of the following about Cloud Pub/Sub topics and subscriptions are true? (Select all 2 correct responses)

- *1 or more publisher(s) can write to the same topic*
- *1 or more subscriber(s) can request from the same subscription*
- Each topic will deliver ALL messages for a topic for each subscriber
- Each topic MUST have at least 1 subscription

4.Question 4. Which of the following delivery methods is ideal for subscribers needing close to real time performance?

- Pull Delivery
- *Push Delivery*

### Cloud Dataflow Streaming Features

1.Question 1
The Dataflow models provides constructs that map to the four questions that are relevant in any out-of-order data processing pipeline:

|Questions|Constructs|
|--|--|
|__ 1. What results are calculated?|A. Answered via Event-time windowing|
|__ 2. Where in event time are results calculated?|B. Answered via transformations|
|__ 3. When in processing time are results materialized?|C. Answered via Accumulation modes|
|__ 4. How do refinements of results relate?|D. Answered via Watermarks, triggers, and allowed lateness.|

- ADCB
- *BADC*
- CADB
- DBAC

### Streaming Analytics and Dashboards

1.Question 1. Which of the following is true for Data Studio ?
- Data Studio can only ingest files stored in Cloud Storage buckets.
- *Data Studio supports data ingest thought multiple connectors.*
- Data Studio is part of Dataflow and requires a streaming pipeline for data ingest.
- Data Studio is part of Google BigQuery and requires data to already exist in tables.

2.Question 2. Data Studio can issue queries to BigQuery
- *True*
- False

### High-Throughput Streaming with Cloud Bigtable

1.Question 1. Which of the following are true about Cloud Bigtable? (Mark all 3 correct responses)
- *Offers very low-latency in the order of milliseconds*
- *Ideal for >1TB data*
- *Great for time-series data*
- Support for SQL

2.Question 2. True or False? Cloud Bigtable learns access patterns and attempts to distribute reads and storage across nodes evenly
- *True*
- False

3.Question 3. Which of the following can help improve performance of Bigtable? (Select all 3 correct responses)
- *Change schema to minimize data skew*
- *Clients and Bigtable are in same zone*
- Use HDD instead of SDD
- *Add more nodes*

### BigQuery advanced functionality and performance considerations

1.Question 1. Which of the following practices help optimize BigQuery queries?
- *Put the largest table on the left*
- *Filter early and often*
- Use COUNT(DISTINCT) instead of APPROX_COUNT_DISTINCT
- *Avoid using unnecessary columns*

