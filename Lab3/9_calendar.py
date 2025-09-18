from pyspark.sql.functions import sequence, to_date, date_add, explode, lit

# Define calendar range
start_date = "2024-01-01"
end_date = "2024-12-31"

# Generate dynamic calendar DataFrame
calendar_df = (
    spark
    .sql(f"SELECT sequence(to_date('{start_date}'), to_date('{end_date}'), interval 1 day) AS calendar_dates")
    .withColumn("calendar_date", explode("calendar_dates"))
    .select("calendar_date")
)

calendar_df.show(5)

# Example: Join calendar to transactions to get daily transaction counts (including days with zero transactions)
daily_counts = (
    calendar_df
    .join(df_clean, calendar_df.calendar_date == df_clean.date, how="left")
    .groupBy("calendar_date")
    .count()
    .orderBy("calendar_date")
)

daily_counts.show(10)