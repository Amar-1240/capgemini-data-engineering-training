# Phase 3A – Data Quality and Cleaning Challenge

## 🔹 Objective
In this phase, the goal is to develop skills in identifying and resolving data quality issues — a critical responsibility for any data engineer. This phase focuses on assessing data quality, handling null values, removing duplicates, standardising formats, detecting outliers, and producing before/after quality reports using a structured **inspect → clean → validate** ETL workflow.

---

## 🔹 Problem Summary
We were given multiple sample datasets (customers.csv, sales.csv, products.json, titanic.parquet) that contain realistic data quality problems.
The task was to:
- Inspect datasets to detect nulls, wrong data types, and duplicate records
- Handle null values using appropriate strategies (drop, fill, coalesce)
- Remove duplicate records using exact and subset-based deduplication
- Standardise data formats (trim whitespace, fix phone/email formats, cast types)
- Detect and flag outliers using statistical methods (percentiles, IQR)
- Generate a quality report comparing metrics before and after cleaning

👉 Detailed problem statement is available in: `phase3A_problem_statement.pdf`

---

## 🔹 Approach
The entire phase follows the **inspect → clean → validate** pattern:

**Inspect:**
- Loaded datasets from SparkPlayground sample files
- Used `printSchema()` to review column names and data types
- Counted null values per column using `F.count(F.when(F.col().isNull(), 1))`
- Checked for duplicate records using `count()` vs `distinct().count()`

**Clean:**
- Dropped rows with nulls in critical columns using `dropna(subset=[...])`
- Filled missing values with defaults using `fillna()` and `coalesce()`
- Removed duplicate rows using `dropDuplicates()` and `dropDuplicates(subset=[...])`
- Trimmed whitespace and fixed formatting using `trim()` and `regexp_replace()`
- Cast columns to correct types using `withColumn()` + `cast()`

**Validate:**
- Re-checked null counts and record counts after cleaning
- Detected outliers using percentile-based bounds (IQR method)
- Generated a quality report with before/after row counts, null counts, and duplicate counts

---

## 🔹 Key Transformations Used
- `spark.read.format().option().load()` → to read CSV, JSON, Parquet files
- `printSchema()` → to inspect column names and data types
- `F.count(F.when(F.col().isNull(), 1))` → to count nulls per column
- `dropna()` → to drop rows with null values in key columns
- `fillna()` → to replace nulls with default values
- `coalesce()` → to pick the first non-null value from multiple columns
- `dropDuplicates()` → to remove exact and subset-based duplicate rows
- `trim()` → to strip leading/trailing whitespace from string columns
- `regexp_replace()` → to fix or remove unwanted characters in string fields
- `cast()` → to convert columns to the correct data type
- `approxQuantile()` → to compute percentile values for outlier detection
- `F.when().otherwise()` → to flag outlier records

---

## 🔹 Output / Results
- Schema inspection for all datasets
- Null value counts per column (before cleaning)
- Duplicate record counts (before cleaning)
- Cleaned datasets with nulls handled and duplicates removed
- Standardised string columns (trimmed, formatted)
- Outlier-flagged records in numeric columns
- Quality report table: before vs after row count, null count, duplicate count

Screenshots of outputs are available in the `Outputs/` folder.

---

## 🔹 Data Engineering Considerations
- Always inspect data BEFORE cleaning to understand the scope of quality issues
- Choose null-handling strategy based on column importance: drop for key columns, fill for optional columns
- Use `dropDuplicates(subset=[...])` when only specific columns define uniqueness (e.g., customer_id)
- Cast numeric columns immediately after CSV load since CSV reads all columns as strings by default
- Document quality metrics before and after cleaning to demonstrate the impact of the cleaning pipeline
- Use IQR-based outlier detection rather than fixed thresholds for statistical robustness

---

## 🔹 Challenges Faced
- Identifying which columns require drop vs fill null strategy — needed domain knowledge
- `dropDuplicates()` with no subset removes only exact duplicates; subset-based deduplication is often more appropriate
- CSV files load all columns as string by default — had to identify and cast numeric columns manually
- `approxQuantile()` returns a list, not a scalar — had to index into the result correctly
- Chaining cleaning steps in the right order: inspect → handle nulls → remove duplicates → fix formats → detect outliers

---

## 🔹 Learnings
- How to systematically assess data quality across multiple dimensions (completeness, uniqueness, consistency)
- The difference between `dropna()`, `fillna()`, and `coalesce()` and when to use each
- How `dropDuplicates()` works with and without a subset of columns
- How to use `regexp_replace()` and `trim()` for data format standardisation
- How to detect outliers using the IQR method in PySpark with `approxQuantile()`
- The importance of generating quality reports to measure the effectiveness of a cleaning pipeline
- How to build a reusable, structured data cleaning pipeline following the inspect → clean → validate pattern

---

## 🔹 Files in this Folder
- `phase3A_problem_statement.pdf` → Problem description
- `solution.py` → PySpark data quality and cleaning pipeline with comments
- `queries.sql` → SQL equivalent of all data quality and cleaning exercises
- `Outputs/` → Screenshots of query results
