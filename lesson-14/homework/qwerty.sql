--1.Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns)

/*CREATE TABLE [dbo].[TestMultipleColumns]
(
[Id] [int] NULL,
[Name] [varchar](20) NULL
)
 
INSERT INTO [TestMultipleColumns] VALUES
(1,    'Pawan,Kumar'),
(2,    'Sandeep,Goyal'),
(3,    'Isha,Mattoo'),
(4,    'Gopal,Ranjan'),
(5,    'Neeraj,Garg'),
(6,    'Deepak,Sharma'),
(7,    ' Mayank,Tripathi')*/
Select
  ltrim(rtrim(LEFT(name, charindex(',', name) - 1))) as name,
  ltrim(rtrim(SUBSTRING(Name, CHARINDEX(',', Name) + 1, LEN(Name)))) AS Surname
From TestMultipleColumns
Where CHARINDEX(',', Name) > 0;
--2.Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent)
SELECT *
FROM TestPercent
WHERE Strs LIKE '%[%]%';

/*CREATE TABLE TestPercent
(
    Strs VARCHAR(100)
)
 
INSERT INTO TestPercent
SELECT 'Pawan'
UNION ALL
SELECT 'Pawan%'
UNION ALL
SELECT 'Pawan%Kumar'
UNION ALL
SELECT '%'*/
3.In this puzzle you will have to split a string based on dot(.).(Splitter)
/*CREATE TABLE Splitter
(
     Id INT
    ,Vals VARCHAR(100)
)
 
INSERT INTO Splitter VALUES
(1,'P.K'),
(2,'a.b'),
(3,'c.d'),
(4,'e.J'),
(5,'t.u.b')*/
select 
    Id,
    PARSENAME(REPLACE(Vals, '.', '.'), 3) AS Part1,
    PARSENAME(REPLACE(Vals, '.', '.'), 2) AS Part2,
    PARSENAME(REPLACE(Vals, '.', '.'), 1) AS Part3
from splitter
--4.Write a SQL query to replace all integers (digits) in the string with 'X'.(1234ABC123456XYZ1234567890ADS)
SELECT REGEXP_REPLACE('1234ABC123456XYZ1234567890ADS', '[0-9]', 'X') AS replaced_string;
--5.Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots)
/*CREATE TABLE testDots
(
     ID INT
    ,Vals VARCHAR(100)
)
 INSERT INTO testDots VALUES
(1,'0.0'),
(2,'2.3.1.1'),
(3,'4.1.a.3.9'),
(4,'1.1.'),
(5,'a.b.b.b.b.b..b..b'),
(6,'6.')*/
SELECT *
FROM testDots
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;
--6.Write a SQL query to count the spaces present in the string.(CountSpaces)
/*CREATE TABLE CountSpaces
(
texts VARCHAR(100)
)
INSERT INTO CountSpaces VALUES
('P Q R S '),
(' L M N O 0 0     '),
('I  am here only '),
(' Welcome to the new world '),
(' Hello world program'),
(' Are u nuts ')*/
SELECT 
  texts,
  LEN(texts) - LEN(REPLACE(texts, ' ', '')) AS space_count
FROM 
  CountSpaces;
--8.write a SQL query that finds out employees who earn more than their managers.(Employee)
/*CREATE TABLE Employee (
    Id INT,
    Name VARCHAR(50),
    Salary INT,
    ManagerId INT
);
INSERT INTO Employee (Id, Name, Salary, ManagerId) VALUES
(1, 'Joe', 70000, 3),
(2, 'Henry', 80000, 4),
(3, 'Sam', 60000, NULL),
(4, 'Max', 90000, NULL);
*/
SELECT 
    e.Name AS EmployeeName,
    e.Salary AS EmployeeSalary,
    m.Name AS ManagerName,
    m.Salary AS ManagerSalary
FROM 
    Employee e
JOIN 
    Employee m ON e.ManagerId = m.Id
WHERE 
    e.Salary > m.Salary;
--9.Write a SQL query to separate the integer values and the character values into two different columns.(rtcfvty34redt)
SELECT 
    original_str,
    REGEXP_REPLACE(original_str, '[0-9]', '') AS only_chars,
    REGEXP_REPLACE(original_str, '[^0-9]', '') AS only_digits
FROM
    (SELECT 'rtcfvty34redt' AS original_str) AS temp;
--10.write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.(weather)
/*CREATE TABLE weather (
    Id INT,
    RecordDate DATE,
    Temperature INT
);
INSERT INTO weather (Id, RecordDate, Temperature) VALUES
(1, '2015-01-01', 10),
(2, '2015-01-02', 25),
(3, '2015-01-03', 20),
(4, '2015-01-04', 30);*/
SELECT 
    w1.Id,
    w1.RecordDate,
    w1.Temperature
FROM 
    weather w1
JOIN 
    weather w2 ON w1.RecordDate = DATEADD(day, 1, w2.RecordDate) 
WHERE 
    w1.Temperature > w2.Temperature;
--11.Write an SQL query that reports the first login date for each player.(Activity)
/*CREATE TABLE Activity (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT
);

INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES
(1, 2, '2016-03-01', 5),
(1, 2, '2016-05-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-02', 0),
(3, 4, '2018-07-03', 5);*/
SELECT 
    player_id, 
    MIN(event_date) AS first_login_date
FROM 
    Activity
GROUP BY 
    player_id;

--12.Your task is to return the third item from that list.(fruits)
/*CREATE TABLE fruits (
    fruit_list VARCHAR(100)
);

INSERT INTO fruits (fruit_list)
VALUES ('apple,banana,orange,grape');*/
SELECT
  SUBSTRING(
    fruit_list,
    -- start position: 1 + position of second comma
    CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1) + 1,
    -- length: position of third comma - start position
    CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1) + 1) 
    - CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1) - 1
  ) AS third_fruit
