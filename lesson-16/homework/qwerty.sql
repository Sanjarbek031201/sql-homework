--1.Create a numbers table using a recursive query from 1 to 1000
WITH Numbers (n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1
    FROM Numbers
    WHERE n < 1000
)
SELECT n
FROM Numbers
OPTION (MAXRECURSION 1000);
--2.Write a query to find the total sales per employee using a derived table.(Sales, Employees)
SELECT e.Name, s.TotalSales
FROM Employees e
JOIN (
    SELECT EmpID, SUM(SaleAmount) AS TotalSales
    FROM Sales
    GROUP BY EmpID
) AS s
ON e.EmpID = s.EmpID;
--3.Create a CTE to find the average salary of employees.(Employees)
WITH avgsalary (avs) AS (
    SELECT AVG(salary) FROM employees
)
SELECT avs
FROM avgsalary;
/*CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, DepartmentID, FirstName, LastName, Salary) VALUES
(1, 1, 'John', 'Doe', 60000.00),
(2, 1, 'Jane', 'Smith', 65000.00),
(3, 2, 'James', 'Brown', 70000.00),
(4, 3, 'Mary', 'Johnson', 75000.00),
(5, 4, 'Linda', 'Williams', 80000.00),
(6, 2, 'Michael', 'Jones', 85000.00),
(7, 1, 'Robert', 'Miller', 55000.00),
(8, 3, 'Patricia', 'Davis', 72000.00),
(9, 4, 'Jennifer', 'García', 77000.00),
(10, 1, 'William', 'Martínez', 69000.00);*/
--4.Write a query using a derived table to find the highest sales for each product.(Sales, Products)
select * from products
/*CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    EmployeeID INT,
    ProductID INT,
    SalesAmount DECIMAL(10, 2),
    SaleDate DATE
);
INSERT INTO Sales (SalesID, EmployeeID, ProductID, SalesAmount, SaleDate) VALUES
-- January 2025
(1, 1, 1, 1550.00, '2025-01-02'),
(2, 2, 2, 2050.00, '2025-01-04'),
(3, 3, 3, 1250.00, '2025-01-06'),
(4, 4, 4, 1850.00, '2025-01-08'),
(5, 5, 5, 2250.00, '2025-01-10'),
(6, 6, 6, 1450.00, '2025-01-12'),
(7, 7, 1, 2550.00, '2025-01-14'),
(8, 8, 2, 1750.00, '2025-01-16'),
(9, 9, 3, 1650.00, '2025-01-18'),
(10, 10, 4, 1950.00, '2025-01-20'),
(11, 1, 5, 2150.00, '2025-02-01'),
(12, 2, 6, 1350.00, '2025-02-03'),
(13, 3, 1, 2050.00, '2025-02-05'),
(14, 4, 2, 1850.00, '2025-02-07'),
(15, 5, 3, 1550.00, '2025-02-09'),
(16, 6, 4, 2250.00, '2025-02-11'),
(17, 7, 5, 1750.00, '2025-02-13'),
(18, 8, 6, 1650.00, '2025-02-15'),
(19, 9, 1, 2550.00, '2025-02-17'),
(20, 10, 2, 1850.00, '2025-02-19'),
(21, 1, 3, 1450.00, '2025-03-02'),
(22, 2, 4, 1950.00, '2025-03-05'),
(23, 3, 5, 2150.00, '2025-03-08'),
(24, 4, 6, 1700.00, '2025-03-11'),
(25, 5, 1, 1600.00, '2025-03-14'),
(26, 6, 2, 2050.00, '2025-03-17'),
(27, 7, 3, 2250.00, '2025-03-20'),
(28, 8, 4, 1350.00, '2025-03-23'),
(29, 9, 5, 2550.00, '2025-03-26'),
(30, 10, 6, 1850.00, '2025-03-29'),
(31, 1, 1, 2150.00, '2025-04-02'),
(32, 2, 2, 1750.00, '2025-04-05'),
(33, 3, 3, 1650.00, '2025-04-08'),
(34, 4, 4, 1950.00, '2025-04-11'),
(35, 5, 5, 2050.00, '2025-04-14'),
(36, 6, 6, 2250.00, '2025-04-17'),
(37, 7, 1, 2350.00, '2025-04-20'),
(38, 8, 2, 1800.00, '2025-04-23'),
(39, 9, 3, 1700.00, '2025-04-26'),
(40, 10, 4, 2000.00, '2025-04-29'),
(41, 1, 5, 2200.00, '2025-05-03'),
(42, 2, 6, 1650.00, '2025-05-07'),
(43, 3, 1, 2250.00, '2025-05-11'),
(44, 4, 2, 1800.00, '2025-05-15'),
(45, 5, 3, 1900.00, '2025-05-19'),
(46, 6, 4, 2000.00, '2025-05-23'),
(47, 7, 5, 2400.00, '2025-05-27'),
(48, 8, 6, 2450.00, '2025-05-31'),
(49, 9, 1, 2600.00, '2025-06-04'),
(50, 10, 2, 2050.00, '2025-06-08'),
(51, 1, 3, 1550.00, '2025-06-12'),
(52, 2, 4, 1850.00, '2025-06-16'),
(53, 3, 5, 1950.00, '2025-06-20'),
(54, 4, 6, 1900.00, '2025-06-24'),
(55, 5, 1, 2000.00, '2025-07-01'),
(56, 6, 2, 2100.00, '2025-07-05'),
(57, 7, 3, 2200.00, '2025-07-09'),
(58, 8, 4, 2300.00, '2025-07-13'),
(59, 9, 5, 2350.00, '2025-07-17'),
(60, 10, 6, 2450.00, '2025-08-01');*/
SELECT p.ProductName, s.MaxSale
FROM Products p
JOIN (
    SELECT ProductID, MAX(SalesAmount) AS MaxSale
    FROM Sales
    GROUP BY ProductID
) AS s ON p.ProductID = s.ProductID;
--5.Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.
WITH DoubledNumbers (n) AS (
    SELECT 1
    UNION ALL
    SELECT n * 2
    FROM DoubledNumbers
    WHERE n * 2 < 1000000
)
SELECT n
FROM DoubledNumbers
OPTION (MAXRECURSION 100);
--6.Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
WITH SalesCount AS (
    SELECT EmployeeID, COUNT(*) AS NumberOfSales
    FROM Sales
    GROUP BY EmployeeID
)
SELECT e.firstname
FROM Employees e
JOIN SalesCount sc ON e.EmployeeID = sc.EmployeeID
WHERE sc.NumberOfSales > 5;
--7.Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
WITH ProductSales AS (
    SELECT ProductID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
)
SELECT p.ProductName, ps.TotalSales
FROM Products p
JOIN ProductSales ps ON p.ProductID = ps.ProductID
WHERE ps.TotalSales > 500;
--8.Create a CTE to find employees with salaries above the average salary.(Employees)
WITH AvgSalaryCTE AS (
    SELECT AVG(Salary) AS AvgSalary
    FROM Employees
)
SELECT e.firstname, e.Salary
FROM Employees e
JOIN AvgSalaryCTE a ON e.Salary > a.AvgSalary;
--9.Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
with toporders as (select top 5 * from sales order by ProductID) select * from toporders
--10.Write a query using a derived table to find the sales per product category.(Sales, Products)
SELECT 
    p.category_name,
    SUM(sales_data.total_sales) AS category_sales
