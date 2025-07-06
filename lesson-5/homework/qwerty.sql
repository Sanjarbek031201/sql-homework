--1.Write a query that uses an alias to rename the ProductName column as Name in the Products table.
Select ProductName AS Name
From Products;
--2.Write a query that uses an alias to rename the Customers table as Client for easier reference.
Select *
From Customers as Client;
--3.Use UNION to combine results from two queries that select ProductName from Products and ProductName from Products_Discounted.
Select ProductName from Products
union
Select ProductName from Products_Discounted;
--4.Write a query to find the intersection of Products and Products_Discounted tables using INTERSECT.
Select ProductName from Products
intersect
Select ProductName from Products_Discounted;
--5.Write a query to select distinct customer names and their corresponding Country using SELECT DISTINCT.
Select distinct FirstName as CustomerName, Country
from Customers;
--6.Write a query that uses CASE to create a conditional column that displays 'High' if Price > 1000, and 'Low' if Price <= 1000 from Products table.
Select ProductName, Price,
       Case
           When  Price > 1000 then 'High'
           Else 'Low'
       End as PriceCategory
From Products;
--7.Use IIF to create a column that shows 'Yes' if Stock > 100, and 'No' otherwise (Products_Discounted table, StockQuantity column).
SELECT ProductName, StockQuantity,
       IIF(StockQuantity > 100, 'Yes', 'No') AS InStock
FROM Products_Discounted;
--8.Use UNION to combine results from two queries that select ProductName from Products and ProductName from Products_Discounted tables.
Select ProductName from Products
union
Select ProductName from Products_Discounted;
--9.Write a query that returns the difference between the Products and Products_Discounted tables using EXCEPT.
Select ProductName from Products
Except
Select ProductName From Products_Discounted;
--10.Create a conditional column using IIF that shows 'Expensive' if the Price is greater than 1000, and 'Affordable' if less, from Products table.
SELECT ProductName, Price,
       IIF(Price > 100, 'Expensive', 'Affordable') AS Pricecatogry
FROM Products;
11.Write a query to find employees in the Employees table who have either Age < 25 or Salary > 60000.
Select* from Employees
where Age<25 and Salary>60000;
--12.Update the salary of an employee based on their departmentname, increase by 10% if they work in 'HR' or EmployeeID = 5
Update Employees 
set Salary=Salary*1.10
Where DepartmentName='hr' or employeeId=5;
--13.Write a query that uses CASE to assign 'Top Tier' if SaleAmount > 500, 'Mid Tier' if SaleAmount BETWEEN 200 AND 500, and 'Low Tier' otherwise. (From Sales table)
/*CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    CustomerID INT,
    SaleDate DATE,
    SaleAmount DECIMAL(10, 2)
);
INSERT INTO Sales (SaleID, ProductID, CustomerID, SaleDate, SaleAmount) VALUES
(1, 1, 1, '2023-01-01', 150.00),
(2, 2, 2, '2023-01-02', 200.00),
(3, 3, 3, '2023-01-03', 250.00),
(4, 4, 4, '2023-01-04', 300.00),
(5, 5, 5, '2023-01-05', 350.00),
(6, 6, 6, '2023-01-06', 400.00),
(7, 7, 7, '2023-01-07', 450.00),
(8, 8, 8, '2023-01-08', 500.00),
(9, 9, 9, '2023-01-09', 550.00),
(10, 10, 10, '2023-01-10', 600.00),
(11, 1, 1, '2023-01-11', 150.00),
(12, 2, 2, '2023-01-12', 200.00),
(13, 3, 3, '2023-01-13', 250.00),
(14, 4, 4, '2023-01-14', 300.00),
(15, 5, 5, '2023-01-15', 350.00),
(16, 6, 6, '2023-01-16', 400.00),
(17, 7, 7, '2023-01-17', 450.00),
(18, 8, 8, '2023-01-18', 500.00),
(19, 9, 9, '2023-01-19', 550.00),
(20, 10, 10, '2023-01-20', 600.00),
(21, 1, 2, '2023-01-21', 150.00),
(22, 2, 3, '2023-01-22', 200.00),
(23, 3, 4, '2023-01-23', 250.00),
(24, 4, 5, '2023-01-24', 300.00),
(25, 5, 6, '2023-01-25', 350.00),
(26, 6, 7, '2023-01-26', 400.00),
(27, 7, 8, '2023-01-27', 450.00),
(28, 8, 9, '2023-01-28', 500.00),
(29, 9, 10, '2023-01-29', 550.00),
(30, 10, 1, '2023-01-30', 600.00),
(31, 1, 2, '2023-02-01', 150.00),
(32, 2, 3, '2023-02-02', 200.00),
(33, 3, 4, '2023-02-03', 250.00),
(34, 4, 5, '2023-02-04', 300.00),
(35, 5, 6, '2023-02-05', 350.00),
(36, 6, 7, '2023-02-06', 400.00),
(37, 7, 8, '2023-02-07', 450.00),
(38, 8, 9, '2023-02-08', 500.00),
(39, 9, 10, '2023-02-09', 550.00),
(40, 10, 1, '2023-02-10', 600.00);*/
Select SaleAmount,
       Case
           When SaleAmount > 500 Then 'Top Tier'
           When SaleAmount between 200 and 500 then 'Mid Tier'
           else 'Low Tier'
       End as SaleCategory
from Sales;
--14.Use EXCEPT to find customers' ID who have placed orders but do not have a corresponding record in the Sales table.
SELECT CustomerID
FROM Orders
EXCEPT
SELECT CustomerID
FROM Sales;
--15.Write a query that uses a CASE statement to determine the discount percentage based on the quantity purchased. Use orders table. Result set should show customerid, quantity and discount percentage. The discount should be applied as follows: 1 item: 3% Between 1 and 3 items : 5% Otherwise: 7%
SELECT CustomerID, Quantity,
       CASE
           WHEN Quantity = 1 THEN 3
           WHEN Quantity > 1 AND Quantity <= 3 THEN 5
           ELSE 7
       END AS DiscountPercentage
FROM Orders;
