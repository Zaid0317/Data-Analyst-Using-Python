select * from employees

select firstname from employees

select EmployeeID, concat(Firstname, ' ', LastName) as fullname from employees



use employee_details
			                                    ##using for distinct values

CREATE TABLE EmployeeRecords (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Department NVARCHAR(50),
    Salary DECIMAL(10, 2)
);


INSERT INTO EmployeeRecords (EmployeeID, FirstName, LastName, Department, Salary)
VALUES
(1, 'John', 'Miller', 'HR', 60000),
(2, 'Jane', 'Smith', 'Finance', 75000),
(3, 'John', 'Miller', 'HR', 60000),
(4, 'Emily', 'Davis', 'IT', 85000),
(5, 'Michael', 'Brown', 'Finance', 75000),
(6, 'Jane', 'Smith', 'Finance', 75000);

select distinct firstname from employeerecords

											##using temporary table
CREATE TEMPORARY TABLE temp1 AS
SELECT *
FROM employees; 

select * from temp1

											##using order by
select * from employeerecords 
order by salary

select * from employeerecords 
order by salary desc

select * from employeerecords 
order by department asc, salary desc

select distinct Department,Salary from employeerecords
where (department='hr' or department='finance') and salary >= 60000

use employee_details
select * from employeesrecords
where not firstname='john' and not salary=60000

use employee_details
select * from employeerecords
where department in ('hr','it') #we can also write not in ('hr','it') for others details

													##insert statement

INSERT INTO employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate)
VALUES (6, 'Raj', 'Ambani', 'IT', 67000, '2023-04-20')

select * from INFORMATION_SCHEMA.COLUMNS
where table_name='employees'

INSERT INTO employees(EmployeeID, FirstName, LastName)
values (7,'Rohit','Kumar')


select * from employees

select department, SUM(salary) as grouped_salary
from employees group by department
having sum(salary) < 60000

drop table table1, table2