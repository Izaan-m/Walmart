create table walmart_sales
(
invoice_id varchar(50) primary key not null,
branch varchar(5),
city varchar(40),
customer_type varchar(30),
gender varchar(10),
product_line varchar(100),
unit_price decimal (10, 2),
quantity int,
VAT float(6, 4),
total decimal (10, 2),
date_ datetime,
time_ time,
payment_method varchar(30),
cogs decimal(10, 2),
gross_margin_percentage FLOAT(11, 9),
gross_income DECIMAL(10, 2),
rating FLOAT(2, 1)
);

select * from walmart_sales;	
    -- -------------------------Feature Engineering-------------------------------
select 
	time_,
	(case
		when time_ between "00:00:00" and "12:00:00" then "Morning"
		when time_ between "12:01:00" and "16:00:00" then "Afternoon"
		else "Evening"
		end) as time_of_day
    from walmart_sales;

alter table walmart_sales
add column time_of_day varchar(50);

update walmart_sales
set time_of_day = (
		case
		when time_ between "00:00:00" and "12:00:00" then "Morning"
		when time_ between "12:01:00" and "16:00:00" then "Afternoon"
		else "Evening"
		end);
-- --------------------------------------------------------------------------------
 select
 date_,
 dayname(date_) as day_of_week
 from walmart_sales;
 
 alter table walmart_sales
 add column day_of_week varchar(10);
 
 update walmart_sales
 set day_of_week = dayname(date_);
 -- -------------------------------------------------------------------------------
 select * from walmart_sales;

select date_, monthname(date_) as month_name
from walmart_sales;

alter table walmart_sales
add column month_name varchar(20);

update walmart_sales
set month_name = monthname(date_);
-- --------------------------------------------------------------------------------
-- ----------------------------BUSINESS--------------------------------------------
select count(distinct(city)) from walmart_sales;
select distinct(city), branch from walmart_sales;
-- --------------------------------------------------------------------------------
-- ----------------------------PRODUCTS--------------------------------------------
Select * from walmart_sales;

select count(distinct(product_line)) from walmart_sales;
-- ------------------
select payment_method, count(payment_method) as common_method from walmart_sales
group by payment_method
order by common_method desc;
-- ------------------
select product_line,count(product_line) as most_selling from walmart_sales
group by product_line
order by most_selling desc;
-- -------------------
select month_name,sum(total) as total_revenue from walmart_sales
group by month_name
order by total_revenue desc;
-- -------------------
select month_name, sum(cogs) as largest_cogs from walmart_sales
group by month_name
order by largest_cogs desc;
-- --------------------
select product_line,sum(total) as largest_revenue from walmart_sales
group by product_line
order by largest_revenue desc;
-- ---------------------
select city, sum(total) as largest_revenue
from walmart_sales
group by city
order by largest_revenue desc;
-- --------------------
select product_line, max(vat) as largest_vat
from walmart_sales
group by product_line
order by largest_vat desc;
-- ---------------------
Select * from walmart_sales;
select product_line, total,
case
 when total > (select avg(total) from walmart_sales) then "Good"
 else "bad"
 end as Reputation
 from walmart_sales;
 -- ----------------------
 select branch, sum(quantity) as Product_sold from walmart_sales
group by branch
order by product_sold desc;
-- ----------------------
select gender, product_line, count(product_line) as common_product
from walmart_sales
group by gender ,product_line
order by common_product desc;
-- ------------------------
select avg(rating), product_line from walmart_sales as average_rating
group by product_line;
-- --------------------------------------------------------------------------------
-- ------------------------------SALES---------------------------------------------
select time_of_day ,count(*) as sale from walmart_sales
group by time_of_day;

-- ----------------------
select customer_type, max(total) as most_revenue from walmart_Sales
group by customer_type
order by most_revenue desc;

-- -----------------------
select city, max(vat) as largest_vat from walmart_sales
group by city
order by largest_vat desc;

-- -----------------------
select customer_type, max(vat) as most_vat from walmart_sales
group by customer_type
order by most_vat desc;

-- -------------------------------------------------------------------------------
-- ---------------------------------CUSTOMER--------------------------------------
select count(distinct(customer_type)) as unique_customer_type from walmart_sales;

-- ------------------------
select count(distinct(payment_method)) as unique_payment_type from walmart_sales;

-- -------------------------
select customer_type, count(*) as common_type from walmart_sales
group by customer_type
order by common_type desc;

-- -------------------------
select customer_type, sum(quantity) as most_buying from walmart_sales
group by customer_type
order by most_buying desc;

-- -------------------------
select gender, count(customer_type) as most_gender from walmart_sales
group by gender
order by most_gender desc;

-- -------------------------
select gender, branch, count(branch) as most_gender from walmart_sales
group by gender, branch
order by most_gender desc;

-- -------------------------
SELECT 
    time_, rating, COUNT(rating) AS time_to_rate FROM walmart_sales
GROUP BY time_, rating
ORDER BY time_to_rate DESC
LIMIT 1;

-- ------------------------
select time_ ,branch, count(rating) as rating_per_branch from walmart_sales
group by branch, time_
order by branch, rating_per_branch desc
limit 1;

-- -------------------------
select day_of_week, round(avg(rating),2) as best_rating from walmart_sales
group by day_of_week
order by best_rating desc
limit 1;

-- ------------------------
select day_of_week, branch, round(avg(rating),2) as best_rating from walmart_sales
group by day_of_week, branch
order by branch, best_rating desc
limit 1;

-- --------------------------



 
 











