-- Create the database for the Store Database Management System
CREATE DATABASE Store;
USE Store;

-- Create the Tables:
-- Products Table:
CREATE TABLE Products (
    product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,   -- Product ID is the primary key
    name VARCHAR(25) NOT NULL,                           -- Product name
    description TEXT,                                     -- Product description
    price DECIMAL(10, 2) NOT NULL,                        -- Product price
    category VARCHAR(50)                                 -- Product category
);

-- Customers Table:
CREATE TABLE Customers (
    customer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,  -- Customer ID
    name VARCHAR(25) NOT NULL,                           -- Customer name
    email VARCHAR(25) UNIQUE NOT NULL,                   -- Unique email
    phone_number VARCHAR(15),                             -- Phone number
    address VARCHAR(55)                                  -- Address
);

-- Orders Table:
CREATE TABLE Orders (
    order_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,     -- Order ID
    customer_id INT,                                      -- Foreign key to Customers table
    order_date DATE NOT NULL,                             -- Order date
    status ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending', -- Order status
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) -- Relating orders to customers
); 

-- Payments Table:
CREATE TABLE Payments (
    payment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,   -- Payment ID
    order_id INT,                                         -- Foreign key to Orders table
    payment_date DATE NOT NULL,                           -- Payment date
    amount DECIMAL(10, 2) NOT NULL,                       -- Payment amount
    payment_status ENUM('Paid', 'Unpaid') DEFAULT 'Unpaid', -- Payment status
	FOREIGN KEY (order_id) REFERENCES Orders(order_id)    -- Relating payments to orders
);

-- Inventory Table:
CREATE TABLE Inventory (
    inventory_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- Inventory ID
    product_id INT,                                       -- Foreign key to Products table
    stock_quantity INT DEFAULT 0,                         -- Quantity in stock
    last_updated DATE DEFAULT (CURRENT_DATE),               -- Last updated date
    FOREIGN KEY (product_id) REFERENCES Products(product_id) -- Relating inventory to products
);

-- Inserting Data:
-- Inserting Data into Products Table:
INSERT INTO Products (name, description, price, category) VALUES
('Laptop', 'High-performance laptop', 1200.00, 'Electronics'),
('Headphones', 'Noise-cancelling wireless headphones', 200.00, 'Electronics'),
('Smartphone', 'Latest model smartphone', 800.00, 'Electronics'),
('Chair', 'Ergonomic office chair', 150.00, 'Furniture'),
('Desk', 'Standing desk', 300.00, 'Furniture'),
('Coffee Mug', 'Ceramic mug', 12.50, 'Kitchenware'),
('Notebook', 'Hardcover notebook', 8.75, 'Stationery'),
('Pen Set', 'Luxury pen set', 25.00, 'Stationery'),
('Backpack', 'Travel backpack', 60.00, 'Accessories'),
('Water Bottle', 'Insulated bottle', 18.00, 'Accessories');

-- Inserting Data into Customers Table:
INSERT INTO Customers (name, email, phone_number, address) VALUES
('John Doe', 'john.doe@example.com', '1111111111', '123 Elm Street'),
('Jane Smith', 'jane.smith@example.com', '2222222222', '456 Oak Avenue'),
('Alice Johnson', 'alice.johnson@example.com', '3333333333', '789 Pine Road'),
('Bob Brown', 'bob.brown@example.com', '4444444444', '321 Maple Street'),
('Carol White', 'carol.white@example.com', '5555555555', '654 Cedar Lane'),
('David Green', 'david.green@example.com', '6666666666', '987 Birch Way'),
('Eve Black', 'eve.black@example.com', '7777777777', '246 Spruce Blvd'),
('Frank Gray', 'frank.gray@example.com', '8888888888', '135 Walnut Circle'),
('Grace Blue', 'grace.blue@example.com', '9999999999', '864 Cherry Court'),
('Hank Gold', 'hank.gold@example.com', '1234567890', '579 Poplar Drive');

-- Inserting Data into Orders Table:
INSERT INTO Orders (customer_id, order_date, status) VALUES
(1, '2025-08-01', 'Pending'),
(2, '2025-08-03', 'Completed'),
(3, '2025-08-05', 'Cancelled'),
(4, '2025-08-07', 'Pending'),
(5, '2025-08-09', 'Completed'),
(6, '2025-08-11', 'Pending'),
(7, '2025-08-13', 'Completed'),
(8, '2025-08-15', 'Cancelled'),
(9, '2025-08-17', 'Pending'),
(10, '2025-08-19', 'Completed');

