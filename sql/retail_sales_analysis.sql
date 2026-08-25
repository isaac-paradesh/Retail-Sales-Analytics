-- ==========================================
-- 1. DATA QUALITY AUDIT
-- ==========================================

-- Check for missing values in important columns
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE order_id IS NULL) AS missing_order_ids,
    COUNT(*) FILTER (WHERE order_date IS NULL) AS missing_order_dates,
    COUNT(*) FILTER (WHERE ship_date IS NULL) AS missing_ship_dates,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_ids,
    COUNT(*) FILTER (WHERE product_id IS NULL) AS missing_product_ids,
    COUNT(*) FILTER (WHERE sales IS NULL) AS missing_sales,
    COUNT(*) FILTER (WHERE postal_code IS NULL) AS missing_postal_codes
FROM sales;


-- Check for duplicate row IDs
SELECT
    row_id,
    COUNT(*) AS occurrences
FROM sales
GROUP BY row_id
HAVING COUNT(*) > 1;


-- Check for logically invalid records
SELECT
    COUNT(*) FILTER (WHERE ship_date < order_date) AS shipped_before_order,
    COUNT(*) FILTER (WHERE sales <= 0) AS zero_or_negative_sales
FROM sales;


-- Check the date range of the dataset
SELECT
    MIN(order_date) AS earliest_order,
    MAX(order_date) AS latest_order,
    MIN(ship_date) AS earliest_ship_date,
    MAX(ship_date) AS latest_ship_date
FROM sales;

-- ==========================================
-- 2. OVERALL BUSINESS KPIs
-- ==========================================

SELECT
    COUNT(*) AS total_rows,
    ROUND(SUM(sales), 2) AS total_sales,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT product_id) AS total_products,
    ROUND(AVG(sales), 2) AS average_line_sale
FROM sales;


-- ==========================================
-- 3. PRODUCT PERFORMANCE
-- ==========================================

-- Sales by category
SELECT
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales
GROUP BY category
ORDER BY total_sales DESC;

-- Sales by sub-category
SELECT
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(sales), 2) AS average_line_sale
FROM sales
GROUP BY sub_category
ORDER BY total_sales DESC;


-- ==========================================
-- 4. REGIONAL PERFORMANCE
-- ==========================================

SELECT
    region,
    ROUND(SUM(sales), 2) AS total_sales,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(AVG(sales), 2) AS average_line_sale
FROM sales
GROUP BY region
ORDER BY total_sales DESC;


-- ==========================================
-- 5. YEARLY SALES TREND
-- ==========================================

SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    ROUND(SUM(sales), 2) AS total_sales,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY year;


-- ==========================================
-- 6. MONTHLY SALES TREND
-- ==========================================

SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    ROUND(SUM(sales), 2) AS total_sales,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY year, month;


-- ==========================================
-- 7. SALES SEASONALITY BY MONTH
-- ==========================================

SELECT
    EXTRACT(MONTH FROM order_date) AS month_number,
    TO_CHAR(order_date, 'Month') AS month_name,
    ROUND(SUM(sales), 2) AS total_sales,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales
GROUP BY
    EXTRACT(MONTH FROM order_date),
    TO_CHAR(order_date, 'Month')
ORDER BY month_number;


-- ==========================================
-- 8. CUSTOMER ANALYSIS
-- ==========================================

