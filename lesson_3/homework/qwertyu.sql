--1.Define and explain the purpose of BULK INSERT in SQL Server.
/*BULK INSERT is a Transact-SQL (T-SQL) command in SQL Server that allows you to efficiently import large volumes of data from a data file (like a .txt or .csv) directly into a database table or view.*/
--2.List four file formats that can be imported into SQL Server.
/*1. CSV (Comma-Separated Values)
2. TXT (Plain Text File)
3. Excel Files (XLS/XLSX)
4. XML Files*/
--3.Create a table Products with columns: ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2)).
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);
--4.Insert three records into the Products table using INSERT INTO.
INSERT INTO Products (ProductID, ProductName, Price)
VALUES
    (1, 'Laptop', 899.99),
    (2, 'Smartphone', 499.50),
    (3, 'Headphones', 79.95);
	select *from Products
--5.Explain the difference between NULL and NOT NULL.
/*NULL means a column can have no value, representing missing or unknown data. 
NOT NULL means a column must always have a value and cannot be left blank.*/
--6.Add a UNIQUE constraint to the ProductName column in the Products table.
CREATE TABLE Product_5 (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50) UNIQUE,
    Price DECIMAL(10,2)
);
--7.Write a comment in a SQL query explaining its purpose.
SELECT ProductID, ProductName, Price
FROM Products
WHERE Price > 100;
--8.Add CategoryID column to the Products table.
ALTER TABLE Product_#
ADD CategoryID INT;
--9.Create a table Categories with a CategoryID as PRIMARY KEY and a CategoryName as UNIQUE.
CREATE TABLE CATEGORIE(
CategoryID int PRIMARY KEY,
CategoryName VARCHAR(50) UNIQUE)
--10.Explain the purpose of the IDENTITY column in SQL Server.
CREATE TABLE CATEGORIES(
CategoryID int IDENTITY,
CategoryName VARCHAR(50))
insert into CATEGORIES values('John')
select*from CATEGORIES 
--11.Use BULK INSERT to import data from a text file into the Products table.
BULK INSERT Products
FROM '\\ACER-LAPTOP\SharedData\products.txt'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);
--12.Create a FOREIGN KEY in the Products table that references the Categories table.
ALTER TABLE Product_4
ADD CategoryID INT;
ALTER TABLE Product_4
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);
--13.Explain the differences between PRIMARY KEY and UNIQUE KEY.
/*PRIMARY KEY uniquely identifies each row in a table and does not allow NULL values; there can be only one primary key per table.
UNIQUE KEY also enforces uniqueness for a column (or combination of columns) but allows one NULL value (in most databases) and you can have multiple unique keys in a table.
PRIMARY KEY = unique + not null + single per table
UNIQUE KEY = unique + allows null(s) + multiple per table*/
--14.Add a CHECK constraint to the Products table ensuring Price > 0.
ALTER TABLE Product_5
DROP CONSTRAINT CHK_Price_Positive;

ALTER TABLE Product_5
ADD CONSTRAINT CHK_Price_Positive CHECK (Price > 0);
--15.Modify the Products table to add a column Stock (INT, NOT NULL).
ALTER TABLE Product_5
ADD Stock INT NOT NULL DEFAULT 0;
--16.Use the ISNULL function to replace NULL values in Price column with a 0.
SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price
FROM Products;
--17.Describe the purpose and usage of FOREIGN KEY constraints in SQL Server.
/* A **FOREIGN KEY** ensures that a column’s values match values in another table’s primary key,
maintaining **data integrity** between related tables. It enforces valid references and prevents invalid data entry.*/
--18.Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Age INT,
    CONSTRAINT CHK_Age_Minimum CHECK (Age >= 18)
);
--19.Create a table with an IDENTITY column starting at 100 and incrementing by 10.
CREATE TABLE SampleTable (
    ID INT IDENTITY(100, 10) PRIMARY KEY,
    Name VARCHAR(50)
);
--20.Write a query to create a composite PRIMARY KEY in a new table OrderDetails.
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
);
--21`.Explain the use of COALESCE and ISNULL functions for handling NULL values.
/* ISNULL(expression, replacement) returns the replacement if expression is NULL;
otherwise, it returns expression. It takes exactly two arguments and is specific to SQL Server.
COALESCE(expression1, expression2, ..., expressionN) returns the first non-NULL value from the list of expressions. 
It can take two or more arguments and is ANSI SQL standard (works in many databases).
*/
--22.Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.
CREATE TABLE Employees_5 (
    EmpID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    Email VARCHAR(255) UNIQUE
);
--23.Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.
ALTER TABLE ChildTable
ADD CONSTRAINT FK_Child_Parent
FOREIGN KEY (ParentID) REFERENCES ParentTable(ParentID)
ON DELETE CASCADE
ON UPDATE CASCADE;
