-- ============================================
-- DDL: Create Tables in [AM_TEST] Schema
-- ============================================
CREATE TABLE [AM_TEST].Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    RegistrationDate DATE NOT NULL
);

CREATE TABLE [AM_TEST].Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50) NOT NULL,
    Price DECIMAL(10,2) NOT NULL
);

CREATE TABLE [AM_TEST].Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES [AM_TEST].Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES [AM_TEST].Products(ProductID)
);

CREATE TABLE [AM_TEST].Calendar (
    CalendarDate DATE PRIMARY KEY,
    Year INT,
    Month INT,
    Day INT,
    DayOfWeek INT,
    MonthName NVARCHAR(20),
    DayName NVARCHAR(20)
);

-- ============================================
-- Indexes for Performance
-- ============================================
CREATE INDEX idx_orders_customerid ON [AM_TEST].Orders(CustomerID);
CREATE INDEX idx_orders_productid ON [AM_TEST].Orders(ProductID);
CREATE INDEX idx_orders_customerid_totalamount ON [AM_TEST].Orders(CustomerID, TotalAmount);

-- ============================================
-- Data Insert: Customers
-- ============================================
INSERT INTO [AM_TEST].Customers (FirstName, LastName, Email, RegistrationDate) VALUES
('John', 'Doe', 'john.doe@email.com', '2024-01-15'),
('Jane', 'Smith', 'jane.smith@email.com', '2024-02-10'),
('Michael', 'Johnson', 'michael.j@email.com', '2024-03-05'),
('Emily', 'Davis', 'emily.d@email.com', '2024-04-12'),
('David', 'Brown', 'david.b@email.com', '2024-05-20'),
('Sarah', 'Miller', 'sarah.m@email.com', '2024-06-18'),
('Chris', 'Wilson', 'chris.w@email.com', '2024-07-22'),
('Jessica', 'Moore', 'jessica.m@email.com', '2024-08-03'),
('Daniel', 'Taylor', 'daniel.t@email.com', '2024-08-15'),
('Laura', 'Anderson', 'laura.a@email.com', '2024-09-01'),
('Matthew', 'Thomas', 'matthew.t@email.com', '2024-09-10'),
('Ashley', 'Jackson', 'ashley.j@email.com', '2024-09-15'),
('Brian', 'White', 'brian.w@email.com', '2024-09-20'),
('Olivia', 'Harris', 'olivia.h@email.com', '2024-09-25'),
('Kevin', 'Martin', 'kevin.m@email.com', '2024-09-30');

-- ============================================
-- Data Insert: Products
-- ============================================
INSERT INTO [AM_TEST].Products (Name, Category, Price) VALUES
('Laptop', 'Electronics', 899.99),
('Smartphone', 'Electronics', 699.99),
('Headphones', 'Electronics', 129.99),
('Desk Chair', 'Furniture', 199.99),
('Coffee Table', 'Furniture', 149.99),
('Running Shoes', 'Apparel', 89.99),
('T-Shirt', 'Apparel', 19.99),
('Blender', 'Appliances', 59.99),
('Microwave', 'Appliances', 119.99),
('Backpack', 'Accessories', 49.99),
('Wristwatch', 'Accessories', 159.99),
('Book', 'Books', 24.99),
('Notebook', 'Stationery', 5.99),
('Pen Set', 'Stationery', 9.99),
('Water Bottle', 'Accessories', 14.99);

-- ============================================
-- Data Insert: Orders (Sample 20 Orders)
-- ============================================
INSERT INTO [AM_TEST].Orders (CustomerID, ProductID, Quantity, OrderDate, TotalAmount) VALUES
(1, 1, 1, '2024-09-01', 899.99),
(2, 2, 2, '2024-09-02', 1399.98),
(3, 3, 1, '2024-09-03', 129.99),
(4, 4, 1, '2024-09-04', 199.99),
(5, 5, 1, '2024-09-05', 149.99),
(6, 6, 2, '2024-09-06', 179.98),
(7, 7, 3, '2024-09-07', 59.97),
(8, 8, 1, '2024-09-08', 59.99),
(9, 9, 1, '2024-09-09', 119.99),
(10, 10, 2, '2024-09-10', 99.98),
(11, 11, 1, '2024-09-11', 159.99),
(12, 12, 4, '2024-09-12', 99.96),
(13, 13, 5, '2024-09-13', 29.95),
(14, 14, 2, '2024-09-14', 19.98),
(15, 15, 3, '2024-09-15', 44.97),
(1, 2, 1, '2024-09-16', 699.99),
(2, 5, 1, '2024-09-17', 149.99),
(3, 7, 2, '2024-09-18', 39.98),
(4, 10, 1, '2024-09-19', 49.99),
(5, 13, 3, '2024-09-20', 17.97);

