-- ANOMLIES
 -- Anomalies are undesirable conditions in a relational database that can lead to data inconsistency, which can lead to data manipulation.
 -- Insertion Anomalies: Occur when you cannot insert valid data due to the structure of the table.
-- Deletion Anomalies: Occur when deleting a row also deletes unrelated data.
-- Update Anomalies: Occur when updating a value in one row requires changes in other rows to maintain consistency, potentially leading to errors.
 
-- Update anomaly
-- Imagine a situation where the price of the "HP Laptop" (ProductID: 1) needs to be updated from ₹50,000 to ₹52,000. Here's the potential update anomaly:

UPDATE Products
SET price = 52000
WHERE pid = 1;

-- The problem arises because the actual selling price of a product might be stored in the Orders table. 
-- If you have existing orders for the "HP Laptop" placed at the old price (₹50,000), these orders won't be automatically updated to reflect the new price (₹52,000). 
-- This inconsistency can lead to issues like incorrect revenue calculations or customer disputes.

-- DELETE ANOMALY
-- Imagine a situation where a specific product, the "Charger" (ProductID: 5), becomes discontinued and needs to be removed from the database. Here's how a delete anomaly could occur:

-- You delete the "Charger" record from the Products table:

DELETE FROM Products
WHERE pid = 5;



-- The problem arises if there are existing orders for the "Charger" in the Orders table. Deleting the product from Products would leave those orders referencing a non-existent product.

-- INSERTION ANOMALY

-- Imagine you want to create a new order for a customer (CustomerID: 106) who hasn't been added to the Customers table yet. Here's how an insertion anomaly could occur:


INSERT INTO Orders (OrderID, CustomerID, ProductID, Quantity)
VALUES (10005, 106, 2, 1);  -- Assuming ProductID 2 is 'Realme Mobile'

-- The insertion fails because the CustomerID (106) doesn't exist in the Customers table.

-- Candidate Keys
-- Candidate keys are attributes or combinations of attributes within a relation (table) that uniquely identify each tuple (row).
-- They are essential for maintaining data integrity and enforcing constraints within a database schema

-- Example:
-- pid (Product ID): Each product ID uniquely identifies a product.
-- It is a candidate key in the products table as it ensures the uniqueness of each product.
-- Also cid, oid and pid uniquely identifies a customer, order and payment respectively.
-- They all are candidate keys in their respective tables that ensures the uniqueness of the Customer, Order and Payment.

/*
PRIMARY KEY
-> It is a column or a set of columns that uniquely identifies each record in a table.
-> Eg: Registration number, Driver's license number, Aadhar number etc

Rules for defining the Primary Key
-> Uniqueness: Each value in a primary key must be unique
-> Null values: A primary key cannot contain null values
-> Number of primary keys: A table can only have one primary key
*/

-- Creation of a Primary Key
/*
Syntax for creating a Primary Key:

CREATE TABLE TABLE_NAME(
	COLUMN_NAME DATA_TYPE PRIMARY KEY,
    COLUMN_NAME DATA_TYPE NOT NULL);

*/
create table products
(
	pid int(3) primary key,
    pname varchar(50) not null,
    price int(10) not null,
    stock int(5),
    location varchar(30) check(location in ('Mumbai','Delhi'))
);

-- Adding Primary Key to an already existing table
/*
Syntax:
ALTER TABLE TABLE_NAME
ADD PRIMARY KEY (COLUMN_NAME);
*/
Alter table products
add primary key (pid);

-- Deleting Primary Key from a table
/*
Syntax:
ALTER TABLE TABLE_NAME
DROP PRIMARY KEY;
*/
Alter table products
drop primary key;

/*
FOREIGN KEY
-> It is a column or group of columns in a database that connects the data in one table to the data in another table.
-> It acts as a cross-reference between tables by referencing the primary key of another table, thereby establishing a link between them.

Need of Foreign Key in dbms:
-> Data Integrity: We need foreign keys as they help us making sure that data is consistent, complete, between both the tables and overall accuracy is maintained.
-> Establishing Relationships: The main requirement of foreign keys is the establishment of relationships between tables. It makes sure that data is linked across multiple tables and helps in storing and retrieving data.
-> Data Security: Foreign keys helps in improving the security of data by preventing unauthorized modifications or deletions of important data in the referenced table.
*/

-- Creating a foreign key
/* 
Syntax:
CREATE TABLE TABLE_NAME(
     COLUMN_NAME DATA_TYPE,
     COLUMN_NAME DATA_TYPE,
     FOREIGN KEY (COLUMN_NAME)
     REFERENCES REFERENCED_TABLE_NAME(REFERENCED_COLUMN_NAME));
*/
-- Establishing a connection between the Product table, Customer table and Orders table
create table orders
(
	oid int(3) primary key,
    cid int(3),
    pid int(3),
    amt int(10) not null,
    foreign key(cid) references customer(cid),
    foreign key(pid) references products(pid)
);

