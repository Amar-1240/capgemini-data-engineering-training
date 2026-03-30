from pyspark.sql import SparkSession
from pyspark.sql import functions as F

spark = SparkSession.builder.appName("Phase1").getOrCreate()


customers = spark.createDataFrame([
    (1, "Ravi",  "Hyderabad", 25),
    (2, "Sita",  "Chennai",   32),
    (3, "Arun",  "Hyderabad", 28),
    (4, "Meena", "Bengaluru", 35),
    (5, "Kiran", "Chennai",   22)
], ["customer_id", "customer_name", "city", "age"])


print("Exercise 1: Show all customers")
customers.show()

print("Exercise 2: Customers from Chennai")
customers.filter(F.col("city") == "Chennai").show()


print("Exercise 3: Customers with age > 25")
customers.filter(F.col("age") > 25).show()

print("Exercise 4: customer_name and city only")
customers.select("customer_name", "city").show()

print("Exercise 5: Customer count by city")
customers.groupBy("city") \
    .agg(F.count("customer_id").alias("customer_count")) \
    .orderBy(F.desc("customer_count")) \
    .show()