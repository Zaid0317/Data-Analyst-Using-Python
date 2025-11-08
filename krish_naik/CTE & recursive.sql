

/*
A Common Table Expression (CTE) in SQL is a temporary result set that you can reference within a 
SELECT, INSERT, UPDATE, or DELETE statement. CTEs are defined using the WITH keyword, 
and they can make complex queries easier to write, understand, and maintain by breaking them into simpler parts.
*/
use employee_details
select * from Employees

CREATE TEMPORARY TABLE temp1 AS
SELECT *
FROM employees; 

select * from temp1

---Example 1 : CTE

With CTE AS (
select * from temp1
)

select * from cte

--Example 2 :

with Test_CTE as (
select employeeid,firstname from temp1 where EmployeeID in (2,4)
)

select * from test_cte 

--Example 3 # it will work on mssql

with Comm_Table_Expression as (
select * from temp1 where EmployeeID in (1,2,3)
)

CREATE TEMPORARY TABLE temp2
AS SELECT * FROM comm_table_expression;

-------EXAMPLE 3 ALTERNATIVE:------------

CREATE TEMPORARY TABLE temp2 AS
SELECT * FROM temp1 WHERE EmployeeID IN (1, 2, 3);

select * from temp2

--Example 4 : work in MSSQLx3
]k,=
with CTE_1 as (
select * from temp1 where EmployeeID in (2,4,6)
)

update temp1 set employeeid = 101 where employeeid in (select distinct employeeid from cte_1)

--
select * from #temp1


--Example 5 :

with cte_2 as (
select * from #temp1 where EmployeeID = 1
)

delete from temp1 where EmployeeID in (select distinct employeeid from cte_2)

select * from #temp1

--Example 6 :

with cte_3 as (
select * from #temp1 where EmployeeID in (101)
)

insert into #temp1 select * from cte_3

---------------------------------------------------------------

select * from Employees

select * into #1 from dbo.Employees

------Example 1------
WITH CTE1 AS (
    SELECT * FROM temp1 WHERE EmployeeID IN (1,2)
),
CTE2 AS (
    SELECT * FROM temp1 WHERE EmployeeID IN (3,4)
)
SELECT * FROM CTE1
UNION ALL
SELECT * FROM CTE2;


--Example 2
with cte3 as (
select employeeid,firstname from #1 where EmployeeID = 1
),cte4 as (
select employeeid,firstname from #1 where EmployeeID in (3)
)

select * into #2 from (
select * from cte3
union all
select * from cte4
) x


--Example 3 
with cte3 as (
select employeeid,firstname from #1 where EmployeeID = 1
),cte4 as (
select employeeid,firstname from #1 where EmployeeID in (3)
)

insert into #2 select * from (
select * from cte3
union all
select * from cte4
) x

select * from #2

--Example 4
with cte3 as (
select employeeid,firstname,Salary from #1 where EmployeeID = 2
),cte4 as (
select employeeid,firstname,Salary from #1 where EmployeeID in (4)
)

delete from #1 where EmployeeID in (select distinct employeeid from cte3
union all
select distinct EmployeeID from cte4
)


select * from #1

--Example 5 :
with cte3 as (
select employeeid,firstname,Salary from #1 where EmployeeID = 9
),cte4 as (
select employeeid,firstname,Salary from #1 where EmployeeID in (10)
)

update #1 set employeeid = 100 where EmployeeID not in (select distinct employeeid from cte3
union all
select distinct EmployeeID from cte4
)

--------------------------------------------------------------------------------
													## RECURSIVE CTE


--Recursive CTE
--Factorial of a given number (5)

with [R CTE] as (
--Anchor Query
select 1 as n

union all

--Recursive Query
select n+1 from [R CTE] where n<=4

)

select exp(sum(log(n))) [Factorial] from [R CTE]
--------

-----------
--3*2*1
--5*4*3*2*1


----------------
with [R CTE] as (
--Anchor Query
select 1 as n

union all

--Recursive Query
select n+1 from [R CTE] where n<=4

)

select * from [r cte]











