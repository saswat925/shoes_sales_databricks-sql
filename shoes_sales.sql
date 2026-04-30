--first check raw data shoes_sales
USE CATALOG workspace;
USE SCHEMA default;
SELECT * FROM shoes_sales ;
--row count
select count(*) from shoes_sales;
   ---1000 data
---duplicate check
SELECT 
    Sale_ID, Date, Brand, Shoe_Type, Color, Country,
    Sales_Channel, Price_USD, Units_Sold, Revenue_USD,
    COUNT(*) AS duplicate_count
FROM shoes_sales
GROUP BY
    Sale_ID, Date, Brand, Shoe_Type, Color, Country,
    Sales_Channel, Price_USD, Units_Sold, Revenue_USD
HAVING COUNT(*) > 1;
      ---no duplicate found
      
---null check and count
select count(*) as total_rows,
       count(*) - count(Sale_ID) as null_sale_id,
       count(*) - count(Date) as null_date,
       count(*) - count(Brand) as null_brand,
       count(*) - count(Shoe_Type) as null_shoe_type,
       count(*) - count(Color) as null_color,
       count(*) - count(Country) as null_country,
       count(*) - count(Sales_Channel) as null_sales_channel,
       count(*) - count(Revenue_USD) as null_revenue_usd,
       count(*) - count(Price_USD) as null_price_usd,
       count(*) - count(Units_Sold) as null_units_sold
       from shoes_sales;   
               ---no null found in shoes_sales

SELECT * FROM shoes_sales;

-- 4. NULL / BLANK CHECK

SELECT *
FROM shoes_sales
WHERE Brand IS NULL OR Brand = ''
   OR Shoe_Type IS NULL OR Shoe_Type = ''
   OR Country IS NULL OR Country = '';

-- 5. SALES VALIDATION
-- Revenue = Price * Units Sold
SELECT *
FROM shoes_sales
WHERE Revenue_USD <> Price_USD * Units_Sold;
       ---Real region = decimal precesion 
SELECT COUNT(*) AS mismatched_rows
FROM shoes_sales
WHERE Revenue_USD <> Price_USD * Units_Sold;

SELECT COUNT(*) AS mismatched_rows
FROM shoes_sales
WHERE ROUND(Revenue_USD,2) <> ROUND(Price_USD * Units_Sold,2);
       ---after rounding 2 decimal places no mismatch found

-- 6. NEGATIVE VALUES CHECK
select *
       FROM shoes_sales
    WHERE Price_USD < 0
       OR Units_Sold < 0
       OR Revenue_USD < 0;
      ----No negative value find 

-- 7. DATE VALIDATION
-- Future dates check
SELECT *
FROM shoes_sales
WHERE Date > CURRENT_DATE;
     ----no future data
         
-- 8. UNIQUE VALUES CHECK

SELECT DISTINCT Brand FROM shoes_sales; ---6
SELECT DISTINCT Country FROM shoes_sales;----7
SELECT DISTINCT Sales_Channel FROM shoes_sales;---3

-- 9. CATEGORY FREQUENCY CHECK
SELECT Brand, COUNT(*) total_sales
FROM shoes_sales
GROUP BY Brand
ORDER BY total_sales DESC;

-- 10. FINAL CLEAN DATA VIEW
SELECT *
FROM shoes_sales;

--ANALISIS PART

--total_revenue = 1453186.03
SELECT round(SUM(Revenue_USD), 2) AS total_revenue
FROM shoes_sales;
--total_unit_sold = 1000
SELECT SUM(Units_Sold) AS total_units_sold
FROM shoes_sales;
--average_price = 137.86
SELECT round(AVG(Price_USD), 2) AS average_price
FROM shoes_sales;
--average_revenue = 1453.19
SELECT round(AVG(Revenue_USD), 2) AS average_revenue FROM shoes_sales;
--average_units_sold = 11
SELECT round(AVG(Units_Sold)) as average_units_sold FROM shoes_sales;
--total_ordes = 1000
SELECT COUNT(*) AS total_orders
FROM shoes_sales;
--Revenue by Brand
SELECT Brand, round(SUM(Revenue_USD), 2) AS revenue
FROM shoes_sales
GROUP BY Brand
ORDER BY revenue DESC;
     ---Skechers generated the highest revenue(269168.63), while Nike(192770.15) recorded the lowest among compared brands.

