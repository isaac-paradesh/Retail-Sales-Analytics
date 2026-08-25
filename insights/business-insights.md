# Business Insights

## Executive Summary

This document summarises the main findings from the combined **PostgreSQL / SQL analysis** and **Power BI dashboard**.

The same retail sales dataset was analysed independently in two complementary workflows:

```text
CSV Dataset
   ├── PostgreSQL → SQL analysis
   └── Power BI   → Interactive dashboard
```

The SQL analysis provides deeper validation, segmentation and order-level analysis, while Power BI provides interactive exploration and customer drill-through.

### Headline Findings

- **Technology** was the highest-revenue category at approximately **$827K**.
- The **West** was the strongest region at approximately **$710K (31.4%)** of total sales.
- The **Consumer** segment generated approximately **$1.15M**, or **50.8%** of total sales.
- Sales showed strong **September–December seasonality**, with November the strongest month overall.
- The average order value was **$459.48**, but the median was only **$151.88**, showing that large orders materially lift the average.
- RFM analysis identified a substantial **At Risk** customer segment representing approximately **$467K** in historical sales.

---

## 1. Technology Leads Product-Category Sales

Technology generated approximately **$827K in sales**, representing about **36.6% of total revenue**.

Furniture generated approximately **$729K**, while Office Supplies generated approximately **$705K**.

### Interpretation

Technology is the strongest category by revenue and also leads category sales in all four regions.

Office Supplies appears in far more orders, which suggests a difference between **high-value purchasing** and **high-frequency purchasing**.

### Business Implication

Technology should remain an important revenue focus, while Office Supplies may require a different strategy centred on repeat purchase volume and customer retention.

---

## 2. The West Is the Strongest Sales Region

The West generated approximately **$710K**, representing **31.4% of total sales**.

The South generated approximately **$389K**, representing about **17.2% of total sales**.

West sales were approximately **82.5% higher than South sales**.

California alone generated approximately **$446K**, making it the strongest individual state.

### Interpretation

Regional performance varies substantially, and the West is heavily supported by California.

### Business Implication

Management could compare customer mix, product demand, sales coverage and market activity between the West and South to identify growth opportunities in weaker regions.

---

## 3. Consumer Customers Are the Largest Segment

The Consumer segment generated approximately **$1.15M**, accounting for approximately **50.8% of total sales**.

Corporate customers generated approximately **$688K**, while Home Office customers generated approximately **$425K**.

### Interpretation

Consumer customers are the largest source of both revenue and order volume.

Home Office is smaller overall but has the highest average order value among the three segments.

### Business Implication

Consumer retention remains important because of its scale, while Home Office may warrant targeted strategies focused on higher-value purchases.

---

## 4. Sean Miller Is the Highest-Value Customer

Sean Miller generated approximately **$25.0K in sales** from five orders.

Tamara Chand generated approximately **$19.1K**, meaning Sean Miller generated about **31% more sales** than the second-ranked customer.

### Interpretation

The most valuable customers are not necessarily the most frequent customers.

Sean Miller generated very high revenue from relatively few orders, showing how large purchases can create substantial customer value.

### Business Implication

High-value customers should be analysed separately from high-frequency customers because different retention and relationship strategies may be appropriate.

---

## 5. Sales Show Strong Year-End Seasonality

Sales consistently strengthened during **September through December**.

Approximate cumulative sales across all four years were:

- **November:** $350K
- **December:** $321K
- **September:** $300K

February was the weakest month overall.

### Interpretation

The repeated pattern across multiple years indicates genuine seasonality rather than one unusually strong period.

### Business Implication

Inventory, staffing and promotional planning should be increased ahead of the September–December peak period.

---

## 6. Sales Rebounded Strongly After 2016

Year-over-year sales performance was:

| Year | Total Sales | YoY Growth |
|---|---:|---:|
| 2015 | $479,856.27 | — |
| 2016 | $459,435.94 | -4.26% |
| 2017 | $600,192.80 | +30.64% |
| 2018 | $722,051.96 | +20.30% |

The 2016 decline was driven mainly by decreases in Office Supplies and Technology.

In 2017, all three major categories returned to growth.

### Interpretation

The decline in 2016 was temporary rather than a sustained deterioration.

### Business Implication

When assessing sales performance, management should examine category-level drivers rather than relying only on company-wide totals.

---

## 7. Typical Orders Are Much Smaller Than the Average Suggests

Order-level analysis showed:

- **Average order value:** $459.48
- **Median order value:** $151.88
- **Smallest order:** $0.56
- **Largest order:** $23,661.24

### Interpretation

The large gap between average and median order value indicates a highly skewed distribution.

A relatively small number of large purchases raise the average significantly above what a typical order looks like.

### Business Implication

Median order value should be monitored alongside average order value so that unusually large transactions do not distort interpretation of normal customer behaviour.

---

## 8. Large Orders Contribute Disproportionately to Revenue

