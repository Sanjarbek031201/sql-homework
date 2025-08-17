/*CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    product_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(50)
);

INSERT INTO sales_data VALUES
    (1, 101, 'Alice', 'Electronics', 'Laptop', 1, 1200.00, 1200.00, '2024-01-01', 'North'),
    (2, 102, 'Bob', 'Electronics', 'Phone', 2, 600.00, 1200.00, '2024-01-02', 'South'),
    (3, 103, 'Charlie', 'Clothing', 'T-Shirt', 5, 20.00, 100.00, '2024-01-03', 'East'),
    (4, 104, 'David', 'Furniture', 'Table', 1, 250.00, 250.00, '2024-01-04', 'West'),
    (5, 105, 'Eve', 'Electronics', 'Tablet', 1, 300.00, 300.00, '2024-01-05', 'North'),
    (6, 106, 'Frank', 'Clothing', 'Jacket', 2, 80.00, 160.00, '2024-01-06', 'South'),
    (7, 107, 'Grace', 'Electronics', 'Headphones', 3, 50.00, 150.00, '2024-01-07', 'East'),
    (8, 108, 'Hank', 'Furniture', 'Chair', 4, 75.00, 300.00, '2024-01-08', 'West'),
    (9, 109, 'Ivy', 'Clothing', 'Jeans', 1, 40.00, 40.00, '2024-01-09', 'North'),
    (10, 110, 'Jack', 'Electronics', 'Laptop', 2, 1200.00, 2400.00, '2024-01-10', 'South'),
    (11, 101, 'Alice', 'Electronics', 'Phone', 1, 600.00, 600.00, '2024-01-11', 'North'),
    (12, 102, 'Bob', 'Furniture', 'Sofa', 1, 500.00, 500.00, '2024-01-12', 'South'),
    (13, 103, 'Charlie', 'Electronics', 'Camera', 1, 400.00, 400.00, '2024-01-13', 'East'),
    (14, 104, 'David', 'Clothing', 'Sweater', 2, 60.00, 120.00, '2024-01-14', 'West'),
    (15, 105, 'Eve', 'Furniture', 'Bed', 1, 800.00, 800.00, '2024-01-15', 'North'),
    (16, 106, 'Frank', 'Electronics', 'Monitor', 1, 200.00, 200.00, '2024-01-16', 'South'),
    (17, 107, 'Grace', 'Clothing', 'Scarf', 3, 25.00, 75.00, '2024-01-17', 'East'),
    (18, 108, 'Hank', 'Furniture', 'Desk', 1, 350.00, 350.00, '2024-01-18', 'West'),
    (19, 109, 'Ivy', 'Electronics', 'Speaker', 2, 100.00, 200.00, '2024-01-19', 'North'),
    (20, 110, 'Jack', 'Clothing', 'Shoes', 1, 90.00, 90.00, '2024-01-20', 'South'),
    (21, 111, 'Kevin', 'Electronics', 'Mouse', 3, 25.00, 75.00, '2024-01-21', 'East'),
    (22, 112, 'Laura', 'Furniture', 'Couch', 1, 700.00, 700.00, '2024-01-22', 'West'),
    (23, 113, 'Mike', 'Clothing', 'Hat', 4, 15.00, 60.00, '2024-01-23', 'North'),
    (24, 114, 'Nancy', 'Electronics', 'Smartwatch', 1, 250.00, 250.00, '2024-01-24', 'South'),
    (25, 115, 'Oscar', 'Furniture', 'Wardrobe', 1, 1000.00, 1000.00, '2024-01-25', 'East')
*/
--1.Compute Running Total Sales per Customer
SELECT
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM sales_data
ORDER BY customer_id, order_date;
--2.Count the Number of Orders per Product Category
select
product_category,
count(*) as numberorder
from sales_data
group by product_category
order by numberorder desc
--3.Find the Maximum Total Amount per Product Category
select
product_category,
max(total_amount) as ts
from sales_data
group by product_category;
--4.Find the Minimum Price of Products per Product Category
select
product_category,
min(unit_price) as mp
from sales_data
group by product_category;
--5.Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)
select
order_date,
product_name,
total_amount,
product_category,
avg(total_amount) over(order by order_date  rows between 1 preceding and 1 following) as avgsale
from sales_data
order by order_date
--6.Find the Total Sales per Region
SELECT
    region,
    SUM(total_amount) AS total_sales
