-- ONLINE BOOKSTORE SQL ANALYSIS PROJECT

-- DATABASE SETUP
CREATE DATABASE OnlineBookstore;

-- TABLE CREATION
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


-- BASIC QUERY ANALYSIS

-- Analyze Fiction Genre Books
SELECT * FROM Books 
WHERE Genre='Fiction';

-- Identify Books Published After 1950
SELECT * FROM Books 
WHERE Published_year>1950;

-- Analyze Customers from Canada
SELECT * FROM Customers 
WHERE country='Canada';

-- Analyze Orders Placed in November 2023
SELECT * FROM Orders 
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- Calculate Total Available Book Stock
SELECT SUM(stock) AS Total_Stock
From Books;

-- Identify Most Expensive Book
SELECT * FROM Books 
ORDER BY Price DESC 
LIMIT 1;

-- Identify Bulk Book Orders
SELECT * FROM Orders 
WHERE quantity>1;

-- Analyze High-Value Orders Above $20
SELECT * FROM Orders 
WHERE total_amount>20;

-- Analyze Available Book Genres
SELECT DISTINCT genre FROM Books;

-- Identify Lowest Stock Book
SELECT * FROM Books 
ORDER BY stock 
LIMIT 1;

-- Calculate Total Revenue Generated
SELECT SUM(total_amount) As Revenue 
FROM Orders;

-- ADVANCED BUSINESS ANALYSIS

-- Analyze Genre-wise Book Sales
SELECT * FROM ORDERS;
SELECT b.Genre, SUM(o.Quantity) AS Total_Books_sold
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.Genre;

-- Calculate Average Price of Fantasy Books
SELECT AVG(price) AS Average_Price
FROM Books
WHERE Genre = 'Fantasy';

-- Identify Customers with Multiple Orders
SELECT o.customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id) >=2;

-- Identify Most Frequently Ordered Book
SELECT o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;

-- Analyze Top 3 Most Expensive Fantasy Books
SELECT * FROM books
WHERE genre ='Fantasy'
ORDER BY price DESC LIMIT 3;

-- Analyze Author-wise Book Sales
SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.Author;

-- Identify Cities with High-Spending Customers
SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
WHERE o.total_amount > 30;

-- Identify Highest Spending Customer
SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent Desc LIMIT 1;

-- Analyze Remaining Book Inventor
SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;

-- END OF SQL ANALYSIS PROJECT








