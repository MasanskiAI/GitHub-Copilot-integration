SELECT 
    C.FirstName + ' ' + C.LastName AS CustomerName,
    P.Name AS ProductName,
    O.Quantity,
    O.OrderDate
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID
INNER JOIN Products P ON O.ProductID = P.ProductID;