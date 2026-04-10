# Databricks notebook source
# MAGIC %md
# MAGIC ###Full Code

# COMMAND ----------

df=spark.read.csv("/Volumes/workspace/default/day1files/orders.csv",header=True,inferSchema=True)



# COMMAND ----------

df.display()

# COMMAND ----------

df=df.fillna({"amount":0})
                
df.display()

# COMMAND ----------

df.write.mode("overwrite").csv("/Volumes/workspace/default/day1files/orders_1.csv",header=True)