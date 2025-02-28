
------------------------ DATA CLEANING --------------------------


----------- TABLE 1 ------------------

SELECT * 
FROM customers;


-- Total records
SELECT COUNT(*) FROM customers; -----2500


-- Check duplicates
WITH repeat_customer AS(

	SELECT 
	       customer_id,
	       ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY customer_id) AS row_num
	FROM customers
)

SELECT * 
FROM repeat_customer
WHERE row_num > 1;


-- Standardize email format
UPDATE customers
SET email = LOWER(TRIM(email))
WHERE email IS NOT NULL;


-- Checking Null values in columns
SELECT * From customers
WHERE customer_name IS NULL;

SELECT * From customers
WHERE email IS NULL;

SELECT * From customers
WHERE address IS NULL;

SELECT * From customers
WHERE area IS NULL;

SELECT * From customers
WHERE pincode IS NULL;

SELECT * From customers
WHERE registration_date IS NULL;

SELECT * From customers
WHERE customer_segments IS NULL;

SELECT * From customers
WHERE total_orders IS NULL;

SELECT * From customers
WHERE average_order_value IS NULL;


-- Convert data type
ALTER TABLE customers
ALTER COLUMN average_order_value TYPE DECIMAL(10,2) USING average_order_value::DECIMAL;


-- Detect Outliers 

SELECT total_orders
FROM customers
ORDER BY total_orders DESC
LIMIT 10;

SELECT average_order_value
FROM customers
ORDER BY average_order_value DESC
LIMIT 10;



----------- TABLE 2 ------------------

SELECT * 
FROM delivery_performance;


-- Total records
SELECT COUNT(*) FROM delivery_performance; -----5000


-- Check duplicates
WITH repeat_customer AS(

	SELECT 
	       delivery_partner_id,
	       ROW_NUMBER() OVER(PARTITION BY delivery_partner_id ORDER BY delivery_partner_id) AS row_num
	FROM delivery_performance
)

SELECT * 
FROM repeat_customer
WHERE row_num > 1;


-- Checking Null values in columns
SELECT * From delivery_performance
WHERE order_id IS NULL;

SELECT * From delivery_performance
WHERE promised_time IS NULL;

SELECT * From delivery_performance
WHERE actual_time IS NULL;

SELECT * From delivery_performance
WHERE delivery_time_minutes IS NULL;

SELECT * From delivery_performance
WHERE distance_km IS NULL;

SELECT * From delivery_performance
WHERE delivery_status IS NULL;

SELECT * From delivery_performance
WHERE reasons_if_delayed IS NULL;


-- Replace NULL product_category with 'Unknown'
UPDATE delivery_performance
SET reasons_if_delayed = 'Unknown'
WHERE reasons_if_delayed IS NULL; ---- 1902 rows updated


-- Convert data type
ALTER TABLE delivery_performance
ALTER COLUMN distance_km TYPE DECIMAL(10,2) USING distance_km::DECIMAL;


-- Detect Outliers 

SELECT delivery_time_minutes
FROM delivery_performance
ORDER BY delivery_time_minutes DESC
LIMIT 10;

SELECT distance_km
FROM delivery_performance
ORDER BY distance_km DESC
LIMIT 10;



----------- TABLE 3 ------------------

SELECT * 
FROM rating_icon; -- no need to cleaned table




----------- TABLE 4 ------------------

SELECT * 
FROM category_icon; -- no need to cleaned table




----------- TABLE 5 ------------------

SELECT * 
FROM orders; 


-- Total records
SELECT COUNT(*) FROM orders; -----5000


-- Check duplicates
WITH repeat_customer AS(

	SELECT 
	       order_id,
	       ROW_NUMBER() OVER(PARTITION BY order_id ORDER BY order_id) AS row_num
	FROM orders
)

SELECT * 
FROM repeat_customer
WHERE row_num > 1;


-- Checking Null values in columns
SELECT * From orders
WHERE order_id IS NULL;

SELECT * From orders
WHERE customer_id IS NULL;

SELECT * From orders
WHERE order_date IS NULL;

SELECT * From orders
WHERE promised_delivery_time IS NULL;

SELECT * From orders
WHERE actual_delivery_time IS NULL;

SELECT * From orders
WHERE delivery_status IS NULL;

SELECT * From orders
WHERE order_total IS NULL;

SELECT * From orders
WHERE payment_method IS NULL;

SELECT * From orders
WHERE delivery_partner_id IS NULL;

SELECT * From orders
WHERE store_id IS NULL;



-- Convert data type
ALTER TABLE orders
ALTER COLUMN order_total TYPE DECIMAL(10,2) USING order_total::DECIMAL;


-- Detect Outliers 

SELECT order_total
FROM orders
ORDER BY order_total DESC
LIMIT 10;



----------- TABLE 6 ------------------

SELECT * 
FROM customer_feedback;


