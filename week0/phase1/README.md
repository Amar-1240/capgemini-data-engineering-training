# Phase 1 – Filtering and Selection

## 🔹 Objective
This phase focuses on building confidence with basic SQL queries and equivalent PySpark DataFrame operations using a simple customers dataset.

---

## 🔹 Problem Statement (Summary)
- Show all records from the customers table
- Filter customers based on city
- Filter customers based on age condition
- Select specific columns from the dataset
- Count customers grouped by city

👉 Detailed problem statement is available in:
`phase1_problem_statement.pdf`

---

## 🔹 Dataset Used
- **Dataset:** Customers (simple starter dataset)
- **Source:** Provided as part of Capgemini Week 0 training material
- **Tables used:** customers (customer_id, customer_name, city, age)

---

## 🔹 Approach
1. Created the customers DataFrame using `spark.createDataFrame()`
2. Used `.show()` to display all records
3. Applied `.filter()` to filter rows based on city and age conditions
4. Used `.select()` to retrieve specific columns
5. Applied `.groupBy()` with `.agg(F.count())` to count customers city-wise

---

## 🔹 Key Transformations
- `.show()` — display all records
- `.filter()` — filter rows based on conditions
- `.select()` — select specific columns
- `.groupBy()` and `.agg()` — group and aggregate data
- `F.count()` — count rows per group
- `F.desc()` — sort in descending order

---

## 🔹 Output / Results
- All customers displayed
- Customers filtered by city (Chennai)
- Customers filtered by age (age > 25)
- Only customer_name and city columns selected
- Customer count per city in descending order

(Screenshots available in `/Outputs` folder)

---

## 🔹 Challenges Faced
- Setting up PySpark locally on Windows had multiple issues (Java not found, pip not recognized, PySpark version incompatibility with Python 3.12)
- Used SparkPlayground online compiler as an alternative to run the code

---

## 🔹 Learnings
- How SQL concepts like SELECT, WHERE, and GROUP BY map to PySpark methods
- How to create and work with PySpark DataFrames
- Difference between `.filter()` and `.select()` in PySpark
- How to use `functions` module (`F`) for aggregations and column operations

---

## 🔹 Files in this Folder
- `phase1_problem_statement.pdf` → Problem description
- `sql_queries.sql` → SQL implementation of all exercises
- `pyspark_code.py` → PySpark implementation of all exercises
- `Outputs/` → Screenshots of query results