# Workflow

### 1. Intital review of the raw dataset  
A structural review was done to understand the scope of the data, the meaning of each column, and the analytical potential of the dataset. This allowed the identification of suitable business questions and the type of transformations required before modelling.

### 2. Data cleaning and validation  

To ensure analytical accuracy and reliability, a comprehensive data quality validation process was conducted on the raw table `swiggy_data`.

**Null value check**  
A null check was performed on all business-critical fields, including:
- state  
- city  
- order_date  
- restaurant_name  
- location  
- category  
- dish_name  
- price_inr  
- rating  
- rating_count  

The validation confirmed that no null values were present in any of these columns.

**Blank and empty string validation**  
In addition to null checks, all string-based fields were examined for blank or empty values that could distort aggregation results or categorical analysis. No blank or empty strings were detected across the dataset.

**Duplicate detection**  
Duplicate records were identified by grouping on all relevant business columns that define a unique order. This process detected 29 duplicate records within the dataset.

**Duplicate removal**  
To ensure data integrity, duplicates were removed using the `ROW_NUMBER()` window function, retaining only one valid record for each duplicate group. After de-duplication, the final cleaned dataset contained 197,401 unique orders.

### 3. Dimensional modelling (Star schema)  

To optimise analytical performance and support scalable reporting, the cleaned dataset was transformed into a Star schema. Dimensional modelling separates descriptive attributes into dimension tables while storing measurable metrics in a central fact table.
The following dimension tables were created:

- **dim_date**: date_id, full_date, year, month, month_name, quarter, day, week 
- **dim_location**: location_id, location, city, state 
- **dim_restaurant**: restaurant_id, restaurant_name  
- **dim_category**: category_id, category  
- **dim_dish**: dish_id, dish_name 

The central fact table was designed as:

**fact_swiggy_orders**:  
- Measures: price_inr, rating, rating_count  
- Foreign keys linking to all dimension tables  

Each dimension was populated using distinct values from the cleaned source data, and the fact table was loaded with fully resolved foreign keys to ensure referential integrity.

### 4. ERD Diagram – Star schema  

An Entity Relationship Diagram (ERD) was created to visually represent the Star Schema, showing the central fact table connected to all supporting dimension tables. This diagram provides a clear structural overview of the analytical data model, available in `assets/erd.png`  [here](assets/)

### 5. KPI development  

With the Star Schema in place, core performance indicators were calculated to evaluate platform performance.

**Basic KPIs**  
- Total orders  
- Total revenue (INR million)  
- Average dish price  
- Average customer rating  

### 6. Deep-dive business analysis  

**Time-based analysis**  
- Monthly order trends  
- Quarterly order trends  
- Year-wise growth patterns  
- Day-of-week ordering behaviour  

**Location-based analysis**  
- Top 10 cities by order volume  
- Revenue contribution by state  

**Food performance analysis**  
- Top 10 restaurants by order volume and revenue  
- Top 10 food categories by order volume and average rating  
- Top 10 most ordered dishes  

**Customer spending insights**  

Customer spending behaviour was analysed by segmenting orders into price buckets:
- Under ₹100  
- ₹100–199  
- ₹200–299  
- ₹300–499  
- ₹500+  

The distribution of total orders across these spending ranges was used to understand price sensitivity, purchasing patterns, and revenue concentration.

### 8. Business insights and strategic recommendations  

After completing the analytical phases and obtaining quantitative results from the KPI calculations and deep-dive analyses, the findings were synthesised into actionable business insights. This step focuses on interpreting patterns in customer behaviour, geographic demand, time-based ordering trends, and spending preferences, rather than reporting numbers in isolation.

Key insights were derived by identifying consistent demand drivers, peak consumption periods, high-performing locations, and revenue-efficient restaurant and pricing segments. These insights reflect how customers actually interact with the Swiggy platform across different contexts, such as weekdays versus weekends, Tier 1 versus Tier 2 cities, and routine versus premium orders.

Based on these insights, strategic recommendations were developed to support Swiggy’s operational efficiency, revenue growth, and customer experience. Recommendations focus on areas including weekend and peak-period readiness, geographic expansion into high-potential Tier 2 cities, optimisation of restaurant and product mix, pricing and promotion strategies aligned with customer spending behaviour, and improved personalisation through data-driven recommendations.
