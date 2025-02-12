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


**DATA CLEANIND QUERY
```SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL
```