FROM 
    (
        SELECT 
            prod_id,
            qty_sold * unit_price AS total_sales
        FROM 
            Sales
    ) AS sales_data
JOIN 
    Products p ON sales_data.prod_id = p.prod_id
GROUP BY 
    p.category_name;
--11.Write a script to return the factorial of each value next to it.(Numbers1)
CREATE FUNCTION dbo.GetFactorial (@n INT)
RETURNS BIGINT
AS
BEGIN
    DECLARE @result BIGINT = 1;
    DECLARE @i INT = 1;
    WHILE @i <= @n
    BEGIN
        SET @result = @result * @i;
        SET @i = @i + 1;
    END
   RETURN @result;
END;
--12.This script uses recursion to split a string into rows of substrings for each character in the string.(Example)
/*CREATE TABLE Example
(
Id       INTEGER IDENTITY(1,1) PRIMARY KEY,
String VARCHAR(30) NOT NULL
);
INSERT INTO Example VALUES('123456789'),('abcdefghi');
*/
WITH RecursiveSplit AS (
    SELECT 
        Id,
        CAST(SUBSTRING(String, 1, 1) AS CHAR(1)) AS character,
        1 AS position,
        String
    FROM 
        Example

    UNION ALL
    SELECT 
        Id,
        CAST(SUBSTRING(String, position + 1, 1) AS CHAR(1)) AS character,
        position + 1,
        String
    FROM 
        RecursiveSplit
    WHERE 
        position + 1 <= LEN(String)
)

SELECT 
    Id,
    character,
    position
FROM 
    RecursiveSplit
ORDER BY 
    Id, position;
--13.Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Sales';
WITH MonthlySales AS (
    SELECT 
        YEAR(sales_date) AS year,
        MONTH(sales_date) AS month,
        SUM(sales_amount) AS total_sales
    FROM Sales
    GROUP BY 
        YEAR(sales_date), MONTH(sales_date)
),
SalesWithLag AS (
    SELECT 
        year,
        month,
        total_sales,
        LAG(total_sales) OVER (ORDER BY year, month) AS previous_month_sales
    FROM MonthlySales
)
SELECT 
    year,
    month,
    total_sales,
    previous_month_sales,
    total_sales - ISNULL(previous_month_sales, 0) AS difference
FROM 
    SalesWithLag
ORDER BY 
    year, month;
--14.Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)
SELECT 
    e.employee_id,
    e.employee_name
FROM 
    Employees e
JOIN 
    (
        SELECT 
            employee_id,
            DATEPART(QUARTER, sale_date) AS quarter,
            SUM(amount) AS total_sales
        FROM 
            Sales
        GROUP BY 
            employee_id, DATEPART(QUARTER, sale_date)
        HAVING 
            SUM(amount) > 45000
    ) AS sales_by_quarter
    ON e.employee_id = sales_by_quarter.employee_id
