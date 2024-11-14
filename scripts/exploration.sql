
-- 1. Overview of total records, distinct vendors, and distinct brands
SELECT 
    COUNT(*) AS total_records, 
    COUNT(DISTINCT vendor) AS distinct_vendors,
    COUNT(DISTINCT brand) AS distinct_brands
FROM product_data;

-- 2. Count missing values for each key column
SELECT 
    SUM(CASE WHEN units IS NULL THEN 1 ELSE 0 END) AS missing_units,
    SUM(CASE WHEN brand IS NULL THEN 1 ELSE 0 END) AS missing_brand,
    SUM(CASE WHEN detail_url IS NULL THEN 1 ELSE 0 END) AS missing_detail_url,
    SUM(CASE WHEN sku IS NULL THEN 1 ELSE 0 END) AS missing_sku,
    SUM(CASE WHEN upc IS NULL THEN 1 ELSE 0 END) AS missing_upc
FROM product_data;

-- 3. Distribution of products by vendor - Top 10 Vendors
SELECT vendor, COUNT(*) AS product_count
FROM product_data
GROUP BY vendor
ORDER BY product_count DESC
LIMIT 10;

-- 4. Brand frequency distribution - Top 10 Brands
SELECT brand, COUNT(*) AS brand_count
FROM product_data
WHERE brand IS NOT NULL
GROUP BY brand
ORDER BY brand_count DESC
LIMIT 10;

-- 5. Units of measurement distribution - Top 10 Units
SELECT units, COUNT(*) AS unit_count
FROM product_data
GROUP BY units
ORDER BY unit_count DESC
LIMIT 10;

-- 6. Frequency of products with detail URLs, grouped by vendor (indicates vendor completeness)
SELECT vendor, COUNT(*) AS total_products, 
       SUM(CASE WHEN detail_url IS NOT NULL THEN 1 ELSE 0 END) AS products_with_detail_url
FROM product_data
GROUP BY vendor
ORDER BY total_products DESC;

