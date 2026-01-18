create database financial_db;
use financial_db;
CREATE TABLE transactions_raw (
    segment VARCHAR(50),
    country VARCHAR(50),
    product VARCHAR(50),
    discount_band VARCHAR(20),
    units_sold VARCHAR(20),
    manufacturing_price VARCHAR(20),
    sale_price VARCHAR(20),
    gross_sales VARCHAR(20),
    discounts VARCHAR(20),
    sales VARCHAR(20),
    cogs VARCHAR(20),
    profit VARCHAR(20),
    date VARCHAR(30),
    month_number VARCHAR(10),
    month_name VARCHAR(20),
    year VARCHAR(10)
);
select * from transactions_raw;
--- check row count
select count(*) from transactions_raw;
CREATE TABLE transactions_clean (
    segment VARCHAR(50),
    country VARCHAR(50),
    product VARCHAR(50),
    discount_band VARCHAR(20),
    units_sold DECIMAL(10,2),
    manufacturing_price DECIMAL(10,2),
    sale_price DECIMAL(10,2),
    gross_sales DECIMAL(12,2),
    discounts DECIMAL(12,2),
    sales DECIMAL(12,2),
    cogs DECIMAL(12,2),
    profit DECIMAL(12,2),
    date DATE,
    month_number INT,
    month_name VARCHAR(20),
    year INT
);

INSERT INTO transactions_clean
SELECT
    TRIM(segment),
    UPPER(TRIM(country)),
    TRIM(product),

    CASE
        WHEN discount_band IS NULL OR discount_band = '' THEN 'No Discount'
        ELSE discount_band
    END,

    -- Units Sold
    COALESCE(
      CAST(NULLIF(REGEXP_REPLACE(TRIM(units_sold), '[^0-9.]', ''), '') AS DECIMAL(10,2)),
      0
    ),

    -- Manufacturing Price
    COALESCE(
      CAST(NULLIF(REGEXP_REPLACE(TRIM(manufacturing_price), '[^0-9.]', ''), '') AS DECIMAL(10,2)),
      0
    ),

    -- Sale Price
    COALESCE(
      CAST(NULLIF(REGEXP_REPLACE(TRIM(sale_price), '[^0-9.]', ''), '') AS DECIMAL(10,2)),
      0
    ),

    -- Gross Sales
    COALESCE(
      CAST(NULLIF(REGEXP_REPLACE(TRIM(gross_sales), '[^0-9.]', ''), '') AS DECIMAL(12,2)),
      0
    ),

    -- Discounts
    COALESCE(
      CAST(NULLIF(REGEXP_REPLACE(TRIM(discounts), '[^0-9.]', ''), '') AS DECIMAL(12,2)),
      0
    ),

    -- Sales
    COALESCE(
      CAST(NULLIF(REGEXP_REPLACE(TRIM(sales), '[^0-9.]', ''), '') AS DECIMAL(12,2)),
      0
    ),

    -- COGS
    COALESCE(
      CAST(NULLIF(REGEXP_REPLACE(TRIM(cogs), '[^0-9.]', ''), '') AS DECIMAL(12,2)),
      0
    ),

    -- Profit
    COALESCE(
      CAST(NULLIF(REGEXP_REPLACE(TRIM(profit), '[^0-9.]', ''), '') AS DECIMAL(12,2)),
      0
    ),

    -- Date
    CASE
        WHEN date REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
            THEN STR_TO_DATE(date, '%d-%m-%Y')
        WHEN date REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
            THEN STR_TO_DATE(date, '%m/%d/%Y')
        ELSE NULL
    END,

    CAST(FLOOR(month_number) AS UNSIGNED),
    TRIM(month_name),
    CAST(FLOOR(year) AS UNSIGNED)

FROM transactions_raw;
select * from transactions_clean;
--- Row count check
SELECT COUNT(*) FROM transactions_raw;
SELECT COUNT(*) FROM transactions_clean;
--- Null and Zero sanity check
SELECT SUM(manufacturing_price = 0) AS zero_mfg,SUM(sale_price = 0) AS zero_sale,SUM(gross_sales = 0) AS zero_gross,SUM(sales = 0) AS zero_sales,SUM(profit = 0) AS zero_profit FROM transactions_clean;
---  Date and Time check
SELECT
  MIN(date) AS start_date,
  MAX(date) AS end_date,
  MIN(month_number),
  MAX(month_number),
  MIN(year),
  MAX(year)
FROM transactions_clean;

--- Total Sales by Country
SELECT country, SUM(sales) AS total_sales
FROM transactions_clean
GROUP BY country
ORDER BY total_sales DESC;
----- Profit by Product
SELECT product, SUM(profit) AS total_profit
FROM transactions_clean
GROUP BY product
ORDER BY total_profit DESC;
---- Monthly Sales Trend
SELECT year, month_number, SUM(sales) AS monthly_sales
FROM transactions_clean
GROUP BY year, month_number
ORDER BY year, month_number;

--- Discount Impact
SELECT discount_band, SUM(sales) AS sales
FROM transactions_clean
GROUP BY discount_band;
--- High-Margin Products
SELECT product,
       SUM(profit) / NULLIF(SUM(sales), 0) AS profit_margin
FROM transactions_clean
GROUP BY product
ORDER BY profit_margin DESC;


select * from transactions_raw;
select * from transactions_clean;









