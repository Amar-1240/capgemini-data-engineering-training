# Phase 1 – Filtering and Selection

## 🔹 Objective
In this phase, the goal is to build confidence with basic SQL queries and their equivalent PySpark DataFrame operations using a simple customers dataset. Focus areas include show(), select(), filter(), and basic groupBy().

---

## 🔹 Problem Summary
We were given a customers dataset with fields customer_id, customer_name, city, and age.
The task was to:
- Show all records from the customers table
- Filter customers based on city
- Filter customers based on age condition
- Select specific columns from the dataset
- Count customers grouped by city

👉 Detailed problem statement is available in: `phase1_problem_statement.pdf`

---

## 🔹 Approach
1. Created the customers DataFrame using `spark.createDataFrame()`
2. Used `.show()` to display all records
3. Applied `.filter()` to filter rows based on city and age conditions
4. Used `.select()` to retrieve only required columns
5. Applied `.groupBy()` with `.agg(F.count())` to count customers city-wise

---

## 🔹 Key Transformations Used
- `createDataFrame()` → to load data into a PySpark DataFrame
- `show()` → to display records
- `filter()` → to apply row-level conditions (equivalent to SQL WHERE)
- `select()` → to choose specific columns (equivalent to SQL SELECT)
- `groupBy()` + `agg()` → to group and aggregate data (equivalent to SQL GROUP BY)
- `F.count()` → to count rows per group
- `F.desc()` → to sort results in descending order

---

## 🔹 Output / Results
- All customers displayed
- Customers filtered by city (Chennai)
- Customers filtered by age (age > 25)
- Only customer_name and city columns selected
- Customer count per city in descending order

Screenshots of outputs are available in the `Outputs/` folder.

---

## 🔹 Data Engineering Considerations
- Kept data types consistent while creating the DataFrame
- Used column references via `F.col()` for safer and more readable filter conditions
- Avoided hardcoded column positions — used column names throughout

---

## 🔹 Challenges Faced
- Setting up PySpark locally on Windows had multiple issues (Java not found, pip not recognized, PySpark version incompatibility with Python 3.12)
- Used SparkPlayground online compiler as an alternative to run the PySpark code
- Used DB Fiddle to run and verify SQL queries

---

## 🔹 Learnings
- How SQL concepts like SELECT, WHERE, and GROUP BY map to PySpark methods
- How to create and work with PySpark DataFrames
- Difference between `.filter()` and `.select()` in PySpark
- How to use the `functions` module (`F`) for aggregations and column operations

---

## 🔹 Files in this Folder
- `phase1_problem_statement.pdf` → Problem description
- `solution.py` → PySpark implementation with comments
- `queries.sql` → SQL implementation with comments
- `Outputs/` → Screenshots of query results