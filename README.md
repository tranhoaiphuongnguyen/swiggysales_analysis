# Swiggy sales performance analysis (India, Jan–Aug 2025)

**Timeframe:** January 2025 – August 2025  
**Location:** India  
**Dataset size:** 197,401 delivery transactions  
**Tools:** Google BigQuery (SQL), Star schema, ERD modelling

This project analyses Swiggy’s food-delivery transactions across India from January to August 2025 using SQL on Google BigQuery.
The goal is to extract business insights that help Swiggy’s stakeholders understand:  

- Where demand is coming from  
- Which products, cities, and restaurant partners drive the most value  
- How customer spending and satisfaction trends evolve  
- What actions Swiggy can take to improve growth, retention, and operational performance 

---

## Project structure
```
swiggysales_analysis/
├── README.md
├── .gitignore
├── data/
│   └── swiggysales_rawdata.csv
├── sql/
│   ├── cleaning.sql
│   ├── schema.sql
│   └── analysis.sql
├── docs/
│   ├── dataset_description.md
│   └── workflow_notes.md
└── assets/
    ├── erd.png
    ├── monthly_ordertrend.png
    ├── quarterly_ordertrend.png
    ├── daytoweek_ordertrend.png
    ├── topcities.png
    ├── topstates.png
    ├── toprestaurants.png
    ├── topcategories.png
    ├── topdishes.png
    └── pricerange_orders.png
```
---

## Project resources

The dataset used in this analysis is hosted on Google BigQuery.    
Schema documentation and table relationships are defined within the project.  

- The original dataset is stored in: `data/swiggysales_rawdata.csv` [here](data/swiggysales_rawdata.csv)
- SQL queries used for cleaning, modelling, and analysis are stored in the `sql/` directory [here](sql/)   
- The Entity Relationship Diagram (ERD) is available in `assets/erd.png`  [here](assets/)   
- Outputs generated from SQL results are stored in the `assets/` folder [here](assets/)   

---

## Executive summary

Swiggy operates in a hyper-competitive environment where consumer expectations around convenience, speed, and consistency shape nearly every strategic decision. Understanding how customers behave when they order, how much they spend, which restaurants they prefer, and how they rate their experience, is essential for optimising both supply and demand sides of the platform.  

Between January and August 2025, Swiggy customers placed nearly 200,000 orders, generating just over ₹53 million in food sales. Ordering remained remarkably consistent across the eight-month period, with predictable uplift during certain months and weekends. The most active markets were India's major metropolitan areas, which continue to drive the bulk of demand thanks to dense populations, strong food culture, and high familiarity with app-based services.  

Restaurant performance strongly favored large, well-established chains, while customer spending tended to cluster in the 100-299 price range, a sweet spot for everyday meals. Customer satisfaction remained high overall, with an average rating of 4.3, highlighting both strong reliability on Swiggy's partner network and positive consumer habits around food delivery.

---

## Findings and insights

### Time-based ordering behaviour

*Monthly ordering patterns*  

[Monthly order trend](assets/monthly_ordertrend.png) 

Monthly order volumes show a remarkably stable demand pattern across the year, with only moderate variation within a relatively narrow range of approximately 23,000 to 25,500 orders per month. January records the highest activity with 25,393 orders, generating ₹6.82 million in revenue. This is followed closely by May (25,188 orders, ₹6.79 million) and August (25,227 orders, ₹6.79 million), which suggests that food delivery demand on Swiggy is less influenced by extreme seasonality and more by consistent lifestyle-driven consumption.  

The strong performance in January is likely linked to post-holiday routines, where consumers return to regular work schedules and rely more heavily on food delivery for convenience. May and August also perform well, possibly reflecting a combination of summer heat, social gatherings, and increased discretionary spending during school holidays and festive periods.  

Importantly, no month shows a sharp decline, even the weakest month in the dataset is February with 23,291 orders and ₹6.27 million in revenue, which represents only an approximate 8–9% decline compared to the strongest month, indicating that Swiggy benefits from a very stable customer base. This steady demand helps the company plan marketing efforts and manage capacity confidently throughout the year, instead of depending on a short peak season.  

