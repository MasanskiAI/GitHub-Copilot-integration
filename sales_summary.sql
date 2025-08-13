SELECT
    customer_id,
    SUM(sale_amount) AS total_sales
FROM
    sales
WHERE
    sale_date >= DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '1 year'
    AND sale_date < DATE_TRUNC('year', CURRENT_DATE)
GROUP BY
    customer_id
ORDER BY
    total_sales DESC;