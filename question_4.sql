SELECT c.country_name, COUNT(co.order_id) AS count_of_orders
FROM cust_order co
JOIN customer_address ca ON co.customer_id = ca.customer_id
JOIN address a ON ca.address_id = a.address_id
JOIN country c ON a.country_id = c.country_id
GROUP BY c.country_name
ORDER BY count_of_orders DESC
LIMIT 1;
