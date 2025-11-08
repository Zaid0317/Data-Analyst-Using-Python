
create database profit_db

use profit_db

-- Create a table to store monthly profit data for different products
CREATE  TABLE ProfitData (
    MonthNumber INT,
    MonthName VARCHAR(3),
    Product VARCHAR(50),
    Profit INT
);

-- Insert data into the ProfitData table
INSERT INTO ProfitData (MonthNumber, MonthName, Product, Profit) VALUES
(1, 'Jan', 'Product A', 1000),
(2, 'Feb', 'Product A', 1500),
(3, 'Mar', 'Product A', 1200),
(4, 'Apr', 'Product A', 1700),
(5, 'May', 'Product A', 1300),
(6, 'Jun', 'Product A', 1600),
(1, 'Jan', 'Product B', 2000),
(2, 'Feb', 'Product B', 2500),
(3, 'Mar', 'Product B', 2200),
(4, 'Apr', 'Product B', 2700),
(5, 'May', 'Product B', 2300),
(6, 'Jun', 'Product B', 2600);
---------------------------------------------------------------------------------
												## LEAD FUNCTION
select *, lead(profit) over(partition by product order by monthnumber)
as next_month_profit from profitdata    	##it will show next month profit

select monthnumber,monthname,sum(profit) as Total_Profit,
lead(sum(profit)) over(order by monthnumber asc) as next_month_profit
from ProfitData
group by MonthNumber,MonthName
order by MonthNumber
------------------------------
										## LAG FUNCTION
                                        
select *, lag(profit) over(partition by product order by monthnumber)
as lag_function from profitdata			##it will show previous month profit

select monthnumber,monthname,sum(profit) as Total_Profit,
lag(sum(profit)) over(order by monthnumber asc) as prvious_month_profit
from ProfitData
group by MonthNumber,MonthName
order by MonthNumber
-----------------------------------------------------------------------------------------------------------------------------
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(20),
    Address VARCHAR(255)
);


INSERT INTO Customers (CustomerID, FirstName, LastName, Email, PhoneNumber, Address)
VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@example.com', '555-1234', '123 Elm St'),
(2, 'Bob', 'Smith', NULL, '555-5678', NULL),
(3, 'Charlie', 'Williams', 'charlie.williams@example.com', NULL, '456 Oak St'),
(4, 'Diana', 'Brown', NULL, NULL, '789 Pine St'),
(5, 'Eve', 'Davis', 'eve.davis@example.com', '555-8765', NULL);
---------------------------------------------------------------------------------
														## IS NULL & COALESCE FUNCTION
# how it works?   ISNULL(column, replacement) replaces NULL with the given replacement value.

select Customerid,ifnull(email,'Email NA'),ifnull(phonenumber,'Phone.No NA') from Customers

select Customerid,coalesce(email,phonenumber,'Contact NA') as Coalesce_Function from Customers


