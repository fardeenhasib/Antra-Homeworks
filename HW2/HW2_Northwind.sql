-- Q14
SELECT p.ProductID, p.ProductName, o.OrderDate
FROM Products p
JOIN "Order Details" od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate >= DATEADD(YEAR, -25, 
	(SELECT MAX(OrderDate)
	FROM Orders
	)
)

-- Q15
SELECT TOP 5 o.ShipPostalCode, SUM(od.Quantity)
FROM Products p
JOIN "Order Details" od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY o.ShipPostalCode
ORDER BY SUM(od.Quantity) DESC

-- Q16
SELECT TOP 5 o.ShipPostalCode, SUM(od.Quantity)
FROM Products p
JOIN "Order Details" od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate >= DATEADD(YEAR, -25, 
	(SELECT MAX(OrderDate)
	FROM Orders
	)
)
GROUP BY o.ShipPostalCode
ORDER BY SUM(od.Quantity) DESC

-- Q17
SELECT c.City, COUNT(c.CustomerID) as NumOfCustomers
FROM Customers c
GROUP BY c.City

-- Q18
SELECT c.City, COUNT(c.CustomerID) as NumOfCustomers
FROM Customers c
GROUP BY c.City
HAVING COUNT(c.CustomerID) > 2

-- Q19
SELECT c.ContactName, o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE OrderDate > '1998-01-01'

-- Q20
SELECT c.ContactName, MAX(o.OrderDate) AS MostRecentOrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName 

-- Q21
SELECT c.ContactName, SUM(od.Quantity) AS ProductCount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN "Order Details" od ON o.OrderID = od.OrderID
GROUP BY c.ContactName

-- Q22
SELECT c.CustomerID, SUM(od.Quantity) AS ProductCount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN "Order Details" od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID
HAVING SUM(od.Quantity) > 100


-- Q23
SELECT sp.CompanyName AS "Supplier Company Name", sh.CompanyName AS "Shipping Company Name"
FROM Suppliers sp
CROSS JOIN Shippers sh

-- Q24
SELECT o.OrderDate, p.ProductName
FROM Orders o
JOIN "Order Details" od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
ORDER BY o.OrderDate

-- Q25
SELECT e1.EmployeeID AS Employee1ID, e1.FirstName + ' ' + e1.LastName AS Employee1Name,
       e2.EmployeeID AS Employee2ID, e2.FirstName + ' ' + e2.LastName AS Employee2Name,
       e1.Title AS JobTitle
FROM Employees e1
JOIN Employees e2 ON e1.EmployeeID < e2.EmployeeID AND e1.Title = e2.Title

-- Q26
SELECT e.EmployeeID, e.FirstName + ' ' + e.LastName AS ManagerName, COUNT(sub.EmployeeID) AS EmployeesReportingTo
FROM Employees e
JOIN Employees sub ON e.EmployeeID = sub.ReportsTo
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(sub.EmployeeID) > 2

-- Q27
SELECT City, CompanyName AS Name, ContactName, 'Customer' Type
FROM Customers
UNION ALL
SELECT City, CompanyName AS Name, ContactName, 'Supplier' Type
FROM Suppliers

