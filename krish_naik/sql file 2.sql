create database Sales
use Sales

--Creating Table1 & insertinting records in Table1
CREATE TABLE table1 (
    C1 INT,
    C2 VARCHAR(255)
);

INSERT INTO table1 (C1, C2) VALUES
(1, 'A'),
(1, 'B'),
(2, 'C'),
(NULL, 'D'),
(3, 'E'),
(7, 'DA');


--Creating Table2 & insertinting records in Table2
create table table2 (C1 int, C3 varchar(200));
insert into table2 values (1,'XA'),
(2,'MB'),
(2,'NX'),
(NULL,'MO'),
(4,'XY'),
(5,'TF')

											## INNER JOIN also called JOIN and can also be used as self join

select a.c1, a.c2, b.c3 from table1 as a 	  # a is table1 and b is table2 & c1,c2,c3 is the column name present in the table
inner join      			 #we can either write join or inner join
table2 as b  		##here for self join we will use table1 as b(joining single table as a & b)
on a.c1=b.c1

											## LEFT JOIN also called LEFT OUTER JOIN
select a.c1,a.c2,b.c3 from table1 as a
left join 
table2 as b
on a.c1=b.c1

											## RIGHT JOIN also called RIGHT OUTER JOIN
select a.c1,a.c2,b.c3 from table1 as a
right join
table2 as b
on a.c1=b.c1

											##LEFT ANTI JOIN
select * from table1 as a
left join
table2 as b
on a.c1=b.c1
where b.c1 is null

											## RIGHT ANTI JOIN
select * from table1 as a
right join
table2 as b
on a.c1=b.c1
where a.c2 is null

											## FULL OUTER JOIN (not supported in mysql workbench)
#select * from table1 as a
#outer join
#table2 as b
#on a.c1=b.c1

create table append1 (C1 int,C2 varchar(255),C3 int);
insert into append1 values
(1,'A',7),
(2,'B',8),
(3,'C',9);


create table append2 (C1 int,C2 varchar(255),C3 int);
insert into append1 values (11,'AA',17),
(2,'B',8),
(33,'C1',91);

---------------------------------------------------------------------------------
											## UNION & UNION ALL
select c1,c2,c3 from append1
union all
select c1,c2,c3 from append2

select c1,c2,c3 from append1
union
select c1,c2,c3 from append2


-- Create Employees_us table
CREATE TABLE Employees_US (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50)
);

-- Insert sample data into Employees table
INSERT INTO Employees_us (EmployeeID, FirstName, LastName, Department) VALUES
(1, 'Alice', 'Smith', 'Finance'),
(2, 'Bob', 'Johnson', 'Engineering'),
(3, 'Charlie', 'Williams', 'Marketing'),
(4, 'Diana', 'Brown', 'Finance'),
(5, 'Edward', 'Jones', 'Engineering'),
(6, 'Fiona', 'Garcia', 'Marketing'),
(7, 'George', 'Miller', 'Finance'),
(8, 'Hannah', 'Wilson', 'Engineering');

---------------------------------------------------------------------------------
										 ###  LIKE FUNCTION  ###

#1) Find Employees whose Last Name starts with 'S'.
select * from employees_us where lastname like 's%'

#2) Find Employees whose First Name ends with 'a'.
select * from employees_us where firstname like '%a'

#3) Find Employees whose Department contains 'Eng'.
select * from employees_us where department like '%eng%'

#4) Find Employees whose Last Name is exactly 5 characters long.
select * from employees_us where lastname like '_____'

#5) Find Employees whose First Name starts with 'C' or 'D'.
select * from employees_us where firstname like 'C%' or firstname like 'd%'

#6) Find Employees whose Last Name contains 'son'.
select * from employees_us where lastname like '%son%'

#7) Find Employees whose First Name contains the letter 'i' as the second character.
select * from employees_us where firstname like '_i%'

#8) Find Employees whose Last Name starts with any letter between 'A' and 'L'.
select * from employees_us where lastname like '(a-l)%'

#9) Find Employees whose First Name does not contain 'o'.
select * from employees_us where firstname not like '%o%'

