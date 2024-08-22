--2.What author should we discontinue stocking?

SELECT a.author_id ,a.author_name, oh.status_date AS order_received_on 
FROM author a
JOIN book_author ba ON a.author_id = ba.author_id
JOIN book b ON ba.book_id = b.book_id
JOIN order_line ol ON b.book_id = ol.book_id
JOIN cust_order co ON ol.order_id = co.order_id
JOIN order_history oh ON co.order_id = oh.order_id 
WHERE oh.status_id = 1
GROUP BY a.author_name
HAVING COUNT(ol.book_id) = 1
ORDER BY MIN(oh.status_date)
LIMIT 1;