-- Total records
SELECT COUNT(*) FROM customer_feedback; -----5000


-- Check duplicates
WITH repeat_customer AS(

	SELECT 
	       feedback_id,
	       ROW_NUMBER() OVER(PARTITION BY feedback_id ORDER BY feedback_id) AS row_num
	FROM customer_feedback
)

SELECT * 
FROM repeat_customer
WHERE row_num > 1;


-- Checking Null values in columns
SELECT * From customer_feedback
WHERE feedback_id IS NULL;

SELECT * From customer_feedback
WHERE order_id IS NULL;

SELECT * From customer_feedback
WHERE customer_id IS NULL;

SELECT * From customer_feedback
WHERE rating IS NULL;

SELECT * From customer_feedback
WHERE feedback_text IS NULL;

SELECT * From customer_feedback
WHERE feedback_category IS NULL;

SELECT * From customer_feedback
WHERE sentiment IS NULL;

SELECT * From customer_feedback
WHERE feedback_date IS NULL;




----------- TABLE 7 ------------------

SELECT * 
FROM marketing_performance;


-- Total records
SELECT COUNT(*) FROM marketing_performance; -----5400


-- Check duplicates
WITH repeat_customer AS(

	SELECT 
	       campaign_id,
	       ROW_NUMBER() OVER(PARTITION BY campaign_id ORDER BY campaign_id) AS row_num
	FROM marketing_performance
)

SELECT * 
FROM repeat_customer
WHERE row_num > 1;


-- Checking Null values in columns
SELECT * From marketing_performance
WHERE campaign_id IS NULL;

SELECT * From marketing_performance
WHERE campaign_name IS NULL;

SELECT * From marketing_performance
WHERE date IS NULL;

SELECT * From marketing_performance
WHERE target_audience IS NULL;

SELECT * From marketing_performance
WHERE channel IS NULL;

SELECT * From marketing_performance
WHERE impressions IS NULL;

SELECT * From marketing_performance
WHERE clicks IS NULL;

SELECT * From marketing_performance
WHERE conversions IS NULL;

SELECT * From marketing_performance
WHERE spend IS NULL;

SELECT * From marketing_performance
WHERE revenue_generated IS NULL;

SELECT * From marketing_performance
WHERE roas IS NULL;


-- Convert data type
ALTER TABLE marketing_performance
ALTER COLUMN spend TYPE DECIMAL(10,2) USING spend::DECIMAL;

ALTER TABLE marketing_performance
ALTER COLUMN revenue_generated TYPE DECIMAL(10,2) USING revenue_generated::DECIMAL;

ALTER TABLE marketing_performance
ALTER COLUMN roas TYPE DECIMAL(10,2) USING roas::DECIMAL;


-- Detect Outliers 
SELECT impressions
FROM marketing_performance
ORDER BY impressions DESC
LIMIT 10;

SELECT clicks
FROM marketing_performance
ORDER BY clicks DESC
LIMIT 10;

SELECT conversions
FROM marketing_performance
ORDER BY conversions DESC
LIMIT 10;

SELECT spend
FROM marketing_performance
ORDER BY spend DESC
LIMIT 10;

SELECT revenue_generated
FROM marketing_performance
ORDER BY revenue_generated DESC
LIMIT 10;

SELECT roas
FROM marketing_performance
ORDER BY roas DESC
LIMIT 10;




----------- TABLE 8 ------------------

SELECT * 
FROM products;


-- Total records
SELECT COUNT(*) FROM products; -----268


-- Check duplicates
WITH repeat_customer AS(

	SELECT 
	       product_id,
	       ROW_NUMBER() OVER(PARTITION BY product_id ORDER BY product_id) AS row_num
	FROM products
)

SELECT * 
FROM repeat_customer
WHERE row_num > 1;


-- Checking Null values in columns
SELECT * From products
WHERE product_id IS NULL;

SELECT * From products
WHERE product_name IS NULL;

SELECT * From products
WHERE category IS NULL;

SELECT * From products
WHERE brand IS NULL;

SELECT * From products
WHERE price IS NULL;

SELECT * From products
WHERE mrp IS NULL;

SELECT * From products
WHERE margin_percentage IS NULL;

SELECT * From products
WHERE shelf_life_days IS NULL;

SELECT * From products
WHERE min_stock_level IS NULL;

SELECT * From products
WHERE max_stock_level IS NULL;



-- Convert data type
ALTER TABLE products
ALTER COLUMN price TYPE DECIMAL(10,2) USING price::DECIMAL;

ALTER TABLE products
ALTER COLUMN mrp TYPE DECIMAL(10,2) USING mrp::DECIMAL;


-- Detect Outliers 

SELECT price
FROM products
ORDER BY price DESC
LIMIT 10;

SELECT mrp
FROM products
ORDER BY mrp DESC
LIMIT 10;

SELECT margin_percentage
FROM products
ORDER BY margin_percentage DESC
LIMIT 10;

