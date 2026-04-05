# Phase 4A – Bucketing & Segmentation in PySpark
# Objective: Understand how continuous data is converted into categories
# Dataset: Same as Phase 4 (hardcoded to ensure all 3 segments are covered)
# Platform: SparkPlayground online compiler

from pyspark.sql import SparkSession
from pyspark.sql import functions as F
from pyspark.ml.feature import Bucketizer

# Initialize Spark session
spark = SparkSession.builder.appName("Phase4A_Bucketing_Segmentation").getOrCreate()

# ─────────────────────────────────────────────
# STEP 1: EXTRACT – Create datasets matching Phase 4 data
# Data is designed to cover all 3 segments: Gold, Silver, Bronze
# ─────────────────────────────────────────────

# Customers data (same as Phase 4)
customers_data = [
    (1, "John", "Smith", "Springfield"),
    (2, "Emma", "Jones", "Centerville"),
    (3, "Olivia", "Brown", "Greenville"),
    (4, "Liam", "Johnson", "Riverside"),
    (5, "Noah", "Williams", "Lakeside"),
    (6, "Alice", "Miller", "Oakland"),
    (7, "Isabella", "Davis", "Boise"),
    (8, "James", "Martinez", "Des Moines"),
    (9, "Sophia", "Garcia", "Albany"),
    (10, "Lucas", "Rodriguez", "Portland")
]

# Sales data (same as Phase 4 — amounts cover Gold >10000, Silver 5000-10000, Bronze <5000)
sales_data = [
    (1, 1, "2024-01-15", 3999.98),
    (2, 1, "2024-01-20", 2999.99),
    (3, 2, "2024-01-16", 5000.00),
    (4, 2, "2024-01-22", 8997.00),
    (5, 3, "2024-01-17", 4998.00),
    (6, 4, "2024-01-18", 11996.00),
    (7, 4, "2024-01-25", 1550.00),
    (8, 5, "2024-01-19", 6675.00),
    (9, 6, "2024-01-20", 4000.00),
    (10, 7, "2024-01-21", 10995.00),
    (11, 8, "2024-01-22", 2000.00),
    (12, 9, "2024-01-23", 7996.00),
    (13, 10, "2024-01-24", 5500.00),
    (14, 1, "2024-01-25", 1500.00),
    (15, 2, "2024-01-26", 3000.00)
]

customers = spark.createDataFrame(customers_data, ["customer_id", "first_name", "last_name", "city"])
sales = spark.createDataFrame(sales_data, ["sale_id", "customer_id", "sale_date", "total_amount"])

# Clean: remove nulls, duplicates and invalid amounts
customers_clean = customers.dropna(subset=["customer_id"]).dropDuplicates()
sales_clean = sales.dropna(subset=["customer_id", "total_amount"]) \
                   .dropDuplicates() \
                   .filter(F.col("total_amount") > 0)

# Join customers and sales
df_joined = customers_clean.join(sales_clean, on="customer_id", how="inner")

# Calculate total spend per customer
customer_spend = df_joined.groupBy("customer_id", "first_name", "last_name", "city") \
    .agg(F.round(F.sum("total_amount"), 2).alias("total_spend"))

print("=== Customer Total Spend ===")
customer_spend.orderBy(F.desc("total_spend")).show()

# ─────────────────────────────────────────────
# TASK 1: Conditional Logic (Most Common)
# Business rules: Gold > 10000, Silver 5000-10000, Bronze < 5000
# ─────────────────────────────────────────────

print("Task 1: Gold/Silver/Bronze segmentation using conditional logic")
df_method1 = customer_spend.withColumn(
    "segment",
    F.when(F.col("total_spend") > 10000, "Gold")
     .when((F.col("total_spend") >= 5000) & (F.col("total_spend") <= 10000), "Silver")
     .otherwise("Bronze")
)
df_method1.select("first_name", "last_name", "total_spend", "segment") \
    .orderBy(F.desc("total_spend")).show()

# ─────────────────────────────────────────────
# TASK 2: Group by segment and count customers
# ─────────────────────────────────────────────

print("Task 2: Customer count per segment")
df_method1.groupBy("segment") \
    .agg(F.count("customer_id").alias("customer_count")) \
    .orderBy("segment") \
    .show()

# ─────────────────────────────────────────────
# TASK 3: Quantile-based Segmentation
# Divides data into equal groups based on distribution
# ─────────────────────────────────────────────

print("Task 3: Quantile-based Segmentation")

# Calculate 33rd and 66th percentile thresholds dynamically
quantiles = customer_spend.approxQuantile("total_spend", [0.33, 0.66], 0.0)
low_threshold = quantiles[0]
high_threshold = quantiles[1]

print(f"33rd percentile (low threshold)  : {low_threshold}")
print(f"66th percentile (high threshold) : {high_threshold}")

# Apply quantile-based segmentation using calculated thresholds
df_method3 = customer_spend.withColumn(
    "segment",
    F.when(F.col("total_spend") > high_threshold, "Top Tier")
     .when(F.col("total_spend") >= low_threshold, "Mid Tier")
     .otherwise("Low Tier")
)
df_method3.select("first_name", "last_name", "total_spend", "segment") \
    .orderBy(F.desc("total_spend")).show()

# ─────────────────────────────────────────────
# TASK 4: Compare results of fixed vs quantile segmentation
# ─────────────────────────────────────────────

print("Task 4: Comparison - Fixed Rules vs Quantile-based Segmentation")
df_method1.select("customer_id", "total_spend", F.col("segment").alias("fixed_segment")) \
    .join(
        df_method3.select("customer_id", F.col("segment").alias("quantile_segment")),
        on="customer_id"
    ) \
    .orderBy(F.desc("total_spend")) \
    .show()

# ─────────────────────────────────────────────
# TASK 5: Bucketizer (MLlib) — additional method
# Uses split points to assign bucket numbers automatically
# ─────────────────────────────────────────────

print("Task 5: Bucketizer (MLlib) Segmentation")

# Define split points: Bronze < 5000, Silver 5000-10000, Gold > 10000
splits = [-float("inf"), 5000.0, 10000.0, float("inf")]
bucketizer = Bucketizer(splits=splits, inputCol="total_spend", outputCol="bucket")
df_method2 = bucketizer.transform(customer_spend)

# Map bucket numbers to segment labels
df_method2 = df_method2.withColumn(
    "segment",
    F.when(F.col("bucket") == 0, "Bronze")
     .when(F.col("bucket") == 1, "Silver")
     .otherwise("Gold")
)
df_method2.select("first_name", "last_name", "total_spend", "bucket", "segment") \
    .orderBy(F.desc("total_spend")).show()

# Stop Spark session
spark.stop()