-- Adding Foreign key to an already existing table
/*
Syntax:
ALTER TABLE TABLE_NAME
ADD FOREIGN KEY (COLUMN_NAME)
REFERENCES REFERENCED_TABLE_NAME(REFERENCED_COLUMN_NAME));
*/
alter table orders 
add foreign key(pid) references products(pid);

-- Removing Foreign Key from a table
/*
Syntax:
ALTER TABLE TABLE_NAME DROP FOREIGN KEY CONSTRAINT_NAME;
*/
alter table products drop foreign key products_ibfk_1;

/*
NORMALISATION
Normalization is the process of minimizing redundancy from a relation or set of relations.
Redundancy in relation may cause insertion, deletion, and update anomalies. So, it helps to minimize the redundancy in relations. 
Normal forms are used to eliminate or reduce redundancy in database tables. 

Levels of Normalization
There are various levels of normalization. These are some of them: 
-> First Normal Form (1NF)
-> Second Normal Form (2NF)
-> Third Normal Form (3NF)
-> Boyce-Codd Normal Form (BCNF)

1NF - FIRST NORMAL FORM
It is a basic level of data organization in relational databases. It ensures a table structure that minimizes redundancy and improves data integrity.
A Table is in 1NF if:
-> There are only single valued attributes (atomic values)
-> No repeating groups


-- Here is an example of a table violating 1NF and how to fix it
/* BEFORE (VIOLATING 1NF):
	ORDER_ID		CUSTOMER_NAME		ITEMS		PRICE
	1001		    JOHN SMITH			SHIRT,HAT	$50
      
   AFTER (FOLLOWING 1NF):
	ORDER_ID		CUSTOMER_NAME		ITEMS		PRICE
    1001			JOHN SMITH			SHIRT		$25
    1001			JOHN SMITH			HAT			$25
    */
    
-- Example of a table following 1NF
create table products
(
	pid int(3) primary key,
    pname varchar(50) not null,
    price int(10) not null,
    stock int(5),
    location varchar(30) check(location in ('Mumbai','Delhi'))
);
/*This table adheres to 1NF by:
-> Having atomic values in each cell (single piece of data)
-> Not containing any repeating groups
*/

-- 2NF (Second Normal Form):

/* ->Table must be in 1NF.
-> All non-key attributes (columns) must depend on the entire primary key.
-> If a table has a composite primary key, each non-key attribute must depend on the entire composite key, not just on part of it.
-> If any non-key attribute depends on only a part of a composite key, it violates 2NF and should be moved to a separate table along with the part of the key it depends on.


-> Example Violating 2NF:

Imagine you want to capture additional information about the product purchased in an order, such as its color. Let's modify the Orders table to include a product_color attribute:

Before (Violating 2NF):

OrderID	CustomerID	ProductID	Amount	ProductColor (New Attribute)
10001	102				3		2700				Blue
10002	104				2		18000				Black
10003	105				5		900					White
10004	101				1		46000				Silver


Problem: The product_color attribute depends solely on the ProductID, not the entire primary key of Orders (assuming OrderID is the primary key). This creates a partial dependency.

Solution (Following 2NF):

Introduce a separate Order_Items table to link specific products with their corresponding orders and include product-specific details:

Orders table:

| OrderID (primary key) | CustomerID | ProductID (foreign key) | Amount |

Order_Items table:

| OrderItemID (primary key) | OrderID (foreign key) | ProductID (foreign key) | ProductColor |

Now, product_color relies on the complete primary key (combination of OrderID and ProductID) in the Order_Items table, satisfying 2NF.


3NF (Third Normal Form):

-> Table must be in 2NF.
-> No transitive dependencies should exist.
-> Every non-key attribute must depend on the primary key, and only the primary key.
-> If a non-key attribute depends on another non-key attribute, it should be moved to a separate table along with the attribute it depends on.
*/
-- Example Violating 3NF:

-- Let's consider adding a customer_city attribute to the Orders table:

-- Before (Violating 3NF):

