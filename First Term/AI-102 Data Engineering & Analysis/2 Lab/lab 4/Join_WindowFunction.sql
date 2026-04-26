-- Group by 
-- Total sales by moth
use datawarehouseanalytics;
select 
month(order_date) as month ,
sum(sales_amount)  as total_sales
from fact_sales 
group by month(order_date)
order by month(order_date)

-- filter on grouping 
 
select 
month(order_date) as Month ,
sum(sales_amount)  as total_sales
from fact_sales 
group by Month
having Month =2

-- working with null values 
use adventureworks ;
select * from product

-- IFNull 
use adventureworks ;
select ifnull(Size,"Non known") as size  , Name
from product

-- COALESCE --> return first None null value
SELECT COALESCE(FirstName,MiddleName,LastName) AS Name
FROM contact;

-- Join 
-- 1. Inner JOin 
use datawarehouseanalytics;
select product_name , category,sales_amount , quantity
from fact_sales 
inner join dim_products
on dim_products.product_key =fact_sales.product_key

-- 2.left join 
use datawarehouseanalytics;
select product_name , category,sales_amount , quantity
from fact_sales 
left join dim_products
on dim_products.product_key =fact_sales.product_key

-- 3. right join 
use datawarehouseanalytics;
select product_name , category,sales_amount , quantity
from fact_sales 
right join dim_products
on dim_products.product_key =fact_sales.product_key

-- 4.outer join
use datawarehouseanalytics;
select product_name , category,sales_amount , quantity
from fact_sales 
cross join dim_products
on dim_products.product_key =fact_sales.product_key

-- union 
-- Customers who bought Electronics
SELECT c.first_name, p.product_name, 'Bikes' AS category
FROM fact_sales as  f
	JOIN dim_products as p 
	ON f.product_key = p.product_key
JOIN dim_customers as  c
ON f.customer_key = c.customer_key
WHERE p.category = 'Bikes'

union 
-- Customers who bought Furniture
SELECT c.first_name, p.product_name, 'Accessories' AS category
FROM fact_sales as  f
	JOIN dim_products as p 
	ON f.product_key = p.product_key
JOIN dim_customers as  c
ON f.customer_key = c.customer_key
WHERE p.category = 'Accessories';

-- SubQueries 
-- Find all customers who bought a product with sales_amount greater than 1000.
select first_name 
from dim_customers 
where customer_key in ( select customer_key from fact_sales where sales_amount >1000)

-- Show each product and the highest sale amount for that product.
select
	product_name ,
	(    select max(sales_amount) 
         from fact_sales as fs 
         where p.product_key = fs.product_key
	) as max_sales
from dim_products as p

-- Find all sales that are greater than the average sale amount.
select *
from fact_sales
where sales_amount > (select avg(sales_amount) from fact_sales)

-- exist condition 
select first_name 
from dim_customers 
where  exists ( select customer_key from fact_sales where sales_amount >1000)

-- CTE (common table expression) temproray named result
 -- Total sales per customer
 
 with total_sales as (
   select customer_key , sum(sales_amount) as total_sales 
   from fact_sales
   group by customer_key
   )
   
select c.first_name , s.total_sales
from dim_customers as c 
join total_sales as s 
on c.customer_key = s.customer_key
where s.total_sales > 1000

-- We want to find the top 3 products with the highest total quantity sold.

with highest_total as (
             select   product_key, sum(quantity) as total_quantity
             from fact_sales
             group by product_key
            )
            
select p.product_name, ht.total_quantity
from dim_products as p 
join highest_total as ht 
on p.product_key = ht.product_key
order by ht.total_quantity desc
limit 3;

-- Window Functions 
-- A window function is a special kind of function that looks 
-- at a group of rows (a “window”) related to the current row 
-- and performs a calculation without collapsing the rows.

-- 1. Normal GROUP BY aggregates rows → you get one row per group.
-- 2. Window functions → you keep all rows, but still calculate sums, averages, ranks, etc., over a group.

-- FUNCTION_NAME(...) OVER (
--     [PARTITION BY column1, column2, ...]  -- optional, groups rows
--     [ORDER BY column1, column2, ...]     -- optional, defines order
-- )

-- Cumulative sales per customer

select 
c.first_name,
fs.sales_amount,
fs.order_date,
sum(sales_amount) over (partition by fs.customer_key order by order_date) as comulative_sales -- comulative sales by customer name 
from fact_sales as fs 
join dim_customers as c 
on c.customer_key = fs.customer_key

-- Rank products by total sales in each category
WITH product_totals AS (
    SELECT 
        p.product_key,
        p.product_name,
        p.category,
        SUM(fs.sales_amount) AS total_sales
    FROM dim_products p
    JOIN fact_sales fs ON fs.product_key = p.product_key
    GROUP BY p.product_key, p.product_name, p.category
)
SELECT
    product_name,
    category,
    total_sales,
    RANK() OVER (PARTITION BY category ORDER BY total_sales DESC) AS rank_in_category
FROM product_totals;

-- previous and next sales for each customer
select 
c.first_name,
fs.sales_amount,
fs.order_date,
lag(fs.sales_amount) over(partition by c.customer_key order by fs.order_date) as previous_sales,
lead(fs.sales_amount) over(partition by c.customer_key order by fs.order_date) as next_sales
from dim_customers as c 
join fact_sales as fs 
on c.customer_key = fs.customer_key
















