-- find 20% of products which give 80% of sales - pareto principle

CREATE TABLE if not exists `Superstore_orders` (
  `Row_ID` int DEFAULT NULL,
  `Order_ID` text,
  `Order_Date` text,
  `Ship_Date` text,
  `Ship_Mode` text,
  `Customer_ID` text,
  `Customer_Name` text,
  `Segment` text,
  `Country/Region` text,
  `City` text,
  `State` text,
  `Postal_Code` int DEFAULT NULL,
  `Region` text,
  `Product_ID` text,
  `Category` text,
  `Sub_Category` text,
  `Product_Name` text,
  `Sales` float DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `Discount` int DEFAULT NULL,
  `Profit` float DEFAULT NULL
);


-- select * from Superstore_orders;


with products_sales as (
	select Product_ID, sum(sales) as product_sale
	from Superstore_orders
	group by 1
)
, sales_sum as (
	SELECT Product_ID
	, product_sale 
	, sum(product_sale) over (order by product_sale desc rows BETWEEN UNBOUNDED PRECEDING and 0 PRECEDING) as running_sales
	, .8*sum(product_sale) over () as total_sales_80
	from products_sales
)
select Product_ID
from sales_sum 
where round(running_sales,2) <= round(total_sales_80, 2) 
order by product_sale desc ;





