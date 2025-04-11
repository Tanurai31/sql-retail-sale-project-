use sql_project_p1;


drop table reatil_sales;

create table reatil_sales(
transactions_id int primary key,  sale_date date,	sale_time time,	customer_id int,	gender varchar(20),	age int, category varchar(20),	quantity int, 
price_per_unit int,	cogs float,	total_sale float)
;

select count(*)
from reatil_sales;


SELECT 
    *
FROM
    reatil_sales
WHERE transactions_id is null
or
    sale_time IS NULL 
    OR sale_date IS NULL
        OR gender IS NULL
        OR category IS NULL
        OR quantity IS NULL
        OR cogs IS NULL
        OR total_sale IS NULL;

delete from retail_sale
where 
transactions_id is null
or
    sale_time IS NULL 
    OR sale_date IS NULL
        OR gender IS NULL
        OR category IS NULL
        OR quantity IS NULL
        OR cogs IS NULL
        OR total_sale IS NULL;

select count(*)
from reatil_sales;

-- how many sales we have

select count(*) as total_sales
from reatil_sales;


-- how many unique customer we have

select count( distinct customer_id) as total_sales
from reatil_sales;


select distinct category as categ from reatil_sales;

-- Data Analysis & Business Key Problems and Answers

-- write a sql query to retrive all columns for sales mode on 2022-11-05

SELECT 
    *
FROM
    reatil_sales
WHERE
    sale_date = '2022-11-05';
    
--     write a SQL query to retrive all transactions where the category is clothing and the quantity sold is more than 3 in the month of nov-2022

SELECT 
    *
FROM
    reatil_sales
WHERE
    category = 'clothing' AND quantity > 3
        AND MONTH(sale_date) = 11
        AND YEAR(sale_date) = 2022;
 
 -- write a sql query to calculate the total sales for each category
 
SELECT 
    category, SUM(total_sale)
FROM
    reatil_sales
GROUP BY category;


--  write a sql query to find the average age of customer who purchased items from the beauty category

SELECT 
    round(avg(age), 2) as avg_age
FROM
    reatil_sales
WHERE
    category = 'beauty'
;

-- write a sql query to find all transactions where the total_sale is greater than 1000.

select *
from reatil_sales
where total_sale > 1000;


-- write a sql query to find the total number of transation (transaction_id) made by each gender in each category.

select 
count(distinct(transactions_id)), gender, category
from reatil_sales
group by gender, category;

--  impo ques (write a sql query to calculate the average sale for each month. find out best selling month in each year)

SELECT 
    MONTH(sale_date), YEAR(sale_date), avg(total_sale),
     rank()  over(partition by extract(year from sale_date) order by avg(total_sale) desc)
FROM
    reatil_sales
GROUP BY MONTH(sale_date) , YEAR(sale_date)
ORDER BY  MONTH(sale_date), avg(total_sale) desc
;


--  write a sql query to find the top 5 customers based on the highest total sales

select customer_id, sum(total_sale)
from reatil_sales
group by  customer_id
order by customer_id desc
limit 5;

-- write a sql query to find the numbers of unique customers who purchased items from each actegory.

SELECT  category,
    count(distinct(customer_id))
FROM
    reatil_sales
GROUP BY category;


-- write a sql query to create each shift and number of orders (example ,morning <= 12, afternoon between 12 & 17, evening > 17)

with hourly_sale
as
(
SELECT 
    *,
    CASE
        WHEN HOUR(sale_time) <= 12 THEN 'morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
        ELSE 'evening'
    END AS shift
FROM
    reatil_sales)
    select
    shift, count(*) as total_orders
    from hourly_sale
    group by shift;




