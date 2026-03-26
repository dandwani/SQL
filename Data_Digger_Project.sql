CREATE DATABASE Data_Digger_Project;
USE Data_Digger_Project;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Address VARCHAR(255)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2),
    Stock INT
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    SubTotal DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
INSERT INTO Customers (Name, Email, Address) VALUES
('Amit Sharma', 'amit.sharma@gmail.com', 'Mumbai, Maharashtra'),
('Priya Patel', 'priya.patel@gmail.com', 'Ahmedabad, Gujarat'),
('Rahul Verma', 'rahul.verma@gmail.com', 'Delhi'),
('Sneha Iyer', 'sneha.iyer@gmail.com', 'Chennai, Tamil Nadu'),
('Vikram Singh', 'vikram.singh@gmail.com', 'Jaipur, Rajasthan');

INSERT INTO Products (ProductName, Price, Stock) VALUES
('Laptop', 55000, 10),
('Smartphone', 20000, 25),
('Headphones', 1500, 50),
('Keyboard', 800, 40),
('Mouse', 500, 60);
SELECT * FROM Customers;
DELETE FROM Customers
WHERE CustomerID > 5;
SELECT * FROM Products;
DELETE FROM Products
WHERE ProductID > 5;
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2026-03-01', 55000),
(2, '2026-03-05', 20000),
(3, '2026-03-10', 1500),
(4, '2026-03-15', 800),
(5, '2026-03-20', 500);
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, SubTotal) VALUES
(1, 1, 1, 55000),
(2, 2, 8, 160000),
(3, 3, 5, 1500),
(4, 4, 3, 800),
(5, 5, 2, 500);
SELECT * FROM orders;
SELECT * FROM orderdetails;
SELECT * FROM customers;
UPDATE customers
SET address = 'Surat'
WHERE customerID = 2;
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES (3, '2026-03-10', 1500);
TRUNCATE TABLE OrderDetails;
SELECT * FROM Orders
WHERE CustomerID = 1;
SELECT * FROM Orders
WHERE OrderDate >= CURDATE() - INTERVAL 30 DAY;
SELECT 
MAX(TotalAmount),
MIN(TotalAmount),
AVG(TotalAmount)
FROM Orders;
SELECT * FROM Products
ORDER BY Price DESC;

SELECT * FROM Products
WHERE Price BETWEEN 500 AND 2000;

SELECT * FROM Products
WHERE Stock = 0;

SELECT MAX(Price), 
MIN(Price) 
FROM Products;

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, SubTotal) VALUES
(1, 1, 1, 55000),
(2, 2, 8, 160000),
(3, 3, 5, 1500),
(4, 4, 3, 800),
(5, 5, 2, 500);
SELECT * FROM OrderDetails
WHERE OrderID = 1;
SELECT SUM(SubTotal) AS TotalRevenue
FROM OrderDetails;

SELECT ProductID, SUM(Quantity) AS TotalSold
FROM OrderDetails
WHERE ProductID = 2
GROUP BY ProductID;
