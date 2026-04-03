/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a 1 schema within the database named 'DataWarehouseAnalytics':
	'gold' after checking if it already exists.
    If the schema exists, it is dropped and recreated.
	
WARNING:
    Running this script will drop Schema 'gold' in database if it exists. 
    All data in the Schems will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

DROP TABLE IF EXISTS gold.fact_sales; -- Drop the table if it exists
DROP TABLE IF EXISTS gold.dim_products; -- Drop the table if it exists
DROP TABLE IF EXISTS gold.dim_customers; -- Drop the table if it exists
DROP SCHEMA IF EXISTS gold; -- Drop the schema if it exists

CREATE SCHEMA gold; -- Create Schema

CREATE TABLE gold.dim_customers(
	customer_key int,
	customer_id int,
	customer_number varchar(50),
	first_name varchar(50),
	last_name varchar(50),
	country varchar(50),
	marital_status varchar(50),
	gender varchar(50),
	birthdate date,
	create_date date
);

CREATE TABLE gold.dim_products(
	product_key int ,
	product_id int ,
	product_number varchar(50) ,
	product_name varchar(50) ,
	category_id varchar(50) ,
	category varchar(50) ,
	subcategory varchar(50) ,
	maintenance varchar(50) ,
	cost int,
	product_line varchar(50),
	start_date date 
);

CREATE TABLE gold.fact_sales(
	order_number varchar(50),
	product_key int,
	customer_key int,
	order_date date,
	shipping_date date,
	due_date date,
	sales_amount int,
	quantity smallint,
	price int 
);

TRUNCATE TABLE gold.dim_customers;
COPY gold.dim_customers (customer_key,customer_id,customer_number,first_name,
						  last_name,country,marital_status,gender,birthdate,create_date)
FROM 'D:\gold.dim_customers.csv'
DELIMITER ','
CSV
HEADER;

TRUNCATE TABLE gold.dim_products;
COPY gold.dim_products (product_key,product_id,product_number,product_name,category_id,
						 category,subcategory,maintenance,cost,product_line,start_date)
FROM 'D:\gold.dim_products.csv'
DELIMITER ','
CSV
HEADER;

TRUNCATE TABLE gold.fact_sales;
COPY gold.fact_sales (order_number,product_key,customer_key,order_date,shipping_date,
					   due_date,sales_amount,quantity,price)
FROM 'D:\gold.fact_sales.csv'
DELIMITER ','
CSV
HEADER;






