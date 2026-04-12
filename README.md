# 👨‍💻 Capgemini Data Engineering Training

This repository contains my work for Capgemini Data Engineering Training. The focus of this training is to learn SQL and PySpark concepts and apply them to build data pipelines and perform basic analytics.

---

## 🗂️ Repository Structure

```
capgemini-data-engineering-training/
│
├── README.md → Project overview and progress
├── mini-project/ → Upcoming work
│
├── week0/ → SQL & PySpark Foundations
│ ├── phase0/ → Databricks Certifications
│ ├── phase1/ → Filtering & Selection
│ ├── phase2/ → Joins & Aggregations
│ ├── phase3/ → ETL Pipeline
│ ├── phase3A/ → Data Quality & Cleaning
│ ├── phase4/ → Business Pipeline & Analytics
│ ├── phase4A/ → Bucketing & Segmentation
│ ├── phase5/ → Databricks + Olist Pipeline
│ └── phase6/ → Spark Playground Exit Sprint
│
├── week1/ → Real-world datasets practice
│ ├── Day1/ → PySpark data cleaning (customers & orders)
│ ├── Day2/ → SQL CASE, GROUP BY & JOINS
│ ├── Day3/ → Advanced SQL (CASE, Functions, Window)
│ ├── Day4/ → Advanced SQL pipeline (student submission analysis)
│ ├── Day5/ → NULL Functions & REGEX
│ ├── Day6/ → Car Sales Pipeline Advanced (PySpark + SQL)
│
├── week2/ → Advanced data engineering pipelines
│ ├── Day1/ → Insurance data pipeline (cleaning, validation, risk analysis)
│
└── week3/ → Upcoming work
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

## **Summary**

* Worked with real-world messy datasets (customers, orders, student submissions, usage data)
* Handled null values, duplicates, invalid records, and inconsistent formats
* Applied CASE logic for business decision-making
* Performed aggregations and joins across multiple datasets
* Used window functions for ranking and duplicate detection
* Implemented NULL handling and REGEX for data cleaning
* Built an end-to-end PySpark pipeline for car sales analytics (Day 6)
* Generated business insights such as customer trends, dealer performance, and revenue analysis

---

## **Key Concepts Covered**

* Data cleaning and preprocessing
* CASE WHEN and nested logic
* GROUP BY and aggregation functions
* Joins (inner, left, right, full outer)
* Window functions (ROW_NUMBER, RANK, DENSE_RANK)
* NULL handling (ISNULL, COALESCE, NULLIF)
* REGEX for pattern matching and text extraction
* Handling inconsistent and real-world datasets
* Analytical SQL problem-solving
* End-to-end pipeline design using PySpark
* Multi-table joins with real-world datasets
* Business-level analytics (customer, dealer, sales insights)

---

## **Technologies Used**

### SQL
* CASE statements
* Joins and aggregations
* Window functions
* NULL handling functions
* REGEX functions

### PySpark
* DataFrame transformations
* Data cleaning and preprocessing
* Filtering, deduplication, and validation

---

## **Learnings**

* Real-world data is messy and requires extensive preprocessing
* SQL is more about logic and problem-solving than syntax
* Combining multiple concepts is essential for solving real problems
* Window functions are critical for analytical tasks
* NULL handling and REGEX are key for data cleaning
* Structured thinking improves query design and debugging

---

## **Challenges Faced**

* Handling inconsistent data formats and missing values
* Writing complex CASE statements with correct priority
* Choosing appropriate join types based on logic
* Debugging incorrect outputs in multi-step queries
* Understanding REGEX patterns and edge cases
* Managing complexity when combining multiple SQL concepts

---

## **Conclusion**

Week 1 focused on applying SQL and PySpark concepts to real-world datasets. It strengthened the ability to clean, transform, and analyze data using structured approaches. The week concluded with building a complete data pipeline (Car Sales – Day 6), combining data cleaning, transformations, and analytical insights, bringing together all learned concepts into a practical solution.

---

# 📊 Week 2 – Advanced Data Engineering Pipelines

## **Objective**

To build complete end-to-end data pipelines using PySpark on domain-based datasets, focusing on data cleaning, validation, transformations, and analytical insights.

---

## **Summary**

- Worked on insurance domain dataset (customers, policies, claims, agents)
- Identified and handled real-world data issues:
  - negative values  
  - nulls  
  - inconsistent formats  
  - invalid relationships  
- Performed data cleaning and preprocessing  
- Validated data using anti joins and row checks  
- Built structured transformations:
  - customer-level premium and claims  
  - risk score calculation  
  - city-wise aggregations  
- Applied window functions for ranking customers and agents  

---

## **Key Concepts Covered**

- Data pipeline design (step-by-step approach)  
- Data cleaning and preprocessing  
- Referential integrity validation  
- Controlled joins (avoiding duplication)  
- Aggregations and business metrics  
- Window functions for ranking and analytics  

---

## **Technologies Used**

### PySpark
- DataFrame transformations  
- Joins and aggregations  
- Window functions  
- Data validation techniques  

---

## **Learnings**

- Data validation is critical before analysis  
- Real-world datasets require multiple cleaning steps  
- Improper joins lead to incorrect aggregations  
- Pipeline thinking is more important than writing single queries  
- Window functions enable deeper analytical insights  

---

## **Challenges Faced**

- Handling inconsistent and invalid data  
- Managing joins without duplication  
- Validating intermediate outputs  
- Structuring the pipeline logically  

---

## **Conclusion**

Week 2 focuses on building structured, real-world data engineering pipelines. Day 1 (Insurance pipeline) emphasized the importance of cleaning, validation, and step-by-step transformations before analysis, strengthening practical data engineering skills.

---

## 👤 Author

Dwibhashyam Amarnath Sharma  
22PA1A1240  
Capgemini Data Engineering Trainee
