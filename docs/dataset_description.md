# Dataset description

This document provides a detailed description of the dataset used in the Swiggy sales performance analysis project. The data represents food-delivery transactions from multiple Indian cities and includes information about dishes, restaurants, prices, ratings, and delivery locations.  

The dataset was used to build a Star Schema, remove duplicates, and generate insights for business decisions.

---

## Raw dataset overview

The raw dataset contains 197,401 food delivery records after cleaning.  
Each row represents a single dish within a customer order, not the entire order.

The dataset contains information in four major domains:

- **Order metadata** (data, price)  
- **Food attributes** (dish name, category)  
- **Restaurant attributes** (restaurant name)  
- **Geographic attributes** (location, city, state)  
- **Customer feedback** (ratings, rating counts)

No NULLs or blank strings were detected.  
A total of 29 exact duplicates were removed.  

Below is a detailed explanation of each column in the raw transactional table.  

| Field name       | Type    | Description                                                                 |
|------------------|---------|-----------------------------------------------------------------------------|
| state            | STRING  | State in India where the order was placed                                   |
| city             | STRING  | City in which the customer placed the order                                 |
| order_date       | DATE    | Date when the order was placed                                              |
| restaurant_name  | STRING  | Name of the restaurant fulfilling the order                                 |
| location         | STRING  | Area or locality within the city where the restaurant is located            |
| category         | STRING  | Food category or cuisine type associated with the order                     |
| dish_name        | STRING  | Name of the dish ordered                                                    |
| price_inr        | FLOAT   | Price of the order item in Indian Rupees (INR)                              |
| rating           | FLOAT   | Customer rating given to the dish or order                                  |
| rating_count     | INTEGER | Number of ratings received for the dish or restaurant                       |

---

## Data quality summary

A set of validation checks was executed to ensure data integrity:

| Check performed         | Result                   |
|-------------------------|--------------------------|
| NULL check              | 0 NULLs in all columns   |
| Blank string check      | 0 blank values           |
| Duplicate check         | 29 duplicates removed    |
| Final record count      | 197,401 unique records   |

This dataset is unusually clean for food-delivery transactional data, allowing straightforward modelling.

---

## Relationship to the Star schema

The raw columns were mapped into fact and dimension tables as follows:

| Raw column       | Mapped table     | Purpose                                           |
|------------------|------------------|---------------------------------------------------|
| order_date       | `dim_date`       | Time hierarchies (day, month, quarter, weekday)   |
| restaurant_name  | `dim_restaurant` | Restaurant profiling & performance analysis       |
| dish_name        | `dim_dish`       | Dish-level analytics                              |
| dish_category    | `dim_category`   | Cuisine/category insights                         |
| location, city, state        | `dim_location`       | Geographic segmentation                   |
| price, rating, rating_count | `fact_swiggy_orders`    | Revenue, satisfaction, and demand metrics |

The central fact table contains 197,401 rows, representing each ordered dish.

### ERD diagram

![](../assets/erd.png) 
