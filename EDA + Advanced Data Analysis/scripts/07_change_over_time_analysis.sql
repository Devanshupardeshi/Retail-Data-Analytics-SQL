/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: EXTRACT(), DATE_TRUNC()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/

-- Analyse sales performance over time
-- Quick Date Functions
SELECT
	EXTRACT(YEAR FROM order_date) AS order_year,
   	EXTRACT(MONTH FROM order_date) AS order_month,
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY 
	EXTRACT(YEAR FROM order_date),
	EXTRACT(MONTH FROM order_date)
ORDER BY 
	EXTRACT(YEAR FROM order_date),
	EXTRACT(MONTH FROM order_date);


-- DATE_TRUNC()
SELECT
	DATE_TRUNC('month',order_date)::date AS order_year,
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATE_TRUNC('month',order_date)
ORDER BY DATE_TRUNC('month',order_date);

