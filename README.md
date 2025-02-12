# online_book_store_sql_project


# SQL Online Bookstore Project

## Project Overview

**Project Title**: Online Bookstore Database  
**Level**: Beginner to Intermediate  
**Database**: `OnlineBookstore`  

This project involves designing and managing a PostgreSQL database for an online bookstore. It includes database creation, data insertion, and SQL queries for managing books, customers, and sales data.

## Objectives

1. **Set up the bookstore database**: Create and populate a database with book and customer data.
2. **Data Retrieval**: Use SQL queries to retrieve and analyze data.
3. **Database Management**: Implement key database operations including CRUD operations.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `OnlineBookstore`.
- **Table Creation**: Two main tables, `Books` and `Customers`, store book details and customer information.

```sql
CREATE DATABASE OnlineBookstore;

\c OnlineBookstore;

CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15)
);

DATA CLEANIND QUERY

SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL


-- Q1: Retrieve sales on '2022-11-05'
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';

-- Q2: Retrieve 'Clothing' sales (Quantity > 4) in Nov-2022
SELECT * FROM retail_sales 
WHERE category = 'Clothing' AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' AND quantity >= 4;

-- Q3: Total sales for each category
SELECT category, SUM(total_sale) as net_sale, COUNT(*) as total_orders
FROM retail_sales GROUP BY category;

-- Q4: Average age of 'Beauty' customers
SELECT ROUND(AVG(age), 2) as avg_age FROM retail_sales WHERE category = 'Beauty';

-- Q5: Transactions where total_sale > 1000
SELECT * FROM retail_sales WHERE total_sale > 1000;

-- Q6: Total transactions by gender for each category
SELECT category, gender, COUNT(*) as total_trans
FROM retail_sales GROUP BY category, gender ORDER BY category;

-- Q7: Best-selling month each year
SELECT year, month, avg_sale FROM (
    SELECT EXTRACT(YEAR FROM sale_date) as year,
           EXTRACT(MONTH FROM sale_date) as month,
           AVG(total_sale) as avg_sale,
           RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
    FROM retail_sales GROUP BY year, month
) as ranked_months WHERE rank = 1;

-- Q8: Top 5 customers by total sales
SELECT customer_id, SUM(total_sale) as total_sales
FROM retail_sales GROUP BY customer_id ORDER BY total_sales DESC LIMIT 5;

-- Q9: Unique customers per category
SELECT category, COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales GROUP BY category;

-- Q10: Orders per shift (Morning, Afternoon, Evening)
WITH hourly_sales AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT shift, COUNT(*) as total_orders FROM hourly_sales GROUP BY shift;

-- Q11: Top 3 highest revenue-generating customers
SELECT customer_id, SUM(total_sale) AS Revenue
FROM retail_sales GROUP BY customer_id ORDER BY Revenue DESC LIMIT 3;

-- Q12: Most popular product category (highest quantity sold)
SELECT category, SUM(quantity) AS Popular_category
FROM retail_sales GROUP BY category ORDER BY Popular_category DESC LIMIT 1;

-- Q13: Top 3 customers with the highest Average Order Value (AOV)
SELECT customer_id, AVG(total_sale) AS AOV
FROM retail_sales GROUP BY customer_id ORDER BY AOV DESC LIMIT 3;


git clone https://github.com/your-username/your-repository.git
cd your-repository




