# 👨‍💻 Capgemini Data Engineering Training

This repository contains my work for Capgemini Data Engineering Training. The focus of this training is to learn SQL and PySpark concepts and apply them to build data pipelines and perform basic analytics.

---

## 🗂️ Repository Structure

```
capgemini-data-engineering-training/
│
├── README.md                         → Project overview and progress
├── mini-project/                     → Upcoming work
│
├── week0/                            → SQL & PySpark Foundations
│   ├── phase0/                       → Databricks Certifications
│   ├── phase1/                       → Filtering & Selection
│   ├── phase2/                       → Joins & Aggregations
│   ├── phase3/                       → ETL Pipeline
│   ├── phase3A/                      → Data Quality & Cleaning
│   ├── phase4/                       → Business Pipeline & Analytics
│   ├── phase4A/                      → Bucketing & Segmentation
│   ├── phase5/                       → Databricks + Olist Pipeline
│   └── phase6/                       → Spark Playground Exit Sprint
│
├── week1/                            → Real-world datasets practice
│   ├── Day1/                         → PySpark data cleaning (customers & orders)
│   ├── Day2/                         → SQL GROUP BY & JOINS practice
│   ├── Day3/                         → CASE statements & Window Functions
│   ├── Day4/                         → Advanced SQL (student submission analysis pipeline)
│   ├── Day5/                         → Upcoming work
│
├── week2/                            → Upcoming work
└── week3/                            → Upcoming work
```

---

# 📊 Week 0 – SQL & PySpark Foundations

## **Objective**

To build a strong foundation in SQL and PySpark by working through multiple phases covering data cleaning, transformations, joins, analytics, and pipeline building.

---

## **Summary**

- Worked with structured datasets (customers, orders, products)
- Handled dirty data (nulls, duplicates, invalid values)
- Performed joins and aggregations
- Applied window functions for advanced analytics
- Built end-to-end data pipelines
- Generated meaningful outputs for analysis

---

## **Key Concepts Covered**

- Data cleaning and preprocessing
- Joins (inner, left, anti)
- Aggregations and groupBy
- Window functions (RANK, DENSE_RANK, LAG)
- Pipeline building

---

## **Technologies Used**

### PySpark

- DataFrame API
- Transformations and actions
- Window functions

### SQL

- Joins and aggregations
- Window functions
- Subqueries

---

## **Learnings**

- Importance of data cleaning before transformations
- Real-world usage of window functions
- Building structured pipelines
- Debugging data workflows effectively

---

# 📊 Week 1 – Real-World Dataset Practice

## **Objective**

To apply SQL and PySpark concepts on real-world datasets, focusing on data cleaning, transformations, joins, and analytical problem-solving.

---

## **Day 1 – Data Cleaning with PySpark**

- Cleaned customer and orders datasets
- Handled null and “blank” values
- Standardized columns (e.g., country formatting)
- Removed duplicates and invalid records
- Generated cleaned output datasets

---

## **Day 2 – SQL: GROUP BY & JOINS**

- Solved 30+ GROUP BY problems (Assignment 3)
- Implemented aggregations: SUM, COUNT, AVG, MIN, MAX
- Applied HAVING vs WHERE conditions
- Practiced joins (INNER, LEFT, RIGHT, FULL)
- Solved real-world relational problems

---

## **Day 3 – SQL: CASE & Window Functions**

- Implemented CASE and nested CASE logic
- Solved business-rule-based problems
- Applied window functions:
  - ROW_NUMBER
  - RANK
  - DENSE_RANK
- Performed partition-based analysis and ranking

---

## **Day 4 – Advanced SQL Assignment**

- Worked with real-world messy datasets (students + responses)
- Performed data cleaning and column normalization
- Handled inconsistent timestamp formats
- Built unified email mapping (college + personal)
- Merged datasets using FULL OUTER JOIN and COALESCE
- Removed redundant and duplicate records
- Applied window functions for duplicate detection
- Generated final classification:
  - Submitted
  - Duplicate
  - Not Submitted
  - Invalid

---

## **Key Concepts Covered in Week 1**

- Data cleaning and preprocessing on real datasets
- Advanced SQL joins and analysis
- CASE statements and conditional logic
- Window functions for analytics
- Handling inconsistent and messy real-world data
- Building structured data pipelines

---

## **Challenges Faced**

- Handling inconsistent column names and formats
- Managing multiple timestamp formats
- Debugging joins and incorrect mappings
- Dealing with real-world messy data instead of clean datasets

---

## **Learnings**

- Real-world data requires extensive preprocessing
- Window functions are powerful for analytical problems
- Joins must be chosen carefully based on logic
- Structured pipeline thinking is essential
- Debugging is part of the process, not an exception

---

## 👤 Author

Dwibhashyam Amarnath Sharma  
22PA1A1240  
Capgemini Data Engineering Trainee
