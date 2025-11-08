create database sql_interview_question
use sql_interview_question

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName NVARCHAR(100),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, EmployeeName, Salary)
VALUES
(1, 'Alice Smith', 70000.00),
(2, 'Bob Johnson', 85000.00),
(3, 'Carol White', 95000.00),
(4, 'David Brown', 60000.00),
(5, 'Eve Davis', 75000.00),
(6, 'Frank Miller', 90000.00),
(7, 'Grace Lee', 80000.00),
(8, 'Hannah Clark', 62000.00),
(9, 'Ivy Harris', 74000.00),
(10, 'Jack Lewis', 98000.00);
--------------------------------------------------------------------------------

# 1. FINDING 2nd HIGHEST SALARY

select max(salary) as 2nd_highest_salary from employees where salary <
(select max(salary) from employees)

# 2. FINDIND #RD HIGHEST SALARY

select max(salary) as 3rd_highest_salary from employees where salary < (
select max(salary) from employees where salary <
(select max(salary) from employees))
---------------------------
# 3. CTE METHOD
with cte as(
select *, dense_rank() over(order by salary desc) as sal
from employees)

select * from cte where sal=3

# 4. sub query with dense_rank()
select salary as 2nd_highest_salary from
(select *, dense_rank() over(order by salary desc) as sal from employees) as x
where sal=2

# 5. subquery
select top 1 salary from
(select distinct top 2 salary from employees order by salary desc) as x
order by salary asc 		 	##WILL RUN IN MS SQL

#ALTERNATIVE
select salary from
(select distinct salary from employees order by salary desc limit 2) as x
order by salary limit 1
-----------------------------------------------------------------------------------------------
use sql_interview_question
-- Create the table
CREATE TABLE ReportingStructure (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    ManagerID INT
);

-- Insert data into the table
INSERT INTO ReportingStructure (EmployeeID, EmployeeName, ManagerID) VALUES
(1, 'Alice Smith', NULL),  -- Alice Smith is at the top and reports to no one
(2, 'Bob Johnson', 1),     -- Bob Johnson reports to Alice Smith
(3, 'Carol White', 1),     -- Carol White reports to Alice Smith
(4, 'David Brown', 2),     -- David Brown reports to Bob Johnson
(5, 'Eve Davis', 2),       -- Eve Davis reports to Bob Johnson
(6, 'Frank Miller', 3);    -- Frank Miller reports to Carol White
---------------------------------------------------------
										##REPORTEE AND MANAGER QUESTION
select * from ReportingStructure

select b.employeename as Reportee,A.employeename as Manager
from ReportingStructure as A
inner join reportingstructure as B
on a.employeeid = b.managerid

union all

select employeename,null as Manager from reportingstructure
where managerid is null
--------------------------------------------------------------------------------------------------------

-- Create the table with potential duplicates
CREATE TABLE EmployeeRecords (
    EmployeeID INT,
    EmployeeName VARCHAR(100),
    ManagerID INT
);


-- Insert data into the table, including duplicates
INSERT INTO EmployeeRecords (EmployeeID, EmployeeName, ManagerID) VALUES
(1, 'Alice Smith', NULL),
(2, 'Bob Johnson', 1),
(3, 'Carol White', 1),
(4, 'David Brown', 2),
(5, 'Eve Davis', 2),
(6, 'Frank Miller', 3),
(2, 'Bob Johnson', 1),  -- Duplicate entry
(4, 'David Brown', 2);  -- Duplicate entry
-----------------------------------------------------------------
										##DELETING DUPLICATES
select * from EmployeeRecords
order by EmployeeID,EmployeeName,ManagerID

With CTE as (
select *, row_number() over(partition by employeeid,employeename,managerid order by employeeid) as R_Number from EmployeeRecords
)
#select * from CTE
delete from cte where R_Number = 2			## this work in MS SQL

##ALTERNATIVE

SET SQL_SAFE_UPDATES = 0; 	##turning off saftey mode
CREATE TABLE temp_records AS
SELECT *, ROW_NUMBER() OVER (PARTITION BY EmployeeID, EmployeeName, ManagerID ORDER BY EmployeeID) AS rn
FROM EmployeeRecords;

DELETE FROM temp_records WHERE rn > 1;

SET SQL_SAFE_UPDATES = 1; 	##turning saftey mode
select * from temp_records
select * from employeerecords
--------------------------
# 2nd method to remove duplicate

create temporary table emp_backup select * from employeerecords
select * from emp_backup

create temporary table emp_backup1 select distinct * from emp_backup
truncate table emp_backup

insert into emp_backup select * from emp_backup1
select * from emp_backup1

---------------------------------------------------------------------------------------
-- Create the table with EmployeeID and Email
CREATE TABLE EmployeeRecords_1 (
    EmployeeID INT,
    Email VARCHAR(100)
);


-- Insert data into the table, including duplicates
INSERT INTO EmployeeRecords_1 (EmployeeID, Email) VALUES
(1, 'alice@example.com'),
(2, 'bob@example.com'),
(3, 'carol@example.com'),
(4, 'david@example.com'),
(2, 'bob@example.com'),        -- Duplicate entry (same EmployeeID and Email)
(4, 'david@example.com'),      -- Duplicate entry (same EmployeeID and Email)
(5, 'shared@example.com'),     -- Valid case: Same email, different EmployeeID
(6, 'shared@example.com');     -- Valid case: Same email, different EmployeeID
--------------------------------------------

#there are two types of duplicate present in above data
create temporary table emp1 select distinct * from employeerecords_1
select * from emp1

truncate table employeerecords_1

insert into employeerecords_1 select * from emp1
select * from employeerecords_1

--Record with Lower Employee ID should remain
with cte as (
select *, DENSE_RANK() over(partition by email order by employeeid) as DR from EmployeeRecords_1
)
delete from cte where dr = 2  		## work on MSSQL
SET SQL_SAFE_UPDATES = 1;

---
select * into employeerecords_2 from #1

select * from employeerecords_2 order by email

--Retail the record with higher Employee id
with cte as (
select *, DENSE_RANK() over(partition by email order by employeeid desc) [DR] from employeerecords_2
)
--select * from cte
delete from cte where DR = 2

-------------------------


select * from employeerecords_1 --Employeeid = 5 was retained

select * from employeerecords_2 --Employeeid = 6 was retained