-- Top 10 customers by total sales
SELECT
    customer_id,
    customer_name,
    ROUND(SUM(sales), 2) AS total_sales,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(
        SUM(sales) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM sales
GROUP BY
    customer_id,
    customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- Most frequent customers
SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(
        SUM(sales) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM sales
GROUP BY
    customer_id,
    customer_name
ORDER BY total_orders DESC, total_sales DESC
LIMIT 10;


-- ==========================================
-- 9. CUSTOMER SEGMENT PERFORMANCE
-- ==========================================

SELECT
    segment,
    ROUND(SUM(sales), 2) AS total_sales,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(
        SUM(sales) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM sales
GROUP BY segment
ORDER BY total_sales DESC;


-- ==========================================
-- 10. STATE PERFORMANCE
-- ==========================================

-- Top 10 states by total sales
SELECT
    state,
    region,
    ROUND(SUM(sales), 2) AS total_sales,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers
FROM sales
GROUP BY
    state,
    region
ORDER BY total_sales DESC
LIMIT 10;


-- ==========================================
-- 11. TOP-PERFORMING PRODUCTS
-- ==========================================

SELECT
    product_id,
    product_name,
    category,
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales
GROUP BY
    product_id,
    product_name,
    category,
    sub_category
ORDER BY total_sales DESC
LIMIT 10;

-- Most frequently ordered products
SELECT
    product_id,
    product_name,
    category,
    sub_category,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales
GROUP BY
    product_id,
    product_name,
    category,
    sub_category
ORDER BY total_orders DESC, total_sales DESC
LIMIT 10;


-- ==========================================
-- 12. SHIPPING PERFORMANCE
-- ==========================================

WITH order_shipping AS (
    SELECT DISTINCT
        order_id,
        ship_mode,
        order_date,
        ship_date,
        ship_date - order_date AS shipping_days
    FROM sales
)

SELECT
    ship_mode,
    COUNT(*) AS total_orders,
    ROUND(AVG(shipping_days), 2) AS average_shipping_days,
    MIN(shipping_days) AS fastest_shipping_days,
    MAX(shipping_days) AS slowest_shipping_days
FROM order_shipping
GROUP BY ship_mode
ORDER BY average_shipping_days;


-- ==========================================
-- 13. YEAR-OVER-YEAR SALES GROWTH
-- ==========================================

WITH yearly_sales AS (
    SELECT
        EXTRACT(YEAR FROM order_date) AS year,
        ROUND(SUM(sales), 2) AS total_sales
    FROM sales
    GROUP BY EXTRACT(YEAR FROM order_date)
)

SELECT
    year,
    total_sales,
    LAG(total_sales) OVER (ORDER BY year) AS previous_year_sales,
    ROUND(
        (
            (total_sales - LAG(total_sales) OVER (ORDER BY year))
            / LAG(total_sales) OVER (ORDER BY year)
        ) * 100,
        2
    ) AS growth_percentage
FROM yearly_sales
ORDER BY year;


-- ==========================================
-- 14. REGIONAL CONTRIBUTION TO TOTAL SALES
-- ==========================================

SELECT
    region,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(
        SUM(sales) * 100.0 / SUM(SUM(sales)) OVER (),
        2
    ) AS percentage_of_total_sales
FROM sales
GROUP BY region
ORDER BY total_sales DESC;


-- ==========================================
-- 15. TOP STATES WITHIN EACH REGION
-- ==========================================

WITH state_sales AS (
    SELECT
        region,
        state,
        ROUND(SUM(sales), 2) AS total_sales
    FROM sales
    GROUP BY
        region,
        state
),

ranked_states AS (
    SELECT
        region,
        state,
        total_sales,
        RANK() OVER (
            PARTITION BY region
            ORDER BY total_sales DESC
        ) AS sales_rank
    FROM state_sales
)

SELECT
    region,
    state,
    total_sales,
    sales_rank
FROM ranked_states
WHERE sales_rank <= 3
ORDER BY region, sales_rank;


-- ==========================================
-- 16. ORDER VALUE ANALYSIS
-- ==========================================

WITH order_totals AS (
    SELECT
        order_id,
        ROUND(SUM(sales), 2) AS order_value
    FROM sales
    GROUP BY order_id
)

SELECT
    COUNT(*) AS total_orders,
    ROUND(AVG(order_value), 2) AS average_order_value,
    ROUND(MIN(order_value), 2) AS smallest_order,
    ROUND(MAX(order_value), 2) AS largest_order,
    ROUND(
        PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY order_value)::numeric,
        2
    ) AS median_order_value
FROM order_totals;


-- ==========================================
-- 17. ORDER VALUE DISTRIBUTION
-- ==========================================

WITH order_totals AS (
    SELECT
        order_id,
        SUM(sales) AS order_value
    FROM sales
    GROUP BY order_id
)

SELECT
    CASE
        WHEN order_value < 100 THEN 'Under $100'
        WHEN order_value < 500 THEN '$100 - $499'
        WHEN order_value < 1000 THEN '$500 - $999'
        WHEN order_value < 5000 THEN '$1,000 - $4,999'
        ELSE '$5,000+'
    END AS order_value_band,
    COUNT(*) AS total_orders,
    ROUND(SUM(order_value), 2) AS total_sales
FROM order_totals
GROUP BY
    CASE
        WHEN order_value < 100 THEN 'Under $100'
        WHEN order_value < 500 THEN '$100 - $499'
        WHEN order_value < 1000 THEN '$500 - $999'
        WHEN order_value < 5000 THEN '$1,000 - $4,999'
        ELSE '$5,000+'
    END
ORDER BY MIN(order_value);


-- ==========================================
-- 18. CATEGORY PERFORMANCE BY REGION
-- ==========================================

SELECT
    region,
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales
GROUP BY
    region,
    category
ORDER BY region, total_sales DESC;


-- ==========================================
-- 19. CUSTOMER REVENUE CONCENTRATION
-- ==========================================

WITH customer_sales AS (
    SELECT
        customer_id,
        customer_name,
        SUM(sales) AS total_sales
    FROM sales
    GROUP BY
        customer_id,
        customer_name
),

ranked_customers AS (
    SELECT
        customer_id,
        customer_name,
        total_sales,
        RANK() OVER (ORDER BY total_sales DESC) AS customer_rank
    FROM customer_sales
)

SELECT
    ROUND(SUM(total_sales), 2) AS top_10_customer_sales,
    ROUND(
        SUM(total_sales) * 100.0 /
        (SELECT SUM(sales) FROM sales),
        2
    ) AS percentage_of_total_sales
FROM ranked_customers
WHERE customer_rank <= 10;


-- ==========================================
-- 20. YEAR-OVER-YEAR GROWTH BY CATEGORY
-- ==========================================

WITH yearly_category_sales AS (
    SELECT
        EXTRACT(YEAR FROM order_date) AS year,
        category,
        ROUND(SUM(sales), 2) AS total_sales
    FROM sales
    GROUP BY
        EXTRACT(YEAR FROM order_date),
        category
),

category_growth AS (
    SELECT
        year,
        category,
        total_sales,
        LAG(total_sales) OVER (
            PARTITION BY category
            ORDER BY year
        ) AS previous_year_sales
    FROM yearly_category_sales
)

SELECT
    year,
    category,
    total_sales,
    previous_year_sales,
    ROUND(
        (
            (total_sales - previous_year_sales)
            / previous_year_sales
        ) * 100,
        2
    ) AS growth_percentage
FROM category_growth
ORDER BY year, category;


-- ==========================================
-- 21. RFM CUSTOMER SEGMENTATION
-- ==========================================

WITH customer_metrics AS (
    SELECT
        customer_id,
        customer_name,

        -- Recency: days since the customer's most recent purchase
        (
            (SELECT MAX(order_date) FROM sales) + 1
            - MAX(order_date)
        ) AS recency_days,

        -- Frequency: number of unique orders placed
        COUNT(DISTINCT order_id) AS frequency,

        -- Monetary: total customer spending
        ROUND(SUM(sales), 2) AS monetary_value

    FROM sales
    GROUP BY
        customer_id,
        customer_name
),

rfm_scores AS (
    SELECT
        customer_id,
        customer_name,
        recency_days,
        frequency,
        monetary_value,

        -- Lower recency is better
        NTILE(5) OVER (
            ORDER BY recency_days DESC
        ) AS recency_score,

        -- Higher frequency is better
        NTILE(5) OVER (
            ORDER BY frequency ASC
        ) AS frequency_score,

        -- Higher spending is better
        NTILE(5) OVER (
            ORDER BY monetary_value ASC
        ) AS monetary_score

    FROM customer_metrics
)

SELECT
    customer_id,
    customer_name,
    recency_days,
    frequency,
    monetary_value,
    recency_score,
    frequency_score,
    monetary_score,

    CASE
        WHEN recency_score >= 4
             AND frequency_score >= 4
             AND monetary_score >= 4
            THEN 'Champions'

        WHEN recency_score >= 3
             AND frequency_score >= 4
            THEN 'Loyal Customers'

        WHEN recency_score >= 4
             AND frequency_score <= 2
            THEN 'New / Promising'

        WHEN recency_score <= 2
             AND frequency_score >= 3
            THEN 'At Risk'

        WHEN monetary_score >= 4
             AND frequency_score <= 2
            THEN 'Big Spenders'

        ELSE 'Regular Customers'
    END AS customer_segment

FROM rfm_scores
ORDER BY
    monetary_value DESC;

-- Summary of RFM customer segments

WITH customer_metrics AS (
    SELECT
        customer_id,
        customer_name,
        (
            (SELECT MAX(order_date) FROM sales) + 1
            - MAX(order_date)
        ) AS recency_days,
        COUNT(DISTINCT order_id) AS frequency,
        ROUND(SUM(sales), 2) AS monetary_value
    FROM sales
    GROUP BY
        customer_id,
        customer_name
),

rfm_scores AS (
    SELECT
        *,
        NTILE(5) OVER (ORDER BY recency_days DESC) AS recency_score,
        NTILE(5) OVER (ORDER BY frequency ASC) AS frequency_score,
        NTILE(5) OVER (ORDER BY monetary_value ASC) AS monetary_score
    FROM customer_metrics
),

segmented_customers AS (
    SELECT
        *,
        CASE
            WHEN recency_score >= 4
                 AND frequency_score >= 4
                 AND monetary_score >= 4
                THEN 'Champions'

            WHEN recency_score >= 3
                 AND frequency_score >= 4
                THEN 'Loyal Customers'

            WHEN recency_score >= 4
                 AND frequency_score <= 2
                THEN 'New / Promising'

            WHEN recency_score <= 2
                 AND frequency_score >= 3
                THEN 'At Risk'

            WHEN monetary_score >= 4
                 AND frequency_score <= 2
                THEN 'Big Spenders'

            ELSE 'Regular Customers'
        END AS customer_segment
    FROM rfm_scores
)

SELECT
    customer_segment,
    COUNT(*) AS total_customers,
    ROUND(SUM(monetary_value), 2) AS total_sales,
    ROUND(AVG(monetary_value), 2) AS average_customer_value
FROM segmented_customers
GROUP BY customer_segment
ORDER BY total_sales DESC;


-- ==========================================
-- 22. REUSABLE ORDER SUMMARY VIEW
-- ==========================================

CREATE OR REPLACE VIEW order_summary AS

SELECT
    order_id,
    customer_id,
    customer_name,
    segment,
    region,
    order_date,
    ship_date,
    ship_mode,
    COUNT(*) AS line_items,
    ROUND(SUM(sales), 2) AS order_value,
    ship_date - order_date AS shipping_days

FROM sales

GROUP BY
    order_id,
    customer_id,
    customer_name,
    segment,
    region,
    order_date,
    ship_date,
    ship_mode;

-- Preview the order summary view

SELECT *
FROM order_summary
LIMIT 10;

-- Validate the view against the original dataset

SELECT
    COUNT(*) AS total_orders,
    ROUND(SUM(order_value), 2) AS total_sales
FROM order_summary;