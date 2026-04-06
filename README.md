<div align="center">

# 👨‍💻 Capgemini Data Engineering Training

**From zero to production-grade ETL pipelines — one phase at a time.**

[![Python](https://img.shields.io/badge/Python_3.12-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://python.org)
[![PySpark](https://img.shields.io/badge/PySpark_3.5.1-E25A1C?style=for-the-badge&logo=apachespark&logoColor=white)](https://spark.apache.org)
[![Databricks](https://img.shields.io/badge/Databricks-FF3621?style=for-the-badge&logo=databricks&logoColor=white)](https://databricks.com)
[![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://mysql.com)
[![GitHub](https://img.shields.io/badge/Amar--1240-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Amar-1240)

![Week 0](https://img.shields.io/badge/Week_0-8_of_8_Phases_Done-00C853?style=flat-square)
![Week 1](https://img.shields.io/badge/Week_1-Upcoming-FF6F00?style=flat-square)
![Week 2](https://img.shields.io/badge/Week_2-Upcoming-9E9E9E?style=flat-square)
![Week 3](https://img.shields.io/badge/Week_3-Upcoming-9E9E9E?style=flat-square)

<br/>

> *"Clean before you join. Filter before you aggregate. Validate before you trust."*

</div>

---

## 🗂️ Repository Structure

```
capgemini-data-engineering-training/
│
├── week0/                    → SQL & PySpark Foundations
│   ├── phase0/               → Learning Materials (PDFs)
│   ├── phase1/               → Filtering & Selection          ✅
│   ├── phase2/               → Joins & Aggregations           ✅
│   ├── phase3/               → ETL Pipeline                   ✅
│   ├── phase3A/              → Data Quality & Cleaning        ✅
│   ├── phase4/               → Business Pipeline & Analytics  ✅
│   ├── phase4A/              → Bucketing & Segmentation       ✅
│   ├── phase5/               → Advanced Transformations       🔄
│   └── phase6/               → Capstone Pipeline              ⏳
│
├── week1/                    → Real-World Datasets (Olist + BFSI)
│   ├── Day1/ · Day2_Olist/ · Day2_BFSI/
│   ├── Day3_Olist/ · Day3_BFSI/
│   ├── Day4_Olist/ · Day4_BFSI/
│   └── Day5_Olist/ · Day5_BFSI/
│
├── week2/                    → Upcoming
├── week3/                    → Upcoming
├── mini-project/             → Upcoming
└── README.md
```

Each phase folder follows a strict structure:
```
phaseX/
├── README.md                     → 8-section documentation
├── solution.py                   → PySpark implementation
├── queries.sql                   → SQL implementation
├── phaseX_problem_statement.pdf  → Original problem statement
└── Outputs/                      → Query result screenshots
```

---

## 📊 Progress at a Glance

### Week 0 — SQL & PySpark Foundations

| # | Phase | What I Built | Core Skills | Status |
|---|-------|-------------|-------------|--------|
| 0 | Setup | Learning materials | Databricks, Lakeflow, DevOps for DE | ✅ |
| 1 | Filtering & Selection | Customer filter queries | `filter()` `select()` `groupBy()` | ✅ |
| 2 | Joins & Aggregations | Multi-table join pipeline | `join()` `agg()` `dropna()` `cast()` | ✅ |
| 3 | ETL Pipeline | Full extract→transform→load pipeline | CSV/JSON/Parquet ingestion | ✅ |
| 3A | Data Quality | Messy data → clean data validator | `fillna()` `dropDuplicates()` `filter()` | ✅ |
| 4 | Business Pipeline | 7-task end-to-end analytics pipeline | Segmentation, reporting, CSV export | ✅ |
| 4A | Bucketing | 3-method segmentation comparison | `F.when()` `Bucketizer` `approxQuantile()` | ✅ |
| 5 | Advanced Transforms | — | Window functions, complex joins | 🔄 |
| 6 | Capstone | — | Full pipeline integration | ⏳ |

### Week 1 — Real-World Datasets

| Day | Datasets | Focus | Status |
|-----|----------|-------|--------|
| Day 1 | TBD | Orientation | ⏳ |
| Day 2–5 | **Olist** (Brazilian e-commerce) + **BFSI** | Domain-specific pipelines | ⏳ |

---

## 🔍 Phase Deep Dives

---

### Phase 1 · Filtering & Selection

The SQL → PySpark mental model — the foundation everything else builds on.

| SQL | PySpark | What it does |
|-----|---------|--------------|
| `SELECT col` | `df.select("col")` | Pick columns |
| `WHERE age > 25` | `df.filter(df.age > 25)` | Row-level filtering |
| `GROUP BY city` | `df.groupBy("city").count()` | Aggregation |
| `ORDER BY spend DESC` | `df.orderBy(df.spend.desc())` | Sorting |
| `LEFT JOIN ON id` | `df.join(df2, "id", "left")` | Table joining |

---

### Phase 2 · Joins & Aggregations

First time working with real CSV files off disk. Introduced the rule that changed everything:

```python
# ❌ WRONG — join first, discover broken keys mid-pipeline
joined = customers.join(orders, "customer_id")

# ✅ RIGHT — clean both sides BEFORE the join
customers = customers.dropna(subset=["customer_id"])
orders    = orders.dropna(subset=["customer_id"])
joined    = customers.join(orders, "customer_id", "inner")
```

---

### Phase 3 · ETL Pipeline

Stopped writing isolated queries. Started thinking in pipelines.

```
┌──────────┐     ┌───────────────────────────────┐     ┌──────────┐
│ EXTRACT  │────▶│          TRANSFORM             │────▶│   LOAD   │
│          │     │                                │     │          │
│ Read CSV │     │  Clean → Filter → Join →       │     │ Save CSV │
│ Read JSON│     │  Aggregate → Validate          │     │ display()│
│ Read PAR │     │                                │     │          │
└──────────┘     └───────────────────────────────┘     └──────────┘
```

**Non-negotiable order of operations:**

```
1.  dropna()          — kill null keys first
2.  dropDuplicates()  — before any count-based logic
3.  cast()            — fix types right after reading
4.  filter()          — narrow scope before joining
5.  join()            — only on clean data
6.  groupBy().agg()   — aggregate last
7.  validate          — row counts before and after every step
```

---

### Phase 3A · Data Quality & Cleaning

Given intentionally broken data. Had to find every issue, fix it, and prove the fix worked with row counts.

| # | Issue | Why It's Dangerous | Fix Applied |
|---|-------|-------------------|-------------|
| 1 | Null `customer_id` | Uncatchable join failures downstream | `dropna(subset=["customer_id"])` |
| 2 | Null `city` | Silent wrong groupBy counts | `fillna({"city": "Unknown"})` |
| 3 | Duplicate row | Every aggregate is double-counted | `dropDuplicates()` |
| 4 | Age = -5 | Corrupts averages, breaks age filters | `filter(df.age > 0)` |

**Before → After:** 6 rows → 4 rows. Every remaining row is trustworthy.

---

### Phase 4 · Business Pipeline & Analytics

Built the most complete pipeline so far. Seven tasks, all feeding one final reporting table.

```
                        ┌─────────────────────┐
      Raw CSV ──────────▶   Clean & Validate   │
                        └──────────┬──────────┘
                                   │
              ┌────────────────────┼────────────────────┐
              │                    │                    │
              ▼                    ▼                    ▼
       Daily Sales           City Revenue         Top 5 Customers
              │                    │                    │
              └────────────────────┼────────────────────┘
                                   │
              ┌────────────────────┼────────────────────┐
              │                                         │
              ▼                                         ▼
      Repeat Customers                        Segmentation
      (order_count > 1)                  (Gold / Silver / Bronze)
              │                                         │
              └─────────────────┬───────────────────────┘
                                │
                                ▼
                      ┌─────────────────┐
                      │  Final Report   │──▶ Save as CSV
                      └─────────────────┘
```

**Segmentation thresholds:**
```python
df = df.withColumn("segment",
    when(df.total_spend > 10000,                               "Gold")
   .when((df.total_spend >= 5000) & (df.total_spend <= 10000), "Silver")
   .otherwise(                                                 "Bronze")
)
```

---

### Phase 4A · Bucketing & Segmentation — Three Methods Compared

Same goal, three different tools. Knowing *which* to reach for is the real skill.

| Method | How It Works | Best For | Watch Out |
|--------|-------------|----------|-----------|
| `F.when()` | Fixed business thresholds | Known, stable cutoffs | Breaks if data shifts |
| `Bucketizer` | MLlib split boundaries | ML pipeline integration | Requires `DoubleType` input |
| `approxQuantile` | Thresholds derived from data | Seasonal / drifting data | Balanced buckets, not business-aligned |

```python
# Method 3 — let the data tell you where the thresholds should be
quantiles      = df.approxQuantile("total_spend", [0.33, 0.66], 0)
low_threshold  = quantiles[0]   # bottom 33% cutoff
high_threshold = quantiles[1]   # top 33% cutoff

df = df.withColumn("tier",
    when(df.total_spend >= high_threshold, "Top Tier")
   .when(df.total_spend >= low_threshold,  "Mid Tier")
   .otherwise(                             "Low Tier")
)
```

> **The insight:** Fixed thresholds are business logic. Quantile thresholds are data logic. Use fixed when the *number* matters. Use quantile when *balance* matters.

---

## 🧠 Concepts That Actually Stuck

### Window Functions — compute across rows without collapsing them

`groupBy` collapses your dataset. Window functions don't.

| Function | Behaviour | Real Use Case |
|----------|-----------|---------------|
| `ROW_NUMBER()` | Unique rank, no ties ever | Paginating results |
| `RANK()` | Ties get same rank, next rank jumps | Leaderboards with gaps |
| `DENSE_RANK()` | Ties get same rank, no gap | Top-N per category |
| `SUM() OVER (ORDER BY date)` | Running cumulative total | Revenue trend tracking |
| `LAG(col, 1)` | Value from the previous row | Month-over-month comparison |

> ⚠️ **SparkPlayground doesn't support Window.** Use `groupBy().agg(max()) + join()` as the workaround.

---

### Fact vs Dimension — the schema thinking that separates DE from DA

| | Fact Table | Dimension Table |
|--|-----------|-----------------|
| **Stores** | Events / transactions | Context / attributes |
| **Key type** | Foreign keys | Primary key |
| **Size** | Huge, grows every day | Small, rarely changes |
| **Changes** | Append-only | Slow-changing |
| **Examples** | `orders`, `payments`, `clicks` | `customers`, `products`, `cities` |

**Rule of thumb:** If a row represents *something that happened*, it's a fact. If it represents *something that exists*, it's a dimension.

---

### Data Quality Checklist — run this before every pipeline

```
□  Check null counts on key join columns          (dropna)
□  Check for duplicate primary keys               (dropDuplicates)
□  Check numeric columns loaded as strings        (cast after read)
□  Check for invalid values (negatives, blanks)   (filter)
□  Validate row count before vs after cleaning    (df.count())
□  Check join result count makes sense            (not fewer than expected)
```

---

## ⚠️ Platform Gotchas (Learned the Hard Way)

| Platform | What Breaks | What Actually Works |
|----------|-------------|---------------------|
| SparkPlayground | `Window` import — silent failure | `groupBy max + join` pattern |
| SparkPlayground | `spark.createDataFrame()` on large lists | Use `/samples/` CSV files |
| SparkPlayground | `.show()` | `display()` |
| SparkPlayground | Sample data max ~$120 total amounts | Adjust Gold/Silver/Bronze thresholds |
| DB Fiddle MySQL | `RANK() OVER (PARTITION BY ...)` | Subquery with `GROUP BY` + `HAVING` |

---

## 🛠️ Tech Stack

<div align="center">

| Layer | Tool | Version | Purpose |
|-------|------|---------|---------|
| Language | Python | 3.12 | Primary |
| Processing | PySpark | 3.5.1 | Distributed compute |
| SQL | MySQL via DB Fiddle | — | Query practice |
| Cloud Platform | Databricks Community | — | Notebook environment |
| Local Compiler | SparkPlayground | — | Online PySpark |
| Version Control | Git + GitHub | — | Code management |

</div>

---

## 📈 What I Actually Learned

Not a copy of the phase objectives — what genuinely changed in how I think:

- **SQL and PySpark are the same idea, different syntax.** Once I built the mapping table mentally, switching between them became automatic.
- **Cleaning is not a step — it's a philosophy.** You clean constantly: after reading, before joining, after joining, before aggregating.
- **Row counts are your best debugging tool.** If the count doesn't make sense, something upstream is broken.
- **Fixed thresholds are a liability.** They're right today and wrong next month. Quantile-based segmentation ages better.
- **Window functions are powerful but platform-fragile.** Always know your fallback before you need it.
- **ETL isn't a sequence of steps — it's a way of thinking.** Every transformation should have a clear *why* before the *how*.

---

<div align="center">

## 👤 Dwibhashyam Amarnath Sharma

**22PA1A1240 · Capgemini Data Engineering Training · 2026**

[![GitHub](https://img.shields.io/badge/GitHub-Amar--1240-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Amar-1240)

<br/>

*Built phase by phase. Every line of code here was written to understand, not to copy.*

</div>
