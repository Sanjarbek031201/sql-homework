--1.reate a table `Employees` with columns: `EmpID` INT, `Name` (VARCHAR(50)), and `Salary` (DECIMAL(1,2))
create table Employees (EmpID INT, Name VARCHAR(50),Salary DECIMAL(10,2))
 --2.Insert three records into the `Employees` table using different INSERT INTO approaches (single-row insert and multiple-row insert).
 insert into Employees values(1,'Sanjarbek',4) 
 insert into Employees values(2,'Ali',3)
 insert into Employees values(3,'Ergashali',5)
 select * from Employees
 --3. Update the `Salary` of an employee where `EmpID = 1
 update  Employees 
 set name='sanjarbek'
 where EmpID=1
 select *from Employees
 --4. Update the `Salary` of an employee to `7000` where `EmpID = 1`. 
 update  Employees 
 set Salary=7000
 where EmpID=1
 select *from Employees
 --5.Delete a record from the `Employees` table where `EmpID = 2`.
 delete Employees
 where EmpID=2
 select *from Employees
  --6.Demonstrate the difference between `DELETE`, `TRUNCATE`, and `DROP` commands on a test table.  
  create table test_table(EMPid INT,name VARCHAR(50))
  INSERT INTO test_table (EMPid, name) VALUES(1, 'Ali'),(2, 'Vali'),(3, 'Hasan')
  select *from test_table
  /*I am going to show DELETE function*/
  delete test_table where EMPid=2
  select *from test_table
  /*I am going to show TRUNCATE function*/
  TRUNCATE TABLE test_table
  /*I am going to show DROP function*/
  create table test_table(EMPid INT,name VARCHAR(50))
  drop table test_table
--7.Give a brief definition for difference between `DELETE`, `TRUNCATE`, and `DROP`.
/*Well, now I can try to give definition for Delete
We can use WHERE to delete specific rows
Table structure remains
Next, Definition for TRUNCATE
All rows are removed.
Table remains, but data is gone.
Finaly, definiton for DROP
Table is completely removed from the database*/
--8. Modify the `Name` column in the `Employees` table to `VARCHAR(100)`.
create table Employees_1 (EmpID INT, Name VARCHAR(50),Salary DECIMAL(10,2))
ALTER TABLE Employees_1
ALTER COLUMN Name VARCHAR(100)
Select*from Employees_1
 --9. Add a new column `Department` (`VARCHAR(50)`) to the `Employees` table. 
ALTER TABLE Employees_1
ADD Department VARCHAR(50)
--10.Change the data type of the `Salary` column to `FLOAT`
ALTER TABLE Employees_1
ALTER COLUMN Salary FLOAT
--11.Create another table Departments with columns DepartmentID (INT, PRIMARY KEY) and DepartmentName (VARCHAR(50))
create table Departments1 (DepartmentID INT PRIMARY KEY ,DepartmentName VARCHAR(50))  
--12.Remove all records from the Employees table without deleting its structure.
TRUNCATE TABLE Employees
--13.Insert five records into the Departments table using INSERT INTO SELECT method(you can write anything you want as data).
Insert into Departments1 values(1,'Ichki ishlar')
Select *from Departments1
--14.Update the Department of all employees where Salary > 5000 to 'Management'.
UPDATE Employees
SET DepartmentName ='Management'
WHERE Salary > 5000
--15.Write a query that removes all employees but keeps the table structure intact.
DELETE FROM Employees
--16.Drop the Department column from the Employees table.
ALTER TABLE Employees
DROP COLUMN Department
--17.Rename the Employees table to StaffMembers using SQL commands.
ALTER TABLE Employees 
RENAME TO StaffMembers
--18.Write a query to completely remove the Departments table from the database.
DROP TABLE Departments1
--19.Create a table named Products with at least 5 columns, including: ProductID (Primary Key), ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL)
CREATE TABLE Products2 (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(100),
    Price DECIMAL(10, 2)
);
--20.Add a CHECK constraint to ensure Price is always greater than 0.
ALTER TABLE Products
ADD CONSTRAINT chk_price_positive CHECK (Price > 0)
--21.Modify the table to add a StockQuantity column with a DEFAULT value of 50.
ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50
/*ALTER TABLE Products – Products jadvalini o‘zgartiramiz.

ADD StockQuantity INT – yangi StockQuantity ustuni qo‘shiladi, INT (butun son) turida.

DEFAULT 50 – foydalanuvchi qiymat bermasa, bu ustunga avtomatik 50 yoziladi.*/
--22.Rename Category to ProductCategory
EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN'
--23.Insert 5 records into the Products table using standard INSERT INTO querie
INSERT INTO Products2 (ProductID, ProductName, Category, Price)
VALUES (1, 'Smartphone', 'Elektronika', 100)
INSERT INTO Products2 (ProductID, ProductName, Category, Price)
VALUES(2,'Readmi','Gajet',80)
INSERT INTO Products2 (ProductID, ProductName, Category, Price)
VALUES(3,'Samsung','Gajet',150)
select*from Products2
--24.Use SELECT INTO to create a backup table called Products_Backup containing all Products data.
SELECT *INTO Products_Backup FROM Products
--25.Rename the Products table to Inventory.
EXEC sp_rename 'Products', 'Inventory'
--26.Alter the Inventory table to change the data type of Price from DECIMAL(10,2) to FLOAT
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT
