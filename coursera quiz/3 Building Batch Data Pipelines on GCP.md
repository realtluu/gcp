# Building Batch Data Pipelines on GCP

### EL, ELT, ETL:

1. Which of the following is the ideal use case for Extract and Load (EL)

- When the raw data needs to be quality-controlled, transformed, or enriched before being loaded into BigQuery
- When the data loading has to happen continuously
- *Scheduled periodic loads of log files (e.g. once a day)*
- When you want to integrate with continuous integration / continuous delivery (CI/CD) systems and perform unit testing on all components.

### Executing Spark on Cloud Dataproc

1.Question 1. Which of the following statements are true about Cloud Dataproc? (Select all 2 correct answers)

- @Lets you run Spark and Hadoop clusters with minimal administration
- Streamlined API for Spark and Hadoop programming
- *Helps you create job-specific clusters without HDFS*

2.Question 2. Match each of the terms with what they do when setting up clusters in Cloud Dataproc:

| | | 
|---|---|
|Term                       |Definition                                                       |
|__1. Zone	                |A. Costs less but may not be available always                    |
|__2. Standard Cluster mode	|B. Determines the Google data center where compute nodes will be |
|__3. Preemptible           |C. Provides 1 master and N workers                               |


- A, B, C
- *B, C, A*
- C, A, B
- C, B, A

3.Question 3. Cloud Dataproc provides the ability for Spark programs to separate compute & storage by:

- *Reading and writing data directory from/to Cloud Storage*
- Pre-copying data from Cloud Storage to persistent disk on cluster startup
- Mirroring data on both Cloud Storage and HDFS
- Setting individual zones for compute and storage

### Cloud Data Fusion and Cloud Composer

1. Question 1. Cloud Data Fusion is the ideal solution when you need


- low-latency and high throughput processing of streaming data
- *to build visual pipelines*
- a data warehousing solution
- to resuse spark pipelines

### Data Processing with Cloud Dataflow

1.Question 1. Which of the following statements are true? (Select all 2 correct responses)

- *Dataflow executes Apache Beam pipelines*
- Side-inputs in Dataflow are a way to export data from one pipeline to share with another pipeline
- Map operations in a MapReduce can be performed by Combine transforms in Dataflow
- *Dataflow transforms support both batch and streaming pipelines*

2.Question 2. Match each of the Dataflow terms with what they do in the life of a dataflow job:

| | | 
|---|---|
|Term|Definition|
|__ 1. Transform|A. Output endpoint for your pipeline|
|__ 2. PCollection|B. A data processing operation or step in your pipeline|
|__ 3. Sink|C. A set of data in your pipeline|

- *B, C, A*
- C, B, A
- A, C, B
- B, A, C