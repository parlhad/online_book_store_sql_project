-- Create Database
CREATE DATABASE OnlineBookstore;

-- Switch to the database
\c OnlineBookstore;

-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


-- Import Data into Books Table
-- by directb file import 


-- 1) Retrieve all books in the "Fiction" genre:
		SELECT * FROM Books
	 WHERE genre='Fiction';
		


-- 2) Find books published after the year 1950:
    SELECT * FROM Books
	WHERE published_year>1950;

-- 3) List all customers from the Canada:
		SELECT * FROM Customers
		WHERE country='Canada';

		
-- 4) Show orders placed in November 2023:
	 SELECT * FROM orders
	 WHERE order_date BETWEEN '01-11-2023'AND'30-11-2023';

-- 5) Retrieve the total stock of books available:
		SELECT SUM(stock) AS total_stock 
		FROM Books;
		
		
-- 6) Find the details of the most expensive book:
		SELECT * FROM Books ORDER BY price DESC LIMIT 1; --top 1 mostexpensive 
	SELECT * FROM Books ORDER BY price DESC LIMIT 5;--top 5 mostexpensive

-- 7) Show all customers who ordered more than 1 quantity of a book:
		SELECT * FROM Orders
		WHERE quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $20:
		SELECT * FROM Orders
		WHERE total_amount>20;


-- 9) List all genres available in the Books table:
		SELECT  DISTINCT genre FROM Books;


-- 10) Find the book with the lowest stock:
SELECT * FROM Books ORDER BY stock ASC LIMIT 1;

-- 11) Calculate the total revenue generated from all orders:
	SELECT SUM(total_amount) FROM Orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
			SELECT b.genre,SUM(o.quantity) AS total_book_sold
			FROM Books b 
		      JOIN 
			Orders o
			ON b.book_id=o.customer_id
			GROUP BY b.genre;

-- 2) Find the average price of books in the "Fantasy" genre:

SELECT * FROM Books;
		
		SELECT AVG(price) FROM Books
		WHERE genre='Fantasy';

-- 3) List customers who have placed at least 2 orders:
		
		SELECT customer_id,COUNT(order_id) AS  Order_count
		FROM Orders
		GROUP BY customer_id
		HAVING COUNT(order_id) >=2 ;

-- customer name 
		 SELECT o.customer_id,c.name,COUNT(o.order_id) AS  Order_count
		FROM Orders o
		JOIN Customers c ON c.customer_id=o.customer_id
		GROUP BY o.customer_id,c.name
		HAVING COUNT(order_id) >=2 ;

-- 4) Find the most frequently ordered book:

	 SELECT Book_id,COUNT(order_id) 
	 FROM Orders 
	 GROUP BY Book_id
	 ORDER BY COUNT(order_id) DESC LIMIT 1;
--book name
	  SELECT o.Book_id,b.title,COUNT(o.order_id) 
	 FROM Orders o
	 JOIN Books b ON o.book_id=b.book_id
	 GROUP BY o.Book_id,b.title
	 ORDER BY COUNT(order_id) DESC LIMIT 1;


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :

 SELECT * FROM Books 
 WHERE genre='Fantasy'
 ORDER BY price DESC LIMIT 3;
 

-- 6) Retrieve the total quantity of books sold by each author:
		SELECT * FROM Books;
		SELECT * FROM Orders;
		SELECT b.author,SUM(o.quantity)
		FROM Books b
		JOIN
		Orders o ON b.book_id=o.book_id
		GROUP BY b.author ;

-- 7) List the cities where customers who spent over $30 are located:
  SELECT * FROM Orders;
  SELECT * FROM Customers;
  
 SELECT DISTINCT c.country,c.name,o.total_amount
 FROM Orders o
 JOIN Customers c
 ON c.customer_id=o.customer_id
 WHERE o.total_amount>=30
GROUP BY c.country,c.name,o.total_amount;


SELECT DISTINCT c.country,o.total_amount
 FROM Orders o
 JOIN Customers c
 ON c.customer_id=o.customer_id
 WHERE o.total_amount>=30
GROUP BY c.country,o.total_amount;


-- 8) Find the customer who spent the most on orders:
     SELECT * FROM Orders;
  SELECT * FROM Customers;

  SELECT c.name,o.total_amount AS total_spent---this is only per customer  one time spent
  FROM Orders o
  JOIN
  Customers c
  ON c.customer_id=o.customer_id
  ORDER BY o.total_amount DESC ;

  SELECT c.customer_id,c.name,SUM(o.total_amount) AS total_spent  --this is customer id sum then all  time total spent
  FROM Orders o
  JOIN
  Customers c
  ON c.customer_id=o.customer_id
  GROUP BY c.name,c.customer_id
  ORDER BY total_spent DESC LIMIT 1 ;
  

--9) Calculate the stock remaining after fulfilling all orders:

   SELECT * FROM Orders;
  SELECT * FROM Books;

	SELECT b.book_id,b.title,b.stock,COALESCE(SUM(o.quantity),0) AS Order_quantity ,
	b.stock - COALESCE(SUM(o.quantity),0) AS REmaining_stock
	FROM Orders o
	LEFT JOIN 
	Books b ON o.book_id=b.book_id
GROUP BY b.book_id ORDER BY b.book_id ;

