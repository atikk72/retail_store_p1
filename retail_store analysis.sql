-- retail store analysis
create database  ptoject_p1

-- create table


create table retail_store (
   transactions_id int primary key,
   sale_date	date,
   sale_time time,	
  customer_id int,
  gender varchar(15),
  age int,
  category varchar(15),
  quantiy int,
  price_per_unit float	,
  cogs float,
  total_sale float);


select *from retail_store
limit 10

-- data cleaning

select *from retail_store
where transactions_id is null
      or
	  sale_date is null
	  or
	  sale_time is null
	  or
	  customer_id is null
	  or
	  gender is null
	  or
	  age is null
	  or
	  category is null
	  or
	  quantiy  is null
	  or
	  price_per_unit is null
	  or cogs is null
	  or total_sale is null
-- deleting null values at once
delete from retail_store
where transactions_id is null
      or
	  sale_date is null
	  or
	  sale_time is null
	  or
	  customer_id is null
	  or
	  gender is null
	  or
	  age is null
	  or
	  category is null
	  or
	  quantiy  is null
	  or
	  price_per_unit is null
	  or cogs is null
	  or total_sale is null
select count(*)  from retail_store
-- data exploration

-- How many sales we have
select count(*) from retail_store

-- How many customer do we have
select*from retail_store

select count(customer_id) from retail_store

-- How many unique customer do we have
select count (distinct customer_id) from retail_store

select  distinct category from retail_store

-- Business key problem


 My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select *from retail_store
where sale_date ='2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is
-- 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

select *from retail_store

select transactions_id,category,quantiy,sale_date
from retail_store
where category='Clothing' and 
to_char(sale_date,'yyyy-mm')='2022-11'
and quantiy>=4

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select *from retail_store
select category, sum(total_sale), count( distinct category) from retail_store
group by category,total_sale


select category, count(*) as total_orders,sum(total_sale)
 as net_sale
from  retail_store
group by category

-- Q.4 Write a SQL query 
-- to find the average age of customers who purchased items from the 'Beauty' category.

select age, category, round(avg(age),2) as avg_age from retail_store
where category='Beauty'
group by age,category

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select transactions_id,total_sale  from retail_store
where total_sale >1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id)
-- made by each gender in each category.
select  category,gender,count(transactions_id) as no_of_transactions_by_gender
from retail_store
group by gender,category

-- Q.7 Write a SQL query to calculate the average sale for each month.
-- Find out best selling month in each year

  select 
  year,
  month,
  avg_sale
   from
   (
   select
   extract (year from sale_date) as year,
   extract( month from sale_date) as month,
  avg(total_sale) as avg_sale,
  rank() over (partition by extract(year from sale_date ) order by  avg(total_sale) desc ) as rankk
  from retail_store
  group by year,month)  as t1
 where rankk =1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select customer_id,sum(total_sale) as total_sale
from retail_store
group by customer_id
order by total_sale desc
limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.


SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_store
GROUP BY category


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
	  
	WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_store
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_store
GROUP BY shift
 

