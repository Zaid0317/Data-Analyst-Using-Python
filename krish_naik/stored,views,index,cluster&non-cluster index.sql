create database testDB
use testdb

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

-----------------------------------------------------------------------------------
											## STORED PROCEDURE
select * from Employees
DELIMITER $$

CREATE PROCEDURE sp_test()
BEGIN
    SELECT * FROM Employees;
END $$

DELIMITER ;

call sp_test() 		## calling sp_test()

--Example 2

delimiter $$

Create procedure sp_test_1()
begin
	select firstname,lastname from Employees;
end $$

delimiter;

call sp_test_1()

-------------------
DROP PROCEDURE IF EXISTS sp_test_1;

DELIMITER $$

CREATE PROCEDURE sp_test_1()
BEGIN
    SELECT employeeid, firstname, lastname FROM Employees;
END $$

DELIMITER ;

--------------------------------------------------------------------------------------------------------
												## VIEWS

select * from Employees
----------
create temporary table emp_bkp as
select * from employees
----------
select * from emp_bkp


--A View is a virtual table,it is a stored SQL Query
--It helps in reducing the complexity of the code
--It helps in implementing security

CREATE VIEW View_1 AS
SELECT * FROM emp_bkp;  		##not working in mysql we need MSSQL 

##alternative by using CTE

WITH emp_cte AS (
    SELECT * FROM emp_bkp
)
SELECT * FROM emp_cte;


select * from emp_cte
update emp_cte
set EmployeeID = 100  	## WORKS IN MSSQL

--*
CREATE TEMPORARY TABLE view_2 AS
SELECT EmployeeID, FirstName, LastName, Email, DepartmentID, HireDate
FROM emp_bkp;

SELECT * FROM view_2;

------------------------------------------------------------------------------------------------------
													##INDEXES 
select * from employees;
create index IX_1 on employees (salary);

SHOW INDEX FROM employees;
DROP INDEX IX_1 ON employees;

--------------------------------------------------------------------------------------------------------
												## CLUSTERED INDEX
create database Test_Index
use test_index

drop table if exists students
create table Students ( id int, name nvarchar(50), age int, gender varchar(20))

insert into Students values
(1,'Raj',23,'M'),
(4,'Nitin',25,'M'),
(3,'Priya',21,'F'),
(2,'Nikita',20,'F'),
(5,'Monica',20,'F')

									##MY SQL DOES NOT SUPPORT CLUSTERED INDEX WE NEED MS SQL


select * from Students

create clustered index ix_1 on students (id)

create clustered index ix_2 on students (id desc)

drop index ix_1 on students

create clustered index ix_3 on students (gender desc, age asc)

drop index ix_2 on students

create nonclustered index ix_1 on students (gender desc, age asc)
drop index ix_1 on students

drop index ix_3 on students
                                                

