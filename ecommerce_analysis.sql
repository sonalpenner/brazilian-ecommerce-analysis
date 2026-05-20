-- ================================================
-- Brazilian Ecommerce Sales Performance Analysis
-- Author: Sonal Penner
-- Database: PostgreSQL
-- ================================================


-- Query 1: Which customers have the highest lifetime value -- candidates for a loyalty program launch?
-- Finding: Top 100 customers by lifetime value are predominantly one-time buyers, suggesting limited organic retention.
--		 	Total spend ranges from $13,664 to $2,430, indicating a long tail of high-value single transactions rather than repeat loyalty.


SELECT
	customers.customer_unique_id, 
	SUM(order_payments.payment_value) AS total_spend, 
	COUNT(orders.customer_id) AS total_orders, 
	ROUND((SUM(order_payments.payment_value) / COUNT(orders.customer_id)),2) AS average_spend
FROM orders
	JOIN order_payments 
		ON orders.order_id = order_payments.order_id
	JOIN customers 
		ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_unique_id
ORDER BY SUM(order_payments.payment_value) DESC, COUNT(orders.customer_id) DESC
LIMIT 100


-- Query 2: How does seller performance compare across revenue, order volume, and review scores?
-- Finding: Review scores and order volume show an inverse relationship among top sellers — high-volume sellers average lower scores, 
--			suggesting fulfillment quality may degrade at scale.
--			Several sellers with 300+ orders fall below a 3.5 average score.

SELECT 
	sellers.seller_id, 
	COUNT(order_items.order_id) AS order_volume, 
	ROUND(AVG(order_reviews.review_score), 2) AS avg_review_score, 
	SUM(price) AS total_revenue
FROM order_items
	JOIN sellers 
		ON sellers.seller_id = order_items.seller_id
	JOIN order_reviews 
		ON order_reviews.order_id =  order_items.order_id
GROUP BY sellers.seller_id
HAVING COUNT(order_items.order_id) >= 10
ORDER BY avg_review_score DESC

-- Query 3: Which product categories drive the most revenue?
-- Finding: The top three product categories -- health & beauty, watches & gifts, and bed & bath -- accounted for over $3 million dollars in revenue or about 25.76% of total revenue.

SELECT 
	product_category_name_translation.product_category_name_english AS product_category, 
	SUM(order_items.price) AS category_revenue_sum,
	ROUND((SUM(order_items.price) / (SELECT SUM(price) FROM order_items)) * 100, 2) AS pct_of_total
FROM order_items
	JOIN products 
		ON order_items.product_id = products.product_id
	JOIN product_category_name_translation
		ON products.product_category_name = product_category_name_translation.product_category_name
GROUP BY product_category
ORDER BY category_revenue_sum desc


-- Query 4: What does order volume and revenue trend look like over time?
-- Finding: Order volume and revenue in Q4 2016 were low. Order volume and revenue steadily grew from 913 in January 2017 to 8,475 in November 2017.
--			Order volume and revenue stayed steady throughout 2018.

SELECT 
	EXTRACT(MONTH FROM order_purchase_timestamp) AS purchase_month, 
	EXTRACT(YEAR FROM order_purchase_timestamp) AS purchase_year, 
	SUM(order_items.price) AS order_revenue, 
	COUNT(orders.order_id) AS order_volume
FROM orders
	JOIN order_items
		ON orders.order_id = order_items.order_id
WHERE orders.order_status = 'delivered'
GROUP BY purchase_year, purchase_month
ORDER BY purchase_year, purchase_month