*Quarterly trends and revenue concentration*  

[Quarterly order trend](assets/quarterly_ordertrend.png) 

Q2 stands out as the strongest period, recording 74,154 orders and ₹19.90 million in revenue, around 38% of the entire year’s revenue, making it the most critical quarter for business performance. This leadership suggests that the April–June window naturally aligns with higher food delivery activity in India. Factors such as warmer weather, more social gatherings, and fewer long holidays likely contribute to this peak. Q1 follows closely with 73,084 orders and ₹19.66 million, indicating strong and stable demand in the early part of the year.  

Q3, however, shows lower totals with 50,163 orders and ₹13.44 million in revenue, but this outcome is expected because the dataset only covers July and August, not the full quarter. As a result, Q3’s figures should be interpreted as partial rather than reflective of true quarterly performance.

*Day-of-week ordering behaviour*  

[Day-to-week order trend](assets/daytoweek_ordertrend.png) 

Weekends consistently outperform weekdays in both order volume and revenue, with Saturday leading at 28,933 orders (₹7.78 million) and Sunday following closely with 28,469 orders (₹7.64 million). Despite representing only two days, weekends contribute nearly 29% of all weekly orders, reinforcing the strong link between food delivery and leisure time, social meals, and more relaxed routines.

Weekday demand remains relatively steady, with Tuesday marking the lowest performance at 27,413 orders (₹7.36 million). From midweek onward, activity gradually picks up, rising through Thursday (28,450 orders) and Friday (28,284 orders), before reaching its peak during the weekend. This upward trend reflects typical workweek behaviour, where food delivery serves mainly as a convenience before shifting toward social and recreational use.

### Geographic performance across India

[Top cities](assets/topcities.png)

Geographic analysis shows that Swiggy’s demand is heavily concentrated in major urban centers, with Tier 1 cities clearly leading. Bengaluru stands out as the top market, recording 20,072 orders, nearly double the next highest city, highlighting its role as Swiggy’s core demand hub, supported by a dense working population, high app adoption, and a strong restaurant ecosystem.

Mumbai (10,507 orders) and Hyderabad (10,308 orders) form the second tier of high volume cities, followed closely by Jaipur (10,285), Lucknow (10,192), and New Delhi (10,191). These figures indicate that Swiggy’s demand is steadily expanding into fast-growing Tier 2 cities, beyond the traditional metro strongholds. The remaining cities in the top 10, Ahmedabad (10,175), Chandigarh (10,060), Kolkata (10,044), and Chennai (10,042), show remarkably consistent order volumes around 10,000, suggesting a balanced distribution of demand across multiple urban regions.  

[Top states](assets/topstates.png)

At the state level, revenue mirrors these urban trends. Karnataka leads with ₹5.46 million, largely driven by Bengaluru. Uttar Pradesh contributes ₹3.12 million, reflecting multiple high-volume cities such as Lucknow and Noida-adjacent areas. Telangana and Maharashtra each generate roughly ₹3.02 million, highlighting Hyderabad and Mumbai as stable revenue anchors. Delhi (₹2.83 million) and Gujarat (₹2.82 million) follow closely, while Punjab (₹2.80 million), West Bengal (₹2.66 million), Tamil Nadu (₹2.64 million), and Rajasthan (₹2.50 million) form a solid middle tier. Lower-revenue states, including Goa (₹1.54 million), Haryana (₹1.44 million), Himachal Pradesh (₹1.38 million), and Jammu & Kashmir (₹1.32 million), reflect smaller populations or limited urban density. The lowest contributors including Mizoram (₹0.82 million), Nagaland (₹0.58 million), and Sikkim (₹0.56 million), represent emerging or niche markets.


### Restaurant and cuisine insights  

[Top restaurant](assets/toprestaurants.png)

