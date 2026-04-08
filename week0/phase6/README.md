# Phase 6 – Spark Playground Exit Sprint

## Objective

Build strong understanding of PySpark transformations and SQL by working with dirty data, performing cleaning, validation, joins, window functions, and full pipeline execution.

---

## Platforms Used

- PySpark: Spark Playground (for main implementation)
- SQL: DB Fiddle (MySQL 8)

---

## Dataset

Hardcoded dataset with intentional issues:

- NULL values (name, email, amount)
- Negative values (invalid amounts)
- Invalid foreign key (customer_id = 99)
- Trailing spaces in names

---

## Workflow

### 1. Data Cleaning

- Removed NULL values
- Removed negative amounts
- Trimmed customer names
- Ensured valid records before processing

### 2. Data Validation

- Identified invalid customer_id using left anti join logic
- Verified referential integrity

### 3. Join Operations

- Inner Join → valid matched records
- Left Join → all records with NULLs for missing matches
- Left Anti Join → invalid/orphan records

### 4. Window Functions

- Top 3 customers per city using RANK()
- Running total of sales
- Global ranking of customers
- LAG function for previous order tracking

### 5. Date Analysis

- Extracted year, month, day
- Monthly sales aggregation
- Days since each order
- Monthly cumulative revenue trend

### 6. Final Pipeline

- Clean → Validate → Join → Aggregate → Rank
- Generated final customer report with:
  - total_spend
  - total_orders
  - ranking

---

## SQL Implementation Notes

- Used MySQL 8 (DB Fiddle)
- Replaced CTEs (`WITH`) with subqueries due to execution issues in DB Fiddle
- Avoided reserved keywords like `rank` (used `spend_rank`, `city_rank`)
- Ensured each query runs independently

---

## Key Learnings

- Handling dirty datasets is critical before transformations
- Window functions are powerful for ranking and analytics
- Joins must be validated to avoid incorrect results
- SQL behavior depends heavily on execution environment
- Debugging environment issues is as important as writing logic

---

## Challenges Faced

- Spark Playground limitations (no file writing support)
- Running PySpark locally (multiple Python environments issue)
- DB Fiddle errors with CTEs (`WITH` clause)
- SQL syntax issues with reserved keywords
- Handling NULLs and invalid joins correctly

---

## Conclusion

This phase improved understanding of real-world data processing workflows. It helped in building confidence with PySpark and SQL while handling practical issues like dirty data, joins, and environment-specific debugging.
