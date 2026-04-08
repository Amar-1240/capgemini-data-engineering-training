# ============================================================
# Phase 6 – Spark Playground Exit Sprint
# Clean, Optimized, and Correct Version
# ============================================================

from pyspark.sql import SparkSession
from pyspark.sql import functions as F
from pyspark.sql.window import Window

spark = SparkSession.builder.appName("Phase6_ExitSprint").getOrCreate()

# ============================================================
# EXTRACT – Load Dirty Data
# ============================================================

customers_data = [
    (1, "John Doe", "john@example.com",  "Hyderabad"),
    (2, "Alice ",   "alice@example.com", "Chennai"),
    (3, None,       "bob@example.com",   "Bangalore"),
    (4, "David",    None,                "Mumbai"),
    (5, "Eva",      "eva@example.com",   "Hyderabad"),
    (6, "Frank",    "frank@example.com", "Delhi"),
]

orders_data = [
    (101, 1,  "2024-01-01", 1000),
    (102, 2,  "2024-01-02", 2000),
    (103, 3,  "2024-01-03", -500),
    (104, 99, "2024-01-04", 1500),
    (105, 1,  "2024-01-05", None),
    (106, 5,  "2024-01-06", 3000),
    (107, 5,  "2024-01-07", 3000),
]

customers = spark.createDataFrame(customers_data, ["customer_id", "name", "email", "city"])
orders = spark.createDataFrame(orders_data, ["order_id", "customer_id", "order_date", "amount"])

orders = orders.withColumn("order_date", F.to_date("order_date"))
orders = orders.withColumn("amount", F.col("amount").cast("int"))

# ============================================================
# CLEANING (DONE ONCE – REUSED EVERYWHERE)
# ============================================================

customers_clean = customers.dropna(subset=["customer_id", "name", "email"]) \
                           .withColumn("name", F.trim("name"))

orders_clean = orders.dropna(subset=["order_id", "customer_id", "amount"]) \
                     .filter(F.col("amount") > 0)

# ============================================================
# PRACTICE SET A – JOIN DRILLS
# ============================================================

print("\n========== PRACTICE SET A ==========")

inner_join_df = orders.join(customers, "customer_id", "inner")
display(inner_join_df)

left_join_df = orders.join(customers, "customer_id", "left")
display(left_join_df)

invalid_orders_df = orders.join(customers, "customer_id", "left_anti")
display(invalid_orders_df)

# ============================================================
# PREPARE JOINED CLEAN DATA
# ============================================================

joined_df = orders_clean.join(customers_clean, "customer_id")

# ============================================================
# PRACTICE SET B – WINDOW FUNCTIONS
# ============================================================

print("\n========== PRACTICE SET B ==========")

# B1: Top 3 customers per city
spend_df = joined_df.groupBy("customer_id", "name", "city") \
    .agg(F.sum("amount").alias("total_spend"))

window_city = Window.partitionBy("city").orderBy(F.col("total_spend").desc())

top3 = spend_df.withColumn("rank", F.rank().over(window_city)) \
               .filter(F.col("rank") <= 3)

display(top3)

# B2: Running total
window_date = Window.orderBy("order_date")

running_df = joined_df.withColumn(
    "running_total",
    F.sum("amount").over(window_date)
)

display(running_df)

# B3: Global ranking
window_global = Window.orderBy(F.col("total_spend").desc())

rank_df = spend_df.withColumn(
    "rank",
    F.rank().over(window_global)
)

display(rank_df)

# B4: LAG
window_lag = Window.partitionBy("customer_id").orderBy("order_date")

lag_df = joined_df.withColumn(
    "previous_amount",
    F.lag("amount").over(window_lag)
)

display(lag_df)

# ============================================================
# PRACTICE SET C – DATE ANALYSIS
# ============================================================

print("\n========== PRACTICE SET C ==========")

date_df = orders_clean.withColumn("year", F.year("order_date")) \
                      .withColumn("month", F.month("order_date")) \
                      .withColumn("day", F.dayofmonth("order_date"))

display(date_df)

monthly_df = orders_clean.withColumn("year", F.year("order_date")) \
    .withColumn("month", F.month("order_date")) \
    .groupBy("year", "month") \
    .agg(F.sum("amount").alias("monthly_sales"))

display(monthly_df)

days_df = orders_clean.withColumn(
    "days_since_order",
    F.datediff(F.current_date(), "order_date")
)

display(days_df)

# ============================================================
# PRACTICE SET D – FINAL PIPELINE
# ============================================================

print("\n========== FINAL PIPELINE ==========")

# Validation
invalid_df = orders_clean.join(customers_clean, "customer_id", "left_anti")
display(invalid_df)

# Join
pipeline_df = orders_clean.join(customers_clean, "customer_id")

# Aggregation
summary_df = pipeline_df.groupBy("customer_id", "name", "city") \
    .agg(
        F.sum("amount").alias("total_spend"),
        F.count("order_id").alias("total_orders")
    )

# Ranking
window_final = Window.orderBy(F.col("total_spend").desc())

final_df = summary_df.withColumn(
    "rank",
    F.rank().over(window_final)
)

display(final_df)

print("\nFinal report generated successfully")

spark.stop()