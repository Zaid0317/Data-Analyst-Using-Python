create database test_env
select * from test_environment_inventory_dataset
select * from products

-------------------------------------------------

 select * into new_table from 
(select a.[Order_Date_DD_MM_YYYY],
a.product_id,a.availability,a.demand,b.product_name,b.unit_price

from [dbo].[Test_Environment_Inventory_Dataset] as a
left join products as b on a.product_id=b.product_id) x


-----------------------------------

select * from new_table
 



