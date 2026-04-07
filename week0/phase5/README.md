# Phase 5 – Databricks + Olist End-to-End Data Engineering Pipeline

## 📌 Objective

The objective of this phase is to work with a real-world multi-table dataset using Databricks and build an end-to-end data engineering pipeline. This includes data ingestion, cleaning, transformation, advanced analytics, and reporting using both PySpark and SQL.

---

## 🛠️ Tools & Technologies

* Databricks Community Edition
* PySpark (DataFrame API)
* Databricks SQL Editor
* Olist Brazilian E-commerce Dataset (Kaggle)

---

## 📂 Dataset Description

The Olist dataset consists of multiple related tables:

* **customers** → customer details (city, ID)
* **orders** → order-level information
* **order_items** → product-level transactions (fact table)
* **products** → product and category information
* **payments** → payment details (optional use)
* **translation** → category name mapping (Portuguese → English)

---

## 🔄 Pipeline Overview

### 1. Data Ingestion

* Uploaded dataset into Databricks storage
* Loaded CSV files using PySpark
* Verified file paths using DBFS

---

### 2. Data Cleaning

* Removed null values from key columns
* Converted `price` column from string to numeric
* Ensured valid keys before performing joins

---

### 3. Data Modeling (Fact & Dimension)

* Treated **order_items** as fact table
* Joined with:

  * orders → to get `customer_id`
  * customers → to get location (`city`)
  * products → to get product category
* Applied translation to convert category names to English
* Handled missing categories using "Unknown"

---

### 4. Analytical Tasks (PySpark + SQL)

#### Task 1: Top 3 Customers per City

* Calculated total spend per customer
* Used window function (`RANK`) partitioned by city

---

#### Task 2: Running Total of Sales

* Aggregated daily sales
* Used window function to compute cumulative sales

---

#### Task 3: Top Products per Category

* Aggregated total sales per product
* Used `DENSE_RANK` to rank products within each category
* Handled ordering so "Unknown" category appears last

---

#### Task 4: Customer Lifetime Value (CLV)

* Calculated total spend per customer across all orders

---

#### Task 5: Customer Segmentation

* Segmented customers based on spend:

  * Gold (>10000)
  * Silver (5000–10000)
  * Bronze (<5000)

---

#### Task 6: Final Reporting Table

* Combined insights into a final dataset containing:

  * customer_id
  * city
  * total_spend
  * segment
  * total_orders

---

## 🗄️ SQL Implementation

* Created tables in Databricks SQL Editor using CSV files
* Executed all analytical queries using SQL
* Learned difference between:

  * Temp Views (Notebook)
  * Permanent Tables (SQL Editor)

---

## ⚠️ Challenges Faced

* Incorrect file paths and storage confusion (FileStore vs Volumes)
* Data type issues (string vs numeric)
* Join mismatches leading to null values
* Ambiguous columns after joins
* Understanding table relationships across datasets

---

## 📈 Key Learnings

* Importance of validating data after each transformation
* Difference between DataFrame API and SQL execution environments
* Proper use of window functions for analytics
* Fact vs Dimension modeling in real datasets
* Debugging step-by-step instead of guessing

---

## 📌 Conclusion

This phase provided hands-on experience with real-world data engineering workflows. It helped in understanding how to process large datasets, perform multi-table joins, apply advanced analytics, and generate meaningful business insights using both PySpark and SQL.
