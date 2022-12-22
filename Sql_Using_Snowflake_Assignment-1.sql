use database SAMPLEDB;

create or replace table Sales_data
(
order_id VARCHAR(50) not Null Primary Key,
order_date DATE,
ship_date DATE,
ship_mode VARCHAR(100),
customer_name VARCHAR(100),
segment STRING,
state STRING,
country STRING,
market STRING,
region string,
product_id VARCHAR2(100),
category STRING,
sub_category STRING,
product_name  STRING,
sales INT,
quantity INT,
discount INT,
profit INT,
shipping_cost INT,
order_priority VARCHAR(50),
year DATE);

--------Making a copy of a Sales_data----------------------------
create or replace table Shri_sales_data_copy as
select * from Sales_data;

select * from Shri_sales_data_copy;

--------task1-Primary Key already set while creating original table------

--------task2-Dates of Order_ID & Ship_ID format to YYYY-MM-DD was changed in excel sheet before uploading CSV--------

--------task3- extracting last numbers of Order_ID-------------------------
create or replace table Shri_sales_data_copy as
select *,
substring(order_id,9,12) as order_extract
from Shri_sales_data_copy;

select * from Shri_sales_data_copy;

--------task4- adding_discount__True/false------------

create or replace table Shri_sales_data_copy as
select *,
case 
    when DISCOUNT >0 then 'TRUE'
        else 'FALSE'
    end as Discount_flag
from Shri_sales_data_copy;
   
select * from Shri_sales_data_copy;

------task5- calculate delivery days---------------
create or replace table Shri_sales_data_copy as
select *,
    datediff('day',order_date,ship_date) as Processing_days
from Shri_sales_data_copy;

select * from Shri_sales_data_copy;
   
------task6- Flagging-Processing_days------------------------
#if Processing_days <= 3 days mark 5 rating
#if Processing_days > 3 and <=6 days mark 4 rating
#if Processing_days >6 and <=10 days mark 3 rating
#if Processing_days >10  mark 2 rating

Alter table Shri_sales_data_copy
add column Processing_day_rating INTEGER;

update Shri_sales_data_copy
set Processing_day_rating = (
case
    when Processing_days <= 3 then '5'
    when Processing_days <= 6 and Processing_days >3 then '4'
    when Processing_days <= 10 and Processing_days > 6 then '3'
    when Processing_days > 10 then '2'
    else 'none'
    END);

select * from Shri_sales_data_copy;
