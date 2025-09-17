-- For SQL Server: Insert 1000 mock orders with safe TotalAmount calculation

DECLARE @i INT = 1;
DECLARE @CustomerID INT, @ProductID INT, @Quantity INT, @OrderDate DATE, @Price DECIMAL(10,2), @TotalAmount DECIMAL(12,2);

WHILE @i <= 1000
BEGIN
    SET @CustomerID = ((@i - 1) % 15) + 1;
    SET @ProductID = ((@i - 1) % 15) + 1;
    SET @Quantity = ((@i - 1) % 5) + 1;
    SET @OrderDate = DATEADD(DAY, @i, '2024-01-01');
    SELECT @Price = Price FROM Products WHERE ProductID = @ProductID;
    SET @TotalAmount = ISNULL(@Price, 0) * @Quantity;

    INSERT INTO [AM_TEST].Orders (CustomerID, ProductID, Quantity, OrderDate, TotalAmount)
    VALUES (@CustomerID, @ProductID, @Quantity, @OrderDate, @TotalAmount);

    SET @i = @i + 1;
END