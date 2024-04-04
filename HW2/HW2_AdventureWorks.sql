-- Q1
SELECT COUNT(p.ProductID) as NumOfProducts
FROM Production.Product p

-- Q2
SELECT COUNT(p.ProductSubcategoryID) as NumOfProductsInSubCategry
FROM Production.Product p

-- Q3
SELECT p.ProductSubcategoryID, COUNT(p.ProductSubcategoryID) as CountedProducts
FROM Production.Product p
GROUP BY p.ProductSubcategoryID

-- Q4
SELECT COUNT(*) as NumOfProductsWithNoSubCategory
FROM Production.Product p
WHERE p.ProductSubcategoryID IS NULL

-- Q5
SELECT ProductID, SUM(Quantity) AS SumOfProduct
FROM  Production.ProductInventory
GROUP BY ProductID

-- Q6
SELECT pIn.ProductID, SUM(pIn.Quantity) AS TheSum
FROM  Production.ProductInventory pIn
WHERE LocationID = 40
GROUP BY pIn.ProductID
HAVING SUM(pIn.Quantity) < 100

-- Q7
SELECT pIn.Shelf, pIn.ProductID, SUM(pIn.Quantity) AS TheSum
FROM  Production.ProductInventory pIn
WHERE LocationID = 40
GROUP BY pIn.Shelf, pIn.ProductID
HAVING SUM(pIn.Quantity) < 100

-- Q8
SELECT pIn.ProductID, AVG(pIn.Quantity) AS TheAvg
FROM  Production.ProductInventory pIn
WHERE LocationID = 10
GROUP BY pIn.ProductID

-- Q9
SELECT pIn.ProductID, pIn.Shelf, AVG(pIn.Quantity) AS TheAvg
FROM  Production.ProductInventory pIn
GROUP BY pIn.ProductID, pIn.Shelf

-- Q10
SELECT pIn.ProductID, pIn.Shelf, AVG(pIn.Quantity) AS TheAvg
FROM  Production.ProductInventory pIn
WHERE pIn.Shelf IS NOT NULL
GROUP BY pIn.ProductID, pIn.Shelf

-- Q11
SELECT p.Color, p.Class, COUNT(*) AS TheCount, AVG(p.ListPrice) AS AvgPrice
FROM Production.Product p
WHERE p.Color IS NOT NULL AND p.Class IS NOT NULL
GROUP BY p.Color, p.Class

-- Q12
SELECT c.Name AS Country, s.Name AS Province
FROM person.CountryRegion c 
INNER JOIN person.StateProvince s
ON c.CountryRegionCode = s.CountryRegionCode

-- Q13
SELECT c.Name AS Country, s.Name AS Province
FROM person.CountryRegion c 
INNER JOIN person.StateProvince s
ON c.CountryRegionCode = s.CountryRegionCode
WHERE c.Name IN ('Canada', 'Germany')