#10) Find Employees whose Last Name ends with 'a' and is exactly 5 characters long.
select * from employees_us where lastname like '_____a'

#11) Find Employees whose Department starts with 'Mar' and ends with 'ing'.
select * from employees_us where department like 'mar%ing'

#12) Find Employees whose First Name has an 'a' in the third position.
select * from employees_us where firstname like '__a%'

#13) Find Employees whose Last Name starts with 'Br' or 'Bl'.
select * from employees_us where lastname like 'br%' or lastname like 'bl%'

#14) Find Employees whose First Name starts with a vowel.
select * from employees_us where firstname like '[aeiou]%'

#15) Find Employees whose First Name does not start with a consonant.
select * from employees_us where firstname not like '[^aeiou]%'

#16) Find Employees whose First Name starts with a consonant.
select * from employees_us where firstname like '[^aeiou]%'

---------------------------------------------------------------------------------
use sales
-- Create the Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(20),
    Price DECIMAL(10, 2),
    StockQuantity INT,
    Supplier VARCHAR(50),
    Rating DECIMAL(3, 1)
);

-- Insert data into the Products table
INSERT INTO Products (ProductID, ProductName, Category, Price, StockQuantity, Supplier, Rating) VALUES
(1, 'Wireless Mouse', 'Electronics', 25.99, 150, 'Tech Supplies', 4.5),
(2, 'Office Chair', 'Furniture', 120.00, 85, 'Comfort Co', 4.7),
(3, 'Water Bottle', 'Accessories', 15.00, 250, 'AquaGear', 4.3),
(4, 'Laptop Backpack', 'Accessories', 45.99, 200, 'GearUp', 4.6),
(5, 'Gaming Laptop', 'Electronics', 999.99, 45, 'Tech Supplies', 4.8),
(6, 'Desk Lamp', 'Furniture', 35.00, 120, 'LightHouse', 4.2),
(7, 'Bluetooth Speaker', 'Electronics', 59.99, 95, 'SoundWave', 4.4),
(8, 'Standing Desk', 'Furniture', 250.00, 50, 'Comfort Co', 4.9),
(9, 'Fitness Tracker', 'Electronics', 129.99, 180, 'FitTech', 4.7),
(10, 'Coffee Mug', 'Accessories', 9.99, 300, 'MugMasters', 4.1);

------------------------------------------------------------------------------------
												##CASE STATEMENT
select *, case
when price >= 500 then 'high'
when price < 500 and price >= 200 then 'medium'
else 'low'
end as price_level
from products
order by price_level desc
-------------------------------------------
select * from products
order by
case
when category in ('electronics') then 1
when category = 'furniture' then 2
else 3
end
-----------------------------------------------------------------------------------
												## NESTED CASE STATEMENT
select *, case
	when category = 'electronics' then
	case when price >= 300 then 'premium electronic'
    else 'affordable electronic'
    end
    when category = 'furniture' then
	case when price >= 250 then 'premium furniture'
    else 'affordable furniture'
    end
else
	case when price >=25 then 'premium accessories'
    else 'affordable acc'
    end
end as grps
from products
-----------------------------------------------------------------------------------
select *, case
	when category = 'electronics' then
	case when price >= 300 then 'premium electronic'
    else 'affordable electronic'
    end
    when category = 'furniture' then
	case when price >= 250 then 'premium furniture'
    else 'affordable furniture'
    end
	when category in ('accessories') then
	case when price >=25 then 'premium accessories'
    else 'affordable acc'
    end
end as grps
from products
-------------------------------------------
select * from information_schema.columns where table_name like 'products'  ## to see all the details
-------------------------------------------
									 ## copying data from existing table to the new table
# case1:copying data from existing table to the new table
CREATE TABLE new_table1 AS
SELECT * FROM products;

select * from new_table1

# case2: we need only certain columns to copy	#remember select cant work in mysql
CREATE TABLE new_table2 AS
SELECT productname, category
FROM products;

select * from new_table2
                        
# case3: table already exist/new table structure
CREATE TABLE new_table3 AS 
SELECT * FROM products WHERE 1=0;    ## structure created
-----------------------
INSERT INTO new_table3		## inserting data after structure created
SELECT * FROM products;


select * from new_table3                    