/* OrderID	CustomerID	ProductID	Amount	CustomerCity (New Attribute)
10001			102			3		2700		Delhi
10002			104			2		18000		Mumbai
10003			105			5		900			Delhi
10004			101			1		46000		Mumbai

drive_spreadsheet
Export to Sheets
Problem: The customer_city attribute depends on the customer_id, not the entire primary key of Orders. This creates a transitive dependency. Even though customer_id is a foreign key, it's not the direct determinant of city information.

Solution (Following 3NF):

Leverage the existing relationship between Orders and Customer tables. There's no need to duplicate customer_city in the Orders table. Retrieve city information by joining Orders with Customer using the customer_id foreign key.

By understanding these concepts and potential violations, you can design a more efficient and normalized database schema for future data growth and modifications.


-- BCNF
-- Boyce-Codd Normal Form (BCNF) is a higher level of normalization than 3NF.
-- It eliminates some anomalies that can arise from non-trivial functional dependencies in 3NF relations.

-- Functional Dependency (FD):
-- A functional dependency exists when one attribute uniquely determines another attribute in a relation.

-- Non-Trivial Functional Dependency:
-- A functional dependency is non-trivial if the determining attribute is not a superkey.

-- Key and Superkey:
-- A superkey is a set of attributes that, taken collectively, uniquely identifies a tuple in a relation.
-- A key is a minimal superkey, meaning no proper subset of the key can uniquely identify a tuple.

--  Requirements for BCNF:
-- Every non-trivial functional dependency X → Y, X must be a superkey.
-- No non-trivial functional dependencies should exist between attributes that are not part of some candidate key.

-- Benefits:
-- BCNF ensures that the database is free from update anomalies, insertion anomalies, and deletion anomalies, thus maintaining data integrity.

-- Example: 
-- Funcional dependencies in order table:
-- oid → {cid, pid, amt} (oid uniquely determines cid, pid, and amt)
-- {cid, pid} → {oid, amt} (a combination of cid and pid uniquely determines oid and amt)
-- Candidate Keys: {oid}, {cid, pid}

-- Check for Violation:
-- From the functional dependency {cid, pid} → {oid, amt},
-- we can see that {cid, pid} is not a superkey because cid and pid are not individually unique.
-- Thus, the table violates BCNF.

-- Decomposition:
-- We need to decompose the table into two tables to remove the violation.
-- Table 1: order_info(oid, amt)
-- Table 2: order_details(oid, cid, pid)

-- order_info table
create table order_info
(
	oid int(3) primary key,
    amt int(10) not null,
    foreign key(oid) references orders(oid)
);

-- order_details table
create table order_details
(
	oid int(3),
    cid int(3),
    pid int(3),
    primary key(oid, cid, pid),
    foreign key(oid) references orders(oid),
    foreign key(cid) references customer(cid),
    foreign key(pid) references products(pid)
);
-- Since we have decomposed based on the functional dependency, the original functional dependencies are preserved.


-- QUESTIONS AND ANSWERS
-- ANOMALIES
-- What are potential data anomalies that could occur if the database is not normalized (specifically 1NF, 2NF, or 3NF)?
-- Answer:  Data anomalies are inconsistencies or redundancies that can arise in a non-normalized database. These anomalies can lead to data integrity issues, making it difficult to insert, update, or delete data accurately.

			Insertion Anomaly: Difficulty inserting complete data due to missing dependencies.
			Deletion Anomaly: Deleting data from one table can unintentionally affect data in another table.
			Updation Anomaly: Updating data in one table might require repetitive changes in other tables to maintain consistency.


-- 2. Candidate Keys and Primary Key:

Query: Write a query to display the product information and choose the most appropriate attribute(s) as the primary key for the Products table. Justify your choice.
-- ANSWER: 
SELECT pid, pname, price, stock, location
FROM Products;

-- 3. Foreign Keys:


Query: Write a query that joins the Orders and Customer tables using the foreign key relationship. This query should retrieve order details (order ID, customer name, product ID) for a specific customer (e.g., customer ID 102).
ANSWER: 

SELECT o.oid, c.cname, o.pid
FROM Orders o
INNER JOIN Customer c ON o.cid = c.cid
WHERE o.cid = 102;

4. Normalization Levels (1NF, 2NF, 3NF):

Question: Describe the key differences between 1NF, 2NF, and 3NF.

Answer:

Normalization
1NF - First Normal Form
-> Multivalued attr should not be present
-> Primary key is present in the table
-> Repeating groups
-> Duplicate rows should not be there

2NF - Second Normal Form
-> Should be in 1NF
-> No partial dependency - 
All non key attr should be completely dependent
on primary key 
3NF 
Table must be in 2NF.
-> No transitive dependencies should exist.
-> Every non-key attribute must depend on the primary key, and only the primary key.
-> If a non-key attribute depends on another non-key attribute, it should be moved to a separate table along with the attribute it depends on.


 Boyce-Codd Normal Form (BCNF):

Question: How does BCNF differ from 3NF? When is it typically used?

BCNF (Boyce-Codd Normal Form) is a higher level of normalization compared to 3NF. It addresses a specific type of redundancy that 3NF might not eliminate.

Key Differences:

Dependency Rule:

3NF: Eliminates transitive dependencies where a non-key attribute relies on another non-key attribute.
BCNF: Every determinant (attribute or set of attributes that determines another attribute) in a table must be a candidate key. This ensures there are no hidden dependencies beyond the primary key.
Strictness: BCNF is stricter than 3NF, requiring an additional condition for eliminating certain types of redundancies.