-- ============================================
-- Data Insert: Orders (Bulk Insert 1000 Mock Orders)
-- ============================================
DECLARE @i INT = 1;
DECLARE @CustomerID INT, @ProductID INT, @Quantity INT, @OrderDate DATE, @Price DECIMAL(10,2), @TotalAmount DECIMAL(12,2);

WHILE @i <= 1000
BEGIN
    SET @CustomerID = ((@i - 1) % 15) + 1;
    SET @ProductID = ((@i - 1) % 15) + 1;
    SET @Quantity = ((@i - 1) % 5) + 1;
    SET @OrderDate = DATEADD(DAY, @i, '2024-01-01');
    SELECT @Price = Price FROM [AM_TEST].Products WHERE ProductID = @ProductID;
    SET @TotalAmount = ISNULL(@Price, 0) * @Quantity;

    INSERT INTO [AM_TEST].Orders (CustomerID, ProductID, Quantity, OrderDate, TotalAmount)
    VALUES (@CustomerID, @ProductID, @Quantity, @OrderDate, @TotalAmount);

    SET @i = @i + 1;
END

-- ============================================
-- Data Insert: Calendar Table (2024)
-- ============================================
DECLARE @d DATE = '2024-01-01';
WHILE @d <= '2024-12-31'
BEGIN
    INSERT INTO [AM_TEST].Calendar (CalendarDate, Year, Month, Day, DayOfWeek, MonthName, DayName)
    VALUES (
        @d,
        YEAR(@d),
        MONTH(@d),
        DAY(@d),
        DATEPART(WEEKDAY, @d),
        DATENAME(MONTH, @d),
        DATENAME(WEEKDAY, @d)
    );
    SET @d = DATEADD(DAY, 1, @d);
END

-- ============================================
-- Test Queries
-- ============================================

-- 1. Join Orders, Customers, and Products: Customer name, product name, quantity, order date
SELECT 
    C.CustomerID,
    C.FirstName + ' ' + C.LastName AS CustomerName,
    P.Name AS ProductName,
    O.Quantity,
    O.OrderDate
FROM [AM_TEST].Orders O
INNER JOIN [AM_TEST].Customers C ON O.CustomerID = C.CustomerID
INNER JOIN [AM_TEST].Products P ON O.ProductID = P.ProductID;

-- 2. Total sales per customer: CustomerID, full name, total spent
SELECT 
    C.CustomerID,
    C.FirstName + ' ' + C.LastName AS FullName,
    SUM(O.TotalAmount) AS TotalSpent
FROM [AM_TEST].Orders O
INNER JOIN [AM_TEST].Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName;

-- 3. Products never ordered
SELECT 
    P.ProductID,
    P.Name AS ProductName
FROM [AM_TEST].Products P
LEFT JOIN [AM_TEST].Orders O ON P.ProductID = O.ProductID
WHERE O.ProductID IS NULL;

-- 4. List orders with negative amounts
SELECT 
    O.OrderID,
    O.CustomerID,
    O.ProductID,
    O.Quantity,
    O.OrderDate,
    O.TotalAmount
FROM [AM_TEST].Orders O
WHERE O.TotalAmount < 0;

-- 5. Calendar join example: Show all dates and order counts
SELECT 
    C.CalendarDate,
    COUNT(O.OrderID) AS OrdersCount
FROM [AM_TEST].Calendar C
LEFT JOIN [AM_TEST].Orders O ON O.OrderDate = C.CalendarDate
GROUP BY C.CalendarDate
ORDER BY C.CalendarDate;

-- ============================================
-- Validation Queries
-- ============================================

-- Validate row counts
SELECT COUNT(*) AS CustomerCount FROM [AM_TEST].Customers;
SELECT COUNT(*) AS ProductCount FROM [AM_TEST].Products;
SELECT COUNT(*) AS OrderCount FROM [AM_TEST].Orders;
SELECT COUNT(*) AS CalendarCount FROM [AM_TEST].Calendar;

-- Validate total sales for a specific customer (e.g., CustomerID = 5)
SELECT 
    C.CustomerID,
    C.FirstName + ' ' + C.LastName AS FullName,
    SUM(O.TotalAmount) AS TotalSpent
FROM [AM_TEST].Orders O
INNER JOIN [AM_TEST].Customers C ON O.CustomerID = C.CustomerID
WHERE C.CustomerID = 5
GROUP BY C.CustomerID, C.FirstName, C.LastName;