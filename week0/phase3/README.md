# Phase 3 – ETL Pipeline using PySpark

## 🔹 Objective
In this phase, the goal is to move from writing isolated queries to thinking like a data engineer. This phase focuses on data ingestion, cleaning, transformation, and pipeline building using a structured ETL (Extract → Transform → Load) workflow.

---

## 🔹 Problem Summary
We were given multiple sample datasets (customers.csv, sales.csv, products.json, titanic.parquet).
The task was to:
- Ingest data from multiple file formats (CSV, JSON, Parquet)
- Inspect schema and identify data quality issues
- Clean data by handling nulls and filtering invalid records
- Build step-by-step transformation pipelines
- Generate business insights: daily sales, city-wise revenue, repeat customers, top spenders

👉 Detailed problem statement is available in: `phase3_problem_statement.pdf`

---

## 🔹 Approach
The entire phase follows the ETL pattern:

**Extract:**
- Read customers.csv, sales.csv using `spark.read.csv()`
- Read products.json using `spark.read.json()` with `multiLine=true`
- Read titanic.parquet using `spark.read.parquet()`
- Inspected schema using `printSchema()` and `show()`

**Transform:**
- Identified null values using `F.count(F.when(F.col().isNull()))`
- Removed nulls using `dropna()` on key columns
- Cast columns to correct types using `withColumn()` + `cast()`
- Filtered invalid records where `total_amount <= 0`
- Joined customers and sales on customer_id
- Applied aggregations for business insights
- Used Window functions for ranking within partitions

**Load:**
- Displayed final reporting table as the output

---

## 🔹 Key Transformations Used
- `spark.read.format().option().load()` → to read CSV, JSON, Parquet files
- `printSchema()` → to inspect column names and data types
- `dropna()` → to remove rows with null values in key columns
- `withColumn()` + `cast()` → to fix incorrect data types
- `filter()` → to remove invalid records
- `join()` → to combine customers and sales tables
- `groupBy()` + `agg()` → to calculate sum, count aggregations
- `Window.partitionBy().orderBy()` + `F.rank()` → to find top customer per city
- `F.round()` → to round decimal values

---

## 🔹 Output / Results
- Schema inspection for all 4 file formats
- Null value counts per column
- Cleaned and filtered datasets
- Daily sales revenue and order count
- City-wise total revenue
- Repeat customers with more than 2 orders
- Highest spending customer in each city
- Final reporting table with customer, city, total spend, order count

Screenshots of outputs are available in the `Outputs/` folder.

---

## 🔹 Data Engineering Considerations
- Cleaned data BEFORE joining to avoid propagating nulls into aggregations
- Filtered invalid records BEFORE aggregation to ensure correct metrics
- Cast all numeric columns immediately after CSV load since CSV reads everything as string
- Reused cleaned DataFrames (`customers_clean`, `sales_clean`) across all pipelines
- Used Window functions instead of subqueries for ranking — more efficient in Spark

---

## 🔹 Challenges Faced
- CSV files load all columns as string by default — had to identify and cast numeric columns manually
- Understanding Window functions and `partitionBy()` for ranking within groups
- Chaining multiple transformations in the correct order (clean → filter → join → aggregate)
- Reading JSON with `multiLine=true` option — not required for regular JSON files

---

## 🔹 Learnings
- How to read and inspect multiple file formats in PySpark (CSV, JSON, Parquet)
- Importance of cleaning data before any transformation or join
- How to detect and handle null values programmatically
- How to build a reusable ETL pipeline with structured steps
- How Window functions work for ranking and partitioning data
- The correct order of operations: clean → filter → join → aggregate

---

## 🔹 Files in this Folder
- `phase3_problem_statement.pdf` → Problem description
- `solution.py` → PySpark ETL pipeline implementation with comments
- `queries.sql` → SQL equivalent of all pipeline exercises
- `Outputs/` → Screenshots of query results