-- Inserting Data into Payments Table:
INSERT INTO Payments (order_id, payment_date, amount, payment_status) VALUES
(1, '2025-08-02', 1200.00, 'Unpaid'),
(2, '2025-08-04', 200.00, 'Paid'),
(3, '2025-08-06', 800.00, 'Unpaid'),
(4, '2025-08-08', 150.00, 'Paid'),
(5, '2025-08-10', 300.00, 'Paid'),
(6, '2025-08-12', 12.50, 'Unpaid'),
(7, '2025-08-14', 8.75, 'Paid'),
(8, '2025-08-16', 25.00, 'Unpaid'),
(9, '2025-08-18', 60.00, 'Paid'),
(10, '2025-08-20', 18.00, 'Paid');

-- Inserting Data into Inventory Table:
INSERT INTO Inventory (product_id, stock_quantity, last_updated) VALUES
(1, 10, '2025-08-01'),
(2, 20, '2025-08-02'),
(3, 30, '2025-08-03'),
(4, 40, '2025-08-04'),
(5, 50, '2025-08-05'),
(6, 60, '2025-08-06'),
(7, 70, '2025-08-07'),
(8, 80, '2025-08-08'),
(9, 90, '2025-08-09'),
(10, 100, '2025-08-10');

-- Query-1: View All Products
SELECT * FROM Products;  -- Retrieves all products listed in the store's database

-- Query-2: Check Product Availability
SELECT name, stock_quantity                 -- Selects the product name and stock quantity
FROM Products p                             -- Retrieves product data from the 'Products' table
JOIN Inventory i ON p.product_id = i.product_id   -- Joins the 'Inventory' table to get stock details
WHERE stock_quantity > 0;                   -- Filters only products with stock available

-- Query-3: Get Customer Details
SELECT * FROM Customers WHERE customer_id = 1;   -- Retrieves customer details for a specific customer

-- Query-4: Orders with Payment Status
SELECT o.order_id, o.order_date, p.payment_status  -- Selects order ID, order date, and payment status
FROM Orders o                                      -- Retrieves order details from the 'Orders' table
JOIN Payments p ON o.order_id = p.order_id;        -- Joins the 'Payments' table to get the payment status  

-- Query-5: Pending Payments
SELECT * FROM Payments WHERE payment_status = 'Unpaid';   -- Retrieves all unpaid payments

-- Query-6: Total Sales per Product
SELECT p.name, SUM(pay.amount) AS total_sales    -- Selects product name and calculates total sales
FROM Products p                                  -- Retrieves product data from the 'Products' table
JOIN Orders o ON p.product_id = o.order_id       -- Joins the 'Orders' table to link product and orders
JOIN Payments pay ON o.order_id = pay.order_id   -- Joins the 'Payments' table to get payment amounts
GROUP BY p.product_id;                           -- Groups by product to sum total sales per product

-- Query-7: Orders Completed in Last Month
SELECT * FROM Orders                              -- Selects all columns from the 'Orders' table
WHERE status = 'Completed'                        -- Filters only orders that are completed
AND order_date > CURDATE() - INTERVAL 1 MONTH;    -- Limits results to orders completed in the last month

-- Query-8: Inventory Restocking
SELECT name, stock_quantity                  -- Selects product name and stock quantity
FROM Products p                              -- Retrieves product data from the 'Products' table
JOIN Inventory i ON p.product_id = i.product_id  -- Joins the 'Inventory' table for stock information
WHERE stock_quantity < 20;                   -- Filters products with low stock that need restocking

-- Query-9: Customers with Multiple Orders
SELECT c.name, COUNT(o.order_id) AS order_count    -- Selects customer name and counts their orders
FROM Customers c                                   -- Retrieves customer data from the 'Customers' table
JOIN Orders o ON c.customer_id = o.customer_id     -- Joins the 'Orders' table to get order data
GROUP BY c.customer_id                             -- Groups by customer to count their orders
HAVING order_count > 1;                            -- Filters customers who placed more than one order

-- Query-10: Average Order Value
SELECT AVG(amount) AS avg_order_value  -- Calculates the average amount from payments
FROM Payments;                         -- Retrieves payment data from the 'Payments' table

-- Query-11: Highest-Paying Customer
SELECT c.name, SUM(p.amount) AS total_spent    -- Selects customer name and calculates total amount spent
FROM Customers c                               -- Retrieves customer data from the 'Customers' table
JOIN Orders o ON c.customer_id = o.customer_id -- Joins 'Orders' table to get customer orders
JOIN Payments p ON o.order_id = p.order_id     -- Joins 'Payments' table to get payment amounts
GROUP BY c.customer_id                         -- Groups by customer ID to sum total spent
ORDER BY total_spent DESC                      -- Sorts by total spent in descending order
LIMIT 1;                                       -- Limits results to the top customer

-- Query-12: Orders by Date Range
SELECT * FROM Orders  -- Selects all columns from the 'Orders' table
WHERE order_date BETWEEN '2025-08-01' AND '2025-08-15';  -- Filters orders placed between October 1 and October 31, 2024

-- Query-13: Find All Canceled Orders
SELECT * FROM Orders WHERE status = 'Cancelled';  -- Retrieves all orders with a status of 'Cancelled'

