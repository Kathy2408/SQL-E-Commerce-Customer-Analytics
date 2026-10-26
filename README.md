
## Background
Analysis of customer purchasing behavior, cohort retention, churn, and revenue per customer for an e-commerce company to identify customer trends, improve retention strategies, and maximize long-term customer value.

## Business Questions
1. **Customer Segmentation:** Who are our most valuable customers?
2. **Cohort Analysis:** How do different customer groups generate revenue?
3. **Retention Analysis:**Which customers haven't purchased recently?

## Analysis Approach
### 1. Customer Segmentation Analysis

- Categorized customers based on their total historical revenue as a proxy for lifetime value (LTV).

- Segmented customers into High, Mid, and Low-value groups.

- Calculated key metrics: total revenue, customer count, and average revenue per customer.

- Analyzed revenue contributions across customer segments to identify high-value customers.

🖥️Query: [1_customer_segmentation.sql](/Contoso/1_customer_segmentation.sql)

📈 **Visualization**
![Customer Segmentation](/Contoso/customersegment.png)

📊 **Key Findings**

High-value customers (25%) contribute 65.6% of total revenue ($135.4M), highlighting their significant impact on business performance.

Mid-value customers (50%) generate 32.3% of revenue ($66.6M), representing the largest customer group with opportunities for growth.

Low-value customers (25%) account for only 2.1% of revenue ($4.3M), indicating relatively low spending.

| Customer Segment | Customer Share | Customers | Total LTV | Avg. LTV | Revenue Share |
|---|---:|---:|---:|---:|---:|
| High Value | 25% | 12,372 | $135.43M | $10,946.43 | 65.6% |
| Mid Value | 50% | 24,743 | $66.64M | $2,693.14 | 32.3% |
| Low Value | 25% | 12,372 | $4.34M | $350.94 | 2.1% |
| **Total** | **100%** | **49,487** | **$206.41M** | **$4,171.01** | **100%** |

💡 **Business Insights & Recommendations**

High-value: Prioritize retaining 12,372 VIP customers through exclusive loyalty programs, personalized benefits, and premium services to protect the company's largest revenue source.

Mid-value: Increase customer spending and purchase frequency through personalized promotions, cross-selling, and targeted loyalty incentives to encourage movement into the high-value segment.

Low-value: Introduce cost-effective re-engagement campaigns and targeted discounts to encourage repeat purchases while maintaining profitability.


### 2.Cohort Analysis

- Tracked revenue and customer count per cohorts
- Cohorts were grouped by year of first purchase
- Analyzed customer retention at a cohort leve

🖥️ Query: [2_cohort_analysis.sql](/Contoso/2_cohort_ltv_over_time_analysis.sql)

📈 **Visualization:**

![cohort_analysis](/Contoso/Customer%20Revenue%20by%20first%20Purchase%20Year.png)

📊 **Key Findings**

Declining revenue per customer: Recent cohorts (2022–2024) show lower cumulative revenue per customer compared to earlier cohorts.

Revenue growth driven by customer volume: Despite increasing total revenue, lower revenue per customer among newer cohorts suggests that growth may be driven more by customer volume than individual customer spending.

Customer acquisition slowdown: A decline in new customer acquisition in 2023 raises concerns about the sustainability of future revenue growth.

💡 **Business Insights**

Customer value: Investigate whether newer cohorts genuinely generate lower customer value by comparing revenue over equal observation periods, such as the first 12 months after acquisition.

Customer acquisition: Examine the factors behind the 2023 acquisition slowdown and identify opportunities to attract new customers.

Long-term revenue risk: Slower customer acquisition combined with potentially weaker customer spending could threaten future revenue growth, highlighting the need to strengthen both acquisition and retention strategies.

### Investigate Monthly Revenue & Customer Trends
- Calculate the monthly revenue and customer trends to explore why we seeing customers spend less over time.
- Could this be attributed to seasonal trend?

```sql
SELECT 
      DATE_TRUNC('month', ca.orderdate)::DATE AS year_month,
      SUM(total_net_revenue) AS total_revenue,
      COUNT(DISTINCT ca.customerkey) AS total_customers,
      SUM(total_net_revenue) / COUNT(DISTINCT ca.customerkey) AS customer_revenue
FROM cohort_analysis ca 
GROUP BY
     year_month
ORDER BY
     year_month;
```

![Monthly Net Revenue and Customers](/Contoso/monthly_net_revenue.png)

📊 **Key Findings**

**Strong relationship between customer activity and revenue:** Monthly revenue generally increases as the number of active customers grows, indicating that customer volume is a key revenue driver.

**Revenue gap during 2022–2023:** Despite high customer activity, revenue did not always increase proportionally, suggesting that average revenue per customer was lower in certain months.

**Customer growth does not guarantee higher spending:** The differences between revenue and customer trends highlight the importance of evaluating revenue per active customer rather than relying solely on customer counts.

### 3. Customer Retention 
🖥️ Query: [3_retention_analysis.sql](/Contoso/3_customer_Retention.sql)

At the customer level, I analyze spending behavior and how customer value changes over time. Finally, I conduct a cohort analysis by first purchase year to track active, retained, and churned customers, helping identify retention patterns across different customer groups.

📈 **Visualization:**

![Customer Retention](/Contoso/churn_retention_stacked_chart_blue.png)

📊 **Key Findings**

High long-term churn: Churn rates reach approximately 90% after 2–3 years, indicating significant customer loss over time.

Consistently low retention: Retention rates remain around 8–10% across mature cohorts, suggesting a company-wide retention challenge rather than issues limited to specific acquisition years.

Similar churn patterns: Newer cohorts (2022–2023) show comparable early churn trends, raising concerns about long-term retention if current patterns continue.

💡 **Business Insights & Recommendations**

Improve early retention: Focus on the first 1–2 years of the customer lifecycle through personalized offers, loyalty rewards, and incentives to encourage repeat purchases.

Re-engage high-value customers: Prioritize targeted win-back campaigns for churned customers with historically high spending to maximize potential revenue recovery.

Identify churn risks early: Monitor purchase recency, frequency, and spending behavior to detect at-risk customers and intervene before they reach the 6-month inactivity threshold.

# Technical Details
- Database: PostgreSQL
- Analysis Tools: PostgreSQL, PGadmin
- Visualization: ChatGPT, Gemini