---Revenue by Country
SELECT Country, round(SUM(Revenue_USD), 2) AS revenue
FROM shoes_sales
GROUP BY Country
ORDER BY revenue DESC;
      ---UAE generated the highest revenue(230549.94), while India(177959.76) recorded the lowest among compared countries.

---Revenue by Sales Channel
SELECT Sales_Channel, round(SUM(Revenue_USD), 2) AS revenue 
FROM shoes_sales
GROUP BY Sales_Channel
ORDER BY revenue DESC;
          ----RETAIL_STORE generated the highest revenue(506125.13), while ONLINE recorded the lowest among compared sales channels

--revenue by shoe_type
SELECT Shoe_Type, round(SUM(Revenue_USD), 2) AS revenue
FROM shoes_sales
GROUP BY Shoe_Type
ORDER BY revenue DESC;
            ---best selling shoe type is Sneakers(283215.03) while worst selling is sports shoes(202592.87).

--top selling shoe by quantity
SELECT Shoe_Type, SUM(Units_Sold) AS units
FROM shoes_sales
GROUP BY Shoe_Type
ORDER BY units DESC;
          ----Sneakers were the most sold category with 1,979 units, showing high customer demand and strong market popularity.
select * from shoes_sales

---monthly trnd
SELECT DATE_TRUNC('month', Date) AS month, round(SUM(Revenue_USD), 2) AS revenue
FROM shoes_sales
GROUP BY month
ORDER BY month;
          ---Revenue increased gradually from January to December


SELECT MONTH(Date) AS month,
round(SUM(Revenue_USD),2) AS revenue
FROM shoes_sales
GROUP BY MONTH(Date)
ORDER BY month;

--Average Selling Price = 137.86
SELECT  round(AVG(Price_USD),2) AS avg_price
FROM shoes_sales;

---month over month growth percentage
SELECT 
MONTH(Date) AS month,
SUM(Revenue_USD) AS revenue,
LAG(SUM(Revenue_USD)) OVER(ORDER BY MONTH(Date)) AS prev_month,
ROUND(
(
SUM(Revenue_USD) - LAG(SUM(Revenue_USD)) OVER(ORDER BY MONTH(Date))
)
/ LAG(SUM(Revenue_USD)) OVER(ORDER BY MONTH(Date)) * 100,2
) AS growth_percent
FROM shoes_sales
GROUP BY MONTH(Date)
ORDER BY month;
    
 --Worst Revenue Month = Month 9
 --Highest Growth = Month 10 (+53.21%)
 --Largest Decline = Month 8 (-31.35%)
 --Stable Growth Period = Months 5–7

--best selling colour
SELECT Color,
SUM(Units_Sold) AS units
FROM shoes_sales
GROUP BY Color
ORDER BY units DESC;
             ----blue is the best selling colour with 1923 units worst selling is white 1494

---Revenue Per Unit= 137.3
SELECT 
ROUND(SUM(Revenue_USD) / SUM(Units_Sold),2) AS revenue_per_unit
FROM shoes_sales;
--Sales Channel Contribution %
SELECT 
Sales_Channel,
SUM(Revenue_USD) AS revenue,
ROUND(SUM(Revenue_USD) * 100 / (SUM(SUM(Revenue_USD)) OVER()),2) AS contribution_percent
FROM shoes_sales
GROUP BY Sales_Channel;
       ---Online sales had the highest contribution at 32.19%, indicating strong customer preference for digital purchasing channels.













