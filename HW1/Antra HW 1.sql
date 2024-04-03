-- Q1
SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product AS p

-- Q2
SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product AS p
WHERE p.ListPrice <> 0

--Q3
SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product AS p
WHERE p.Color IS NULL

--Q4
SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product AS p
WHERE p.Color IS NOT NULL


-- Q5
SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product AS p
WHERE p.Color IS NOT NULL AND p.ListPrice > 0

-- Q6
SELECT p.Name+' '+p.Color AS "Name & Color"
FROM Production.Product AS p
WHERE p.Color IS NOT NULL

-- Q7
SELECT TOP 6 'Name: ' + p.Name + ' -- ' + 'Color: ' + p.Color AS "Top 6 Name & Color"
FROM Production.Product AS p
WHERE p.Color IS NOT NULL


-- Q8
SELECT p.ProductID, p.Name
FROM Production.Product AS p
WHERE p.ProductID BETWEEN 400 AND 500

-- Q9
SELECT p.ProductID, p.Name, p.Color
FROM Production.Product AS p
WHERE p.Color IN ('Black', 'Blue')

-- Q10
SELECT p.Name
FROM Production.Product AS p
WHERE Name LIKE 'S%'

-- Q11
SELECT TOP 6 p.Name, p.ListPrice
FROM Production.Product AS p
WHERE Name LIKE 'S%'
ORDER BY p.Name

-- Q12
SELECT TOP 5 p.Name, p.ListPrice
FROM Production.Product AS p
WHERE Name LIKE 'S%' or Name LIKE 'A%'
ORDER BY p.Name

-- Q13
SELECT p.Name, p.ListPrice
FROM Production.Product AS p
WHERE Name LIKE 'SPO[^K]%'
ORDER BY p.Name


-- Q14
SELECT DISTINCT p.Color
FROM Production.Product AS p
ORDER BY 1 DESC

-- Q15
SELECT DISTINCT p.ProductSubcategoryID, p.Color
FROM Production.Product AS p
WHERE p.ProductSubcategoryID IS NOT NULL AND p.Color IS NOT NULL
ORDER BY 1, 2;
