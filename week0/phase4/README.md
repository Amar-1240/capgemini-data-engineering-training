# Phase 4 – Mini Project: Business Pipeline & Analytics

## 🔹 Objective

In this phase, the goal is to build a first end-to-end data pipeline. Move from isolated queries to a structured workflow that generates real business insights using PySpark and SQL.

---

## 🔹 Problem Summary

We were given customers and sales datasets and tasked with building a complete business pipeline:

- Calculate daily sales revenue
- Calculate city-wise total revenue
- Find top 5 customers by total spend
- Identify repeat customers with more than 1 order
- Segment customers into Gold, Silver, Bronze based on total spend
- Build a final reporting table combining all insights
- Save the final report as a CSV file

👉 Detailed problem statement is available in: `phase4_problem_statement.pdf`

---

## 🔹 Dataset Used

- **Dataset:** Hardcoded customers and sales data
- **Tables used:** customers (customer_id, first_name, last_name, city), sales (sale_id, customer_id, sale_date, total_amount)
- Data is designed to cover all 3 segments — Gold (>10000), Silver (5000–10000), Bronze (<5000)

---

## 🔹 Approach

The pipeline follows a structured ETL flow:

**Extract:**

- Created customers and sales DataFrames using `spark.createDataFrame()`
- Inspected data using `show()`

**Transform:**

- Removed null customer_id from both datasets using `dropna()`
- Removed duplicate rows using `dropDuplicates()`
- Filtered invalid records where total_amount <= 0
- Joined customers and sales using inner join after cleaning
- Applied business logic for segmentation using `F.when()`
- Built final reporting table by joining all metrics

**Load:**

- Saved final report as CSV using `write.mode("overwrite").csv()`

---

## 🔹 Key Transformations Used

- `spark.createDataFrame()` → create DataFrames from hardcoded data
- `dropna()` → remove null key rows
- `dropDuplicates()` → remove duplicate records
- `filter()` → remove invalid records
- `join()` → combine customers and sales tables
- `groupBy()` + `agg()` → calculate sum, count metrics
- `F.when()` → apply customer segmentation business logic
- `write.mode("overwrite").csv()` → save final output

---

## 🔹 Output / Results

- Daily sales revenue per date
- City-wise total revenue ranked descending
- Top 5 customers by total spend
- Repeat customers with order count
- Customer segmentation (Gold / Silver / Bronze)
- Final reporting table with all metrics combined
- Report saved to `/samples/output/report`

Screenshots of outputs are available in the `Outputs/` folder.

---

## 🔹 Data Engineering Considerations

- Cleaned data BEFORE joining to avoid propagating nulls into results
- Used inner join since only customers with purchases are needed for reporting
- Hardcoded data instead of CSV files to ensure all 3 segments are represented
- Reused cleaned DataFrames across all tasks to avoid redundant computation
- Segmentation logic applied after aggregation so thresholds apply to total spend

---

## 🔹 Challenges Faced

- When using `/samples/customers.csv` and `/samples/sales.csv` from SparkPlayground, the total_amount values were too small — most customers fell into Bronze only. Had to use hardcoded data with larger amounts to properly demonstrate all 3 segments
- Building the final reporting table required joining multiple aggregated DataFrames correctly

## 🔹 Reflection Questions

- **Why is cleaning done before joining?** Null keys cause incorrect joins and wrong results — cleaning first ensures data integrity
- **What would go wrong if null keys are not removed?** Records with null customer_id would fail to join or create wrong matches
- **How did you decide join order?** Customers joined with sales since sales is the fact table — customers provide dimension data like city and name
- **Which step was most difficult?** Building the final reporting table — required joining multiple aggregated DataFrames correctly
- **How is SQL logic similar to PySpark?** SELECT = select(), WHERE = filter(), GROUP BY = groupBy(), JOIN = join(), CASE WHEN = F.when()
- **What challenges will appear with large data?** Shuffling during joins will be expensive — partitioning and broadcast joins would be needed
- **Can you explain your pipeline in simple steps?** Read data → clean nulls and duplicates → join tables → aggregate → segment → save report

---

## 🔹 Learnings

- How to build a complete end-to-end data pipeline from ingestion to output
- Importance of cleaning before joining to get correct results
- How to apply business logic using `F.when()` for customer segmentation
- How to save a final DataFrame as CSV using `write.mode("overwrite")`
- How SQL CASE WHEN maps directly to PySpark `F.when().otherwise()`
- Sample data must be carefully chosen to cover all business segments

---

## 🔹 Files in this Folder

- `phase4_problem_statement.pdf` → Problem description
- `solution.py` → PySpark end-to-end pipeline implementation with comments
- `queries.sql` → SQL equivalent of all 6 tasks
- `Outputs/` → Screenshots of query results