FROM sales_data
GROUP BY region
ORDER BY region;
--7.Compute the Rank of Customers Based on Their Total Purchase Amount
WITH customer_totals AS (
    SELECT
        customer_id,
        customer_name,
        SUM(total_amount) AS total_purchase
    FROM sales_data
    GROUP BY customer_id, customer_name
)
SELECT
    customer_id,
    customer_name,
    total_purchase,
    RANK() OVER (ORDER BY total_purchase DESC) AS purchase_rank
FROM customer_totals
ORDER BY purchase_rank;
--8.Calculate the Difference Between Current and Previous Sale Amount per Customer
select 
customer_id,
customer_name,
order_date,
total_amount,
lag(total_amount) over(partition by customer_id order by order_date) as previoussales,
isnull(total_amount-(lag(total_amount) over(partition by customer_id order by order_date)), 0) as difamount 
from sales_data
order by 
customer_id,
customer_name
--9.Find the Top 3 Most Expensive Products in Each Category
WITH RankedProducts AS (
    SELECT
        product_category,
        product_name,
        unit_price,
        ROW_NUMBER() OVER (
            PARTITION BY product_category 
            ORDER BY unit_price DESC
        ) AS rn
    FROM sales_data
)
SELECT
    product_category,
    product_name,
    unit_price
FROM RankedProducts
WHERE rn <= 3
ORDER BY product_category, unit_price DESC;
--10.Compute the Cumulative Sum of Sales Per Region by Order Date
SELECT
    region,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY region
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_sales
FROM sales_data
ORDER BY region, order_date;
--11.Compute Cumulative Revenue per Product Category
SELECT
    product_category,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY product_category
        ORDER BY order_date
    ) AS cumulative_revenue
FROM sales_data
ORDER BY product_category, order_date;
--12.Here you need to find out the sum of previous values. Please go through the sample input and expected output.

--Sample Input

--| ID |
--|----|
--|  1 |
--|  2 |
--|  3 |
--|  4 |
--|  5 |
--Expected Output

--| ID | SumPreValues |
--|----|--------------|
--|  1 |            1 |
--|  2 |            3 |
--|  3 |            6 |
--|  4 |           10 |
--|  5 |           15 |
SELECT
    ID,
    SUM(ID) OVER (
        ORDER BY ID
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS SumPreValues
FROM sales_data;
--13.Sum of Previous Values to Current Value
/*CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);*/
select value,
sum(value) over (order by value rows between unbounded preceding and current row)
as sumprevious
from onecolumn;
--14.Find customers who have purchased items from more than one product_category
SELECT 
    c.customer_id,
    c.name,
    COUNT(DISTINCT p.product_category) AS category_count
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id
JOIN 
    order_items oi ON o.order_id = oi.order_id
JOIN 
    products p ON oi.product_id = p.product_id
GROUP BY 
    c.customer_id, c.name
HAVING 
    COUNT(DISTINCT p.product_category) > 1;
--15.Find Customers with Above-Average Spending in Their Region
SELECT 
    customer_id,
    region,
    total_amount,
    regional_avg,
    CASE 
        WHEN total_amount > regional_avg THEN 'Above Average'
        ELSE 'Below or Equal to Average'
    END AS spending_category
FROM (
    SELECT 
        customer_id,
        region,
        total_amount,
        AVG(total_amount) OVER(PARTITION BY region) AS regional_avg
    FROM sales_data
) sub
WHERE total_amount > regional_avg;
--16.Rank customers based on their total spending (total_amount) within each region.
--If multiple customers have the same spending, they should receive the same rank.
SELECT 
    customer_id,
    region,
    total_amount,
    DENSE_RANK() OVER(PARTITION BY region ORDER BY total_amount DESC) AS spending_rank
FROM 
    sales_data;
--17.Calculate the running total (cumulative_sales) of total_amount for each customer_id, ordered by order_date.
SELECT CUSTOMER_ID, SUM(TOTAL_AMOUNT) OVER (ORDER BY ORDER_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) FROM sales_data
--18.Calculate the sales growth rate (growth_rate) for each month compared to the previous month.
SELECT 
    DATE_TRUNC('month', sale_date) AS month,
    SUM(total_amount) AS monthly_sales,
    LAG(SUM(total_amount)) OVER (ORDER BY DATE_TRUNC('month', sale_date)) AS previous_month_sales,
    ROUND(
        (SUM(total_amount) - LAG(SUM(total_amount)) OVER (ORDER BY DATE_TRUNC('month', sale_date)))
        / NULLIF(LAG(SUM(total_amount)) OVER (ORDER BY DATE_TRUNC('month', sale_date)), 0) * 100, 
        2
    ) AS growth_rate
FROM 
    sales_data
GROUP BY 
    DATE_TRUNC('month', sale_date)
ORDER BY 
    month;
--19.Identify customers whose total_amount is higher than their last order''s total_amount.(Table sales_data)
WITH total_spent AS (
    SELECT 
        customer_id,
        SUM(total_amount) AS total_amount
    FROM 
        sales_data
    GROUP BY 
        customer_id
),
last_order AS (
    SELECT 
        customer_id,
        total_amount AS last_order_amount
    FROM (
        SELECT 
            customer_id,
            total_amount,
            ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY sale_date DESC) AS rn
        FROM 
            sales_data
    ) sub
    WHERE rn = 1
)
SELECT 
    t.customer_id,
    t.total_amount AS total_spent,
    l.last_order_amount