FROM fruits;
--13.Write a SQL query to create a table where each character from the string will be converted into a row.(sdgfhsdgfhs@121313131)
DECLARE @str VARCHAR(100) = 'sdgfhsdgfhs@121313131';

WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM Numbers WHERE n < LEN(@str)
)
SELECT
    SUBSTRING(@str, n, 1) AS char
FROM Numbers
OPTION (MAXRECURSION 0);
--14.You are given two tables: p1 and p2. Join these tables on the id column. The catch is: when the value of p1.code is 0, replace it with the value of p2.code.(p1,p2)
/*create table p1 (id int, code int)
create table p2 (id int, code int)
insert into p1 select 1,0
insert into p1 select 2,1
insert into p2 select 1,5
insert into p2 select 2,5*/
SELECT
    p1.id,
    CASE 
        WHEN p1.code = 0 THEN p2.code
        ELSE p1.code
    END AS code
FROM p1
JOIN p2 ON p1.id = p2.id;
--15.Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:
/*If the employee has worked for less than 1 year → 'New Hire'
If the employee has worked for 1 to 5 years → 'Junior'
If the employee has worked for 5 to 10 years → 'Mid-Level'
If the employee has worked for 10 to 20 years → 'Senior'
If the employee has worked for more than 20 years → 'Veteran'(Employees)*/
/*CREATE TABLE Employee (
    Id INT,
    Name VARCHAR(50),
    Salary INT,
    ManagerId INT
);

INSERT INTO Employee (Id, Name, Salary, ManagerId) VALUES
(1, 'Joe', 70000, 3),
(2, 'Henry', 80000, 4),
(3, 'Sam', 60000, NULL),
(4, 'Max', 90000, NULL);
*/
SELECT
    Id,
    Name,
    HIRE_DATE,
    CASE 
        WHEN DATEDIFF(year, HIRE_DATE, GETDATE()) < 1 THEN 'New Hire'
        WHEN DATEDIFF(year, HIRE_DATE, GETDATE()) BETWEEN 1 AND 5 THEN 'Junior'
        WHEN DATEDIFF(year, HIRE_DATE, GETDATE()) BETWEEN 5 AND 10 THEN 'Mid-Level'
        WHEN DATEDIFF(year, HIRE_DATE, GETDATE()) BETWEEN 10 AND 20 THEN 'Senior'
        ELSE 'Veteran'
    END AS Employment_Stage
FROM Employee;
--16.Write a SQL query to extract the integer value that appears at the start of the string in a column named Vals.(GetIntegers)
/*CREATE TABLE GetIntegers
(
     Id INT
    ,VALS VARCHAR(100)
)
 
INSERT INTO GetIntegers VALUES
 (1,'P1')
,(2,'1 - Hero')
,(3,'2 - Ramesh')
,(4,'3 - KrishnaKANT')
,(5,'21 - Avtaar')
,(6,'5Laila')
,(7,'6  MMT')
,(8,'7#7#')
,(9,'#')
,(10,'8')
,(11,'98')
,(12,'111')
,(13,NULL)*/
SELECT
  Vals,
  CASE 
    WHEN LEFT(Vals, 1) NOT LIKE '[0-9]' THEN NULL
    ELSE
      SUBSTRING(
        Vals,
        1,
        ISNULL(
          NULLIF(
            PATINDEX('%[^0-9]%', Vals + 'a') - 1,
            -1
          ),
          LEN(Vals)
        )
      )
  END AS integer_start
FROM GetIntegers;
--17.n this puzzle you have to swap the first two letters of the comma separated string.(MultipleVals)
/*CREATE TABLE MultipleVals 
( Id INT
 ,[Vals] VARCHAR(100)
)
Insert Into MultipleVals values
 (1,'a,b,c')
,(2,'x,y,z')*/
SELECT 
    Id,
    Vals,
    -- Split and rearrange the first two parts, keep the rest
    CONCAT(
        PARSENAME(REPLACE(Vals, ',', '.'), 2), ',',  -- 2nd part
        PARSENAME(REPLACE(Vals, ',', '.'), 3), ',',  -- 1st part
        PARSENAME(REPLACE(Vals, ',', '.'), 1)        -- 3rd part
    ) AS SwappedVals
FROM MultipleVals;
--18.Write a SQL query that reports the device that is first logged in for each player.(Activity)
/*CREATE TABLE Activity (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT
);
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES
(1, 2, '2016-03-01', 5),
(1, 2, '2016-05-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-02', 0),
(3, 4, '2018-07-03', 5);
*/
SELECT 
    player_id,
    device_id
FROM Activity A
WHERE event_date = (
    SELECT MIN(event_date)
    FROM Activity
    WHERE player_id = A.player_id
);
--19.ou are given a sales table. Calculate the week-on-week percentage of sales per area for each financial week. For each week, the total sales will be considered 100%, and the percentage sales for each day of the week should be calculated based on the area sales for that week.(WeekPercentagePuzzle)
/*CREATE TABLE WeekPercentagePuzzle (
    sale_date DATE,
    area VARCHAR(50),
    sales INT
);
*/    SELECT
        DATEPART(ISO_WEEK, sale_date) AS week_number,
        area,
        SUM(sales) AS area_weekly_sales
    FROM WeekPercentagePuzzle
    GROUP BY DATEPART(ISO_WEEK, sale_date), area

   SELECT
        DATEPART(ISO_WEEK, sale_date) AS week_number,
        SUM(sales) AS total_weekly_sales
    FROM WeekPercentagePuzzle
    GROUP BY DATEPART(ISO_WEEK, sale_date)
