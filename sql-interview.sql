-- Q1
/*
Assume you have two tables: employees and departments.
Retrieve the second highest salary of each department.
*/
-- Creating the tables
CREATE TABLE departments (
	department_id INT PRIMARY KEY
	,department_name VARCHAR(50) NOT NULL
	);

CREATE TABLE employees (
	employee_id INT PRIMARY KEY
	,employee_name VARCHAR(50) NOT NULL
	,salary INT NOT NULL
	,department_id INT
	,FOREIGN KEY (department_id) REFERENCES departments(department_id)
	);

-- Populating the tables with dummy records
INSERT INTO departments (
	department_id
	,department_name
	)
VALUES (
	11
	,'Accounts'
	)
	,(
	18
	,'Risk'
	)
	,(
	8
	,'Engineering'
	);

INSERT INTO employees (
	employee_id
	,employee_name
	,salary
	,department_id
	)
VALUES (
	12003
	,'Puja'
	,180000
	,11
	)
	,(
	12001
	,'Shubham'
	,150000
	,11
	)
	,(
	25220
	,'Avinash'
	,210000
	,18
	)
	,(
	9005
	,'Atul'
	,300000
	,8
	);

WITH ranked_salary
AS (
	SELECT e.department_id
		,d.department_name
		,rank() OVER (
			PARTITION BY e.department_id ORDER BY e.salary DESC
			) AS rank_by_salary
	FROM employees e
	JOIN departments d ON e.department_id = d.department_id
	)
SELECT department_id
	,department_name
	,rank_by_salary
FROM ranked_salary
WHERE rank_by_salary = 2

-- Q2
/*
Given a table named orders with columns: order_id, order_date, and order_amount,
write a query to calculate the running total of order_amount, based on order_date
*/
CREATE TABLE orders (
	order_id INT PRIMARY KEY
	,order_date DATE
	,order_amount DECIMAL
	)

-- Populating the table
INSERT INTO orders (
	order_id
	,order_date
	,order_amount
	)
VALUES (
	1
	,'2024-01-01'
	,100.00
	)
	,(
	2
	,'2024-01-05'
	,200.00
	)
	,(
	3
	,'2024-01-10'
	,150.00
	)
	,(
	4
	,'2024-01-15'
	,300.00
	)
	,(
	5
	,'2024-01-20'
	,250.00
	);

SELECT *
	,sum(order_amount) OVER (
		ORDER BY order_date
		) AS running_total
FROM orders

-- Q3
/*
Given the following table
id-----------------marks---------------student_id
1					65					100
2					80					200
3					90					300
4					85					400
5					50					501
6					60					701

Get an additional column rank. 'Rank' is ranked on the basis of marks in ascending order

*/
CREATE TABLE student_marks (
	id INT PRIMARY KEY
	,marks INT
	,student_id INT
	)

INSERT INTO student_marks (
	id
	,marks
	,student_id
	)
VALUES (
	1
	,65
	,100
	)
	,(
	2
	,80
	,200
	)
	,(
	3
	,90
	,300
	)
	,(
	4
	,85
	,400
	)
	,(
	5
	,50
	,501
	)
	,(
	6
	,60
	,701
	);

SELECT *
	,dense_rank() OVER (
		ORDER BY marks
		)
FROM student_marks;

-- Q4
/*
Consider the following table which contains information about the temperature on a
certain day. Id is the primary key in this table.
id-------------------------records_date---------------temperature
1						 	2015-01-01					10
2							2015-01-01					25
3							2015-01-03					20
4							2015-01-04					30
Write an SQL query to find all dates' Id with higher temperatures compared to its
previous dates (yesterday).
Expected Output :
Id
2
4
*/
CREATE TABLE temperature (
	id INT PRIMARY KEY
	,records_date DATE
	,temperature INT
	)

INSERT INTO temperature (
	id
	,records_date
	,temperature
	)
VALUES (
	1
	,'2015-01-01'
	,10
	)
	,(
	2
	,'2015-01-02'
	,25
	)
	,(
	3
	,'2015-01-03'
	,20
	)
	,(
	4
	,'2015-01-04'
	,30
	)

SELECT id
FROM (
	SELECT *
		,lag(temperature) OVER () AS prev_temp
	FROM temperature
	)
WHERE temperature > prev_temp

-----------------END OF QUERIES-------------------------------------------
