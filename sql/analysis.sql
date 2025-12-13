--KPI Development
--Total orders
SELECT
  COUNT(*) AS total_orders
FROM swiggy-sales-analysis.swiggy_data.fact_swiggy_orders;

--Total revenue (INR million)
SELECT 
  FORMAT('%0.2f', SUM(CAST(price_inr AS FLOAT64))/1000000) 
  || ' INR million' AS total_revenue
FROM swiggy-sales-analysis.swiggy_data.fact_swiggy_orders;

--Average dish price
SELECT 
  FORMAT('%0.2f', AVG(CAST(price_inr AS FLOAT64))) 
  || ' INR' AS avg_price
FROM swiggy-sales-analysis.swiggy_data.fact_swiggy_orders;

--Average rating
SELECT
  ROUND(AVG(rating), 1) AS avg_rating
FROM swiggy-sales-analysis.swiggy_data.fact_swiggy_orders;

--Deep-dive analysis
--Date-based analysis

SELECT --monthly order trends
  d.month,
  d.month_name,
  COUNT(*) AS total_orders,
  FORMAT('%0.2f', SUM(CAST(price_inr AS FLOAT64))/1000000) 
  || ' INR million' AS total_revenue
FROM swiggy-sales-analysis.swiggy_data.fact_swiggy_orders f
INNER JOIN swiggy-sales-analysis.swiggy_data.dim_date d
  ON f.date_id = d.date_id
GROUP BY
  d.year,
  d.month,
  d.month_name
ORDER BY
  total_orders DESC;

SELECT --quarterly order trends
  d.quarter,
  COUNT(*) AS total_orders,
  FORMAT('%0.2f', SUM(CAST(price_inr AS FLOAT64))/1000000) 
  || ' INR million' AS total_revenue
FROM swiggy-sales-analysis.swiggy_data.fact_swiggy_orders f
INNER JOIN swiggy-sales-analysis.swiggy_data.dim_date d
  ON f.date_id = d.date_id
GROUP BY
  d.quarter
ORDER BY
  total_orders DESC;

SELECT --year-wise growth
  d.year,
  COUNT(*) AS total_orders,
  FORMAT('%0.2f', SUM(CAST(price_inr AS FLOAT64))/1000000) 
  || ' INR million' AS total_revenue
FROM swiggy-sales-analysis.swiggy_data.fact_swiggy_orders f
INNER JOIN swiggy-sales-analysis.swiggy_data.dim_date d
  ON f.date_id = d.date_id
GROUP BY
  d.year
ORDER BY
  total_orders DESC;

SELECT --day-of-week patterns
  FORMAT_DATE('%A', d.full_date) AS day_name,
  COUNT(*) AS total_orders,
  FORMAT('%0.2f', SUM(CAST(price_inr AS FLOAT64))/1000000) 
  || ' INR million' AS total_revenue
FROM swiggy-sales-analysis.swiggy_data.fact_swiggy_orders f
INNER JOIN swiggy-sales-analysis.swiggy_data.dim_date d
  ON f.date_id = d.date_id
GROUP BY
  day_name,
  EXTRACT(DAYOFWEEK FROM d.full_date)
ORDER BY
  total_orders DESC;

--Location-based analysis

SELECT --top 10 cities by order volume
  l.city,
  COUNT(*) AS total_orders
FROM swiggy-sales-analysis.swiggy_data.fact_swiggy_orders f
INNER JOIN swiggy-sales-analysis.swiggy_data.dim_location l
  ON f.location_id=l.location_id
GROUP BY 
  l.city
ORDER BY 
  total_orders DESC
LIMIT 10;

SELECT --revenue contribution by states
  l.state,
  FORMAT('%0.2f', SUM(CAST(price_inr AS FLOAT64))/1000000) 
  || ' INR million' AS total_revenue
FROM swiggy-sales-analysis.swiggy_data.fact_swiggy_orders f
INNER JOIN swiggy-sales-analysis.swiggy_data.dim_location l
  ON f.location_id=l.location_id
GROUP BY 
  l.state
ORDER BY 
  total_revenue DESC;

--Food performance

SELECT --top 10 restaurants by orders and their revenue
  r.restaurant_name,
  COUNT(*) AS total_orders,
  FORMAT('%0.2f', SUM(CAST(price_inr AS FLOAT64))/1000000) 
  || ' INR million' AS total_revenue
FROM swiggy-sales-analysis.swiggy_data.fact_swiggy_orders f
INNER JOIN swiggy-sales-analysis.swiggy_data.dim_restaurant r
  ON f.restaurant_id=r.restaurant_id
GROUP BY 
  r.restaurant_name
ORDER BY 
  total_orders DESC
LIMIT 10;

SELECT --top 10 categories by orders and their average ratings
  c.category,
  COUNT(*) AS total_orders,
  ROUND(AVG(f.rating), 1) AS avg_rating
FROM swiggy-sales-analysis.swiggy_data.fact_swiggy_orders f
INNER JOIN swiggy-sales-analysis.swiggy_data.dim_category c
  ON f.category_id=c.category_id
GROUP BY 
  c.category
ORDER BY 
  total_orders DESC
LIMIT 10;

SELECT --top 10 most ordered dishes and their rating
  di.dish_name,
  COUNT(*) AS total_orders,
  ROUND(AVG(f.rating), 1) AS avg_rating
FROM swiggy-sales-analysis.swiggy_data.fact_swiggy_orders f
INNER JOIN swiggy-sales-analysis.swiggy_data.dim_dish di
  ON f.dish_id=di.dish_id
GROUP BY 
  di.dish_name
ORDER BY 
  total_orders DESC
LIMIT 10;

--Customer spending insights
SELECT
  CASE
    WHEN CAST(price_inr AS FLOAT64)<100 THEN 'Under 100'
    WHEN CAST(price_inr AS FLOAT64) BETWEEN 100 AND 199 THEN '100-199'
    WHEN CAST(price_inr AS FLOAT64) BETWEEN 200 AND 299 THEN '200-299'
    WHEN CAST(price_inr AS FLOAT64) BETWEEN 300 AND 499 THEN '300-499'
    ELSE '500+'
  END AS price_range,
  COUNT(*) AS total_orders
FROM swiggy-sales-analysis.swiggy_data.fact_swiggy_orders
GROUP BY
  CASE
      WHEN CAST(price_inr AS FLOAT64)<100 THEN 'Under 100'
      WHEN CAST(price_inr AS FLOAT64) BETWEEN 100 AND 199 THEN '100-199'
      WHEN CAST(price_inr AS FLOAT64) BETWEEN 200 AND 299 THEN '200-299'
      WHEN CAST(price_inr AS FLOAT64) BETWEEN 300 AND 499 THEN '300-499'
      ELSE '500+'
  END
ORDER BY total_orders DESC;

