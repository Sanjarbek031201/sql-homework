/*1. Find Employees with Minimum Salary
Task: Retrieve employees who earn the minimum salary in the company. Tables: employees (columns: id, name, salary)

create table employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (id, name, salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 50000);*/
select *from employees
where salary=(select min(salary) from employees)
/*2. Find Products Above Average Price
Task: Retrieve products priced above the average price. Tables: products (columns: id, product_name, price)

select*from products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO products (id, product_name, price) VALUES
(1, 'Laptop', 1200),
(2, 'Tablet', 400),
(3, 'Smartphone', 800),
(4, 'Monitor', 300);*/
select * from products
where price>(select avg(price) from products)
/*3: Nested Subqueries with Conditions
Find Employees in Sales Department Task: Retrieve employees who work in the "Sales" department. Tables: employees (columns: id, name, department_id), departments (columns: id, department_name)

create TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

create table employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'Sales'),
(2, 'HR');

INSERT INTO employees (id, name, department_id) VALUES
(1, 'David', 1),
(2, 'Eve', 2),
(3, 'Frank', 1);*/
select * from employees
where department_id=(select id from departments where department_name='sales')
/*4. Find Customers with No Orders
Task: Retrieve customers who have not placed any orders. Tables: customers (columns: customer_id, name), orders (columns: order_id, customer_id)
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100)
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, name) VALUES
(1, 'Grace'),
(2, 'Heidi'),
(3, 'Ivan');

INSERT INTO orders (order_id, customer_id) VALUES
(1, 1),
(2, 1);*/
select * from customers
where customerid not in (select CustomerID from orders)
/*5.Find Products with Max Price in Each Category
Task: Retrieve products with the highest price in each category. Tables: products (columns: id, product_name, price, category_id)
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Tablet', 400, 1),
(2, 'Laptop', 1500, 1),
(3, 'Headphones', 200, 2),
(4, 'Speakers', 300, 2);*/
select * from Products as p
where Price=(select max(price) from products where Category=p.Category)
/*6. Find Employees in Department with Highest Average Salary
Task: Retrieve employees working in the department with the highest average salary. Tables: employees (columns: id, name, salary, department_id), departments (columns: id, department_name)
CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employee1 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'IT'),
(2, 'Sales');

INSERT INTO employee1 (id, name, salary, department_id) VALUES
(1, 'Jack', 80000, 1),
(2, 'Karen', 70000, 1),
(3, 'Leo', 60000, 2);*/
SELECT *
FROM employee1 e
WHERE e.department_id = (
    SELECT TOP 1 department_id
    FROM employee1
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);
/*7.Find Employees Earning Above Department Average
Task: Retrieve employees earning more than the average salary in their department. Tables: employees (columns: id, name, salary, department_id)

CREATE TABLE employee2 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employee2 (id, name, salary, department_id) VALUES
(1, 'Mike', 50000, 1),
(2, 'Nina', 75000, 1),
(3, 'Olivia', 40000, 2),
(4, 'Paul', 55000, 2);*/
select* from employee2
where salary>(select avg (salary)from employee2)

/*8. Find Students with Highest Grade per Course
Task: Retrieve students who received the highest grade in each course. Tables: students (columns: student_id, name), grades (columns: student_id, course_id, grade)

CREATE TABLE student1 (
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE grades (
    student_id INT,
    course_id INT,
    grade DECIMAL(4, 2),
    FOREIGN KEY (student_id) REFERENCES student1(student_id)
);

INSERT INTO student1 (student_id, name) VALUES
(1, 'Sarah'),
(2, 'Tom'),
(3, 'Uma');

INSERT INTO grades (student_id, course_id, grade) VALUES
(1, 101, 95),
(2, 101, 85),
(3, 102, 90),
(1, 102, 80);*/
SELECT *
FROM grades g
WHERE grade = (
    SELECT MAX(grade)
    FROM grades
    WHERE course_id = g.course_id
);
/*9. Find Third-Highest Price per Category Task: Retrieve products with the third-highest price in each category. Tables: products (columns: id, product_name, price, category_id)

CREATE TABLE product1 (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO product1 (id, product_name, price, category_id) VALUES
(1, 'Phone', 800, 1),
(2, 'Laptop', 1500, 1),
(3, 'Tablet', 600, 1),
(4, 'Smartwatch', 300, 1),
(5, 'Headphones', 200, 2),
(6, 'Speakers', 300, 2),
(7, 'Earbuds', 100, 2);*/
SELECT *
FROM product1 p1
WHERE 2 = (
    SELECT COUNT(DISTINCT p2.price)
    FROM product1 p2
    WHERE p2.category_id = p1.category_id
      AND p2.price > p1.price
);
/*10.Find Employee3 whose Salary Between Company Average and Department Max Salary
Task: Retrieve employee3 with salaries above the company average but below the maximum in their department. Tables: employees (columns: id, name, salary, department_id)
CREATE TABLE employee3 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);
INSERT INTO employee3 (id, name, salary, department_id) VALUES
(1, 'Alex', 70000, 1),
(2, 'Blake', 90000, 1),
(3, 'Casey', 50000, 2),
(4, 'Dana', 60000, 2),
(5, 'Evan', 75000, 1);*/
SELECT *
FROM employee3 e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employee3
)
AND e.salary < (
    SELECT MAX(salary)
    FROM employee3 e2
    WHERE e2.department_id = e.department_id
);
