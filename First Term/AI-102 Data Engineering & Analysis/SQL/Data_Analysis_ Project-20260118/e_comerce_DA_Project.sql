use datawarehouseanalytics;
-- Dimention exploration 
-- product categories
select distinct category
from dim_products;

--  countries
select distinct  country
from dim_customers;

-- products
select distinct product_name
from dim_products ;

-- Date exploration 
select 
min(order_date) as first_order_date,
max(order_date) as last_order_date
from  fact_sales;

-- change sales over time 
-- 1. changes over years 
select 
year(order_date),
sum(sales_amount) as total_sales ,
count(distinct customer_key) as total_customer,
sum(quantity) as total_quantity 
from fact_sales 
group by  year(order_date)
order by year(order_date);

-- 2. changes over years and months 
select 
year(order_date) as year,
month(order_date) as month,
sum(sales_amount) as total_sales ,
count(distinct customer_key) as total_customer,
sum(quantity) as total_quantity 
from fact_sales 
group by  year(order_date),month(order_date)
order by year(order_date),month(order_date);


select 
date_format(order_date,'%y-%m') as date,
sum(sales_amount) as total_sales ,
count(distinct customer_key) as total_customer,
sum(quantity) as total_quantity 
from fact_sales 
group by  date_format(order_date,'%y-%m')
order by date_format(order_date,'%y-%m');


-- year and month in only one col 
select 
date_format(order_date,'%Y-%m') as order_date,
sum(sales_amount) as total_sales
from fact_sales
group by date_format(order_date,'%Y-%m');

-- comulative analysis 
-- window function 
-- calculate total sales for each month 
-- running total sales ( colulative sales) over time 
with sales as (
select 
date_format(order_date,'%Y-%m') as order_date,
sum(sales_amount) as total_sales
from fact_sales
group by date_format(order_date,'%Y-%m')
) 
select 
order_date,
total_sales,
sum(total_sales) over(order by  order_date )as comulative_sales 
from sales;

 
-- running total sealse for each year
-- comulative sales for each year
with sales as (
select 
date_format(order_date,'%Y') as order_date,
sum(sales_amount) as total_sales
from fact_sales
group by date_format(order_date,'%Y')
) 
select 
order_date,
total_sales,
sum(total_sales) over(order by  order_date )as comulative_sales 
from sales;

-- Performance analysis (we use window function)
-- task
/* 
analyize the yearly perforamnce of products 
by comparing  each products sales to both 
its avgrage salse performance and the previous 
years sales
*/

with product_sales as (
select 
year(order_date) as year_date,
product_name,
sum(sales_amount) as total_sales
from 
fact_sales
join dim_products
on dim_products.product_key =fact_sales.product_key
group by year(order_date), product_name
)

select 
year_date,
product_name,
total_sales as current_Sales,
avg(total_sales) over(partition by product_name ) as avg_sales,
total_sales - avg(total_sales) over(partition by product_name ) as avg_diff,
case when total_sales - avg(total_sales) over(partition by product_name ) > 0 then "above avg"
     when total_sales - avg(total_sales) over(partition by product_name ) < 0 then "below avg"
     else "avg" 
end "avg_performance" , 
lag(total_sales) over (partition by product_name order by year_date) as py_sales,
case when total_sales - lag(total_sales) over (partition by product_name order by year_date) > 0 then "increase"
     when total_sales - lag(total_sales) over (partition by product_name order by year_date) < 0 then "decrease"
     else "No Change" 
end py_performance
from product_sales
order by year_date , product_name;

-- part to hole analysis
-- which categories contribute the most to overall saels?
-- to get total sales for all categories we need for window function
with category_sales as (
select 
category ,
sum(sales_amount) as total_sales
from fact_sales
join  dim_products
on dim_products.product_key = fact_sales.product_key
group by category
) 

select 
category ,
total_sales,
sum(total_sales) over() as total_sales_all,
concat(round((total_sales / sum(total_sales) over() ) * 100,2) , "%")  as percentage
from category_sales
order by total_sales desc ;
 
-- -- which categories contribute the most to overall quantity?
 
with category_quantity as (
select 
category ,
sum(quantity) as total_quantity
from fact_sales
join  dim_products
on dim_products.product_key = fact_sales.product_key
group by category
) 

select 
category ,
total_quantity,
sum(total_quantity) over() as total_quantity_all,
concat(round((total_quantity / sum(total_quantity) over() ) * 100,2) , "%")  as percentage
from category_quantity
order by total_quantity desc ;
 
-- Data Segmentation 
-- segment products into cost ranges and count how many products 
-- fall into each segment 
with product_segements as (
select 
product_key,
product_name,
cost,
case when cost < 100 then "below 100"
	 when cost between 100 and 500 then "100-500"
     when cost between 500 and 1000 then "500-1000"
     else "Above 1000"
end  cost_range
from dim_products
)
select
cost_range,
count(product_key) as num_products 
from product_segements
group by cost_range
order by num_products desc

 
 
 
 
 
 