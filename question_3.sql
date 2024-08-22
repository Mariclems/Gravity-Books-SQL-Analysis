SELECT c.customer_id, c.first_name, c.last_name, SUM(ol.price) AS total_spent
FROM customer c
JOIN cust_order o ON c.customer_id = o.customer_id
JOIN order_line ol ON o.order_id = ol.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 10;
