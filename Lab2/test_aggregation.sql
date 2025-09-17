SELECT 
    C.CustomerID,
    C.FirstName + ' ' + C.LastName AS FullName,
    SUM(O.TotalAmount) AS TotalSpent
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName;