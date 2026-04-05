# Phase 3A – Data Quality & Cleaning Challenge
# Objective: Identify and clean messy data before aggregation
# Platform: SparkPlayground online compiler

from pyspark.sql import SparkSession
from pyspark.sql import functions as F

# Initialize Spark session
spark = SparkSession.builder.appName("Phase3A_Data_Quality").getOrCreate()

# ─────────────────────────────────────────────
# Create messy dataset with nulls, duplicates and invalid values
# ─────────────────────────────────────────────

data = [
    (1, "Ravi", "Hyderabad", 25),
    (2, None, "Chennai", 32),
    (None, "Arun", "Hyderabad", 28),
    (4, "Meena", None, 30),
    (4, "Meena", None, 30),
    (5, "John", "Bangalore", -5)
]
columns = ["customer_id", "name", "city", "age"]

df = spark.createDataFrame(data, columns)

# ─────────────────────────────────────────────
# Identify null values in each column
# ─────────────────────────────────────────────

print("=== Null counts per column ===")
df.select(
    F.count(F.when(F.col("customer_id").isNull(), "customer_id")).alias("customer_id_nulls"),
    F.count(F.when(F.col("name").isNull(), "name")).alias("name_nulls"),
    F.count(F.when(F.col("city").isNull(), "city")).alias("city_nulls"),
    F.count(F.when(F.col("age").isNull(), "age")).alias("age_nulls")
).show()

# ─────────────────────────────────────────────
# Identify duplicate rows
# ─────────────────────────────────────────────

print("=== Duplicate rows ===")
df.groupBy("customer_id", "name", "city", "age") \
    .agg(F.count("*").alias("count")) \
    .filter(F.col("count") > 1) \
    .show()

# ─────────────────────────────────────────────
# Identify invalid age records
# ─────────────────────────────────────────────

print("=== Invalid age records (age <= 0) ===")
df.filter(F.col("age") <= 0).show()

# ─────────────────────────────────────────────
# Clean: remove null customer_id, fill missing values,
#        remove duplicates, filter invalid age
# ─────────────────────────────────────────────

print("=== Cleaned Data ===")
df_clean = df.filter(F.col("customer_id").isNotNull()) \
             .fillna({"name": "Unknown", "city": "Unknown"}) \
             .dropDuplicates() \
             .filter(F.col("age") > 0)
df_clean.show()

# ─────────────────────────────────────────────
# Validation: row counts before and after cleaning
# ─────────────────────────────────────────────

rows_before = df.count()
rows_after = df_clean.count()
rows_removed = rows_before - rows_after

print(f"Rows before cleaning : {rows_before}")
print(f"Rows after cleaning  : {rows_after}")
print(f"Rows removed         : {rows_removed}")

# ─────────────────────────────────────────────
# Aggregation: customers per city after cleaning
# ─────────────────────────────────────────────

print("=== Customers per City (after cleaning) ===")
df_clean.groupBy("city") \
    .agg(F.count("customer_id").alias("customer_count")) \
    .orderBy(F.desc("customer_count")) \
    .show()

# Stop Spark session
spark.stop()
