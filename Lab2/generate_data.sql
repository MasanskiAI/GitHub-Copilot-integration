-- Insert sample data into Customers
INSERT INTO Customers (FirstName, LastName, Email, RegistrationDate) VALUES
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

-- Insert sample data into Products
INSERT INTO Products (Name, Category, Price) VALUES
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

-- Insert sample data into Orders
INSERT INTO Orders (CustomerID, ProductID, Quantity, OrderDate, TotalAmount) VALUES
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