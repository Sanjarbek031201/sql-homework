/*CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2),
    Category VARCHAR(50),
    StockQuantity INT
);
INSERT INTO Products VALUES
(1, 'Laptop', 1200.00, 'Electronics', 30),
(2, 'Smartphone', 800.00, 'Electronics', 50),
(3, 'Tablet', 400.00, 'Electronics', 40),
(4, 'Monitor', 250.00, 'Electronics', 60),
(5, 'Keyboard', 50.00, 'Accessories', 100),
(6, 'Mouse', 30.00, 'Accessories', 120),
(7, 'Chair', 150.00, 'Furniture', 80),
(8, 'Desk', 200.00, 'Furniture', 75),
(9, 'Pen', 5.00, 'Stationery', 300),
(10, 'Notebook', 10.00, 'Stationery', 500),
(11, 'Printer', 180.00, 'Electronics', 25),
(12, 'Camera', 500.00, 'Electronics', 40),
(13, 'Flashlight', 25.00, 'Tools', 200),
(14, 'Shirt', 30.00, 'Clothing', 150),
(15, 'Jeans', 45.00, 'Clothing', 120),
(16, 'Jacket', 80.00, 'Clothing', 70),
(17, 'Shoes', 60.00, 'Clothing', 100),
(18, 'Hat', 20.00, 'Accessories', 50),
(19, 'Socks', 10.00, 'Clothing', 200),
(20, 'T-Shirt', 25.00, 'Clothing', 150),
(21, 'Lamp', 60.00, 'Furniture', 40),
(22, 'Coffee Table', 100.00, 'Furniture', 35),
(23, 'Book', 15.00, 'Stationery', 250),
(24, 'Rug', 90.00, 'Furniture', 60),
(25, 'Cup', 5.00, 'Accessories', 500),
(26, 'Bag', 25.00, 'Accessories', 300),
(27, 'Couch', 450.00, 'Furniture', 15),
(28, 'Fridge', 600.00, 'Electronics', 20),
(29, 'Stove', 500.00, 'Electronics', 15),
(30, 'Microwave', 120.00, 'Electronics', 25),
(31, 'Air Conditioner', 350.00, 'Electronics', 10),
(32, 'Washing Machine', 450.00, 'Electronics', 15),
(33, 'Dryer', 400.00, 'Electronics', 10),
(34, 'Hair Dryer', 30.00, 'Accessories', 100),
(35, 'Iron', 40.00, 'Electronics', 50),
(36, 'Coffee Maker', 50.00, 'Electronics', 60),
(37, 'Blender', 35.00, 'Electronics', 40),
(38, 'Juicer', 55.00, 'Electronics', 30),
(39, 'Toaster', 40.00, 'Electronics', 70),
(40, 'Dishwasher', 500.00, 'Electronics', 20);*/
--1.Using Products table, find the total number of products available in each category.
SELECT Category, COUNT(*) AS TotalProducts
FROM Products
GROUP BY Category;
--2.Using Products table, get the average price of products in the 'Electronics' category.
SELECT AVG(Price) AS AveragePrice
FROM Products
WHERE Category = 'Electronics';    
--3.Using Customers table, list all customers from cities that start with 'L'.
select *
from Customers
where City LIKE 'L%';
--4.Using Products table, get all product names that end with 'er'.
Select Productname from Products
where Productname like '%er'
--5.Using Customers table, list all customers from countries ending in 'A'.
Select*from Customers
where Country like '%A'
--6.Using Products table, show the highest price among all products.
Select max(price) as highprice from Products
--7.Using Products table, label stock as 'Low Stock' if quantity < 30, else 'Sufficient'
Select StockQuantity,
       case
           when StockQuantity < 30 then 'Low Stock'
           else 'Sufficient'
       end as StockStatus
