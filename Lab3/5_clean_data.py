from pyspark.sql.functions import year, when, col

# Clean data: drop rows with any nulls
df_clean = df_csv_loaded.dropna()

# Cast types if needed (example: ensure amount is double, date is date)
df_clean = df_clean.withColumn("amount", col("amount").cast("double")) \
                   .withColumn("date", col("date").cast("date"))

# Add calculated fields
df_clean = df_clean.withColumn("transaction_year", year(col("date"))) \
    .withColumn(
        "amount_bucket",
        when(col("amount") < 50, "Low")
        .when((col("amount") >= 50) & (col("amount") < 200), "Medium")
        .otherwise("High")
    )

df_clean.show(5)