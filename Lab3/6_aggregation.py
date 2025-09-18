from pyspark.sql.functions import month, avg, sum as _sum

# 1. Total amount per payment method
total_per_payment_method = df_clean.groupBy("payment_method").agg(_sum("amount").alias("total_amount"))
total_per_payment_method.show()

# 2. Average monthly transaction amount
avg_monthly_transaction = df_clean.withColumn("month", month(col("date"))) \
    .groupBy("transaction_year", "month") \
    .agg(avg("amount").alias("avg_amount"))
avg_monthly_transaction.show()

# 3. Filter: Transactions over $300, grouped by payment method
high_value_by_method = df_clean.filter(col("amount") > 300) \
    .groupBy("payment_method") \
    .agg(_sum("amount").alias("high_value_total"))
high_value_by_method.show()