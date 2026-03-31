# Phase 2 – Data Transformation using PySpark

## 🔹 Objective
In this phase, the goal is to perform data transformations on the given dataset using PySpark. This includes joining multiple tables, applying aggregations, and generating meaningful business insights.

---

## 🔹 Problem Summary
We were given two datasets — customers and sales (orders).
The task was to:
- Combine data from customers and sales tables using joins
- Perform aggregations to calculate total spend, average spend, and order count per customer
- Identify customers with no orders using left join
- Calculate city-wise total revenue
- Find top customers by total spend

👉 Detailed problem statement is available in: `phase2_problem_statement.pdf`

---

## 🔹 Approach
1. Loaded customers and sales datasets from SparkPlayground sample CSV files
2. Performed basic data cleaning:
   - Removed null values in customer_id using `dropna()`
   - Cast total_amount from string to double using `withColumn()` and `cast()`
3. Created a joined DataFrame using left join to retain all customers
4. Applied transformations:
   - `groupBy()` and `agg()` for aggregations
   - `filter()` with `isNull()` to find customers with no orders
   - `orderBy()` and `limit()` for top-N results

---

## 🔹 Key Transformations Used
- `spark.read.csv()` → to load CSV files into DataFrames
- `dropna()` → to remove rows with null customer_id
- `withColumn()` + `cast()` → to convert string columns to numeric types
- `join()` → to combine customers and sales tables
- `groupBy()` + `agg()` → to calculate sum, average, and count
- `filter()` + `isNull()` → to find unmatched records after left join
- `orderBy()` + `limit()` → to get top-N results
- `F.round()` → to round decimal values to 2 places

---

## 🔹 Output / Results
- Total order amount per customer
- Top 3 customers by total spend
- Customers with no sales records
- City-wise total revenue
- Average order amount per customer
- Customers with more than one order
- All customers sorted by total spend descending

Screenshots of outputs are available in the `Outputs/` folder.

---

## 🔹 Data Engineering Considerations
- Handled null values before performing joins to avoid incorrect aggregations
- Cast all numeric columns from string type after CSV load
- Used left join to ensure customers with no orders are also captured
- Reused aggregated DataFrame (`res1`) across multiple queries to avoid redundant computation

---

## 🔹 Challenges Faced
- Understanding the difference between inner join and left join
- Filtering null values correctly after left join using `isNull()`
- Mapping SQL HAVING clause to PySpark `.filter()` after `.agg()`
- CSV files load all columns as string by default — had to cast manually

---

## 🔹 Learnings
- How to load and inspect CSV files in PySpark
- How to clean data before processing using `dropna()` and `cast()`
- How SQL JOIN types map to PySpark join types (inner, left)
- How to use multiple aggregation functions together in `.agg()`
- How to find unmatched records using left join + `isNull()` filter

---

## 🔹 Files in this Folder
- `phase2_problem_statement.pdf` → Problem description
- `solution.py` → PySpark implementation with comments
- `queries.sql` → SQL implementation with comments
- `Outputs/` → Screenshots of query results