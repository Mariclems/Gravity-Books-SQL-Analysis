-- 1.Which language should we stock more books in?
SELECT bl.language_name, COUNT(*) AS number_of_books_sold
FROM book b
JOIN order_line ol ON b.book_id = ol.book_id
JOIN book_language bl ON b.language_id = bl.language_id
GROUP BY bl.language_name
ORDER BY number_of_books_sold DESC
LIMIT 1;

