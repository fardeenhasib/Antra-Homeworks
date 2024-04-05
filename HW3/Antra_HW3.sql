-- Q1
SELECT DISTINCT City
FROM Customers
WHERE City IN (
	SELECT City 
	FROM Employees
)

-- Q2a
SELECT DISTINCT City
FROM Customers
WHERE City NOT IN (
	SELECT City 
	FROM Employees
)

-- Q2b
SELECT DISTINCT c.City
FROM Customers c
LEFT JOIN Employees e ON c.City = e.City
WHERE e.City IS NULL

-- Q3
SELECT p.ProductName, SUM(od.Quantity) AS TotalOrderQuantity
FROM Products p
JOIN "Order Details" od ON p.ProductID = od.ProductID
GROUP BY p.ProductName


-- Q4
SELECT c.City, SUM(od.Quantity) AS TotalOrderQuantityByCity
FROM Customers c
INNER JOIN Orders o 
ON c.CustomerID = o.CustomerID
INNER JOIN "Order Details" od 
ON o.OrderID = od.OrderID
GROUP BY c.City

-- Q5a
SELECT City
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) >= 2
UNION
SELECT City
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) >= 2

-- Q5b
SELECT City
FROM (
    SELECT City, COUNT(CustomerID) AS CustomerCount
    FROM Customers
    GROUP BY City
    HAVING COUNT(CustomerID) >= 2
) AS CustCities

-- Q6
SELECT c.City
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN "Order Details" od ON o.OrderID = od.OrderID
GROUP BY c.City
HAVING COUNT(DISTINCT od.ProductID) >= 2

-- Q7
SELECT DISTINCT c.CustomerID, c.ContactName, c.City, o.ShipCity
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.City != o.ShipCity

-- Q8 
-- TOP 5 Products and their AvgPrice
-- SAVE it as temp t1
SELECT t1.ProductName, t1.AvgPrice, t2.City
FROM
(SELECT TOP 5 p.ProductName, SUM(od.Quantity*od.UnitPrice)/ SUM(od.Quantity) AS AvgPrice
FROM Products p
JOIN "Order Details" od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY  SUM(od.Quantity) DESC) AS t1
JOIN 
-- PRODUCTS AND thier highest sold city
-- Save it as temp t2
(SELECT dt.ProductName, dt.City
FROM
(SELECT p.ProductName, c.city, SUM(od.Quantity) AS OrderQtyByCity, RANK() OVER(PARTITION BY p.ProductName ORDER BY SUM(od.Quantity) DESC) AS rnk
FROM Products p
JOIN "Order Details" od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY p.ProductName, c.City) AS dt
WHERE dt.rnk = 1) t2
ON t1.ProductName = t2.ProductName -- final filter by product name


-- Q9a
SELECT DISTINCT City
FROM Employees
WHERE City NOT IN (
	SELECT City 
	FROM Customers c
	JOIN Orders o
	ON c.CustomerID = o.CustomerID
)

-- Q9b
SELECT e.City
FROM Employees e
LEFT JOIN Orders o ON e.City = o.ShipCity
WHERE o.ShipCity IS NULL

-- Q10
SELECT TOP 1 t1.City
FROM 
(SELECT TOP 1 e.City, COUNT(o.OrderID) AS OrderCntByCity
FROM Employees e
JOIN Orders o
ON o.EmployeeID = e.EmployeeID
GROUP BY e.City
ORDER BY COUNT(o.OrderID) DESC
) AS t1
JOIN
(SELECT TOP 1 p.ProductID, SUM(od.Quantity) AS TotalProductQtyOrdered, c.City
FROM Orders o
JOIN "Order Details" od
ON od.OrderID = o.OrderID
JOIN Products p
ON p.ProductID = od.ProductID
JOIN Customers c
ON c.CustomerID = o.CustomerID
GROUP BY p.ProductID, c.City
ORDER BY SUM(od.Quantity) DESC) AS t2
ON t1.City = t2.City

-- Q11
-- To remove duplicate records from a table in SQL, 
-- we can use the DELETE statement with a subquery that identifies the duplicate records. 
-- Lets create a table with dulicates

CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL
);

INSERT INTO Users (UserID, Username, Email) VALUES
(1, 'john', 'john@gmail.com'),
(2, 'jane', 'jane@gmail.com'),
(3, 'john', 'john@gmail.com');

-- SHOW all rows
SELECT *
FROM USERS

-- DELETE Duplicate rows
DELETE FROM Users
WHERE UserID NOT IN (
    SELECT MIN(UserID)
    FROM Users
    GROUP BY Username, Email
)

-- Show the updated table
SELECT *
FROM USERS
