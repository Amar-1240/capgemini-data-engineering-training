# 👨‍💻 Capgemini Data Engineering Training

This repository contains my work for Capgemini Data Engineering Training. The focus of this training is to learn SQL and PySpark concepts and apply them to build data pipelines and perform basic analytics.

---
## 🗂️ Repository Structure

```
capgemini-data-engineering-training/
│
├── README.md
├── mini-project/                  → Upcoming work
│
├── week0/                         → SQL & PySpark Foundations
│   ├── phase0/                    → Learning materials (PDFs)
│   ├── phase1/                    → Filtering & Selection
│   ├── phase2/                    → Joins & Aggregations
│   ├── phase3/                    → ETL Pipeline
│   ├── phase3A/                   → Data Quality & Cleaning
│   ├── phase4/                    → Business Pipeline & Analytics
│   ├── phase4A/                   → Bucketing & Segmentation
│   ├── phase5/                    → Advanced Transformations (Pending)
│   └── phase6/                    → Capstone Pipeline (Pending)
│
├── week1/                         → Real-world datasets practice
│   ├── Day1/
│   ├── Day2_Olist/
│   ├── Day2_BFSI/
│   ├── Day3_Olist/
│   ├── Day3_BFSI/
│   ├── Day4_Olist/
│   ├── Day4_BFSI/
│   ├── Day5_Olist/
│   └── Day5_BFSI/
│
├── week2/                         → Upcoming work
└── week3/                         → Upcoming work
```

Each phase folder contains:

* solution.py (PySpark implementation)
* queries.sql (SQL queries)
* phaseX_problem_statement.pdf
* Outputs/ (screenshots)
* README.md



---

## 📊 Phase Details

---

### 🔹 Phase 1 – Filtering & Selection

**Objective**
To understand basic SQL queries and equivalent PySpark DataFrame operations.

**Problem Summary**

* Work with a simple customers dataset
* Perform filtering, selection, and grouping operations

**Approach**

1. Created DataFrame using sample data
2. Applied select() to choose columns
3. Used filter() for conditions
4. Performed groupBy() for aggregation

**Key Transformations Used**

* select()
* filter()
* groupBy()
* count()

**Output / Results**

* Filtered customer data
* City-wise customer count

**Challenges Faced**

* Understanding DataFrame operations initially

**Learnings**

* Basic mapping between SQL and PySpark
* DataFrame behaves similar to SQL table

**Files in this Folder**

* solution.py
* queries.sql
* outputs/

---

### 🔹 Phase 2 – Joins & Aggregations

**Objective**
To perform joins and aggregations on multiple datasets.

**Problem Summary**

* Combine customers and orders data
* Calculate metrics like total spend and revenue

**Approach**

1. Loaded CSV files into DataFrames
2. Cleaned data by removing null customer_id
3. Joined datasets using customer_id
4. Applied aggregations and sorting

**Key Transformations Used**

* join()
* groupBy()
* agg()
* filter()
* orderBy()

**Output / Results**

* Total spend per customer
* Top customers
* City-wise revenue

**Challenges Faced**

* Understanding join conditions
* Handling null values before join

**Learnings**

* Importance of cleaning before join
* How joins and aggregations work together

**Files in this Folder**

* solution.py
* queries.sql
* outputs/

---

### 🔹 Phase 3 – ETL Pipeline

**Objective**
To build a complete ETL pipeline using PySpark.

**Problem Summary**

* Read data from different formats
* Clean and transform data
* Generate final outputs

**Approach**

1. Extract → Read CSV, JSON, Parquet
2. Transform → Clean, filter, join, aggregate
3. Load → Display and save results

**Key Transformations Used**

* dropna()
* fillna()
* filter()
* join()
* groupBy()
* agg()

**Output / Results**

* Daily sales
* City-wise revenue
* Final reporting dataset

**Challenges Faced**

* Managing multiple steps in pipeline
* Understanding ETL flow

**Learnings**

* ETL process in data engineering
* Importance of step-by-step transformation

**Files in this Folder**

* solution.py
* queries.sql
* outputs/

---

### 🔹 Phase 3A – Data Quality & Cleaning

**Objective**
To identify and fix data quality issues.

**Problem Summary**

* Dataset contains nulls, duplicates, and invalid values
* Clean data before processing

**Approach**

1. Identified null and duplicate values
2. Removed null keys using dropna()
3. Filled missing values using fillna()
4. Removed duplicates using dropDuplicates()
5. Filtered invalid records

**Key Transformations Used**

* dropna()
* fillna()
* dropDuplicates()
* filter()

**Output / Results**

* Clean dataset with valid records
* Correct aggregation results

**Challenges Faced**

* Identifying all data issues
* Ensuring correct row count after cleaning

**Learnings**

* Data cleaning is critical before analysis
* Invalid data leads to wrong results

**Files in this Folder**

* solution.py
* queries.sql
* outputs/

---

### 🔹 Phase 4 – Business Pipeline & Analytics

**Objective**
To build an end-to-end pipeline and generate business insights.

**Problem Summary**

* Perform multiple analytical tasks on datasets
* Combine results into a final report

**Approach**

1. Cleaned datasets
2. Performed joins
3. Calculated metrics (sales, revenue, etc.)
4. Identified top and repeat customers
5. Created segmentation logic
6. Generated final report

**Key Transformations Used**

* join()
* groupBy()
* agg()
* filter()
* when()

**Output / Results**

* Daily sales
* City-wise revenue
* Customer segmentation
* Final report saved as CSV

**Challenges Faced**

* Combining multiple outputs into one pipeline
* Managing transformation order

**Learnings**

* Building complete pipeline
* Generating business insights from data

**Files in this Folder**

* solution.py
* queries.sql
* outputs/

---

### 🔹 Phase 4A – Bucketing & Segmentation

**Objective**
To understand different methods of segmentation.

**Problem Summary**

* Divide customers into categories based on spend

**Approach**

1. Applied conditional logic (Gold/Silver/Bronze)
2. Used Bucketizer for splitting data
3. Used approxQuantile for dynamic segmentation

**Key Transformations Used**

* when()
* Bucketizer
* approxQuantile()

**Output / Results**

* Segmented customer data
* Comparison of segmentation methods

**Challenges Faced**

* Understanding different segmentation methods
* Implementing quantile-based logic

**Learnings**

* Difference between fixed and dynamic segmentation
* Importance of choosing correct method

**Files in this Folder**

* solution.py
* queries.sql
* outputs/

---

## 👤 Author

Dwibhashyam Amarnath Sharma

22PA1A1240

Capgemini Data Engineering Trainee