-- Query-14: Customers with Unpaid Orders
SELECT c.name, p.payment_status  -- Selects customer name and payment status
FROM Customers c                 -- Retrieves customer data from the 'Customers' table
JOIN Orders o ON c.customer_id = o.customer_id   -- Joins 'Orders' table to link customers and orders
JOIN Payments p ON o.order_id = p.order_id       -- Joins 'Payments' table to get payment statuses
WHERE p.payment_status = 'Unpaid';               -- Filters for orders with unpaid payments

-- Query-15: Top 3 Most Sold Products
-- Select the name of the product and the total quantity sold (summed from inventory)
SELECT p.name, SUM(i.stock_quantity) AS total_sold 
-- Join the Orders table with the Products table based on the product ID
FROM Orders o 
JOIN Products p ON o.order_id = p.product_id
-- Join the Products table with the Inventory table to get stock quantities
JOIN Inventory i ON p.product_id = i.product_id 
-- Filter only completed orders
WHERE o.status = 'Completed' 
-- Group results by product ID to calculate total sales per product
GROUP BY p.product_id 
-- Order the results by the total quantity sold in descending order
ORDER BY total_sold DESC 
-- Limit the result to the top 3 products with the highest sales
LIMIT 3;

-- Query-17: Products Without Any Orders
-- Select the name of the products
SELECT p.name
-- Perform a LEFT JOIN between Products and Orders, matching product IDs with order IDs
FROM Products p
LEFT JOIN Orders o ON p.product_id = o.order_id
-- Filter the results to only show products that have no matching order (i.e., have never been ordered)
WHERE o.order_id IS NULL;

-- 1. Manage Products
-- Add New Product
INSERT INTO Products (name, description, price, category)
VALUES ('Wireless Mouse', 'Ergonomic wireless mouse', 25.99, 'Electronics');

-- Read Products
SELECT * FROM Products;

-- Update Product Info
UPDATE Products
SET price = 29.99, category = 'Computer Accessories'
WHERE product_id = 1;

-- Delete Product
DELETE FROM Products
WHERE product_id = 10;

-- 2. Track Customer Orders
-- View All Orders
SELECT o.order_id, o.order_date, o.status, c.name AS customer_name
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;

-- View Orders by Status
SELECT *
FROM Orders
WHERE status = 'Pending';

-- 3. Process Payments
-- Update Payment Status
UPDATE Payments
SET payment_status = 'Paid'
WHERE payment_id = 5;

-- View Payments with Orders
SELECT p.payment_id, p.amount, p.payment_status, o.order_id, o.status AS order_status
FROM Payments p
JOIN Orders o ON p.order_id = o.order_id;

-- 4. Manage Inventory
-- Adjust Stock Levels (e.g., upon shipment receipt)
UPDATE Inventory
SET stock_quantity = stock_quantity + 50,
    last_updated = NOW()
WHERE product_id = 1;

-- View Current Inventory Levels
SELECT p.name, i.stock_quantity
FROM Inventory i
JOIN Products p ON i.product_id = p.product_id;

-- 5. Total Sales per Month (Reporting Query)
SELECT
  YEAR(payment_date) AS sales_year,
  MONTH(payment_date) AS sales_month,
  SUM(amount) AS total_sales
FROM Payments
GROUP BY YEAR(payment_date), MONTH(payment_date)
ORDER BY sales_year, sales_month;

-- 1. Calculate Total Amount Paid for an Order
DELIMITER $$
CREATE FUNCTION TotalPaid(orderId INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE total DECIMAL(10,2);
  SELECT IFNULL(SUM(amount), 0.00) INTO total
  FROM Payments
  WHERE order_id = orderId
    AND payment_status = 'Paid';
  RETURN total;
END$$
DELIMITER ;

SELECT TotalPaid(7) AS amount_paid;


-- payment due
DELIMITER $$
CREATE FUNCTION PaymentDue1(orderId INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE paid DECIMAL(10,2);
  
  SELECT IFNULL(SUM(amount), 0.00) INTO paid
  FROM Payments
  WHERE order_id = orderId AND payment_status = 'Paid';

  RETURN paid;
END$$
DELIMITER ;
SELECT PaymentDue1(123) AS amount_remaining;

DELIMITER $$


-- Stored Procedure: RestockProduct
-- It updates the Inventory table accordingly and also refreshes the last_updated timestamp.
CREATE PROCEDURE RestockProduct(
  IN p_product_id INT,
  IN p_added_quantity INT
)
BEGIN
  UPDATE Inventory
  SET
    stock_quantity = stock_quantity + p_added_quantity,
    last_updated = NOW()
  WHERE product_id = p_product_id;
END$$

DELIMITER ;

-- To restock 5 units of product ID 3, run:
CALL RestockProduct(3, 5);

-- Then verify the update:
SELECT product_id, stock_quantity, last_updated
FROM Inventory
WHERE product_id = 4;

