from Products;
--8.Using Customers table, find the total number of customers in each country.
Select Country,count(*) as TotalNumber 
from Customers
group by Country
--9.Using Orders table, find the minimum and maximum quantity ordered.
Select min(Quantity) as minquantity,
max(Quantity) as maxquantity from
Orders
--10.Using Orders and Invoices tables, list customer IDs who placed orders in 2023 January to find those who did not have invoices.
/* CREATE TABLE Invoices (
    InvoiceID INT PRIMARY KEY,
    CustomerID INT,
    InvoiceDate DATE,
    TotalAmount DECIMAL(10, 2)
);
INSERT INTO Invoices (InvoiceID, CustomerID, InvoiceDate, TotalAmount) VALUES
(1, 1, '2023-01-05', 150.00),
(2, 2, '2023-01-07', 200.00),
(3, 3, '2023-01-10', 250.00),
(4, 4, '2023-01-12', 300.00),
(5, 5, '2023-01-15', 350.00),
(6, 6, '2023-01-18', 400.00),
(7, 7, '2023-01-20', 450.00),
(8, 8, '2023-01-23', 500.00),
(9, 9, '2023-01-25', 550.00),
(10, 10, '2023-01-28', 600.00),
(11, 11, '2023-02-02', 150.00),
(12, 12, '2023-02-04', 200.00),
(13, 13, '2023-02-07', 250.00),
(14, 14, '2023-02-09', 300.00),
(15, 15, '2023-02-11', 350.00),
(16, 16, '2023-02-13', 400.00),
(17, 17, '2023-02-15', 450.00),
(18, 18, '2023-02-17', 500.00),
(19, 19, '2023-02-19', 550.00),
(20, 20, '2023-02-21', 600.00),
(21, 21, '2023-02-24', 150.00),
(22, 22, '2023-02-26', 200.00),
(23, 23, '2023-02-28', 250.00),
(24, 24, '2023-03-02', 300.00),
(25, 25, '2023-03-04', 350.00),
(26, 26, '2023-03-06', 400.00),
(27, 27, '2023-03-08', 450.00),
(28, 28, '2023-03-10', 500.00),
(29, 29, '2023-03-12', 550.00),
(30, 30, '2023-03-14', 600.00),
(31, 31, '2023-03-17', 150.00),
(32, 32, '2023-03-19', 200.00),
(33, 33, '2023-03-21', 250.00),
(34, 34, '2023-03-23', 300.00),
(35, 35, '2023-03-25', 350.00),
(36, 36, '2023-03-27', 400.00),
(37, 37, '2023-03-29', 450.00),
(38, 38, '2023-03-31', 500.00),
(39, 39, '2023-04-02', 550.00),
(40, 40, '2023-04-04', 600.00);*/
Select distinct o.CustomerID
From Orders o
Left join Invoices i on o.CustomerID = i.CustomerID
    and i.InvoiceDate between '2023-01-01' and '2023-01-31'
Where o.OrderDate between '2023-01-01' and '2023-01-31'
  and i.InvoiceID is null;
  --11.Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted including duplicates.
  Select ProductName from Products
union ALL
Select ProductName from Products_Discounted;
--12.Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted without duplicates
Select ProductName from Products
Union 
Select ProductName from Products_Discounted;
--13.Using Orders table, find the average order amount by year.
SELECT 
    YEAR(OrderDate) AS OrderYear,
    AVG(TotalAmount) AS AverageOrderAmount
FROM Orders
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear;
--14.Using Products table, group products based on price: 'Low' (<100), 'Mid' (100-500), 'High' (>500). Return productname and pricegroup.
SELECT 
    ProductName,
    CASE
        WHEN Price < 100 THEN 'Low'
        WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
        ELSE 'High'
    END AS PriceGroup
FROM Products;
--15.Using City_Population table, use Pivot to show values of Year column in seperate columns ([2012], [2013]) and copy results to a new Population_Each_Year table.
/*create table city_population ( district_id int, district_name varchar(30),population decimal(10,2),year varchar(20))
insert into city_population values 
(1,'Chilonzor',2500,2012),
(2,'Yakkasaroy',1500,2012),
(3,'Mirobod',3000,2012),
(4,'Yashnobod',1000,2012),
(5,'Bektemir',2000,2012),
(1,'Chilonzor',2800,2013),
(2,'Yakkasaroy',1900,2013),
(3,'Mirobod',2000,2013),
(4,'Yashnobod',5000,2013),
(5,'Bektemir',1500,2013)*/
SELECT *
INTO Population_Each_Year
FROM (
    SELECT 
       Year,
        Population
    FROM City_Population
) AS SourceTable
PIVOT (
    SUM(Population)
    FOR Year IN ([2012], [2013])
) AS PivotTable;
--16.Using Sales table, find total sales per product Id.
SELECT 
    ProductID,
    SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ProductID;
--17.Using Products table, use wildcard to find products that contain 'oo' in the name. Return productname.
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%oo%';
--18.Using City_Population table, use Pivot to show values of City column in seperate columns (Bektemir, Chilonzor, Yakkasaroy) and copy results to a new Population_Each_City table.
SELECT *
INTO Population_Each_City
FROM (
    SELECT 
        Year,
        City,
        Population
    FROM City_Population
) AS SourceTable
PIVOT (
    SUM(Population)
    FOR City IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS PivotTable;
--19.Using Invoices table, show top 3 customers with the highest total invoice amount. Return CustomerID and Totalspent.
SELECT TOP 3 
    CustomerID, 
    SUM(TotalAmount) AS TotalSpent
FROM Invoices
GROUP BY CustomerID
ORDER BY TotalSpent DESC;
--20.Transform Population_Each_Year table to its original format (City_Population).
SELECT 
   district_name,
    Year,
    Population
INTO City_Population
FROM (
    SELECT 
        district_name,
        [2012],
        [2013]
    FROM Population_Each_Year
) AS PivotedData
UNPIVOT (
    Population FOR Year IN ([2012], [2013])
) AS UnpivotedData;
--21.Using Products and Sales tables, list product names and the number of times each has been sold. (Research for Joins)
SELECT 
    p.ProductName,
    COUNT(s.SaleID) AS TimesSold
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName;
--22.Transform Population_Each_City table to its original format (City_Population).
SELECT City, '2020' AS Year, [2020] AS Population FROM Population_Each_City
UNION ALL
SELECT City, '2021' AS Year, [2021] AS Population FROM Population_Each_City
UNION ALL
SELECT City, '2022' AS Year, [2022] AS Population FROM Population_Each_City;
