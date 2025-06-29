--1.Define the following terms: data, database, relational database, and table.
/*Data:
Data refers to raw facts, figures, or symbols that represent information. It can be in the form of numbers, text, images, audio, or video and is often unprocessed and unorganized.
Database:
A database is an organized collection of data that is stored and accessed electronically. It allows users to efficiently store, retrieve, and manage data using database management systems (DBMS).
Relational Database:
A relational database is a type of database that stores data in structured tables consisting of rows and columns. Relationships between different tables are established using keys (e.g., primary keys and foreign keys). It is based on the relational model proposed by E.F. Codd.
Table:
A table is a structured set of data elements (values) organized in rows and columns within a relational database. Each row represents a record, and each column represents a specific attribute or field of the data.
*/
--2.List five key features of SQL Server
/*Data Management and Storage:
SQL Server provides a reliable and scalable platform for storing and managing data, supporting both structured and semi-structured data formats.

Security Features:
It includes robust security mechanisms such as authentication, authorization, transparent data encryption (TDE), row-level security, and dynamic data masking to protect sensitive information.

High Availability and Disaster Recovery:
Features like Always On Availability Groups, database mirroring, failover clustering, and backup/restore options ensure data availability and business continuity.

Integration Services (SSIS):
SQL Server supports ETL (Extract, Transform, Load) processes through SQL Server Integration Services, allowing data integration from multiple sources.

Advanced Analytics and Reporting:
With built-in tools like SQL Server Reporting Services (SSRS) and SQL Server Analysis Services (SSAS), users can create reports, perform data analysis, and gain insights using OLAP and data mining capabilities.
*/
--3.What are the different authentication modes available when connecting to SQL Server? (Give at least 2)
/*Windows Authentication:
This mode uses the Windows user account credentials of the user who is attempting to connect. It integrates with the Windows security model and provides a secure, single sign-on experience.
SQL Server Authentication:
This mode requires users to provide a SQL Server-specific username and password. It is managed independently of Windows and is useful when connecting from non-Windows systems or when separate login credentials are preferred.*/
--4.Create a new database in SSMS named SchoolDB.
create database SchoolDB
--5.Write and execute a query to create a table called Students with columns: StudentID (INT, PRIMARY KEY), Name (VARCHAR(50)), Age (INT).5.
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);
--6.Describe the differences between SQL Server, SSMS, and SQL.
/*1. SQL Server
Type: Database Management System (DBMS)
Description:
Microsoft SQL Server is a relational database management system (RDBMS) used to store, manage, and retrieve data. It handles data storage, processing, security, backup, and more.
Function: Runs the databases, executes SQL queries, and manages data operations.
2. SSMS (SQL Server Management Studio)
Type: Graphical User Interface (GUI) Tool
Description:
SSMS is a management and development environment for working with SQL Server. It allows users to write and run SQL queries, design databases, manage objects, and monitor performance.
Function: Acts as the interface to interact with SQL Server visually and via scripts.
3. SQL (Structured Query Language)
Type: Query Language
Description:
SQL is the language used to communicate with relational databases. It allows you to create databases, insert data, update records, retrieve data, and define permissions.
Function: Used to perform CRUD operations (Create, Read, Update, Delete) on data stored in a database
*/
--7.Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.
/*| Category | Full Form                    | Purpose                       | Key Commands                          |
| -------- | ---------------------------- | ----------------------------- | ------------------------------------- |
| DQL      | Data Query Language          | Query data                    | `SELECT`                              |
| DML      | Data Manipulation Language   | Manipulate data in tables     | `INSERT`, `UPDATE`, `DELETE`          |
| DDL      | Data Definition Language     | Define/modify table structure | `CREATE`, `ALTER`, `DROP`, `TRUNCATE` |
| DCL      | Data Control Language        | Control access & permissions  | `GRANT`, `REVOKE`                     |
| TCL      | Transaction Control Language | Manage transactions           | `COMMIT`, `ROLLBACK`, `SAVEPOINT`     |*/
--8.Write a query to insert three records into the Students table.
insert into Students VALUES (1,'Ali',18)
insert into Students VALUES (2,'Umar',19)
insert into Students VALUES (3,'Abubakr',20)
select *from Students
----9.Restore AdventureWorksDW2022.bak file to your server. (write its steps to submit)
--You can find the database from this link 
--:https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2022.bak
/*I can do it*/
