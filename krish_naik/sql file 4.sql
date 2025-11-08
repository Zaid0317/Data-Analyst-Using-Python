create database assignment
use assignment
--------------------------

--Step 1) Create Table
CREATE TABLE EmployeeSales (
    SaleID INT PRIMARY KEY,
    EmployeeID INT,
    Department VARCHAR(50),
    SaleAmount DECIMAL(10, 2),
    SaleDate DATE
);

--Step 2) Insert records into the table
INSERT INTO EmployeeSales (SaleID, EmployeeID, Department, SaleAmount, SaleDate)
VALUES 
(1, 101, 'Electronics', 500.00, '2023-08-01'),
(2, 102, 'Electronics', 300.00, '2023-08-03'),
(3, 101, 'Furniture', 150.00, '2023-08-02'),
(4, 103, 'Electronics', 250.00, '2023-08-04'),
(5, 104, 'Furniture', 200.00, '2023-08-02'),
(6, 101, 'Furniture', 450.00, '2023-08-05'),
(7, 102, 'Electronics', 700.00, '2023-08-05'),
(8, 103, 'Furniture', 100.00, '2023-08-06');

-----------------------------------------------------------------------------------
													## ASSIGNMENT 1
select department,sum(saleAmount) as total_sale from employeeSales
group by Department

select * from employeesales

select employeeid,count(saleid) as count_of_sale from employeesales
group by employeeid

select department,avg(saleamount) as avg_sale from employeesales
group by department

select employeeid, sum(saleamount) as total_sale, count(saleid) as number_of_sale from employeesales
group by employeeid
having count(saleid) > 1

select sum(saleamount) as total_sale, month(saledate) as month from employeesales
where year(saledate)= 2023
group by month(saledate)
order by month(saledate)

------------------------------------------------------------------------------------
													## ASSIGNMENT 2
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100) UNIQUE,
    DepartmentID INT,
    HireDate DATE,
    Salary DECIMAL(10, 2)
);


INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, DepartmentID, HireDate, Salary)
VALUES 
(1, 'John', 'Smith', 'john.smith@example.com', 101, '2021-06-15', 75000.00),
(2, 'Jane', 'Doe', 'jane.doe@example.com', 102, '2020-03-10', 85000.00),
(3, 'Michael', 'Johnson', 'michael.johnson@example.com', 101, '2019-11-22', 95000.00),
(4, 'Emily', 'Davis', 'emily.davis@example.com', 103, '2022-01-05', 68000.00),
(5, 'William', 'Brown', 'william.brown@example.com', 102, '2018-07-19', 80000.00);

----------------------------------------------------------------------------------
# 1:Write a SQL query to find the names of employees who have a salary higher than the average salary of all employees.
select employeeid, firstname, lastname, salary from employees
where salary > (select avg(salary) from employees)

# 2:Write a SQL query to list the employee names and their departments for employees who were hired after the oldest employee in the company.
select firstname, lastname, departmentid, hiredate from employees
where hiredate > (select min(hiredate) from employees)

#3:Write a SQL query to find the details of the employee(s) with the highest salary.
SELECT firstname, lastname, departmentid, salary
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

#4:Write a SQL query to find the names of employees who work in the same department as 'John Smith'.
SELECT firstname, lastname, departmentid
FROM employees
WHERE departmentid = (
    SELECT departmentid
    FROM employees
    WHERE firstname = 'John' AND lastname = 'Smith')

#5:Write a SQL query to find the names of employees who do not belong to the department with the highest average salary.
SELECT firstname, lastname, departmentid, salary
FROM employees
WHERE departmentid <> (
    SELECT departmentid
    FROM employees
    GROUP BY departmentid
    ORDER BY AVG(salary) DESC
    LIMIT 1)
-------------------------------------------------------------------------------------
														## ASSIGNMENT 3
select * from employees
#1: Write a SQL query to find the names of employees whose first names start with the letter 'J'.
select * from employees where firstname like 'j%'

#2: Write a SQL query to find the names of employees whose last names end with the letter 'n'.
select * from employees where lastname like '%n'

#3: Write a SQL query to find the email addresses of employees that contain the word "john".
select * from employees where email like '%john%'

#4:Write a SQL query to find the names of employees whose first names have exactly 5 characters.
select * from employees where firstname like '_____'

#5. Write a SQL query to find the names of employees whose last names contain the letter 'a' as the second character.
select * from employees where lastname like '_a%'

----------------------------------------------------------------------------------------
-- Creating the Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(100)
);
-- Inserting data into the Departments table
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES
(101, 'Human Resources'),
(102, 'Finance'),
(103, 'IT');
------------------------------------------------------------------------------------------
													## ASSIGNMENT 4
#1. Write a SQL query to list the names of employees along with the names of the departments they work in.
 select * from employees
 select * from departments
select firstname, lastname, departmentname
from employees as e join
departments as d on e.departmentid=d.departmentid

#2. Write a SQL query to list all the departments and the employees working in them, including departments with no employees.
select firstname, lastname, departmentname
from employees as e right join
departments as d on e.departmentid=d.departmentid

#3. Write a SQL query to find the names of employees who do not belong to any department (i.e., no matching department ID).
select firstname, lastname, departmentname
from employees as d left join
departments as e on e.departmentid=d.departmentid
where d.departmentid is null

#4. Write a SQL query to list the names of employees who work in the same department as 'Jane Doe'.
select firstname,lastname, departmentid
from employees where departmentid = (
	select departmentid
    from employees
	where firstname='jane' and lastname='doe')

#5. Write a SQL query to find the department with the highest total salary paid to its employees.
SELECT departmentname, sum(salary) AS total_salary
FROM employees AS e
JOIN departments AS d ON e.departmentid = d.departmentid
GROUP BY d.departmentname
ORDER BY total_salary DESC
LIMIT 1
---------------------------------------------------------------------------------
												## ASSIGNMENT 5
use assignment
#1. Write a SQL query to select all columns and rows from the Employees table.
select * from employees

#2. Write a SQL query to find the names and email addresses of all employees who work in the department with DepartmentID = 101.
select firstname, lastname, email, departmentid from employees where departmentid=101

#3. Write a SQL query to find the total number of employees in the Employees table.
select count(employeeid)as number_of_emp from employees

#4. Write a SQL query to find the details of employees who were hired in the year 2020.
select * from employees where year(hiredate)= 2020

#5. Write a SQL query to update the salary of 'Jane Doe' to 90,000.
UPDATE employees SET salary = 90000 WHERE employeeid = 2
