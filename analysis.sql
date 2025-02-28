
 ------------------------- BLINKIT DATA ANAYSIS ------------------------------

 ------------------------- QUESTIONS --------------------------------

-- Q1.	Identify the top reasons customers leave bad reviews.

-- Q2.	Finds how many customers, despite negative customer service feedback, continued ordering.

-- Q3.	Finds customers who left after their first order due to delivery-related complaints.

-- Q4.	Compares ROAS across different marketing channels.

-- Q5.	Finds the top 10 most damaged products.

-- Q6.	Order trends for seasonal category of products like Cold Drinks & Juices by month.

-- Q7.	Compares average order values across product categories.

-- Q8.	Finds top 10 locations with the highest order volumes.

-- Q9.	Compares repeat order rates for customers who received deliveries on time vs delayed ones.

-- Q10.	Finds the number of negatives feedback related to the app experience.

-- Q11.	Analyzes whether negative feedback is increasing or decreasing over time.

-- Q12.	Identify customers who haven't placed an order in the last 90 days.

-- Q13.	Find out which customer segments are most dissatisfied based on sentiment analysis.

-- Q14.	Find out which customer segment brings the highest revenue

-- Q15.	Find the top-selling product categories.

-- Q16.	Measure customer satisfaction across different categories

-- Q17.	Measure inventory handling efficiency over time.


-------------------------------- DATA TO BE USED ---------------------------------------

SELECT *
FROM blinkit_data;

SELECT *
FROM marketing_performance;

SELECT *
FROM inventory;



 ------------------------- QUESTIONS -------------------------------- 

-- Q1.  Identify the top reasons customers leave bad reviews.

SELECT *
FROM blinkit_data;

-- Top reasons customers leave bad reviews.
SELECT 
	  feedback_category,
	  COUNT(sentiment) AS no_of_bad_reviews
FROM blinkit_data
WHERE sentiment = 'Negative'
GROUP BY feedback_category,sentiment
ORDER BY no_of_bad_reviews DESC;




-- Q2.	Finds how many customers, despite negative customer service feedback, continued ordering.

SELECT *
FROM blinkit_data;

--  Count of customers, with negative customer service feedback.
WITH lost_customer AS (
	
	SELECT 
	      customer_id,
		  feedback_category,
		  sentiment
	FROM blinkit_data
	GROUP BY customer_id,feedback_category,sentiment
)
SELECT 
      COUNT(customer_id) AS Total_lost_customers
FROM lost_customer
WHERE feedback_category IN ('Customer Service')
AND sentiment = 'Negative';	


--  Records of customers, despite negative customer service feedback, continued ordering.
SELECT 
	  customer_id
FROM blinkit_data
GROUP BY customer_id,feedback_category,sentiment 
HAVING COUNT(order_id) > 1 AND feedback_category = 'Customer Service' AND sentiment = 'Negative';


--  Count of customers, despite negative customer service feedback, continued ordering.
WITH lost_customer AS (
	
	SELECT 
	      customer_id,
		  feedback_category,
		  sentiment,
		  COUNT(order_id) AS orders
	FROM blinkit_data
	GROUP BY customer_id,feedback_category,sentiment
)
SELECT 
      COUNT(customer_id) AS Total_lost_customers
FROM lost_customer
WHERE orders > 1
AND feedback_category IN ('Customer Service')
AND sentiment = 'Negative';	




-- Q3.	Finds customers who left after their first order due to delivery-related complaints.

SELECT *
FROM blinkit_data;

--  Records of customers who left after their first order due to delivery-related complaints.
SELECT 
	  customer_id
FROM blinkit_data
GROUP BY customer_id,feedback_category,sentiment 
HAVING COUNT(order_id) = 1 AND feedback_category = 'Delivery' AND sentiment = 'Negative';

--  Count of customers placed only one order after using a first-time discount.
WITH lost_customer AS (
	
	SELECT 
	      customer_id,
		  COUNT(order_id) AS orders,
		  feedback_category,
		  sentiment
	FROM blinkit_data
	GROUP BY customer_id,feedback_category,sentiment
)
SELECT 
      COUNT(customer_id) AS Total_lost_customers
FROM lost_customer
WHERE orders = 1
AND feedback_category IN ('Delivery')
AND sentiment = 'Negative';	  


	  


-- Q4.	Compares ROAS across different marketing channels.

SELECT *
FROM marketing_performance;

-- Types of channel
SELECT DISTINCT(channel)
FROM marketing_performance;

-- ROAS across different marketing channels.
SELECT 
      channel,
	  ROUND(AVG(roas),2) AS roas
FROM marketing_performance
GROUP BY channel
ORDER BY roas DESC;




-- Q5.	Finds the top 10 most damaged products.

SELECT *
FROM inventory;

SELECT *
FROM blinkit_data;


-- Top 10 most damaged products.
SELECT
      i.product_id,
      bd.product_name,
	  SUM(i.damaged_stock) AS damaged_stocks_volume
FROM inventory AS i
JOIN blinkit_data AS bd
ON i.product_id = bd.product_id
GROUP BY i.product_id,bd.product_name
ORDER BY damaged_stocks_volume DESC
LIMIT 10;




-- Q6.	Shows order trends for seasonal category of products like Cold Drinks & Juices by month.

SELECT *
FROM blinkit_data;

-- Types of category
SELECT DISTINCT(category)
FROM blinkit_data;

-- Order trends for seasonal category of products like Cold Drinks & Juices by month.
SELECT 
      TO_CHAR(order_date,'Month') AS month,
	  COUNT(order_id) AS orders
FROM blinkit_data
WHERE category = 'Cold Drinks & Juices'
GROUP BY month, category
ORDER BY orders DESC;





-- Q7.	Compares average order values across product categories.

SELECT *
FROM blinkit_data;

-- Types of category
SELECT DISTINCT(category)
FROM blinkit_data;

-- Average order values across product categories.
SELECT 
      category, 
	  ROUND(AVG(average_order_value),2) AS avg_order_value
FROM blinkit_data
GROUP BY category
ORDER BY avg_order_value DESC;






-- Q8.	Finds top 10 locations with the highest order volumes.

SELECT *
FROM blinkit_data;

-- Top 10 locations with the highest order volumes.
SELECT 
      area,
	  COUNT(order_id) AS order_volume
FROM blinkit_data
GROUP BY area
ORDER BY order_volume DESC
LIMIT 10;




-- Q9. Compares repeat order rates for customers who received deliveries on time vs delayed ones.

SELECT *
FROM blinkit_data;

-- Types of delivery_status
SELECT DISTINCT(dp_delivery_status)
FROM blinkit_data;


-- Repeat order rates for customers who received deliveries on time vs delayed ones.
SELECT 
      dp_delivery_status, 
      COUNT(DISTINCT CASE WHEN total_orders > 1 THEN customer_id END) AS repeat_customers,
      COUNT(DISTINCT customer_id) AS total_customers,
      ROUND((COUNT(DISTINCT CASE WHEN total_orders > 1 THEN customer_id END) * 100.0 / COUNT(DISTINCT customer_id)),2) 
	  AS repeat_order_rate
FROM blinkit_data
GROUP BY dp_delivery_status
ORDER BY repeat_order_rate DESC;




-- Q10.	Finds the number of negatives feedback related to the app experience.

SELECT *
FROM blinkit_data;

-- Number of negatives feedback.
SELECT 
      COUNT(*) AS total_negative_feedbacks
FROM blinkit_data
WHERE sentiment = 'Negative';


-- Number of negatives feedback related to the app experience.
SELECT 
      COUNT(*) AS negative_app_experience
FROM blinkit_data
WHERE feedback_category = 'App Experience' AND sentiment = 'Negative';




-- Q11.	Analyzes whether negative feedback is increasing or decreasing over time.

SELECT *
FROM blinkit_data;

-- Negative feedback over time.
SELECT 
       TO_CHAR(feedback_date,'MonYY') AS month,
	  COUNT(sentiment) AS negative_feedback_count
FROM blinkit_data
WHERE sentiment = 'Negative'
GROUP BY month
ORDER BY month,negative_feedback_count DESC;




-- Q12.	Identify customers who haven't placed an order in the last 90 days.

SELECT *
FROM blinkit_data;

-- Customers who haven't placed an order in the last 90 days.
SELECT 
      customer_id
FROM blinkit_data
GROUP BY customer_id
HAVING MAX(order_date) < DATE '2024-12-31' - INTERVAL '90 days';

-- Count of customers who haven't placed an order in the last 90 days.
SELECT 
      COUNT(customer_id) AS inactive_customers_count
FROM (
    SELECT customer_id, MAX(order_date) AS last_order_date
    FROM blinkit_data
    GROUP BY customer_id
    HAVING MAX(order_date) <DATE '2024-12-31' - INTERVAL '90 days'
) AS inactive_customers;

---- As we have data till 2024 we choose the current date as DATE '2024-12-31'




-- Q13.	Find out which customer segments are most dissatisfied based on sentiment analysis.

SELECT *
FROM blinkit_data;

-- Types of sentiment
SELECT DISTINCT(sentiment)
FROM blinkit_data;

-- Types of segments
SELECT DISTINCT(customer_segments)
FROM blinkit_data;

-- Customer segments that are most dissatisfied based on sentiment analysis.
SELECT 
      customer_segments,
	  COUNT(sentiment) AS negative_sentiment
FROM blinkit_data
WHERE sentiment = 'Negative'
GROUP BY customer_segments
ORDER BY negative_sentiment DESC;




-- Q14.	Find out which customer segment brings the highest revenue

SELECT *
FROM blinkit_data;

-- Types of segments
SELECT DISTINCT(customer_segments)
FROM blinkit_data;

-- Customer segment with the highest revenue
SELECT 
      customer_segments,
	  SUM(order_total) AS revenue
FROM blinkit_data
GROUP BY customer_segments
ORDER BY revenue DESC;

	  



-- Q15.	Find the top-selling product categories.

SELECT *
FROM blinkit_data;

-- Types of categories
SELECT DISTINCT(category)
FROM blinkit_data;

-- Top-selling product categories.
SELECT 
      category,
	  COUNT(order_id) AS orders
FROM blinkit_data
GROUP BY category
ORDER BY orders DESC;




-- Q16.	Measure average rating across different product categories

SELECT *
FROM blinkit_data;

-- Types of categories
SELECT DISTINCT(category)
FROM blinkit_data;


-- Average rating across different product categories
SELECT 
      category,
	  ROUND(AVG(rating_icon),2) AS avg_rating
FROM blinkit_data
GROUP BY category
ORDER BY  avg_rating DESC;




-- Q17.	Measure inventory handling efficiency over time.

SELECT *
FROM inventory;

-- Percentage of stock received damaged each month
SELECT 
      TO_CHAR(date,'MONTH') AS month,
	  (SUM(damaged_stock)*100) / SUM(stock_received)|| '%' AS damaged_percentage
FROM inventory
GROUP BY month, EXTRACT(MONTH FROM date)
ORDER BY EXTRACT(MONTH FROM date);


