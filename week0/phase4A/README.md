# Phase 4A – Bucketing & Segmentation in PySpark

## 🔹 Objective

In this phase, the goal is to understand how continuous data is converted into categories (bucketing/segmentation) and learn multiple ways to implement it in PySpark.

---

## 🔹 Problem Summary

We were given customers and sales datasets and tasked with:

- Implementing Gold/Silver/Bronze segmentation using conditional logic
- Grouping data by segment and counting customers per segment
- Trying quantile-based segmentation using `approxQuantile()`
- Comparing results of fixed threshold vs quantile-based methods
- Reflecting on which method is most useful and why with summary stats per segment

👉 Detailed problem statement is available in: `phase4a_problem_statement.pdf`

---

## 🔹 Dataset Used

- **Dataset:** Same as Phase 4 — customers and sales data
- **Source:** Hardcoded in solution.py / DB Fiddle for SQL (same values as Phase 4)
- **Tables used:** customers (customer_id, first_name, last_name, city), sales (sale_id, customer_id, total_amount, sale_date)
- Data is designed to cover all 3 segments — Gold (>10000), Silver (5000–10000), Bronze (<5000)

---

## 🔹 Approach

1. Loaded and cleaned customers and sales datasets (same pipeline as Phase 4)
2. Joined tables and calculated total spend per customer
3. Applied 3 different segmentation methods:
   - **Method 1:** Conditional logic using `F.when()` with fixed business thresholds
   - **Method 2:** MLlib `Bucketizer` with split points
   - **Method 3:** Quantile-based segmentation using `approxQuantile()`
4. Counted customers per segment
5. Compared fixed threshold vs quantile-based results side by side
6. Generated summary stats per segment (count, min, max, avg spend)

---

## 🔹 Key Transformations Used

- `F.when().otherwise()` → apply conditional segmentation logic
- `Bucketizer` → MLlib-based bucketing with split points
- `approxQuantile()` → calculate 33rd and 66th percentile thresholds dynamically
- `groupBy()` + `agg(F.count())` → count customers per segment
- `join()` → compare results of two methods side by side

---

## 🔹 Output / Results

- Customer total spend table
- Task 1: Fixed threshold segmentation (Gold/Silver/Bronze)
- Task 2: Customer count per segment
- Task 3: Quantile-based segmentation (Top/Mid/Low Tier)
- Task 4: Side-by-side comparison of fixed vs quantile segmentation
- Task 5: Summary stats per segment (count, min, max, avg spend)

Screenshots of outputs are available in the `Outputs/` folder.

---

## 🔹 Data Engineering Considerations

- Fixed thresholds work well when business rules are clearly defined
- Quantile-based segmentation is better when data distribution is unknown
- Bucketizer requires double type input — cast before using
- Always clean and aggregate before applying segmentation logic
- Sample data values were carefully chosen to ensure all 3 segments (Gold, Silver, Bronze) are represented in the output

---

## 🔹 Challenges Faced

- When using `/samples/customers.csv` and `/samples/sales.csv` from SparkPlayground, the total_amount values were too small — most customers fell into the Bronze segment only and Gold/Silver were empty. Had to use hardcoded data with larger amounts from Phase 4 to properly demonstrate all 3 segments
- Bucketizer requires the input column to be double type — had to cast before applying
- Understanding the difference between fixed threshold and quantile-based results
- MySQL does not support `PERCENT_RANK()` in older versions — had to approximate quantile logic using subqueries

---

## 🔹 Reflection Questions

- **Why do we convert continuous values into categories?** Categories are easier to understand and act on for business decisions than raw numbers
- **Difference between business segmentation and technical bucketing?** Business segmentation uses domain-specific thresholds (Gold/Silver/Bronze), technical bucketing divides data mathematically (quantiles, equal width)
- **When would fixed thresholds fail?** When data distribution changes over time — a threshold that was correct last year may misclassify customers this year
- **How does quantile-based segmentation differ from fixed rules?** Quantile-based always distributes customers evenly across tiers regardless of actual spend values — fixed rules reflect real business logic
- **Which method would you use in real-world projects?** Fixed thresholds for business reporting where rules are defined by stakeholders. Quantile-based for exploratory analysis or when thresholds are unknown

---

## 🔹 Learnings

- Multiple ways to implement bucketing in PySpark — `F.when()`, `Bucketizer`, `approxQuantile()`
- Fixed thresholds reflect business rules, quantile-based reflects data distribution
- `approxQuantile()` is a powerful function for dynamic threshold calculation
- MLlib `Bucketizer` is useful when integrating with machine learning pipelines
- Sample data must be carefully chosen to cover all segments — small values can make results misleading

---

## 🔹 Files in this Folder

- `phase4a_problem_statement.pdf` → Problem description
- `solution.py` → PySpark implementation with all 3 segmentation methods
- `queries.sql` → SQL equivalent of all 5 tasks
- `Outputs/` → Screenshots of query results