FROM 
    total_spent t
JOIN 
    last_order l ON t.customer_id = l.customer_id
WHERE 
    t.total_amount > l.last_order_amount;
--20.Identify Products that prices are above the average product price
SELECT 
    product_id,
    product_name,
    FROM 
    sales_data
WHERE 
    total_amount > (SELECT AVG(total_amount) FROM sales_data);
--21.In this puzzle you have to find the sum of val1 and val2 for each group and put that value at the beginning of the group in the new column. 
--The challenge here is to do this in a single select. For more details please see the sample input and expected output.
/*CREATE TABLE MyData (
    Id INT, Grp INT, Val1 INT, Val2 INT
);
INSERT INTO MyData VALUES
(1,1,30,29), (2,1,19,0), (3,1,11,45), (4,2,0,0), (5,2,100,17);*/
SELECT
    Id,
    Grp,
    Val1,
    Val2,
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1 
        THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
        ELSE NULL
    END AS Tot
FROM MYDATA
ORDER BY Grp, Id;
--22.Here you have to sum up the value of the cost column based on the values of Id.
--For Quantity if values are different then we have to add those values.
--Please go through the sample input and expected output for details.
/*CREATE TABLE TheSumPuzzle (
    ID INT, Cost INT, Quantity INT
);
INSERT INTO TheSumPuzzle VALUES
(1234,12,164), (1234,13,164), (1235,100,130), (1235,100,135), (1236,12,136);*/
SELECT
    ID,
    SUM(Cost) AS TotalCost,
    CASE 
        WHEN COUNT(DISTINCT Quantity) = 1 THEN MAX(Quantity)
        ELSE SUM(DISTINCT Quantity)
    END AS QuantitySumOrSingle
FROM TheSumPuzzle
GROUP BY ID;
--23.From following set of integers, write an SQL statement to determine the expected outputs
/*CREATE TABLE Seats 
( 
SeatNumber INTEGER 
); 

INSERT INTO Seats VALUES 
(7),(13),(14),(15),(27),(28),(29),(30), 
(31),(32),(33),(34),(35),(52),(53),(54); */
WITH NumberRange AS (
    SELECT MIN(SeatNumber) AS MinSeat, MAX(SeatNumber) AS MaxSeat FROM Seats
),
AllSeats AS (
    SELECT generate_series(MinSeat, MaxSeat) AS SeatNumber
    FROM NumberRange
)
SELECT
    s.SeatNumber
FROM
    AllSeats s
LEFT JOIN
    Seats t ON s.SeatNumber = t.SeatNumber
WHERE
    t.SeatNumber IS NULL
ORDER BY
    s.SeatNumber;