| Order Value Band | Orders | Share of Orders | Sales | Share of Sales |
|---|---:|---:|---:|---:|
| Under $100 | 2,074 | 42.1% | $75,341.15 | 3.3% |
| $100–$499 | 1,594 | 32.4% | $403,911.51 | 17.9% |
| $500–$999 | 643 | 13.1% | $453,762.53 | 20.1% |
| $1,000–$4,999 | 584 | 11.9% | $1,090,302.01 | 48.2% |
| $5,000+ | 27 | 0.5% | $238,219.77 | 10.5% |

### Interpretation

About **42% of all orders are under $100**, but they contribute only **3.3% of sales**.

By contrast, orders of $1,000 or more represent only about **12.4% of orders** but contribute approximately **58.7% of revenue**.

### Business Implication

High-value purchases should be monitored separately because a relatively small number of large orders has a major impact on overall revenue.

---

## 9. Revenue Is Broadly Distributed Across Customers

The top 10 customers generated approximately **$153.8K**, representing only **6.8% of total sales**.

### Interpretation

Although individual high-value customers exist, the business is not heavily dependent on a very small group of customers.

### Business Implication

This reduces customer-concentration risk and suggests that retention activity should consider both high-value customers and the broader customer base.

---

## 10. RFM Segmentation Identifies Clear Retention Opportunities

Customers were segmented using **Recency, Frequency and Monetary value (RFM)**.

| Segment | Customers | Total Sales | Average Customer Value |
|---|---:|---:|---:|
| Champions | 105 | $551,799.44 | $5,255.23 |
| Regular Customers | 297 | $493,962.30 | $1,663.17 |
| At Risk | 139 | $467,384.83 | $3,362.48 |
| Loyal Customers | 133 | $386,786.64 | $2,908.17 |
| Big Spenders | 39 | $224,078.09 | $5,745.59 |
| New / Promising | 80 | $137,525.67 | $1,719.07 |

### Interpretation

- **Champions** generated approximately **24.4% of total sales**.
- **At Risk** customers generated approximately **20.7% of total sales**.
- **Big Spenders** had the highest average customer value.
- Regular Customers were the largest group by customer count.

### Business Implication

The **At Risk** group is a particularly valuable retention opportunity because it combines strong historical spending with lower recent activity.

Targeted re-engagement campaigns could focus on this segment first.

---

## 11. Technology Generates Value While Office Supplies Generates Frequency

Technology was the highest-revenue category in every region.

Office Supplies generated the highest order volume in every region.

### Interpretation

The business has two different forms of product strength:

- **Technology:** high-value revenue generation
- **Office Supplies:** frequent repeat purchasing

### Business Implication

Inventory, promotion and customer strategies should account for both revenue per purchase and purchase frequency rather than treating all categories the same.

---

## 12. Shipping Performance Follows the Expected Service Hierarchy

Order-level shipping analysis produced the following results:

| Ship Mode | Orders | Average Shipping Days |
|---|---:|---:|
| Same Day | 261 | 0.05 |
| First Class | 772 | 2.19 |
| Second Class | 944 | 3.24 |
| Standard Class | 2,945 | 5.00 |

### Interpretation

Faster service levels consistently produce shorter order-to-shipment times, while Standard Class is the most common and slowest option.

### Business Implication

These figures provide a baseline for monitoring fulfilment performance and checking whether actual service levels match customer expectations.

---

## 13. Customer-Level Analysis Supports Drill-Through Investigation

The Power BI dashboard includes a Customer Details page that allows individual customer purchasing behaviour to be explored in more detail.

This supports investigation of:

- Customer-level sales
- Purchase history
- Products purchased
- Order behaviour
- High-value customers identified through SQL analysis

### Business Implication

The SQL analysis identifies where to investigate, while Power BI provides an interactive way for users to explore individual customers and products.

---

# Recommended Business Actions

Based on the combined PostgreSQL and Power BI analysis:

1. **Prepare for Q4 demand**  
   Increase inventory, staffing and promotional readiness ahead of the September–December peak period.

2. **Protect Technology revenue**  
   Maintain a strong focus on Technology because it generates the highest category revenue across all regions.

3. **Re-engage At Risk customers**  
   Prioritise customers with strong historical value but weak recent purchasing activity.

4. **Track high-value orders separately**  
   Large purchases have a disproportionate impact on revenue and should be analysed alongside normal order volume.

5. **Investigate weaker regions**  
   Compare the West and South across customer mix, product demand, market coverage and sales activity.

6. **Use different strategies for value and frequency**  
   Technology and Office Supplies contribute differently to performance and should not be managed identically.

7. **Use both average and median order value**  
   The median provides a more representative view of a typical order when large transactions skew the average.

---

# Summary

The combined analysis identifies several major drivers of retail sales performance:

- **Technology** leads product-category revenue.
- The **West** leads regional sales.
- **Consumer** is the largest customer segment.
- Sales show clear **September–December seasonality**.
- Revenue growth accelerated strongly after 2016.
- A small proportion of large orders contributes a substantial share of revenue.
- Customer revenue is broadly distributed rather than heavily concentrated.
- **RFM segmentation** identifies both high-value Champions and a substantial At Risk segment.
- Power BI drill-through allows these findings to be investigated at individual customer and product level.

Together, the PostgreSQL analysis and Power BI dashboard provide both a robust analytical foundation and an interactive way to communicate business findings.
