-- ============================================================
-- SALES PERFORMANCE ANALYSIS — RETAIL SUPERSTORE
-- Author: Ardel
-- Dataset: Sample Superstore (Kaggle)
-- Tool: SQLite
-- ============================================================


-- Q1: Total sales per product category
-- Tujuan: Mengetahui kategori mana yang paling berkontribusi terhadap revenue

SELECT 
    Category,
    SUM(Sales) AS Total_Sales,
    ROUND(SUM(Sales) / (SELECT SUM(Sales) FROM SampleSuperstore) * 100, 2) AS Sales_Percentage
FROM SampleSuperstore
GROUP BY Category
ORDER BY Total_Sales DESC;


-- Q2: Most profitable region
-- Tujuan: Mengetahui region mana yang menghasilkan profit tertinggi

SELECT 
    region,
    ROUND(SUM(profit), 2) AS Total_Profit,
    ROUND(AVG(profit), 2) AS Avg_Profit_Per_Order,
    COUNT(order_id) AS Total_Orders
FROM SampleSuperstore
GROUP BY region
ORDER BY Total_Profit DESC;


-- Q3: Customer segment by order frequency and revenue
-- Tujuan: Mengetahui segment mana yang paling valuable

SELECT 
    segment,
    COUNT(order_id) AS Total_Orders,
    ROUND(SUM(sales), 2) AS Total_Sales,
    ROUND(SUM(profit), 2) AS Total_Profit,
    ROUND(AVG(profit), 2) AS Avg_Profit_Per_Order
FROM SampleSuperstore
GROUP BY segment
ORDER BY Total_Orders DESC;


-- Q4: Monthly sales trend
-- Tujuan: Mengetahui pola musiman penjualan
-- Note: order_date format is M/D/YYYY, converted manually using SUBSTR

SELECT 
    SUBSTR(order_date, -4) || '-' || 
    PRINTF('%02d', CAST(SUBSTR(order_date, 1, INSTR(order_date, '/') - 1) AS INTEGER)) AS Year_Month,
    ROUND(SUM(sales), 2) AS Total_Sales,
    COUNT(order_id) AS Total_Orders
FROM SampleSuperstore
GROUP BY Year_Month
ORDER BY Year_Month ASC;


-- Q5: Impact of discount on profit
-- Tujuan: Mengetahui apakah diskon tinggi selalu menguntungkan

SELECT 
    CASE 
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.2 THEN 'Low (0-20%)'
        WHEN discount <= 0.4 THEN 'Medium (21-40%)'
        ELSE 'High (>40%)'
    END AS Discount_Category,
    COUNT(order_id) AS Total_Orders,
    ROUND(AVG(discount) * 100, 1) AS Avg_Discount_Pct,
    ROUND(SUM(profit), 2) AS Total_Profit,
    ROUND(AVG(profit), 2) AS Avg_Profit_Per_Order
FROM SampleSuperstore
GROUP BY Discount_Category
ORDER BY Avg_Discount_Pct ASC;


-- Q6: Top 10 products by total sales
-- Tujuan: Mengetahui produk dengan kontribusi revenue tertinggi

SELECT 
    product_name,
    category,
    ROUND(SUM(sales), 2) AS Total_Sales,
    COUNT(order_id) AS Total_Orders,
    ROUND(SUM(profit), 2) AS Total_Profit
FROM SampleSuperstore
GROUP BY product_name
ORDER BY Total_Sales DESC
LIMIT 10;


-- Q7: Customer segments with most loss-making orders
-- Tujuan: Mengetahui segment mana yang paling banyak menghasilkan kerugian

SELECT 
    segment,
    COUNT(order_id) AS Loss_Orders,
    ROUND(SUM(profit), 2) AS Total_Loss,
    ROUND(AVG(profit), 2) AS Avg_Loss_Per_Order
FROM SampleSuperstore
WHERE profit < 0
GROUP BY segment
ORDER BY Total_Loss ASC;
