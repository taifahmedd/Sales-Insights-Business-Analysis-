-- 1️ Total Sales & Profit by Region --
-- Business Question --
-- Which region is performing best in terms of revenue and profit? --

select Region,
       round(sum(Sales),2) as Total_Sales,
       round(sum(Profit),2) as Total_Profit
from clean_sales_data
group by Region
order by total_sales desc;

-- 2 Monthly Sales Trend --
-- Business Question --
-- Are sales increasing or decreasing over time? --

SELECT
    DATE_FORMAT(
        STR_TO_DATE(Order_Date, '%d-%m-%Y'),
        '%Y-%m'
    ) AS sales_month,
    SUM(Sales) AS total_sales
FROM clean_sales_data
GROUP BY sales_month
ORDER BY sales_month;

-- 3 Top 10 Customers by Sales --
-- Business Question
-- Who are our most valuable customers? --

select Customer_ID,
       Customer_Name,
       round(sum(Sales),2) as Total_Sales
from clean_sales_data
group by Customer_ID,Customer_Name
order by Total_Sales desc
limit 10;

-- 4 Profitability by Product Category --
-- Business Question --
-- Which product category gives the highest profit? --

select
     Category,
     round(sum(Profit),2) as Total_Profit
from clean_sales_data
group by Category
order by Total_Profit desc;

-- 5 Loss-Making Orders --
-- Business Question --
-- Which orders are causing losses? --

select Order_ID,
       Product_Name,
       Sales,
       Profit
from clean_sales_data
where Profit < 0;

-- 6 Impact of Discount on Profit --
-- Business Question --
-- Does high discount reduce profit? -

select Discount_Percent,
       round(sum(Sales),2) as Total_Sales,
       round(sum(Profit),2) as Total_Profit
from clean_sales_data
group by Discount_Percent
order by Discount_Percent;

-- 7 Sales Channel Performance--
-- Business Question --
-- Which channel performs better – Online or Offline? --

select Sales_Channel,
       round(sum(Sales),2) as Total_Sales,
      count(Order_ID) as Order_Count
from clean_sales_data
group by Sales_Channel;

-- 8 Payment Mode Analysis --
-- Business Question --
-- Which payment method is most preferred? --

select Payment_Mode,
       round(sum(Sales),2) as Total_Sales,
	   count(Order_ID) as Total_Transactions
from clean_sales_data
group by Payment_Mode
order by Total_Transactions desc;

-- 9 Customer Segment Performance --
-- Business Question --
-- Which customer segment generates highest revenue? --

select Customer_Segment,
       round(sum(Sales),2) as Total_Sales
from clean_sales_data
group by Customer_Segment
order by Total_Sales desc;

-- 10 Average Order Value (AOV) --
-- Business Question --
-- How much does a customer spend per order on average? --

select Customer_ID,
      round(sum(Sales) / count(distinct Order_ID),2) as AVG_Order_Value
	from clean_sales_data
    group by Customer_ID
    order by AVG_Order_Value;
    
--  11 Top Product per Category --
    
    select *
from (
    select 
        Category,
        Product_Name,
        sum(Sales) as Total_Sales,
        rank() over (partition by Category order by SUM(Sales) desc) as rnk
    from clean_sales_data
    group by Category, Product_Name
) t
where rnk = 1;



