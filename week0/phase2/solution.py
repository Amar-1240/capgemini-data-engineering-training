res1 = orders.groupBy("customer_id") \
             .agg(F.sum("order_amount").alias("total_order_amount"))
res1.show()

top3 = res1.orderBy(F.col("total_order_amount").desc()).limit(3)
top3.show()


no_orders = df_joined.filter(F.col("order_id").isNull()).select("name", "customer_id")
no_orders.show()


city_revenue = df_joined.groupBy("city") \
                         .agg(F.sum("order_amount").alias("city_total"))
city_revenue.show()

r
avg_order = orders.groupBy("customer_id") \
                  .agg(F.avg("order_amount").alias("avg_spend"))
avg_order.show()


frequent_customers = orders.groupBy("customer_id") \
                           .agg(F.count("order_id").alias("order_count")) \
                           .filter(F.col("order_count") > 1)
frequent_customers.show()

sorted_spend = res1.sort(F.desc("total_order_amount"))
sorted_spend.show()