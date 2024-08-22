# Gravity-Books-SQL-Analysis
SQL analysis for optimizing book stock and customer insights at Gravity Books


-- 1.Which language should we stock more books in?

## SQL Query Explanation

**Query explained:** This query joins information from the `book` table with the `order_line` table on the `book_id` column and then joins the resulting table with the `book_language` table on the `language_id` column. We grouped the results by `language_name`, and the number of books sold for each language is counted using the `COUNT(*)` function. We ordered the results in descending order by the number of books sold, and the `LIMIT` statement is used to limit the results to only one as the language that sells the most. The result is as follows:

## Results Explained

**Results explained:** The output shows the `language_name` from the `book_language` table as well as the count of books sold, described as `number_of_books_sold`, and returned that English has the highest numbers of books sold.


## Conclusion

**Conclusion:** The goal is to optimize sales while providing satisfaction to our customers. Since they all have different tastes, selling more books in either American or British English will fulfill both conditions.

--2.What author should we discontinue stocking?

## Query Explanation

This query retrieves information about authors who have sold exactly one book with `status_id` of 1 (which represents a status value of "order received") and sorts them in ascending order based on the date when the order with the `status_id` of 1 was completed. The query utilizes JOIN to link tables that share common key columns such as `order_id` and `book_id`. The WHERE clause specifies that only the orders with `status_id` of 1 should be considered. The GROUP BY clause groups the results by author name, and the HAVING clause ensures that only authors who sold one book are selected. The ORDER BY clause sorts the authors in ascending order based on the oldest date when the order was received. We limited the results to 1.


## Results Explained

The output above shows the `author_id` column, the `author_name`, and the `Status Status id` column from the order_line table, described as `order_received_on`. It returned the exact date and time when author Ingrid Christopherson had their last book sale.

## Insight

In our analysis, we explored different variables to ensure that we get the most accurate results. One of them was to find the author that sells the least. It was found that "no author made 0 sale" and "all authors made at least one sale", which complicates proceeding with the least sale theory. We then determined that since there are so many authors who sold only once, we could consider eliminating the author with the oldest sale, datetime-wise. Coincidentally, the output of the "oldest sale of authors that sold the least" also corresponds to the oldest status date.

## Conclusion

Even though author Ingrid Christopherson has been identified as the author with the oldest book sale, the database has multiple authors that are not selling very well and need further investigation.


--3. Who are the 10 best customers? 

We have thought about the many definitions we could attribute to “best customers” and came up with two possible options: 

Option 1:  The best customers are the customers that spent the most money.
## Explanation

This query joins the customer, cust_order, and order_line tables.We calculated the total amount spent by each customer using the SUM function and grouped the results by customer. Finally, the results are sorted in descending order based on the total amount spent and we limited the output to the top 10 customers. 

Option 2: The best customers are the most frequent buyers. 

## Explanation

This query uses the COUNT (*) function to count “the number of orders” for each customer. Then we joined the cust_order table with the customer table on the customer_id (foreign key) column and grouped the results by the customer_id, first_name, and last_name to identify the frequent buyers by their full name and ids. The results are ordered in descending order by the “number of orders”. Again, we limited the results to the top 10 customers

## Conclusion

After exploring both options, we have determined that the 10 best customers would be the frequent buyers because even though some customers spent a lot of money at once that doesn’t necessarily mean they would purchase again.We would want to focus on loyal customers because they would generate more money in the long run.

-- 4. Gravity Books is looking to add a warehouse to help optimize shipping. Where should they locate that warehouse?

## Query Explanation

to determine the country with the most orders, we selected the country_name column and used the count function to count the number of orders per country. We later joined the cust_order table with the customer address table, which connects customers to their addresses. Then we joined the address table with the country table to get the country associated with each address. The results were grouped by country, and finally the results were sorted in descending order and select the top country.

## Results Explained
The output shows the country_name column from the country table and the total count of order_id defined as count_of _orders. The variables characters and intergers inside the table shows that China is the country that has the largest size of orders. 


## Tables Description

### Order Status
- **status_id** (int, PK): Unique identifier for the status.
- **status_value** (varchar(20)): Description of the order status.

### Order History
- **history_id** (int, PK): Unique identifier for the history record.
- **order_id** (int, FK): Identifier for the order.
- **status_id** (int, FK): Status associated with the order history.
- **status_date** (datetime): Date and time the status was recorded.

### Order Line
- **line_id** (int, PK): Unique identifier for each order line.
- **order_id** (int, FK): Identifier linking to the order.
- **book_id** (int, FK): Identifier linking to the book.
- **price** (decimal): Price of the book at the time of the order.

### Author
- **author_id** (int, PK): Unique identifier for the author.
- **author_name** (varchar(400)): Full name of the author.

### Book Author
- **book_id** (int, FK, PK): Identifier linking to the book.
- **author_id** (int, FK, PK): Identifier linking to the author.

### Shipping Method
- **method_id** (int, PK): Unique identifier for the shipping method.
- **method_name** (varchar(100)): Name of the shipping method.
- **cost** (decimal): Cost of the shipping method.

### Order
- **order_id** (int, PK): Unique identifier for the order.
- **order_date** (datetime): Date the order was placed.
- **customer_id** (int, FK): Identifier linking to the customer.
- **shipping_method_id** (int, FK): Identifier for the shipping method used.
- **dest_address_id** (int, FK): Destination address identifier for the order.

### Customer
- **customer_id** (int, PK): Unique identifier for the customer.
- **first_name** (varchar(200)): First name of the customer.
- **last_name** (varchar(200)): Last name of the customer.
- **email** (varchar(350)): Email address of the customer.

### Address
- **address_id** (int, PK): Unique identifier for the address.
- **street_number** (varchar(10)): Street number of the address.
- **street_name** (varchar(200)): Street name.
- **city** (varchar(100)): City where the address is located.
- **country_id** (int, FK): Identifier linking to the country.

### Customer Address
- **customer_id** (int, FK, PK): Identifier linking to the customer.
- **address_id** (int, FK, PK): Identifier linking to the address.
- **status_id** (int, FK): Status associated with the customer address.

### Book Language
- **language_id** (int, PK): Unique identifier for the language.
- **language_code** (varchar(8)): Short code for the language.
- **language_name** (varchar(50)): Full name of the language.

### Book
- **book_id** (int, PK): Unique identifier for the book.
- **title** (varchar(400)): Title of the book.
- **isbn13** (varchar(13)): ISBN number of the book.
- **language_id** (int, FK): Identifier linking to the book language.
- **num_pages** (int): Number of pages in the book.
- **publication_date** (date): Publication date of the book.
- **publisher_id** (int, FK): Identifier linking to the publisher.

### Address Status
- **status_id** (int, PK): Unique identifier for the address status.
- **address_status** (varchar(30)): Description of the address status.

### Publisher
- **publisher_id** (int, PK): Unique identifier for the publisher.
- **publisher_name** (varchar(400)): Name of the publisher.

### Country
- **country_id** (int, PK): Unique identifier for the country.
- **country_name** (varchar(200)): Name of the country.

## Entity-Relationship Diagram (ERD)
Below is the ERD which visualizes the relationships between the various tables in the Gravity Books database:



