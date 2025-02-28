
---------------- BLINKIT DATA ANALYSIS--------------------------

---------------- TABLE CREATION --------------------------------



---- TABLE 1 -----

CREATE TABLE customers(

	customer_id INT PRIMARY KEY,
	customer_name VARCHAR(100), 
	email VARCHAR(50),
	address VARCHAR(100),
	area VARCHAR(50),
	pincode INT,
	registration_date DATE,
	customer_segments VARCHAR(20),
	total_orders INT,
	average_order_value FLOAT

);



---- TABLE 2 -----

CREATE TABLE delivery_performance(

	order_id BIGINT,
	delivery_partner_id INT PRIMARY KEY,
	promised_time TIME,
	actual_time TIME,
	delivery_time_minutes INT,
	distance_km FLOAT,
	delivery_status VARCHAR(100),
	reasons_if_delayed VARCHAR(100)

);



---- TABLE 3 -----

CREATE TABLE rating_icon(

	rating INT PRIMARY KEY,
	emoji VARCHAR(200),
	star VARCHAR(10)

);



---- TABLE 4 -----

CREATE TABLE category_icon(

	category VARCHAR(100) PRIMARY KEY,
	img VARCHAR(200)

);



---- TABLE 5 -----

CREATE TABLE orders(

	order_id BIGINT PRIMARY KEY,
	customer_id INT,
	order_date DATE,
	promised_delivery_time TIME,
	actual_delivery_time TIME,
	delivery_status VARCHAR(100),
	order_total FLOAT,
	payment_method VARCHAR(50),
	delivery_partner_id INT,
	store_id BIGINT,
	FOREIGN KEY (delivery_partner_id) REFERENCES delivery_performance(delivery_partner_id),
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id)

);



---- TABLE 6 -----

CREATE TABLE customer_feedback(

	feedback_id INT PRIMARY KEY,
	order_id BIGINT,
	customer_id INT,
	rating INT,
	feedback_text VARCHAR(300),
	feedback_category VARCHAR(50),
	sentiment VARCHAR(30),
	feedback_date DATE,
    FOREIGN KEY (rating) REFERENCES rating_icon(rating),
	FOREIGN KEY (order_id) REFERENCES orders(order_id)
	
);



---- TABLE 7 -----

CREATE TABLE marketing_performance(

	campaign_id INT PRIMARY KEY,
	campaign_name VARCHAR(100),
	date DATE,
	target_audience VARCHAR(50),
	channel VARCHAR(50),
	impressions INT,
	clicks INT,
	conversions INT,
	spend FLOAT,
	revenue_generated FLOAT,
	roas FLOAT

);



---- TABLE 8 -----

CREATE TABLE products(

	product_id INT PRIMARY KEY,
	product_name VARCHAR(200),
	category VARCHAR(100),
	brand VARCHAR(100),
	price FLOAT,
	mrp FLOAT,
	margin_percentage INT,
	shelf_life_days INT,
	min_stock_level INT,
	max_stock_level INT,
    FOREIGN KEY (category) REFERENCES category_icon(category)
	
);



---- TABLE 9 -----

CREATE TABLE inventory(

	product_id INT,
	date DATE,
	stock_received INT,
	damaged_stock INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)

);



---- TABLE 10 -----

CREATE TABLE order_items(

	order_id BIGINT,
	product_id INT,
	quantity INT,
	unit_price FLOAT,
	total_price FLOAT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
	FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- Checking table

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