GROUP BY 
    e.employee_id, e.employee_name
HAVING 
    COUNT(DISTINCT sales_by_quarter.quarter) = 4;
--15.This script uses recursion to calculate Fibonacci numbers
WITH FibonacciCTE  AS (
    SELECT 1 AS position, 0 AS fibonacci
    UNION ALL
    SELECT 2 AS position, 1 AS fibonacci
    UNION ALL
 SELECT 
        position + 1 AS position,
        prev.fibonacci + curr.fibonacci AS fibonacci
    FROM 
        FibonacciCTE prev
    JOIN 
        FibonacciCTE curr ON prev.position = curr.position - 1
    WHERE 
        curr.position < 20  
)
SELECT * 
FROM FibonacciCTE
ORDER BY position
OPTION (MAXRECURSION 0);
--16.Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
/*CREATE TABLE FindSameCharacters
(
     Id INT
    ,Vals VARCHAR(10)
)
 
INSERT INTO FindSameCharacters VALUES
(1,'aa'),
(2,'cccc'),
(3,'abc'),
(4,'aabc'),
(5,NULL),
(6,'a'),
(7,'zzz'),
(8,'abc')*/
SELECT *
FROM FindSameCharacters
WHERE 
    Vals IS NOT NULL
    AND LEN(Vals) > 1
    AND LEN(REPLACE(Vals, LEFT(Vals, 1), '')) = 0;
--17.Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)
DECLARE @n INT = 5;
WITH NumbersCTE AS (
    SELECT 1 AS n, CAST('1' AS VARCHAR(MAX)) AS concatenated_number
    UNION ALL
    SELECT 
        n + 1,
        concatenated_number + CAST(n + 1 AS VARCHAR)
    FROM NumbersCTE
    WHERE n < @n
)
SELECT * FROM NumbersCTE
ORDER BY n
OPTION (MAXRECURSION 0);
--18.Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)
SELECT 
    e.employee_id,
    e.employee_name,
    sales_summary.total_sales
FROM 
    Employees e
JOIN 
    (
        SELECT 
            employee_id,
            SUM(amount) AS total_sales
        FROM 
            Sales
        WHERE 
            sale_date >= DATEADD(MONTH, -6, GETDATE())
        GROUP BY 
            employee_id
    ) AS sales_summary ON e.employee_id = sales_summary.employee_id
WHERE 
    sales_summary.total_sales = (
        SELECT MAX(total_sales) 
        FROM (
            SELECT 
                employee_id,
                SUM(amount) AS total_sales
            FROM 
                Sales
            WHERE 
                sale_date >= DATEADD(MONTH, -6, GETDATE())
            GROUP BY 
                employee_id
        ) AS max_sales_sub
    );
--19.Write a T-SQL query to remove the duplicate integer values present in the string column. Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)
/*CREATE TABLE RemoveDuplicateIntsFromNames
(
      PawanName INT
    , Pawan_slug_name VARCHAR(1000)
)
INSERT INTO RemoveDuplicateIntsFromNames VALUES
(1,  'PawanA-111'  ),
(2, 'PawanB-123'   ),
(3, 'PawanB-32'    ),
(4, 'PawanC-4444' ),
(5, 'PawanD-3'  )*/
WITH DigitCounts AS (
    SELECT 
        PawanName,
        Pawan_slug_name,
        -- Extract digits after the hyphen
        RIGHT(Pawan_slug_name, LEN(Pawan_slug_name) - CHARINDEX('-', Pawan_slug_name)) AS digits_part
    FROM RemoveDuplicateIntsFromNames
),
DigitsExpanded AS (
    SELECT 
        PawanName,
        Pawan_slug_name,
        SUBSTRING(digits_part, v.number, 1) AS digit
    FROM DigitCounts
    CROSS APPLY (
        SELECT TOP (LEN(digits_part)) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS number
        FROM sys.all_objects -- just a big table for generating numbers
    ) v
),
DigitFrequency AS (
    SELECT 
        PawanName,
        digit,
        COUNT(*) AS freq
    FROM DigitsExpanded
    GROUP BY PawanName, digit
),
FilteredDigits AS (
    SELECT DISTINCT
        d.PawanName,
        d.digit
    FROM DigitFrequency d
    WHERE d.freq > 1 -- keep digits that appear more than once
),
RebuiltStrings AS (
    SELECT 
        dc.PawanName,
        dc.Pawan_slug_name,
        -- Rebuild digit string from filtered digits sorted ascending
        (
            SELECT STRING_AGG(digit, '') WITHIN GROUP (ORDER BY digit)
            FROM FilteredDigits fd
            WHERE fd.PawanName = dc.PawanName
        ) AS filtered_digits
    FROM DigitCounts dc
)
SELECT 
    PawanName,
    -- Replace old digits part with filtered digits or empty string if NULL
    LEFT(Pawan_slug_name, CHARINDEX('-', Pawan_slug_name)) + ISNULL(filtered_digits, '') AS cleaned_slug_name
FROM RebuiltStrings;
