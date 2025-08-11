/*CREATE TABLE #Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10,2),
    SaleDate DATE
);
INSERT INTO #Sales (CustomerName, Product, Quantity, Price, SaleDate) VALUES
('Alice', 'Laptop', 1, 1200.00, '2024-01-15'),
('Bob', 'Smartphone', 2, 800.00, '2024-02-10'),
('Charlie', 'Tablet', 1, 500.00, '2024-02-20'),
('David', 'Laptop', 1, 1300.00, '2024-03-05'),
('Eve', 'Smartphone', 3, 750.00, '2024-03-12'),
('Frank', 'Headphones', 2, 100.00, '2024-04-08'),
('Grace', 'Smartwatch', 1, 300.00, '2024-04-25'),
('Hannah', 'Tablet', 2, 480.00, '2024-05-05'),
('Isaac', 'Laptop', 1, 1250.00, '2024-05-15'),
('Jack', 'Smartphone', 1, 820.00, '2024-06-01');*/
select* from #sales
--1. Find customers who purchased at least one item in March 2024 using EXISTS
SELECT *
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s2.CustomerName = s1.CustomerName
      AND s2.SaleDate >= '2024-03-01'
      AND s2.SaleDate < '2024-04-01'
);
--2. Find the product with the highest total sales revenue using a subquery.
SELECT Product, SUM(Quantity * Price) AS TotalRevenue
FROM #Sales
GROUP BY Product
HAVING SUM(Quantity * Price) = (
    SELECT MAX(TotalRevenue)
    FROM (
        SELECT Product, SUM(Quantity * Price) AS TotalRevenue
        FROM #Sales
        GROUP BY Product
    ) AS RevenuePerProduct
);
--3. Find the second highest sale amount using a subquery
select	max(quantity*price) as secondhighest 
from #sales
where price<(select	max(quantity*price)  
from #sales);
--4. Find the total quantity of products sold per month using a subquery
select distinct 
    format(saledate, 'yyyy-MM') as salemonth,
    (
        select sum(quantity)
        from #sales s2
        where format(s2.saledate, 'yyyy-MM') = format(s1.saledate, 'yyyy-MM')
    ) as totalquantity
from #sales s1
order by salemonth;
--5. Find customers who bought same products as another customer using EXISTS
select distinct s1.customername from #sales s1
where exists (
select 1 from #sales s2
where s1.product=s2.product
and s1.customername<>s2.customername);
--6.Return how many fruits does each person have in individual fruit level
/*create table Fruits(Name varchar(50), Fruit varchar(50))
insert into Fruits values 
('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Orange'),
('Francesko', 'Banana'), ('Francesko', 'Orange'), ('Li', 'Apple'), 
('Li', 'Orange'), ('Li', 'Apple'), ('Li', 'Banana'), ('Mario', 'Apple'), ('Mario', 'Apple'), 
('Mario', 'Apple'), ('Mario', 'Banana'), ('Mario', 'Banana'), ('Mario', 'Orange');*/
/*select * from fruits */
select
name,fruit,
count(*) as numberoffruits from fruits
group by name,fruit
order by name,fruit;
--7.Return older people in the family with younger ones
/*create table Family(ParentId int, ChildID int)
insert into Family values (1, 2), (2, 3), (3, 4)*/
select parentid as OlderPerson, childid as YoungerPerson
from family;
--8.Write an SQL statement given the following requirements. For every customer that had a delivery to California, 
--provide a result set of the customer orders that were delivered to Texas
/*CREATE TABLE #Orders
(
CustomerID     INTEGER,
OrderID        INTEGER,
DeliveryState  VARCHAR(100) NOT NULL,
Amount         MONEY NOT NULL,
PRIMARY KEY (CustomerID, OrderID)
);
INSERT INTO #Orders (CustomerID, OrderID, DeliveryState, Amount) VALUES
(1001,1,'CA',340),(1001,2,'TX',950),(1001,3,'TX',670),
(1001,4,'TX',860),(2002,5,'WA',320),(3003,6,'CA',650),
(3003,7,'CA',830),(4004,8,'TX',120);*/
select * from #orders o
where o.deliveryState='tx' and exists
(select 1 from #orders ca
where ca.deliveryState='ca'
and o.customerid=ca.customerid)
order by customerid, orderid;
--9. Insert the names of residents if they are missing
/*create table #residents(resid int identity, fullname varchar(50), address varchar(100))
insert into #residents values 
('Dragan', 'city=Bratislava country=Slovakia name=Dragan age=45'),
('Diogo', 'city=Lisboa country=Portugal age=26'),
('Celine', 'city=Marseille country=France name=Celine age=21'),
('Theo', 'city=Milan country=Italy age=28'),
('Rajabboy', 'city=Tashkent country=Uzbekistan age=22')*/
update #residents
set address = concat(address, ' name=', fullname)
where address NOT LIKE '%name=%';
--10. Write a query to return the route to reach from Tashkent to Khorezm. 
--The result should include the cheapest and the most expensive routes
CREATE TABLE #Routes
(
RouteID        INTEGER NOT NULL,
DepartureCity  VARCHAR(30) NOT NULL,
ArrivalCity    VARCHAR(30) NOT NULL,
Cost           MONEY NOT NULL,
PRIMARY KEY (DepartureCity, ArrivalCity)
);
/*INSERT INTO #Routes (RouteID, DepartureCity, ArrivalCity, Cost) VALUES
(1,'Tashkent','Samarkand',100),
(2,'Samarkand','Bukhoro',200),
(3,'Bukhoro','Khorezm',300),
(4,'Samarkand','Khorezm',400),
(5,'Tashkent','Jizzakh',100),
(6,'Jizzakh','Samarkand',50);*/
with RecCte as(
SELECT 
    RouteID,
    DepartureCity,
    ArrivalCity,
    Cost,
    cast(DepartureCity + ' -> ' + ArrivalCity as varchar(max)) AS Path
FROM #Routes
WHERE DepartureCity = 'Tashkent'
UNION ALL
SELECT
    r.RouteID,
    rc.DepartureCity,
    r.ArrivalCity,
    rc.Cost + r.Cost AS Cost,
  cast(Path + ' -> ' + r.ArrivalCity as varchar(max)) as Path
FROM RecCte rc
JOIN #Routes r
on rc.ArrivalCity = r.DepartureCity
where rc.arrivalCity <> 'Khorezm'
),
cte2 as(
select
  path,
  Cost,
  case
    when Cost = MIN(cost) over() then 'Cheapest'
    when Cost = MAX(cost) over() then 'Most Expensive'
  end as Category
from RecCte
where ArrivalCity = 'Khorezm'
)
select *
from cte2
where Category is not null
 --11.Rank products based on their order of insertion.
/*CREATE TABLE #RankingPuzzle
(
     ID INT
    ,Vals VARCHAR(10)
)
INSERT INTO #RankingPuzzle VALUES
(1,'Product'),
(2,'a'),
(3,'a'),
(4,'a'),
(5,'a'),
(6,'Product'),
(7,'b'),
(8,'b'),
(9,'Product'),
(10,'c')*/
--select* from #RankingPuzzle
with product_starts as (
    select id as product_id,
           row_number() over (order by id) as product_group
    from #RankingPuzzle
    where vals = 'Product'
);
select 
    ps.product_group,
    p.id,
    p.vals,
    row_number() over (partition by ps.product_id order by p.id) as product_rank
from product_starts ps
join #RankingPuzzle p on p.id > ps.product_id
where not exists (
    select 1 
    from #RankingPuzzle nx
    where nx.id > ps.product_id 
      and nx.id < p.id 
      and nx.vals = 'Product'
)
order by p.id;
--12.Find employees whose sales were higher than the average sales in their department
/*CREATE TABLE #EmployeeSales (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    SalesAmount DECIMAL(10,2),
    SalesMonth INT,
    SalesYear INT
);

INSERT INTO #EmployeeSales (EmployeeName, Department, SalesAmount, SalesMonth, SalesYear) VALUES
('Alice', 'Electronics', 5000, 1, 2024),
('Bob', 'Electronics', 7000, 1, 2024),
('Charlie', 'Furniture', 3000, 1, 2024),
('David', 'Furniture', 4500, 1, 2024),
('Eve', 'Clothing', 6000, 1, 2024),
('Frank', 'Electronics', 8000, 2, 2024),
('Grace', 'Furniture', 3200, 2, 2024),
('Hannah', 'Clothing', 7200, 2, 2024),
('Isaac', 'Electronics', 9100, 3, 2024),
('Jack', 'Furniture', 5300, 3, 2024),
('Kevin', 'Clothing', 6800, 3, 2024),
('Laura', 'Electronics', 6500, 4, 2024),
('Mia', 'Furniture', 4000, 4, 2024),
('Nathan', 'Clothing', 7800, 4, 2024);*/
WITH RankedSales AS (
  SELECT
    EmployeeID,
    EmployeeName,
    Department,
    SalesAmount,
    SalesMonth,
    SalesYear,
    ROW_NUMBER() OVER (
      PARTITION BY Department, SalesYear, SalesMonth
      ORDER BY SalesAmount DESC
    ) AS RankInMonth
  FROM #EmployeeSales
)
SELECT
  EmployeeID,
  EmployeeName,
  Department,
  SalesAmount,
  SalesMonth,
  SalesYear
FROM RankedSales
WHERE RankInMonth = 1;
--13. Find employees who had the highest sales in any given month using EXISTS
with cte as
( select EmployeeName,
year(SalesYear) as sy,
month(salesMonth) as sm,
sum(SalesAmount) as amount,
rank() over(partition by year(SalesYear),
month(salesMonth) order by sum(salesamount) desc) as sales_rank
from #EmployeeSales
group by EmployeeName,
year(SalesYear) ,
month(salesMonth) ,
) 
select employeename,
sy,
sm,
amount
from cte
where sales_rank=1;
--14. Find employees who made sales in every month using NOT EXISTS
SELECT DISTINCT e.EmployeeID, e.EmployeeName
FROM #EmployeeSales AS e
WHERE NOT EXISTS (
  -- For any month in the data...
  SELECT 1
  FROM (
    SELECT DISTINCT SalesYear, SalesMonth
    FROM #EmployeeSales
  ) AS months
  -- ... ensure the employee does not lack a sale in that month
  WHERE NOT EXISTS (
    SELECT 1
    FROM #EmployeeSales AS s2
    WHERE s2.EmployeeID = e.EmployeeID
      AND s2.SalesYear = months.SalesYear
      AND s2.SalesMonth = months.SalesMonth
  )
);
--15. Retrieve the names of products that are more expensive than the average price of all products.
/*CREATE TABLE Products (
    ProductID   INT PRIMARY KEY,
    Name        VARCHAR(50),
    Category    VARCHAR(50),
    Price       DECIMAL(10,2),
    Stock       INT
);

INSERT INTO Products (ProductID, Name, Category, Price, Stock) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 15),
(2, 'Smartphone', 'Electronics', 800.00, 30),
(3, 'Tablet', 'Electronics', 500.00, 25),
(4, 'Headphones', 'Accessories', 150.00, 50),
(5, 'Keyboard', 'Accessories', 100.00, 40),
(6, 'Monitor', 'Electronics', 300.00, 20),
(7, 'Mouse', 'Accessories', 50.00, 60),
(8, 'Chair', 'Furniture', 200.00, 10),
(9, 'Desk', 'Furniture', 400.00, 5),
(10, 'Printer', 'Office Supplies', 250.00, 12),
(11, 'Scanner', 'Office Supplies', 180.00, 8),
(12, 'Notebook', 'Stationery', 10.00, 100),
(13, 'Pen', 'Stationery', 2.00, 500),
(14, 'Backpack', 'Accessories', 80.00, 30),
(15, 'Lamp', 'Furniture', 60.00, 25);*/
SELECT productname
FROM Products
WHERE Price > (
    SELECT AVG(Price)
    FROM Products
);
--16. Find the products that have a stock count lower than the highest stock count.
select productname from products
where stockquantity<(
select max(stockquantity) from products)
;
--17. Get the names of products that belong to the same category as 'Laptop'.
select productname from products
where category=(
select category from products
where category='laptop');
--18. Retrieve products whose price is greater than the lowest price in the Electronics category.
select productname from products 
where price<(
select min(price)
from products
where category='electronics');
--19. Find the products that have a higher price than the average price of their respective category.
SELECT p.productName
FROM Products p
WHERE p.Price > (
    SELECT AVG(p2.Price)
    FROM Products p2
    WHERE p2.Category = p.Category
);
/*CREATE TABLE Orders5 (
    OrderID    INT PRIMARY KEY,
    ProductID  INT,
    Quantity   INT,
    OrderDate  DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Orders5 (OrderID, ProductID, Quantity, OrderDate) VALUES
(1, 1, 2, '2024-03-01'),
(2, 3, 5, '2024-03-05'),
(3, 2, 3, '2024-03-07'),
(4, 5, 4, '2024-03-10'),
(5, 8, 1, '2024-03-12'),
(6, 10, 2, '2024-03-15'),
(7, 12, 10, '2024-03-18'),
(8, 7, 6, '2024-03-20'),
(9, 6, 2, '2024-03-22'),
(10, 4, 3, '2024-03-25'),
(11, 9, 2, '2024-03-28'),
(12, 11, 1, '2024-03-30'),
(13, 14, 4, '2024-04-02'),
(14, 15, 5, '2024-04-05'),
(15, 13, 20, '2024-04-08');*/
--20. Find the products that have been ordered at least once
SELECT DISTINCT p.orderid
FROM orders5 p
JOIN OrderDetails od ON p.ProductID = od.ProductID;
--21. Retrieve the names of products that have been ordered more than the average quantity ordered.
SELECT DISTINCT p.productName
FROM Products p
JOIN Orders5 o ON p.ProductID = o.ProductID
WHERE o.Quantity > (
    SELECT AVG(Quantity)
    FROM Orders5
);
--22.Find the products that have never been ordered.
SELECT productName
FROM Products
WHERE ProductID NOT IN (
    SELECT DISTINCT ProductID
    FROM Orders5
);
--23. Retrieve the product with the highest total quantity ordered.
SELECT p.productName
FROM Products p
JOIN Orders5 o ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.productName
ORDER BY SUM(o.Quantity) DESC;
