# Retail Sales Analytics Dashboard | Power BI

## Overview

This project is an interactive Power BI solution built to analyse retail sales performance across time, regions, product categories, customer segments and individual customers.

The report was designed as a portfolio project to demonstrate practical skills in:

- Power BI
- DAX
- Data modelling
- Time intelligence
- KPI reporting
- Interactive filtering
- Customer and product analysis
- Drill-through navigation
- Dashboard design and business storytelling

## Business Problem

Management needs a clear, centralised view of sales performance in order to understand:

- How sales change over time
- Which regions and product categories generate the most revenue
- Which customer segments contribute the most sales
- Who the highest-value customers are
- What individual customers are purchasing

## Objective

Build an interactive Power BI dashboard that allows business users to monitor key sales KPIs, explore performance using filters and visual interactions, and drill into customer-level purchasing behaviour.

## Dashboard Pages

### 1. Executive Dashboard

Provides a high-level overview of business performance, including:

- Total Sales
- Total Orders
- Total Customers
- Average Order Value
- Year-over-Year Sales Growth
- Monthly Sales Trend
- Sales by Category
- Sales by Region
- Top 10 Customers by Sales
- Interactive Year, Region, Category and Segment filters

![Executive Dashboard](screenshots/01-executive-dashboard.png)

### 2. Customer & Product Analysis

Provides deeper analysis of:

- Total Customers
- Total Products
- Sales per Customer
- Average Order Value
- Top 10 Customers by Sales
- Sales by Sub-Category
- Sales by Customer Segment

![Customer and Product Analysis](screenshots/02-customer-product-analysis.png)

### 3. Customer Details

Allows users to investigate individual customer purchasing behavior using:

- Customer selection
- Customer-level KPI cards
- Customer purchase history
- Product purchase details
- Drill-through from customer analysis

![Customer Details](screenshots/03-customer-details.png)

## Key Findings

1. **Technology was the highest-performing product category**, generating approximately **$827K in sales**, or about **36.6% of total revenue**. Furniture generated approximately $729K and Office Supplies approximately $705K.

2. **The West was the strongest-performing region**, generating approximately **$710K in sales (31.4% of total sales)**. The South generated approximately **$389K (17.2%)**, meaning West sales were about **82.5% higher than South sales**.

3. **Consumer customers were the largest customer segment**, contributing roughly **$1.15M in sales — about half of total revenue**. Corporate customers were the second-largest segment, followed by Home Office.

4. **Sean Miller was the highest-value customer**, generating approximately **$25.0K in sales**. This was about **31% higher than Tamara Chand**, the second-highest customer at approximately $19.1K.

## Business Interpretation

The results suggest that sales performance is concentrated in several clear areas:

- Technology products are an important revenue driver and should remain a key focus for product and sales strategy.
- Regional performance varies substantially, with the West outperforming the South by a large margin.
- Consumer customers represent the largest source of revenue, making this segment particularly important for retention and marketing activity.
- High-value customers can be identified and analysed individually through the Customer Details page, allowing the business to better understand valuable purchasing behavior.

## Data Model

The report uses a dedicated Date table connected to the sales transaction table.

```text
Date
  1
  |
  *
Sales Data
```

This model supports time-intelligence calculations and chronological reporting.

## DAX Measures

Key measures created for the project include:

```DAX
Total Sales =
SUM('Sales Data'[Sales])
```

```DAX
Total Orders =
DISTINCTCOUNT('Sales Data'[Order ID])
```

```DAX
Total Customers =
DISTINCTCOUNT('Sales Data'[Customer ID])
```

```DAX
Total Products =
DISTINCTCOUNT('Sales Data'[Product ID])
```

```DAX
Average Order Value =
DIVIDE(
    [Total Sales],
    [Total Orders]
)
```

```DAX
Sales per Customer =
DIVIDE(
    [Total Sales],
    [Total Customers]
)
```

```DAX
Customer Rank =
RANKX(
    ALLSELECTED('Sales Data'[Customer Name]),
    [Total Sales],
    ,
    DESC,
    DENSE
)
```

```DAX
YoY Sales Growth =
VAR CurrentSales =
    [Total Sales]

VAR PreviousSales =
    CALCULATE(
        [Total Sales],
        DATEADD('Date'[Date], -1, YEAR)
    )

RETURN
    DIVIDE(
        CurrentSales - PreviousSales,
        PreviousSales
    )
```

## Interactive Features

The report includes:

- Year, Region, Category and Segment slicers
- Cross-filtering between visuals
- Page navigation
- Active-page navigation highlighting
- Reset-filter controls
- Customer drill-through
- Customer-level filtering
- Dynamic KPI calculations
- Top-N customer analysis

## Tools Used

- **Power BI Desktop** — report development and dashboard design
- **Power Query** — data preparation and type validation
- **DAX** — measures, ranking and time intelligence
- **GitHub** — project documentation and portfolio presentation

## Dataset

Retail sales transaction dataset covering customers, products, regions, categories and sales over multiple years.

**Dataset source:** [Kaggle — Sales Forecasting Dataset](https://www.kaggle.com/datasets/rohitsahoo/sales-forecasting)


## Repository Structure

```text
Retail-Sales-PowerBI/
│
├── README.md
├── Retail_Sales_Analytics_Dashboard.pbix
├── .gitignore
│
├── screenshots/
│   ├── 01-executive-dashboard.png
│   ├── 02-customer-product-analysis.png
│   └── 03-customer-details.png
│
├── insights/
│   └── business-insights.md
│
└── docs/
    ├── dax-measures.md
```

## How to View the Report

1. Download `Retail_Sales_Analytics_Dashboard.pbix`.
2. Open the file using Microsoft Power BI Desktop.
3. Use the report navigation to move between pages.
4. Use the slicers and visuals to explore different sales segments.
5. Use Customer Details / drill-through to investigate individual customers.

## Skills Demonstrated

This project demonstrates practical ability in:

`Power BI` · `DAX` · `Power Query` · `Data Modelling` · `Data Visualisation` · `Business Analysis` · `Time Intelligence` · `Dashboard Design`

## Author

**[Isaac Paradesh]**

- LinkedIn: [linkedin.com/in/isaac-paradesh-567706281](https://www.linkedin.com/in/isaac-paradesh-567706281)
- GitHub: [github.com/isaac-paradesh](https://github.com/isaac-paradesh)
