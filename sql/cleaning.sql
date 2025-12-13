--View dataset
SELECT *
FROM swiggy-sales-analysis.swiggy_data.swiggy_data;

--Data validation and cleaning
--Null check
SELECT
  SUM(CASE WHEN state IS NULL THEN 1 ELSE 0 END) AS null_state,
  SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS null_city,
  SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS null_order_date,
  SUM(CASE WHEN restaurant_name IS NULL THEN 1 ELSE 0 END) AS null_restaurant_name,
  SUM(CASE WHEN location IS NULL THEN 1 ELSE 0 END) AS null_location,
  SUM(CASE WHEN category IS NULL THEN 1 ELSE 0 END) AS null_category,
  SUM(CASE WHEN dish_name IS NULL THEN 1 ELSE 0 END) AS null_dish_name,
  SUM(CASE WHEN price_inr IS NULL THEN 1 ELSE 0 END) AS null_price_inr,
  SUM(CASE WHEN rating IS NULL THEN 1 ELSE 0 END) AS null_rating,
  SUM(CASE WHEN rating_count IS NULL THEN 1 ELSE 0 END) AS null_rating_count
FROM swiggy-sales-analysis.swiggy_data.swiggy_data;

--Blank or empty strings
SELECT *
FROM swiggy-sales-analysis.swiggy_data.swiggy_data
WHERE
  state='' 
  OR city='' 
  OR restaurant_name='' 
  OR location='' 
  OR category='' 
  OR dish_name='';

--Duplicate detection
SELECT
  state,
  city,
  order_date,
  restaurant_name,
  location,
  category,
  dish_name,
  price_inr,
  rating,
  rating_count,
  COUNT(*) AS case_count
FROM swiggy-sales-analysis.swiggy_data.swiggy_data
GROUP BY
  state,
  city,
  order_date,
  restaurant_name,
  location,
  category,
  dish_name,
  price_inr,
  rating,
  rating_count
HAVING COUNT(*)>1;

--Delete duplication
CREATE OR REPLACE TABLE swiggy-sales-analysis.swiggy_data.swiggy_data AS
SELECT *
FROM (
  SELECT *,
    ROW_NUMBER() OVER(PARTITION BY 
      state,
      city,
      order_date,
      restaurant_name,
      location,
      category,
      dish_name,
      CAST(price_inr AS STRING),
      CAST(rating AS STRING),
      rating_count
      ORDER BY (SELECT NULL)
    ) AS rn
FROM swiggy-sales-analysis.swiggy_data.swiggy_data
)
WHERE rn=1;

ALTER TABLE swiggy-sales-analysis.swiggy_data.swiggy_data
DROP COLUMN rn; --delete column rn