CREATE VIEW "blinkit_data" AS
SELECT 
    -- Customers table
    c.customer_id,c.area,c.registration_date, c.customer_segments, c.total_orders, c.average_order_value,

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
