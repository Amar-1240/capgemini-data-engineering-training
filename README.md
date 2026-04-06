# 🚀 Capgemini Data Engineering Training
### PySpark · SQL · ETL Pipelines · Databricks · Real-World Datasets

![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Apache Spark](https://img.shields.io/badge/Apache%20Spark-E25A1C?style=for-the-badge&logo=apachespark&logoColor=white)
![Databricks](https://img.shields.io/badge/Databricks-FF3621?style=for-the-badge&logo=databricks&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-Amar--1240-181717?style=for-the-badge&logo=github&logoColor=white)
![Status](https://img.shields.io/badge/Status-Active-brightgreen?style=for-the-badge)

---

## 📌 About This Repository

This repository documents my complete **Data Engineering training journey** at **Capgemini**, progressing from SQL fundamentals to building production-grade ETL pipelines using **PySpark** and **Databricks**.

Each phase is a hands-on, week-by-week progression — no theory without code, no code without purpose.

> **Core philosophy:** *Clean before you join. Filter before you aggregate. Validate before you trust.*

---

## 📁 Repository Structure

```
capgemini-data-engineering-training/
│
├── week0/                          → SQL & PySpark Foundations
│   ├── phase0/                     → Learning Materials (PDFs)
│   ├── phase1/                     → Filtering and Selection ✅
│   ├── phase2/                     → Joins and Aggregations ✅
│   ├── phase3/                     → ETL Pipeline ✅
│   ├── phase3A/                    → Data Quality & Cleaning ✅
│   ├── phase4/                     → Business Pipeline & Analytics ✅
│   ├── phase4A/                    → Bucketing & Segmentation ✅
│   ├── phase5/                     → Advanced Transformations 🔄
│   └── phase6/                     → Capstone Pipeline ⏳
│
├── week1/                          → Real World Datasets (Upcoming)
│   ├── Day1/
│   ├── Day2_Olist/
│   ├── Day2_BFSI/
│   ├── Day3_Olist/
│   ├── Day3_BFSI/
│   ├── Day4_Olist/
│   ├── Day4_BFSI/
│   ├── Day5_Olist/
│   └── Day5_BFSI/
│
├── week2/                          → Upcoming
├── week3/                          → Upcoming
├── mini-project/                   → Upcoming
└── README.md
```

---

## 📊 Progress Tracker

### Week 0 – SQL & PySpark Foundations

| Phase | Topic | Key Concepts | Status |
|-------|-------|-------------|--------|
| Phase 0 | Learning Materials | Databricks, Lakeflow, DevOps for DE | ✅ Completed |
| Phase 1 | Filtering and Selection | `filter()`, `select()`, `groupBy()` | ✅ Completed |
| Phase 2 | Joins and Aggregations | `join()`, `agg()`, `dropna()`, `cast()` | ✅ Completed |
| Phase 3 | ETL Pipeline | CSV/JSON/Parquet ingestion, full pipeline | ✅ Completed |
| Phase 3A | Data Quality & Cleaning | `fillna()`, `dropDuplicates()`, validation | ✅ Completed |
| Phase 4 | Business Pipeline & Analytics | End-to-end pipeline, segmentation, CSV output | ✅ Completed |
| Phase 4A | Bucketing & Segmentation | `F.when()`, `Bucketizer`, `approxQuantile()` | ✅ Completed |
| Phase 5 | Advanced Transformations | TBD | 🔄 In Progress |
| Phase 6 | Capstone Pipeline | TBD | ⏳ Pending |

### Week 1 – Real World Datasets

| Day | Dataset | Status |
|-----|---------|--------|
| Day 1 | TBD | ⏳ Upcoming |
| Day 2 | Olist + BFSI | ⏳ Upcoming |
| Day 3 | Olist + BFSI | ⏳ Upcoming |
| Day 4 | Olist + BFSI | ⏳ Upcoming |
| Day 5 | Olist + BFSI | ⏳ Upcoming |

### Week 2 ⏳ Upcoming
### Week 3 ⏳ Upcoming
### Mini Project ⏳ Upcoming

---

## 🔍 Phase Summaries

---

### 🔵 Phase 1 – Filtering and Selection

Built confidence with basic SQL queries and PySpark DataFrame operations using a simple customers dataset.

**SQL ↔ PySpark mental model established:**

| SQL | PySpark Equivalent |
|-----|-------------------|
| `SELECT col` | `df.select("col")` |
| `WHERE age > 25` | `df.filter(df.age > 25)` |
| `GROUP BY city` | `df.groupBy("city").count()` |
| `ORDER BY spend DESC` | `df.orderBy(df.spend.desc())` |
| `JOIN ON id` | `df.join(df2, "customer_id")` |

**Exercises:** Show all customers · Filter by city · Filter by age · Select columns · Count by city

---

### 🟢 Phase 2 – Joins and Aggregations

Bridged the gap between basic syntax and real-world data engineering tasks. Worked with SparkPlayground sample CSV files, performed light data cleaning and solved realistic join and aggregation exercises.

**Critical pattern introduced — always clean before joining:**
```python
customers = customers.dropna(subset=["customer_id"])
orders    = orders.dropna(subset=["customer_id"])
joined    = customers.join(orders, "customer_id", "inner")
```

**Exercises:** Total spend per customer · Top 3 customers · Customers with no orders · City revenue · Avg order amount · Repeat customers · Sort by spend

---

### 🟡 Phase 3 – ETL Pipeline

Moved from isolated queries to thinking like a data engineer. Built a structured ETL pipeline covering ingestion from CSV, JSON, and Parquet formats.

**The ETL mental model:**
```
EXTRACT          TRANSFORM                          LOAD
  │                   │                               │
Read CSV  →  Clean nulls  →  Filter invalids  →  Save output
              Drop dupes      Join tables
              Cast types      Aggregate
                              Validate
```

**Order of operations (non-negotiable):**
```
✅ Clean   BEFORE  Join
✅ Filter  BEFORE  Aggregate
✅ Validate BEFORE  Process
```

---

### 🔴 Phase 3A – Data Quality & Cleaning

Worked with intentionally messy data — nulls, duplicates, invalid values. Validated results using before/after row counts.

**Issues found and fixed:**

| Issue | Impact | Fix |
|-------|--------|-----|
| Null `customer_id` | Can't join — row is useless | `dropna(subset=["customer_id"])` |
| Null `city` | Wrong city-wise counts | `fillna({"city": "Unknown"})` |
| Duplicate rows | Double-counted in aggregations | `dropDuplicates()` |
| Invalid age (-5) | Corrupts averages and filters | `filter(df.age > 0)` |

**Result:** From 6 dirty rows → 4 clean, trustworthy rows.

---

### 🟠 Phase 4 – Business Pipeline & Analytics

Built a complete end-to-end business pipeline. All 7 tasks feed into a single final reporting table.

**Pipeline architecture:**
```
Raw CSV files
     │
     ▼
 Data Cleaning  ──────────────────────────────────────────┐
     │                                                      │
     ├──▶ Task 1: Daily Sales       (date, total_sales)     │
     ├──▶ Task 2: City Revenue      (city, total_revenue)   │
     ├──▶ Task 3: Top 5 Customers   (name, total_spend)     │
     ├──▶ Task 4: Repeat Customers  (id, order_count)       │
     ├──▶ Task 5: Segmentation      (name, spend, segment)  │
     │                                                      │
     └──▶ Task 6: Final Report ◀────────────────────────────┘
                    │
                    ▼
           Task 7: Save as CSV
```

**Customer segmentation logic:**
```python
df = df.withColumn("segment",
    when(df.total_spend > 10000, "Gold")
    .when((df.total_spend >= 5000) & (df.total_spend <= 10000), "Silver")
    .otherwise("Bronze")
)
```

---

### 🟤 Phase 4A – Bucketing & Segmentation

Explored multiple ways to convert continuous numerical data into categories — and understood when to use each.

**Method 1 — Conditional Logic (most common in production):**
```python
df = df.withColumn("segment",
    when(df.total_spend > 10000, "Gold")
    .when((df.total_spend >= 5000) & (df.total_spend <= 10000), "Silver")
    .otherwise("Bronze")
)
```

**Method 2 — MLlib Bucketizer (ML pipelines):**
```python
from pyspark.ml.feature import Bucketizer
splits = [-float("inf"), 5000, 10000, float("inf")]
bucketizer = Bucketizer(splits=splits, inputCol="total_spend", outputCol="bucket")
df = bucketizer.transform(df)
```

**Method 3 — Quantile-based (adaptive, handles data drift):**
```python
quantiles = df.approxQuantile("total_spend", [0.33, 0.66], 0)
low, high  = quantiles[0], quantiles[1]
df = df.withColumn("segment",
    when(df.total_spend >= high, "Gold")
    .when(df.total_spend >= low,  "Silver")
    .otherwise("Bronze")
)
```

**When to use which:**

| Method | Use When |
|--------|----------|
| `when()` conditional | Business rules have fixed, meaningful thresholds |
| SQL CASE | Working in SparkSQL / notebook environments |
| `Bucketizer` | Part of an MLlib ML pipeline |
| `approxQuantile` | Distribution changes over time (seasonal data, growth) |

> ⚠️ **Fixed thresholds fail** when data distribution shifts — e.g. during a sale season everyone crosses ₹10,000 and your Bronze bucket empties out. Use quantile-based segmentation when balance matters more than absolute values.

---

## 🧠 Key Concepts Summary

### Window Functions — when and why

Window functions let you compute values *across related rows* without collapsing the dataset like `groupBy` does.

| Function | Behaviour | Example Use |
|----------|-----------|-------------|
| `ROW_NUMBER()` | Always unique, no ties | Pagination |
| `RANK()` | Ties share rank, next rank skips | Top-N with gaps |
| `DENSE_RANK()` | Ties share rank, no gap | Top-N per category |
| `SUM() OVER` | Running / cumulative total | Revenue tracking |
| `LAG() / LEAD()` | Previous / next row value | Period-over-period comparison |

> ⚠️ **SparkPlayground limitation:** Window functions are not supported. Use `groupBy max + join` approach instead.

### Fact vs Dimension Tables

| | Fact Table | Dimension Table |
|--|-----------|-----------------|
| **Contains** | Transactions / events | Descriptive attributes |
| **Keys** | Foreign keys | Primary keys |
| **Size** | Large, grows constantly | Small, relatively stable |
| **Examples** | `orders`, `sales`, `payments` | `customers`, `products`, `cities` |

### ETL Order of Operations

```
1. EXTRACT    → Read raw data
2. CLEAN      → Remove nulls, dupes, invalid values
3. FILTER     → Remove out-of-scope records
4. JOIN       → Combine related tables (after cleaning!)
5. AGGREGATE  → Group and summarise
6. VALIDATE   → Check counts and business rules
7. LOAD       → Write final output
```

---

## 📌 Repository Standards

Each phase folder contains:
- `README.md` — detailed documentation with objective, approach, learnings and challenges (8 sections)
- `solution.py` — PySpark implementation with inline comments and ETL section dividers
- `queries.sql` — SQL implementation with inline comments
- `phaseX_problem_statement.pdf` — original problem statement
- `Outputs/` — screenshots of query results

**Commit message format:**
```
Week0 PhaseX: <clear description of what was done>
```

---

## ⚠️ Known Platform Limitations

| Platform | Limitation | Workaround |
|----------|-----------|------------|
| SparkPlayground | No `Window` function support | Use `groupBy max + join` approach |
| SparkPlayground | `createDataFrame()` fails for large data | Use `/samples/` CSV files instead |
| SparkPlayground | `.show()` not supported | Use `display()` |
| DB Fiddle MySQL | No `RANK() OVER (PARTITION BY)` | Use subquery with `HAVING` |
| SparkPlayground | Small CSV data (max ~$120 totals) | Adjust segmentation thresholds accordingly |

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| **Python 3.12** | Primary programming language |
| **PySpark 3.5.1** | Distributed data processing |
| **SQL (MySQL)** | Data querying and transformation |
| **Apache Spark / Databricks** | Big data processing platform |
| **SparkPlayground** | Online PySpark compiler |
| **DB Fiddle** | Online SQL compiler (MySQL) |
| **Git & GitHub** | Version control and code management |

---

## 📈 Key Learnings So Far

- How SQL concepts map directly to PySpark DataFrame operations
- Importance of cleaning data **before** joining or aggregating
- How to build a structured ETL pipeline — Extract → Transform → Load
- Multiple ways to implement bucketing and segmentation in PySpark
- Real-world data is always messy — cleaning is not optional
- Order of operations matters: clean → filter → join → aggregate
- Fixed segmentation thresholds break when data distribution shifts — quantile-based is more robust
- Window functions are powerful but platform-dependent — always have a fallback

---

## 👤 About Me

**Name:** Dwibhashyam Amarnath Sharma
**Roll Number:** 22PA1A1240
**Program:** Capgemini Data Engineering Training
**GitHub:** [Amar-1240](https://github.com/Amar-1240)

---

*Built phase by phase. Every line of code here was written to understand, not to copy.*