SELECT shelf_life_days
FROM products
ORDER BY shelf_life_days DESC
LIMIT 10;

SELECT min_stock_level
FROM products
ORDER BY min_stock_level DESC
LIMIT 10;

SELECT max_stock_level
FROM products
ORDER BY max_stock_level DESC
LIMIT 10;




----------- TABLE 9 ------------------

SELECT * 
FROM inventory;


-- Total records
SELECT COUNT(*) FROM inventory; -----75,172



-- Checking Null values in columns
SELECT * From inventory
WHERE product_id IS NULL;

SELECT * From inventory
WHERE date IS NULL;

SELECT * From inventory
WHERE stock_received IS NULL;

SELECT * From inventory
WHERE damaged_stock IS NULL;



-- Detect Outliers 

SELECT stock_received
FROM inventory
ORDER BY stock_received DESC
LIMIT 10;

SELECT damaged_stock
FROM inventory
ORDER BY damaged_stock DESC
LIMIT 10;


----------- TABLE 10 ------------------

SELECT * 
FROM order_items;


-- Total records
SELECT COUNT(*) FROM order_items; -----5000



-- Checking Null values in columns
SELECT * From order_items
WHERE order_id IS NULL;

SELECT * From order_items
WHERE product_id IS NULL;

SELECT * From order_items
WHERE quantity IS NULL;

SELECT * From order_items
WHERE unit_price IS NULL;

SELECT * From order_items
WHERE total_price IS NULL;


-- Convert data type
ALTER TABLE order_items
ALTER COLUMN unit_price TYPE DECIMAL(10,2) USING unit_price::DECIMAL;

ALTER TABLE order_items
ALTER COLUMN total_price TYPE DECIMAL(10,2) USING total_price::DECIMAL;


-- Detect Outliers 

SELECT quantity
FROM order_items
ORDER BY quantity DESC
LIMIT 10;

SELECT unit_price
FROM order_items
ORDER BY unit_price DESC
LIMIT 10;

SELECT total_price
FROM order_items
ORDER BY total_price DESC
LIMIT 10;


------------------- ALL CLEANED TABLES ----------------------------

SELECT * FROM customers;
SELECT * FROM delivery_performance;
SELECT * FROM rating_icon;
SELECT * FROM category_icon;
SELECT * FROM orders;
SELECT * FROM customer_feedback;
SELECT * FROM marketing_performance;
SELECT * FROM products;
SELECT * FROM inventory;
SELECT * FROM order_items;


-------------------- TABLES JOINING --------------------------


SELECT 
    -- Customers table
    c.customer_id,c.registration_date, c.customer_segments, c.total_orders, c.average_order_value,

    -- Orders table
    o.order_id, o.order_date, o.promised_delivery_time, o.actual_delivery_time,
    o.delivery_status, o.order_total, o.payment_method, o.delivery_partner_id, o.store_id,

    -- Order Items table
    oi.product_id, oi.quantity, oi.unit_price, oi.total_price,

    -- Products table
    p.product_name, p.category, p.brand, p.price, p.mrp, p.margin_percentage,
    p.shelf_life_days, p.min_stock_level, p.max_stock_level,

    -- Delivery Performance table
    dp.promised_time, dp.actual_time, dp.delivery_time_minutes, dp.distance_km,
    dp.delivery_status AS dp_delivery_status, dp.reasons_if_delayed,

    -- Customer Feedback table
    cf.feedback_id, cf.rating, cf.feedback_text, cf.feedback_category, 
    cf.sentiment, cf.feedback_date,

    -- Rating Icon table
    ri.rating AS rating_icon, ri.emoji, ri.star,

    -- Category Icon table
    ci.category AS category_name, ci.img AS category_img

FROM 
    customers c, orders o, order_items oi, products p, delivery_performance dp, customer_feedback cf, rating_icon ri, 
	category_icon ci
WHERE 
    c.customer_id = o.customer_id
AND 
    o.order_id = oi.order_id
AND 
    oi.product_id = p.product_id
AND 
   o.order_id = dp.order_id 
AND 
   o.delivery_partner_id = dp.delivery_partner_id
AND 
    o.order_id = cf.order_id 
AND 
    c.customer_id = cf.customer_id
AND 
    cf.rating = ri.rating
AND
    p.category = ci.category;



-- Creating index
CREATE INDEX idx_customers_customer_id ON customers(customer_id);



-- Cleaned data
SELECT *
FROM blinkit_data;

SELECT *
FROM marketing_performance;

SELECT *
FROM inventory;


SELECT 
      i.product_id,
	  p.category,
	  p.product_name,
	  p.price,
	  i.date,
	  i.stock_received,
	  i.damaged_stock,
	  Round(p.price * i.stock_received, 2) order_price
FROM 
     inventory i,
	 products p
WHERE 
      i.product_id = p.product_id

