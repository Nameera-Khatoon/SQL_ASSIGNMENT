-- The image contains a document titled **SQL Joins** which provides four sample tables for database practice. Below is the full extraction of the text and data tables.

-- ---

-- ## SQL Joins

-- **Note:** Create the following dummy tables in MySQL Workbench using CREATE FUNCTION—

CREATE DATABASE sql_join_asment;
USE sql_join_asment;

-- ### Table 1: Customers
-- | CustomerID | CustomerName | City |
-- | --- | --- | --- |
-- | 1 | John Smith | New York |
-- | 2 | Mary Johnson | Chicago |
-- | 3 | Peter Adams | Los Angeles |
-- | 4 | Nancy Miller | Houston |
-- | 5 | Robert White | Miami |

CREATE TABLE Customers(
CustomerID INT PRIMARY KEY,
CustomerName VARCHAR(50),
City VARCHAR(50)
);

INSERT INTO Customers VALUES
(1, "John Smith" ,"New York" ),
(2, "Mary Johnson" ,"Chicago" ),
(3, "Peter Adams" ,"Los Angeles" ),
(4, "Nancy Miller" ,"Houston" ),
(5, "Robert White" ,"Miami" );

SELECT * FROM Customers;



-- ### Table 2: Orders

-- | OrderID | CustomerID | OrderDate | Amount |
-- | --- | --- | --- | --- |
-- | 101 | 1 | 2024-10-01 | 250 |
-- | 102 | 2 | 2024-10-05 | 300 |
-- | 103 | 1 | 2024-10-07 | 150 |
-- | 104 | 3 | 2024-10-10 | 450 |
-- | 105 | 6 | 2024-10-12 | 400 |

CREATE TABLE Orders(
OrderID  INT PRIMARY KEY,
CustomerID  INT, 
OrderDate DATE, 
Amount INT,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
 ); 
 
 SET FOREIGN_KEY_CHECKS = 1;
 
 SET SQL_SAFE_UPDATES = 1;

 INSERT INTO Orders VALUES
 ( 101 , 1 , "2024-10-01" ,250 ),
( 102 , 2 , "2024-10-05" , 300 ),
(103 , 1 , "2024-10-07" , 150 ),
(104 , 3 , "2024-10-10" , 450 ),
(105 , 5 , "2024-10-12" , 400 );

SELECT * FROM Orders;
 


-- ### Table 3: Payments

-- | PaymentID | CustomerID | PaymentDate | Amount |
-- | --- | --- | --- | --- |
-- | P001 | 1 | 2024-10-02 | 250 |
-- | P002 | 2 | 2024-10-06 | 300 |
-- | P003 | 3 | 2024-10-11 | 450 |
-- | P004 | 4 | 2024-10-15 | 200 |

CREATE TABLE Payments(
PaymentID VARCHAR(50) PRIMARY KEY,
CustomerID INT,
PaymentDate DATE,
Amount INT,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Payments VALUES
( "P001" , 1 ,"2024-10-02" , 250),
( "P002" , 2 ,"2024-10-06" , 300),
( "P003" , 3 ,"2024-10-11" , 450),
( "P004" , 4 ,"2024-10-15" , 200);

SELECT * FROM Payments;


-- ### Table 4: Employees

-- | EmployeeID | EmployeeName | ManagerID |
-- | --- | --- | --- |
-- | 1 | Alex Green | NULL |
-- | 2 | Brian Lee | 1 |
-- | 3 | Carol Ray | 1 |
-- | 4 | David Kim | 2 |
-- | 5 | Eva Smith | 2 |

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    ManagerID INT NULL,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Employees (EmployeeID, EmployeeName, ManagerID) VALUES
(1, 'Alex Green', NULL),
(2, 'Brian Lee', 1),
(3, 'Carol Ray', 1),
(4, 'David Kim', 2),
(5, 'Eva Smith', 2);

SELECT * FROM Employees;


-- Question 1. Retrieve all customers who have placed at least one order.
SELECT c.CustomerID, c.CustomerName, c.City
FROM customers c
INNER JOIN orders o
ON c.CustomerID= o.CustomerID;

-- Question 2. Retrieve all customers and their orders, including customers who have not placed any orders.
SELECT c.CustomerID, c.CustomerName, c.City,o.OrderID,o.OrderDate,o.Amount
FROM customers c
LEFT JOIN orders o
ON c.CustomerID= o.CustomerID;

-- Question 3. Retrieve all orders and their corresponding customers, including orders placed by unknown customers.
SELECT o.OrderID,o.OrderDate,o.Amount,c.CustomerID, c.CustomerName
FROM  customers c
RIGHT JOIN orders o
ON c.CustomerID= o.CustomerID;


-- Question 4. Display all customers and orders, whether matched or not.
SELECT  c.CustomerID, c.CustomerName, o.OrderID, o.OrderDate, o.Amount
FROM customers c
LEFT JOIN orders o
ON c.CustomerID= o.CustomerID
UNION
SELECT  c.CustomerID, c.CustomerName, o.OrderID, o.OrderDate, o.Amount
FROM customers c
RIGHT JOIN orders o
ON c.CustomerID= o.CustomerID;


-- Question 5. Find customers who have not placed any orders.
SELECT c.CustomerID,c.CustomerName,c.city
FROM customers c
LEFT JOIN orders o
ON c.CustomerID=o.CustomerID
WHERE o.OrderID IS NULL ;


-- Question 6. Retrieve customers who made payments but did not place any orders.

SELECT c.CustomerID, c.CustomerName
FROM customers c
LEFT JOIN payments p ON c.CustomerID=p.CustomerID 
LEFT JOIN orders o ON c.CustomerID=o.CustomerID 
WHERE o.ORDERID IS NULL ;


-- Question 7. Generate a list of all possible combinations between Customers and Orders.
SELECT  c.CustomerID, c.CustomerName, o.OrderID, o.OrderDate, o.Amount
FROM customers c
CROSS JOIN orders o;


-- Question 8. Show all customers along with order and payment amounts in one table.

SELECT c.CustomerID, c.CustomerName, c.City, o.OrderID, o.OrderDate, o.Amount order_amount, p.PaymentID, p.PaymentDate, p.Amount payment_amount
FROM customers c
LEFT JOIN orders o ON c.CustomerID=o.CustomerID
LEFT JOIN payments p ON c.CustomerID=p.CustomerID;


-- Question 9. Retrieve all customers who have both placed orders and made payments.
SELECT c.CustomerID, c.CustomerName
FROM customers c
LEFT JOIN orders o ON c.CustomerID=o.CustomerID
LEFT JOIN payments p ON c.CustomerID=p.CustomerID
WHERE o.OrderID IS NOT NULL AND  p.PaymentID IS NOT NULL ;



