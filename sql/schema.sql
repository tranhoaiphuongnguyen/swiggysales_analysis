--Creating schema
--Dimension tables
CREATE OR REPLACE TABLE swiggy-sales-analysis.swiggy_data.dim_date AS --date table
SELECT
  ROW_NUMBER() OVER (ORDER BY order_date) AS date_id,
  order_date AS full_date,
  EXTRACT(YEAR FROM order_date) AS year,
  EXTRACT(MONTH FROM order_date) AS month,
  FORMAT_DATE('%B', order_date) AS month_name,
  EXTRACT(QUARTER FROM order_date) AS quarter,
  EXTRACT(DAY FROM order_date) AS day,
  EXTRACT(WEEK FROM order_date) AS week
FROM (
  SELECT DISTINCT order_date
  FROM swiggy-sales-analysis.swiggy_data.swiggy_data
  WHERE order_date IS NOT NULL
)
ORDER BY date_id;

CREATE OR REPLACE TABLE swiggy-sales-analysis.swiggy_data.dim_location AS --location table
SELECT
  ROW_NUMBER() OVER (ORDER BY state, city, location) AS location_id,
  state,
  city,
  location
FROM (
  SELECT DISTINCT state, city, location
  FROM swiggy-sales-analysis.swiggy_data.swiggy_data
)
ORDER BY location_id;

CREATE OR REPLACE TABLE swiggy-sales-analysis.swiggy_data.dim_restaurant AS --restaurant table
SELECT
  ROW_NUMBER() OVER (ORDER BY restaurant_name) AS restaurant_id,
  restaurant_name
FROM (
  SELECT DISTINCT restaurant_name
  FROM swiggy-sales-analysis.swiggy_data.swiggy_data
)
ORDER BY restaurant_id;

CREATE OR REPLACE TABLE swiggy-sales-analysis.swiggy_data.dim_category AS --category table
SELECT
  ROW_NUMBER() OVER (ORDER BY category) AS category_id,
  category
FROM (
  SELECT DISTINCT category
  FROM swiggy-sales-analysis.swiggy_data.swiggy_data
)
ORDER BY category_id;

CREATE OR REPLACE TABLE swiggy-sales-analysis.swiggy_data.dim_dish AS --dish table
SELECT
  ROW_NUMBER() OVER (ORDER BY dish_name) AS dish_id,
  dish_name
FROM (
  SELECT DISTINCT dish_name
  FROM swiggy-sales-analysis.swiggy_data.swiggy_data
)
ORDER BY dish_id;

--Fact table
CREATE OR REPLACE TABLE swiggy-sales-analysis.swiggy_data.fact_swiggy_orders AS
SELECT
  ROW_NUMBER() OVER() AS order_id,
  dd.date_id,
  s.price_inr,
  s.rating,
  s.rating_count,

  dl.location_id,
  dr.restaurant_id,
  dc.category_id,
  dsh.dish_id
FROM swiggy-sales-analysis.swiggy_data.swiggy_data s
INNER JOIN swiggy-sales-analysis.swiggy_data.dim_date dd
  ON dd.full_date=s.order_date

INNER JOIN swiggy-sales-analysis.swiggy_data.dim_location dl
  ON dl.state=s.state
  AND dl.city=s.city
  AND dl.location=s.location

INNER JOIN swiggy-sales-analysis.swiggy_data.dim_restaurant dr
  ON dr.restaurant_name=s.restaurant_name

INNER JOIN swiggy-sales-analysis.swiggy_data.dim_category dc
  ON dc.category=s.category

INNER JOIN swiggy-sales-analysis.swiggy_data.dim_dish dsh
  ON dsh.dish_name=s.dish_name

ORDER BY order_id;

SELECT * FROM swiggy-sales-analysis.swiggy_data.fact_swiggy_orders f
INNER JOIN swiggy-sales-analysis.swiggy_data.dim_date d
  ON f.date_id=d.date_id
INNER JOIN swiggy-sales-analysis.swiggy_data.dim_location l
  ON f.location_id=l.location_id
INNER JOIN swiggy-sales-analysis.swiggy_data.dim_restaurant r
  ON f.restaurant_id=r.restaurant_id
INNER JOIN swiggy-sales-analysis.swiggy_data.dim_category c
  ON f.category_id=c.category_id
INNER JOIN swiggy-sales-analysis.swiggy_data.dim_dish di
  ON f.dish_id=di.dish_id;