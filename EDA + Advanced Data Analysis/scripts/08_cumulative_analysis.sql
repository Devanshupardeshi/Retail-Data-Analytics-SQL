/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/

-- Calculate the total sales per month 
-- and the running total of sales over time 
SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
	avg_price,
	ROUND(AVG(avg_price) OVER (ORDER BY order_date),2) AS moving_average_price
FROM
(
	SELECT 
		DATE_TRUNC('year',order_date)::DATE AS order_date,
		SUM(sales_amount) AS total_sales,
		ROUND(AVG(price),2) AS avg_price
	FROM gold.fact_sales 
	WHERE order_date IS NOT NULL
	GROUP BY DATE_TRUNC('year',order_date)
)

