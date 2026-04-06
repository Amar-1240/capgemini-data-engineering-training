# Capgemini Data Engineering Training

This repository contains all my work from the Capgemini Data Engineering Training Program.
Each week is divided into phases covering different data engineering concepts using SQL, PySpark, and Databricks.

---

## 👤 About Me
**Name:** Dwibhashyam Amarnath Sharma
**Roll Number:** 22PA1A1240
**Program:** Capgemini Data Engineering Training
**GitHub:** [Amar-1240](https://github.com/Amar-1240)

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

### Phase 1 – Filtering and Selection
Built confidence with basic SQL queries and PySpark DataFrame operations using a simple customers dataset. Learned how `SELECT`, `WHERE`, and `GROUP BY` in SQL map to `select()`, `filter()`, and `groupBy()` in PySpark.

### Phase 2 – Joins and Aggregations
Bridged the gap between basic syntax and real-world data engineering tasks. Worked with SparkPlayground sample datasets, performed light data cleaning and solved realistic join and aggregation exercises.

### Phase 3 – ETL Pipeline
Moved from writing isolated queries to thinking like a data engineer. Built a structured ETL pipeline covering data ingestion from CSV, JSON and Parquet formats, cleaning, transformation and aggregation.

### Phase 3A – Data Quality & Cleaning
Worked with intentionally messy data containing nulls, duplicates and invalid values. Learned why data cleaning is critical before processing and validated results using row count comparisons before and after cleaning.

### Phase 4 – Business Pipeline & Analytics
Built a complete end-to-end business pipeline generating insights including daily sales, city-wise revenue, top customers, repeat customers, customer segmentation (Gold/Silver/Bronze) and a final reporting table saved as CSV.

### Phase 4A – Bucketing & Segmentation
Explored multiple ways to convert continuous data into categories — using `F.when()` for fixed thresholds, MLlib `Bucketizer` for technical bucketing, and `approxQuantile()` for dynamic quantile-based segmentation. Compared results of all three methods.

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| Python 3.12 | Primary programming language |
| PySpark 3.5.1 | Distributed data processing |
| SQL | Data querying and transformation |
| Apache Spark / Databricks | Big data processing platform |
| SparkPlayground | Online PySpark compiler |
| DB Fiddle | Online SQL compiler (MySQL) |
| Git & GitHub | Version control and code management |

---

## 📌 Repository Standards

Each phase folder contains:
- `README.md` — detailed documentation with objective, approach, learnings and challenges
- `solution.py` — PySpark implementation with inline comments
- `queries.sql` — SQL implementation with inline comments
- `phaseX_problem_statement.pdf` — original problem statement
- `Outputs/` — screenshots of query results

Commit message format followed throughout:
```
Week0 PhaseX: <clear description of what was done>
```

---

## 📈 Key Learnings So Far

- How SQL concepts map directly to PySpark DataFrame operations
- Importance of cleaning data before joining or aggregating
- How to build a structured ETL pipeline (Extract → Transform → Load)
- Multiple ways to implement bucketing and segmentation in PySpark
- Real-world data is always messy — cleaning is not optional
- Order of operations matters: clean → filter → join → aggregate
