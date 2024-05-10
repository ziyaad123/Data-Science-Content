-- DQL COMMANDS
-- 1) DQL stands for Data Query Language.

-- SELECT
-- Used to retrieve rows selected from one or more tables.
-- SELECT can be used in many ways
-- A) SELECT With DISTINCT Clause
-- The DISTINCT Clause after SELECT eliminates duplicate rows from the result set.
SELECT DISTINCT cname,addr FROM customer;

-- B) SELECT all columns(*)
SELECT * FROM orders;

-- C) SELECT by column name
SELECT oid FROM orders;

-- D) SELECT with LIKE(%)
-- Basically helps in searching using some syllables of the name
-- a) "Ra" anywhere
SELECT * FROM customer WHERE cname LIKE "%Ra%";

-- b) Begins With "Ra"
SELECT * FROM customer WHERE cname LIKE "Ra%";

-- a) Ends With "vi
SELECT * FROM customer WHERE cname LIKE "%vi";

-- E) SELECT with CASE or IF
-- a) CASE
SELECT cid,
	   cname,
       CASE WHEN cid > 102 THEN 'Pass' ELSE 'Fail' END AS 'Remark'
FROM customer;

-- b) IF
SELECT cid,
	   cname,
       IF(cid > 102, 'Pass', 'Fail')AS 'Remark'
FROM customer;

-- F) SELECT with a LIMIT Clause
SELECT * 
FROM customer
ORDER BY cid
LIMIT 2;

-- G) SELECT with WHERE
SELECT * FROM customer WHERE cname = "Ravi";



-- ------------------------------------------QUESTIONS-------------------------------------------------------------
/*
1) Write a query to retrieve the distinct locations of products from the products table.
2) Write a query to retrieve the customer ID, customer name, and the length of their address
   as address_length from the customer table.
3) Write a query to retrieve the order ID, customer name, product name, and the concatenated
   string 'Order for [product name] by [customer name]' as order_description from the orders, customer,
   and products tables.
4) Write a query to retrieve the product ID, product name, price, and a new column price_category that categorizes
   the products based on their price range (e.g., 'Low' for prices less than 10000, 'Medium' for prices between 10000
   and 50000, and 'High' for prices greater than 50000).
5) Write a query to retrieve the customer ID, customer name, and the total order amount for each customer.
   The total order amount should be retrieved from a subquery that calculates the sum of order amounts for each
   customer.
*/

-- --------------------------------------------ANSWERS-----------------------------------------------------------
-- 1)
SELECT DISTINCT location 
FROM products;

-- 2)
SELECT cid, cname, LENGTH(addr) AS address_length
FROM customer;

-- 3)
SELECT o.oid, c.cname, p.pname, CONCAT('Order for ', p.pname, ' by ', c.cname) AS order_description
FROM orders o
JOIN customer c ON o.cid = c.cid
JOIN products p ON o.pid = p.pid;

-- 4)
SELECT pid, pname, price,
       CASE
           WHEN price < 10000 THEN 'Low'
           WHEN price BETWEEN 10000 AND 50000 THEN 'Medium'
           ELSE 'High'
       END AS price_category
FROM products;

-- 5)
SELECT c.cid, c.cname, (
    SELECT SUM(amt)
    FROM orders o
    WHERE o.cid = c.cid
) AS total_order_amount
FROM customer c;
