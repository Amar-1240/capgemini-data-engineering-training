# Phase 2 – Joins and Aggregations

## 🔹 Objective
This phase focuses on bridging the gap between basic SQL-to-PySpark syntax and real-world data engineering tasks. It involves working with sample datasets, performing light data cleaning, and solving realistic joins and aggregations.

---

## 🔹 Problem Statement (Summary)
- Load customers and orders datasets from CSV files
- Perform light data cleaning (remove rows with missing customer_id)
- Calculate total order amount for each customer
- Find top 3 customers by total spend
- Identify customers with no orders (left join)
- Calculate city-wise total revenue
- Find average order amount per customer
- Find customers with more than one order
- Sort customers by total spend in descending order

👉 Detailed problem statement is available in:
`phase2_problem_statement.pdf`

---

## 🔹 Dataset Used
- **Dataset:** SparkPlayground sample files
- **Source:** SparkPlayground online compiler (`/samples/`)
- **Tables used:** customers, orders

---

## 🔹 Approach
1. Loaded customers and orders CSV files using `spark.read.option("header", "true").csv()`
2. Inspected schema using `printSchema()`
3. Cleaned data by removing rows with null customer_id using `dropna()`
4. Performed inner joins to calculate aggregations across both tables
5. Used left join to find customers with no orders
6. Applied `groupBy()` with `agg()` for sum, count, and average calculations
7. Used `orderBy()` and `limit()` for top-N results

---

## 🔹 Key Transformations
- `spark.read.csv()` — load CSV files with header
- `printSchema()` — inspect column types
- `dropna()` — remove rows with null values
- `.join(..., how="inner")` — join tables on customer_id
- `.join(..., how="left")` — left join to find unmatched records
- `F.isNull()` — filter null values after left join
- `F.sum()`, `F.avg()`, `F.count()` — aggregation functions
- `F.round()` — round decimal values
- `F.desc()` — sort in descending order
- `.limit()` — restrict output to top N rows

---

## 🔹 Output / Results
- Total order amount per customer
- Top 3 customers by total spend
- Customers with no orders
- City-wise total revenue
- Average order amount per customer
- Customers with more than one order
- All customers sorted by total spend descending

(Screenshots available in `/outputs` folder)

---

## 🔹 Challenges Faced
- Understanding the difference between inner join and left join
- Filtering null values correctly after a left join using `isNull()`
- Mapping SQL HAVING clause to PySpark `.filter()` after `.agg()`

---

## 🔹 Learnings
- How to load and inspect CSV files in PySpark
- How to clean data before processing using `dropna()`
- How SQL JOIN types map to PySpark join types (inner, left)
- How to use multiple aggregation functions together in `.agg()`
- How to find unmatched records using left join + `isNull()` filter

---

## 🔹 Files in this Folder
- `phase2_problem_statement.pdf` → Problem description
- `solution.py` → PySpark implementation of all exercises
- `queries.sql` → SQL implementation of all exercises
- `outputs/` → Screenshots of query results