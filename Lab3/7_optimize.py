df_clean.count()  # Triggers caching
df_partitioned = df_clean.repartition("transaction_year")
#spark.conf.set("spark.sql.parquet.enableVectorizedReader", "true") #Vectorized reading is usually enabled by default in Databricks and recent Spark versions, so you typically do not need to set it manually.
spark.conf.set("spark.sql.shuffle.partitions", "8")