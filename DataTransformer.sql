
CREATE DATABASE DataTransformerDB;
USE DataTransformerDB;


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    RegistrationDate DATE
);


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2)
);


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10, 2)
);



INSERT INTO Customers VALUES 
(1, 'John', 'Doe', 'john.doe@email.com', '2022-03-15'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '2021-11-02');

INSERT INTO Orders VALUES 
(101, 1, '2023-07-01', 150.50),
(102, 2, '2023-07-03', 200.75);

INSERT INTO Employees VALUES 
(1, 'Mark', 'Johnson', 'Sales', '2020-01-15', 50000.00),
(2, 'Susan', 'Lee', 'HR', '2021-03-20', 55000.00);




SELECT Orders.*, Customers.FirstName, Customers.LastName 
FROM Orders 
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;


SELECT Customers.*, Orders.OrderID 
FROM Customers 
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;


SELECT Orders.*, Customers.FirstName, Customers.LastName 
FROM Orders 
RIGHT JOIN Customers ON Orders.CustomerID = Customers.CustomerID;


SELECT Customers.CustomerID, Customers.FirstName, Orders.OrderID
FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
UNION
SELECT Customers.CustomerID, Customers.FirstName, Orders.OrderID
FROM Customers RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;


SELECT * FROM Customers 
WHERE CustomerID IN (SELECT CustomerID FROM Orders WHERE TotalAmount > (SELECT AVG(TotalAmount) FROM Orders));


SELECT * FROM Employees 
WHERE Salary > (SELECT AVG(Salary) FROM Employees);


SELECT OrderDate, YEAR(OrderDate) AS Year, MONTH(OrderDate) AS Month FROM Orders;


SELECT OrderDate, DATEDIFF(CURDATE(), OrderDate) AS Days_Difference FROM Orders;


SELECT DATE_FORMAT(OrderDate, '%d-%b-%Y') AS FormattedDate FROM Orders;

SELECT CONCAT(FirstName, ' ', LastName) AS FullName FROM Employees;


SELECT REPLACE(FirstName, 'John', 'Jonathan') AS NewName FROM Customers;


SELECT UPPER(FirstName) AS UpperFirst, LOWER(LastName) AS LowerLast FROM Employees;


SELECT TRIM(Email) AS CleanEmail FROM Customers;


SELECT OrderID, TotalAmount, SUM(TotalAmount) OVER (ORDER BY OrderID) AS RunningTotal FROM Orders;


SELECT OrderID, TotalAmount, RANK() OVER (ORDER BY TotalAmount DESC) AS OrderRank FROM Orders;


SELECT OrderID, TotalAmount,
CASE 
    WHEN TotalAmount > 1000 THEN '10% off'
    WHEN TotalAmount > 500 THEN '5% off'
    ELSE 'No Discount'
END AS Discount_Category
FROM Orders;


SELECT FirstName, Salary,
CASE 
    WHEN Salary >= 60000 THEN 'High'
    WHEN Salary >= 40000 THEN 'Medium'
    ELSE 'Low'
END AS Salary_Level
FROM Employees;