McDonald’s leads in order volume with 13,528 orders and ₹3.34 million in revenue, making it the most frequently chosen brand due to strong brand recognition, affordability, and broad appeal. KFC, however, achieves higher total revenue with 12,957 orders generating ₹4.25 million, indicating a higher average order value driven by combo meals, premium pricing, and larger portions. Burger King (7,115 orders, ₹1.90 million) and Pizza Hut (6,529 orders, ₹2.13 million) form a second tier, where Pizza Hut’s revenue suggests stronger per-order spending. Domino’s Pizza (5,489 orders, ₹1.83 million) shows steady demand with slightly lower spend per order. Mid-sized and niche brands, such as LunchBox – Meals and Thalis, Baskin Robbins, Faasos, Olio, and The Good Bowl, have smaller order volumes (2,600–4,700) and revenues, reflecting their focus on specialized or occasional offerings like desserts, premium meals, or regional cuisines.

This shows that high order volume does not always translate into higher revenue; McDonald’s focuses on high volume, while KFC focuses on revenue per order.  

[Top categories](assets/topcategories.png)

At the category level, the Recommended section dominates with 24,097 orders and an average rating of 4.3, highlighting the influence of algorithm-driven suggestions. Desserts, Beverages, and Main Course categories all maintain high ratings (4.3–4.4), while Sweets achieve the highest rating at 4.5 despite modest orders (1,715), showing that desserts are highly satisfying but typically consumed as add-ons. Value-focused categories like McSaver Combos and Exclusive Deals maintain solid ratings and moderate order volumes, demonstrating the importance of discounts and bundles in driving engagement without sacrificing satisfaction.  

[Top dishes](assets/dishes.png)

At the dish level, Choco Lava Cake tops the list with 303 orders and a 4.4 rating, confirming its popularity as an add-on. Rice dishes like Veg Fried Rice (269 orders) and Jeera Rice (233 orders) show consistent demand for affordable staples, while comfort foods such as French Fries, Margherita Pizza, and Butter Naan maintain strong orders and ratings above 4.2, reinforcing that familiar, low-risk items drive repeat purchases.

## Customer spending behaviour  

[Price range orders](assets/pricerange_orders.png)

The majority of orders fall into the ₹100–199 and ₹200–299 price ranges. The ₹100–199 bucket records the highest order volume with 56,189 orders, closely followed by the ₹200–299 range at 54,567 orders. These two segments make up the majority of transactions, showing that users are price-conscious and typically optimise spending for everyday meals rather than premium options.

The ₹300–499 range remains substantial with 43,758 orders, capturing customers willing to spend more on group meals, branded chains, or add-ons like desserts and drinks. This segment often reflects family orders, weekend consumption, or social occasions where convenience matters more than price.

At the lower end, orders under ₹100 account for 26,795 orders, reflecting budget-focused users, snack purchases, or single-item add-ons. While this segment contributes meaningfully to order volume, its revenue impact is limited due to the low basket size. The ₹500+ segment records the smallest volume at 16,092 orders, but it remains strategically important. These high-value orders likely correspond to group orders, premium restaurants, or large bundled meals. Although fewer in number, such orders significantly lift overall revenue and margins due to higher delivery fees, commissions, and add-on potential.

---

## Key observations  

**Time-based ordering** 
- Monthly orders are stable (23k–25.5k), with January, May, and August leading; even the lowest month, February, is only ~8–9% below peak.  
- Q2 dominates (74k orders, ₹19.9M, 38% of revenue), Q1 close behind; Q3 lower due to partial data.  
- Weekends drive demand: Saturday (28.9k orders, ₹7.78M) and Sunday (28.5k, ₹7.64M) account for ~29% of weekly orders, while weekdays are steadier, rising toward Friday.  

**Geography**
- Demand is concentrated in Tier 1 cities, led by Bengaluru (20k orders). Mumbai, Hyderabad, Jaipur, Lucknow, and New Delhi form a second tier.  
- Top 10 cities show consistent volumes (~10k), indicating balanced urban demand.  
- Karnataka leads state revenue (₹5.46M), followed by UP, Telangana, Maharashtra, Delhi, and Gujarat; smaller states contribute less but represent emerging opportunities.  

