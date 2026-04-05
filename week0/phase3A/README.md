# Phase 3A – Data Quality & Cleaning Challenge

## 🔹 Objective
In this phase, the goal is to work with intentionally messy data and apply cleaning techniques before building a pipeline. This phase highlights why data cleaning is critical in real-world data engineering.

---

## 🔹 Problem Summary
We were given a messy dataset with the following issues:
- Null customer_id (primary key missing)
- Null name values
- Null city values
- Duplicate rows
- Invalid age values (age = -5)

The task was to:
- Identify all data quality issues
- Clean data using appropriate techniques
- Validate cleaning with row counts before and after
- Perform aggregation on cleaned data

👉 Detailed problem statement is available in: `phase3a_problem_statement.pdf`

---

## 🔹 Approach
1. Loaded the messy dataset using `spark.createDataFrame()`
2. Identified data issues:
   - Null counts per column using `F.count(F.when(F.col().isNull()))`
   - Duplicate count using `df.count() - df.dropDuplicates().count()`
   - Invalid age using `filter(age <= 0)`
3. Cleaned data step by step:
   - Removed rows with null `customer_id` using `filter(isNotNull())`
   - Filled missing `city` and `name` with 'Unknown' using `fillna()`
   - Removed duplicate rows using `dropDuplicates()`
   - Filtered invalid age records using `filter(age > 0)`
4. Validated cleaning by comparing row counts before and after
5. Performed city-wise customer count aggregation on cleaned data

---

## 🔹 Key Transformations Used
- `filter(isNotNull())` → remove rows with null primary key
- `fillna()` → fill missing values with default values
- `dropDuplicates()` → remove duplicate rows
- `filter(age > 0)` → remove invalid records
- `F.count(F.when())` → count nulls per column
- `groupBy()` + `agg(F.count())` → count customers per city

---

## 🔹 Output / Results
- Raw messy data displayed
- Null counts per column
- Duplicate row count
- Invalid age records identified
- Cleaned data after each step
- Row count comparison (before vs after cleaning)
- City-wise customer count after cleaning

Screenshots of outputs are available in the `Outputs/` folder.

---

## 🔹 Data Engineering Considerations
- Primary key (customer_id) nulls must be removed — they cannot be processed
- Missing non-key columns (city, name) filled with 'Unknown' instead of dropping — preserves data
- Duplicates removed before aggregation to avoid inflated counts
- Invalid values filtered before any business logic is applied
- Row count validation is essential to confirm cleaning worked correctly

---

## 🔹 Reflection Questions
- **What happens if cleaning is skipped?** Nulls and duplicates will cause wrong aggregation results and business decisions will be based on incorrect data
- **Which issue impacted results most?** Duplicate rows — they directly inflate counts and totals
- **How would this affect business decisions?** City-wise revenue or customer counts would be overstated leading to wrong targeting
- **Cleaning checklist:** Check nulls → fill or drop → remove duplicates → filter invalid values → validate row counts

---

## 🔹 Challenges Faced
- Deciding whether to drop or fill null values — depends on whether the column is a key or not
- Understanding the correct order of cleaning steps (remove nulls first, then duplicates, then invalid values)

---

## 🔹 Learnings
- Real-world data always has quality issues — cleaning is not optional
- `fillna()` is better than `dropna()` for non-key columns to preserve data
- Always validate cleaning with row counts before and after
- The order of cleaning operations matters — clean before joining or aggregating

---

## 🔹 Files in this Folder
- `phase3a_problem_statement.pdf` → Problem description
- `solution.py` → PySpark implementation with comments
- `queries.sql` → SQL equivalent of all cleaning and aggregation steps
- `Outputs/` → Screenshots of query results