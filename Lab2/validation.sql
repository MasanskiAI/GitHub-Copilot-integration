SELECT 
    O.OrderID,
    O.CustomerID,
    O.ProductID,
    O.Quantity,
    O.OrderDate,
    O.TotalAmount
FROM Orders O
WHERE O.TotalAmount < 0;