**Restaurants, cuisine, and dishes**
- McDonald’s leads in orders (13.5k, ₹3.34M), KFC higher in revenue (12.9k, ₹4.25M); high volume doesn’t always mean high revenue.  
- Recommended dominates categories (24k orders, 4.3 rating); Sweets top ratings at 4.5 despite fewer orders. Bundles and combos maintain engagement efficiently.  
- Popular dishes include Choco Lava Cake, Veg Fried Rice, Jeera Rice, French Fries, Margherita Pizza, and Butter Naan, showing staples and familiar items drive repeat purchases.  

**Customer spending**
- Most orders fall in ₹100–299 (110k combined), reflecting price-conscious everyday spending.  
- ₹300–499 captures higher-value group or social orders; under ₹100 orders are budget-focused, and ₹500+ orders, though fewer, boost revenue and margins.  
- Customers value convenience and routine meals; higher spending occurs when perceived value justifies it (weekends, promotions, group dining).  

---

## Strategy recommendations for Swiggy in India

Swiggy should focus on strengthening operations during weekends and peak periods, as Saturday and Sunday consistently account for nearly 30% of weekly orders. In addition, ensuring adequate delivery fleet capacity, restaurant staffing, and customer support during these high-demand days will improve service reliability and customer satisfaction. Weekend-focused promotions, bundle offers, and loyalty incentives can further capitalize on leisure-driven ordering patterns and encourage higher basket sizes.

Expansion into Tier 2 and emerging cities presents a significant growth opportunity. Cities such as Jaipur, Lucknow, and Ahmedabad are showing increasing demand, and targeted partnerships with local restaurants, combined with city-specific marketing campaigns, can help Swiggy capture new users while building long-term brand loyalty. Moreover, careful localization of offerings and promotions will ensure relevance and resonance with these audiences.

Optimising the restaurant mix is another key lever for improving revenue efficiency. While high-volume restaurants like McDonald’s drive orders, brands such as KFC demonstrate that higher average order values can generate more revenue. In addition, promoting premium combos, add-ons, and high value dishes alongside popular staple items will balance accessibility with revenue growth. Leveraging insights from top-rated categories and dishes, such as desserts and comfort foods, through recommendations and in-app prompts can further increase basket size and repeat usage.

Pricing strategies should reflect customer behavior, focusing on the ₹100–299 segment for routine, price-conscious orders while offering targeted incentives for mid-range (₹300–499) and high-value (₹500+) orders. Besides midweek deals and social occasion promotions, premium bundle offerings can smooth demand across the week and encourage larger transactions.

In addition, Swiggy should continue enhancing personalisation and recommendations. Algorithm-driven suggestions have proven effective in driving orders, and combining behavioral and geographic insights can make offers more relevant and increase average order value. At the same time, monitoring emerging states and cities with growing adoption will allow Swiggy to identify high potential markets early and gradually scale operations without overextending resources. These strategies aim to balance operational efficiency, revenue growth, and customer satisfaction across India’s diverse markets.  

The following table summarises the key strategic focus areas and recommendations for Swiggy based on observed customer behavior, geographic trends, and revenue insights

| Focus area                         | Key points |
|-----------------------------------|------------|
| Weekend & peak operations          | Strengthen delivery fleet, restaurant staffing, and customer support; Saturday & Sunday ~30% of weekly orders; use weekend promotions, bundles, and loyalty incentives to boost basket size. |
| Tier 2 & emerging cities           | Expand into cities like Jaipur, Lucknow, Ahmedabad; partner with local restaurants; run city-specific marketing; localise offerings to build brand loyalty. |
| Restaurant mix & revenue efficiency| Balance high-volume (McDonald’s) with high AOV (KFC); promote premium combos, add-ons, and popular staples; leverage top-rated categories/dishes to increase basket size and repeat usage. |
| Pricing strategies                  | Focus on ₹100–299 for routine, price-conscious orders; incentivize ₹300–499 and ₹500+ with midweek deals, social promotions, and premium bundles; smooth demand across the week. |
| Personalisation & recommendations  | Use algorithm-driven suggestions; personalise offers using behavioral and geographic data to increase AOV; monitor emerging markets for early expansion. |
