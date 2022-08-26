-- create table if not exists customer_orders (
-- order_id integer,
-- customer_id integer,
-- order_date date,
-- order_amount integer
-- );


-- insert into customer_orders values(1,100,cast('2022-01-01' as date),2000);
-- insert into customer_orders values(2,200,cast('2022-01-01' as date),2500);
-- insert into customer_orders values(3,300,cast('2022-01-01' as date),2100);
-- insert into customer_orders values(4,100,cast('2022-01-02' as date),2000);
-- insert into customer_orders values(5,400,cast('2022-01-02' as date),2200);
-- insert into customer_orders values(6,500,cast('2022-01-02' as date),2700);
-- insert into customer_orders values(7,100,cast('2022-01-03' as date),3000);
-- insert into customer_orders values(8,400,cast('2022-01-03' as date),1000);
-- insert into customer_orders values(9,600,cast('2022-01-03' as date),3000);

select * from customer_orders

with cte as (
	select order_date
	, customer_id
	, lag(order_date) over (PARTITION by customer_id order by order_date) as prev_order_date
	, dense_rank() over (PARTITION by customer_id order by order_date) as pos
	from customer_orders
)
, diffs as (
	select *, DATEDIFF(order_date,prev_order_date) as date_diff
	from cte
)
select order_date
, sum(case when pos=1 then 1 else 0 end) as new_customers_count
, sum(case when date_diff=1 then 1 else 0 end) as repeat_customers_count
from diffs
group by order_date

--------METHOD-2-----------

Select a.order_date,
Sum(Case when a.order_date = a.first_order_date then 1 else 0 end) as new_customer,
Sum(Case when a.order_date != a.first_order_date then 1 else 0 end) as repeat_customer
from(
Select customer_id, order_date, min(order_date) over(partition by customer_id) as first_order_date from customer_orders) a 
group by a.order_date;
