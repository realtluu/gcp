# Google Cloud Platform Big Data and Machine Learning Fundamentals

### Module Review 1

1.Question 1. What are the common big data challenges that you will be building solutions for in this course? (check all that apply)

- *Migrating existing on-premise workloads to the cloud*
- *Analyzing large datasets at scale*
- Building containerized applications for web development
- *Building streaming data pipelines*
- *Applying machine learning to your datasets*

2.Question 2. You have a large enterprise that will likely have many teams using their own Google Cloud Platform projects and resources. What should you be sure to have to help manage and administer these resources? (check all that apply)

- *A defined Organization*
- Folders for teams and/or products
- *A defined access control policy with Cloud IAM*
- *A Kubernetes or Hadoop cluster for each project*

3.Question 3. Which of the following is NOT one of the advantages of Google Cloud security

- *Google Cloud will automatically manage and curate your content and access policies to be safe for the public*
- Google Cloud will secure the physical hardware that is running your applications and infrastructure
- Google Cloud has tools like Cloud IAM that help you administer and set company-wide security policies
- Google Cloud will manage audit logging of access and use of resources in your account

4.Question 4. If you don't have a large dataset of your own but still want to practice writing queries and building pipelines on Google Cloud Platform, what should you do?

- *Practice with the datasets in the Google Cloud Public Datasets program*
- *Find other public datasets online and upload them into BigQuery*
- *Work to create your own dataset and then upload it into BigQuery for analysis*

5.Question 5. As you saw in the demo, Compute Engine nodes on GCP are:

- Pre-installed with all the software packages you might ever need.
- *Allocated on demand, and you pay for the time that they are up.*
- One of ~50 choices in terms of CPU and memory
- Expensive to create and teardown

### Module Review 2

1.Question 1. Complete the following: You should feed your machine learning model your _______ and not your _______. It will learn those for itself!

- rules, data
- *data, rules*
- if/then statements, data

2.Question 2. True or False: Cloud SQL is a big data analytics warehouse

- True
- *False*

3.Question 3. True or False: If you are migrating your Hadoop workload to the cloud, you must first rewrite all your Spark jobs to be compliant with the cloud.

- True
- False

4.Question 4. You are thinking about migrating your Hadoop workloads to the cloud and you have a few workloads that are fault-tolerant (they can handle interruptions of individual VMs gracefully). What are some architecture considerations you should explore in the cloud? Choose all that apply

- *Use PVMs or Preemptible Virtual Machines*
- *Migrate your storage from on-cluster HDFS to off-cluster Google Cloud Storage (GCS)*
- Consider having multiple Cloud Dataproc instances for each priority workload and then turning them down when not in use*

5.Question 5. Google Cloud Storage is a good option for storing data that: (Select the 2 correct options below).

- Is ingested in real-time from sensors and other devices and supports SQL-based queries
- *May be required to be read at some later time (i.e. load a CSV file into BigQuery)*
- Will be accessed frequently and updated constantly with new transactions from a front-end and needs to be stored in a relational database
- *May be imported from a bucket into a Hadoop cluster for analysis*

6.Question 6. Relational databases are a good choice when you need:

- *Transactional updates on relatively small datasets*
- Fast queries on terabytes of data
- Streaming, high-throughput writes
- Aggregations on unstructured data

7.Question 7. Cloud SQL and Cloud Dataproc offer familiar tools (MySQL and Hadoop/Pig/Hive/Spark). What is the value-add provided by Google Cloud Platform? (Select the 2 correct options below )

- It’s the same API, but Google implements it better
- *Fully-managed versions of the software offer no-ops*
- Google-proprietary extensions and bug fixes to MySQL, Hadoop, and so on
- *Running it on Google infrastructure offers reliability and cost savings*

### Module Review 3

1.Question 1. Which of the below are the core services that make up BigQuery? (choose the correct 2)

- *Query service*
- *Storage service*
- Data Optimization service
- Machine Learning service

2.Question 2. You want to know how many rows are in the BigQuery Public Dataset on San Francisco Bike Shares. What could you do? Run the below query:

- *SELECT COUNT(*) AS total_trips FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`*
- *In the BigQuery Web UI, find the table and click the details tab and view the rows.*
- SELECT SUM(*) AS total_trips FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`

3.Question 3. True or False: You can query a Google Spreadsheet directly from BigQuery without loading it in first.

- *True*
- False

4.Question 4. You have a taxi service data schema that has three columns: ride_id, ride_timestamp, ride_status
You want to use BigQuery for reporting but you don't want to split your table into multiple sub-tables. What native features of BigQuery data types should you explore? (check all that apply). 

- *Consider making ride_timestamp an ARRAY of timestamp values so each ride_id row in your table could still be unique and easy to report off of.*
- *Consider adding lat / long geographic data points as new columns and using GIS Functions to quickly plot the distances your fleet has travelled.*
- Consider renaming the ride_id column to 'label' so you can use it in a BigQuery ML model to predict the ride_id of the next ride.

5.Question 5. Complete the following
In ML, a row of data is called a(n) ________ and a column of data is called a(n) _______. We mark one or more columns as ________ which we know for historical data and are trying to predict for future data.

- labels, instance or observation, feature
- instance or observation, labels, feature
- *instance or observation, feature, labels*

### Module Review 4 

1.Question 1. Relational databases are a good choice when you need:

- Streaming, high-throughput writes
- Fast queries on terabytes of data
- Aggregations on unstructured data
- *Transactional updates on relatively small datasets*

2.Question 2. Cloud SQL and Cloud Dataproc offer familiar tools (MySQL and Hadoop/Pig/Hive/Spark). What is the value-add provided by Google Cloud Platform? (Select all of the correct options)

- It’s the same API, but Google implements it better
- Google-proprietary extensions and bug fixes to MySQL, Hadoop, and so on
- *Fully-managed versions of the software offer no-ops*
- *Running it on Google infrastructure offers reliability and cost savings*

### Module Review 5

1.Question 1. If you have an image classification task for identifying whether a car is present in a photo or not, which solution should you try first?

- Try AutoML Vision first
- Try a custom model in TensorFlow first
- *Try the Cloud Vision API first*
- Try a custom model in BQML first