-- 3. Who are the 10 best customers? 
-- Option 2 

SELECT c.customer_id, c.first_name, c.last_name, COUNT(*) as num_orders
FROM cust_order co
JOIN customer c ON co.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY num_orders DESC
LIMIT 10;

