SELECT 
    O.OrderDate,
    P.Name AS ProductName
FROM Products P
LEFT JOIN Orders O ON P.ProductID = O.ProductID
WHERE P.Name LIKE 'B%';