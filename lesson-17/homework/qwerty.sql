--1.You must provide a report of all distributors and their sales by region. 
--If a distributor did not have any sales for a region, rovide a zero-dollar value for that day.
--Assume there is at least one sale for each region
/*DROP TABLE IF EXISTS #RegionSales;
GO
CREATE TABLE #RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
GO
INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);*/
WITH AllDistributors  AS (
    SELECT DISTINCT Distributor FROM #RegionSales
),
AllRegions AS (
    SELECT DISTINCT Region FROM #RegionSales
),
AllCombinations AS (
    SELECT r.Region, d.Distributor
    FROM AllRegions r
    CROSS JOIN AllDistributors d
)
SELECT 
    ac.Region,
    ac.Distributor,
    ISNULL(rs.Sales, 0) AS Sales
FROM AllCombinations ac
LEFT JOIN #RegionSales rs
    ON ac.Region = rs.Region AND ac.Distributor = rs.Distributor
ORDER BY ac.Region, ac.Distributor;
--2.Find managers with at least five direct reports
/*CREATE TABLE Employes (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employes;
INSERT INTO Employes VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);*/
SELECT managerId
FROM Employes
WHERE managerId IS NOT NULL
GROUP BY managerId
HAVING COUNT(*) >= 5;
--3.Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
/*CREATE TABLE Products1 (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders2 (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products1;
INSERT INTO Products1 VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders2;
INSERT INTO Orders2 VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);*/
/*select* from products1
select * from orders2*/
with productname as
(select product_id,
sum(unit) as totalunit
from orders2
where order_date>='2020-02-01' and order_date<'2020-03-01'
group by product_id
having sum(unit)>=100
)
select
    p.product_name,
    pn.totalunit
from Productname pn
join Products1 p on p.product_id = pn.product_id;
--4.Write an SQL statement that returns the vendor from which each customer
--has placed the most orders
/*DROP TABLE Orders3;
CREATE TABLE Orders3 (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);
INSERT INTO Orders3 VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');
select * from orders3*/
with cte as(
select 
	customerID,
	vendor,
	count(*) AS CNT
from ORDERS3
group by 
	customerID,
	vendor
	),
cte2 as(
SELECT 
	customerID,
		max(CNT) cnt2
from cte
group by
	customerID
)
select o.customerID, Vendor
from cte o
join cte2 c
on o.customerID = c.customerID
and o.CNT = c.cnt2
--5.You will be given a number as a variable called @Check_Prime check if this number is prime then return 
--'This number is prime' else eturn 'This number is not prime'
DECLARE @Check_Prime INT = 29; 
DECLARE @IsPrime BIT = 1;       

IF @Check_Prime <= 1
BEGIN
    SET @IsPrime = 0;
END
ELSE
BEGIN
    DECLARE @i INT = 2;
    WHILE @i <= SQRT(@Check_Prime)
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @IsPrime = 0;
            BREAK;
        END
        SET @i = @i + 1;
    END
ENd
IF @IsPrime = 1
  PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';
--6.Write an SQL query to return the number of locations,in which location most signals sent, 
--and total number of signal for each device from the given table.
/*CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');*/
WITH LocationCounts AS (
    SELECT 
        Locations,
        COUNT(*) AS SignalCount
    FROM Device
    GROUP BY Locations
),
MaxLocation AS (
    SELECT TOP 1 Locations, SignalCount
    FROM LocationCounts
    ORDER BY SignalCount DESC
),
DeviceSignalTotals AS (
    SELECT 
        Device_id,
        COUNT(*) AS TotalSignals
    FROM Device
    GROUP BY Device_id
)
SELECT 
    (SELECT COUNT(DISTINCT Locations) FROM Device) AS NumberOfLocations,
    (SELECT Locations FROM MaxLocation) AS LocationWithMostSignals,
    dst.Device_id,
    dst.TotalSignals
FROM DeviceSignalTotals dst;
--7. Write a SQL to find all Employees who earn more than the average salary in their corresponding department. 
--Return EmpID, EmpName,Salary in your output
/*CREATE TABLE Employeee (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);
INSERT INTO Employeee VALUES
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);*/
select empid,
empname,
deptid,
salary
from employeee e
where salary>=(select avg(salary) from employeee
where DeptID = e.DeptID)
--8.You are part of an office lottery pool where you keep a table of the winning 
--lottery numbers along with a table of each ticket’s chosen numbers. 
--If a ticket has some but not all the winning numbers, you win $10. 
--If a ticket has all the winning numbers, you win $100. 
WITH TotalWinningNumbers AS (
    SELECT COUNT(*) AS TotalWins FROM WinningNumbers
),
TicketMatches AS (
    SELECT
        t.TicketID,
        COUNT(DISTINCT t.ChosenNumber) AS MatchedWins
    FROM Tickets t
    JOIN WinningNumbers w ON t.ChosenNumber = w.WinningNumber
    GROUP BY t.TicketID
),
TicketWinnings AS (
    SELECT
        tm.TicketID,
        CASE
            WHEN tm.MatchedWins = tw.TotalWins THEN 100
            WHEN tm.MatchedWins > 0 THEN 10
            ELSE 0
        END AS Winnings
    FROM TicketMatches tm
    CROSS JOIN TotalWinningNumbers tw
)
SELECT SUM(Winnings) AS TotalWinnings
FROM TicketWinnings;
/*CREATE TABLE WinningNumbers (
  WinningNumber INT
);

CREATE TABLE Tickets (
  TicketID INT,
  ChosenNumber INT
);
*/
--9.The Spending table keeps the logs of the spendings history of users that make 
--purchases from an online shopping website which has a desktop and a mobile devices.
--Write an SQL query to find the total number of users and the total amount spent using mobile only,
--desktop only and both mobile and desktop together for each date.
/*CREATE TABLE Spending (
  User_id INT,
  Spend_date DATE,
  Platform VARCHAR(10),
  Amount INT
);
INSERT INTO Spending VALUES
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);*/
WITH UserPlatformSummary AS (
  SELECT
    User_id,
    Spend_date,
    MAX(CASE WHEN Platform = 'Mobile' THEN 1 ELSE 0 END) AS HasMobile,
    MAX(CASE WHEN Platform = 'Desktop' THEN 1 ELSE 0 END) AS HasDesktop,
    SUM(Amount) AS TotalAmount
  FROM Spending
  GROUP BY User_id, Spend_date
)
SELECT
  Spend_date,
  CASE
    WHEN HasMobile = 1 AND HasDesktop = 0 THEN 'Mobile Only'
    WHEN HasMobile = 0 AND HasDesktop = 1 THEN 'Desktop Only'
    WHEN HasMobile = 1 AND HasDesktop = 1 THEN 'Both'
  END AS PlatformType,
  COUNT(DISTINCT User_id) AS UserCount,
  SUM(TotalAmount) AS TotalSpent
FROM UserPlatformSummary
GROUP BY Spend_date, PlatformType
ORDER BY Spend_date, PlatformType;
--10.Write an SQL Statement to de-group the following data.
/*DROP TABLE IF EXISTS Grouped;
CREATE TABLE Grouped1
(
  Product  VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);
INSERT INTO Grouped1 (Product, Quantity) VALUES
('Pencil', 3), ('Eraser', 4), ('Notebook', 2);*/
WITH RECURSIVE DeGrouped AS (
  SELECT Product, Quantity
  FROM Grouped1
  WHERE Quantity > 0
  UNION ALL
  SELECT Product, Quantity - 1
  FROM DeGrouped
  WHERE Quantity > 1
)
SELECT Product
FROM DeGrouped
ORDER BY Product;
