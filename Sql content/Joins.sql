#JOINS
#-> As the word suggests, Joins are used to combine two or more tables to get specific data/information
#-> Join is mainly of 6 types:
#1. Inner Join
#2. Left Outer Join
#3. Right Outer Join
#4. Full Outer Join
#5. Self Join
#6. Cross Join

-- Creating database
create database amazon;

#using databse
use amazon;

-- Creating table Products - pid, pname, price, stock, location (Mumbai or Delhi)
create table products
(
	pid int(3) primary key,
    pname varchar(50) not null,
    price int(10) not null,
    stock int(5),
    location varchar(30) check(location in ('Mumbai','Delhi'))
);

-- Creating table Customer - cid, cname, age, addr
create table customer
(
	cid int(3) primary key,
    cname varchar(30) not null,
    age int(3),
    addr varchar(50)
);

-- Creating table Orders - oid, cid, pid, amt
create table orders
(
	oid int(3) primary key,
    cid int(3),
    pid int(3),
    amt int(10) not null,
    foreign key(cid) references customer(cid),
    foreign key(pid) references products(pid)
);


-- Creating table Payment - pay_id, oid,amount, mode(upi, cerdit, debit), status
create table payment
(
	pay_id int(3) primary key,
    oid int(3),
    amount int(10) not null,
    mode varchar(30) check(mode in('upi','credit','debit')),
    status varchar(30),
    foreign key(oid) references orders(oid)
);

#Creating table employee - eid, ename, phone_no., department, manager_id
CREATE TABLE employee(
eid INT(4) PRIMARY KEY,
ename VARCHAR(40) NOT NULL,
phone_no INT(10) NOT NULL,
department VARCHAR(40) NOT NULL,
manager_id INT(4)
);

#Inserting values into products table
insert into products values(1,'HP Laptop',50000,15,'Mumbai');
insert into products values(2,'Realme Mobile',20000,30,'Delhi');
insert into products values(3,'Boat earpods',3000,50,'Delhi');
insert into products values(4,'Levono Laptop',40000,15,'Mumbai');
insert into products values(5,'Charger',1000,0,'Mumbai');
insert into products values(6, 'Mac Book', 78000, 6, 'Delhi');
insert into products values(7, 'JBL speaker', 6000, 2, 'Delhi');

#Inserting values into customer table
insert into customer values(101,'Ravi',30,'fdslfjl');
insert into customer values(102,'Rahul',25,'fdslfjl');
insert into customer values(103,'Simran',32,'fdslfjl');
insert into customer values(104,'Purvesh',28,'fdslfjl');
insert into customer values(105,'Sanjana',22,'fdslfjl');

#Inserting values into orders table
insert into orders values(10001,102,3,2700);
insert into orders values(10002,104,2,18000);
insert into orders values(10003,105,5,900);
insert into orders values(10004,101,1,46000);


#inserting values into payments table
insert into payment values(1,10001,2700,'upi','completed');
insert into payment values(2,10002,18000,'credit','completed');
insert into payment values(3,10003,900,'debit','in process');

#Inserting into employee table
INSERT INTO employee VALUES (401, "Rohan", 364832549, "Analysis", 404);
INSERT INTO employee VALUES (402, "Rahul", 782654123, "Delivery", 406);
INSERT INTO employee VALUES (403, "Shyam", 856471235, "Delivery", 402);
INSERT INTO employee VALUES (404, "Neha", 724863287, "Sales", 402);
INSERT INTO employee VALUES (405, "Sanjana", 125478954, "HR", 404);
INSERT INTO employee VALUES (406, "Sanjay", 956478535, "Tech",null);

#displaying details of products table
SELECT * FROM products;

#displaying details of customer table
SELECT * FROM customer;

#displaying details of orders table
SELECT * FROM orders;

#displaying details of payment table
SELECT * FROM payment;

#Displaying details of employee table
SELECT * FROM employee;

#1.Inner Join -> Matching values from both tables should be present
# for example: For getting the name of customers who placed the order, we need to inner join customer and orders table

SELECT customer.cid, cname, orders.oid FROM orders 
INNER JOIN customer ON orders.cid = customer.cid;

#example2: now getting the name of the customers and products that were ordered, we need to inner join orders, products and customer table

SELECT customer.cid, cname, products.pid, pname, oid FROM orders
INNER JOIN products ON orders.pid = products.pid
INNER JOIN customer ON orders.cid = customer.cid;


#2. Left Outer Join-> All the rows from the left table should be present and matching rows from the right table are present
#example: Getting the product id, product name, amount to be paid in an order, we need to left join products and orders table

SELECT products.pid, pname, amt, orders.oid FROM products
LEFT JOIN orders ON orders.pid = products.pid;

#3. Right Join-> All the rows from the right table should be present and only matching rows from the left table are present 
#example: Displaying order details in paymnets table, we need to right join payment and orders table
SELECT * FROM payment 
RIGHT JOIN orders ON orders.oid = payment.oid;
 

#4.Full Join-> All the rows from both the table should be present 
#Note:- MySQL does not support full join we need to perform "UNION" operation between the results obtained from left and right join
#example: Displaying the details of all the orders and products, we need to full join orders and products tables 

SELECT orders.oid, products.pid, pname, amt, price, stock, location FROM orders
LEFT JOIN products ON orders.pid = products.pid
UNION
SELECT orders.oid, products.pid, pname, amt, price, stock, location FROM orders
RIGHT JOIN products ON orders.pid = products.pid;
 

#5.Self Join-> It is a regular join, but the table is joined by itself
#example: Displaying the employees with managers, we need to self join the employee table 

SELECT e1.ename AS Employee, e2.ename AS Manager FROM employee e1
INNER JOIN employee e2 ON e1.manager_id = e2.eid;


#6.Cross Join-> It is used to view all the possible combinations of the rows of one table and with all the rows from second table
#example: Displaying all the details of customer and orders where amount is less than 3000, we need to cross join customer and orders table

SELECT customer.cid, cname, orders.oid, amt FROM customer
CROSS JOIN orders ON customer.cid = orders.cid
WHERE amt > 3000;

# ***************************************************** Practice Questions *******************************************

#q1. Display details of all orders which were delivered from "Mumbai"

SELECT * FROM orders 
LEFT JOIN products ON orders.pid = products.pid
WHERE location = "Mumbai";

#q2. Display details of all orders whose payment was made through "UPI"

SELECT * FROM orders
RIGHT JOIN payment ON orders.oid = payment.oid
WHERE mode = "UPI";

#q3. Dispaly oid, amt, cname, payment mode of orders which were made by people below 30 years

SELECT orders.oid, cname, amt, mode FROM orders
INNER JOIN payment ON orders.oid = payment.oid
INNER JOIN customer ON orders.cid = customer.cid
WHERE age < 30;

#q4. Dispaly oid, amt, cname, paymentmode of orders which were made by people below 30 years and payment was made through "Credit"

SELECT orders.oid, cname, amt, mode FROM orders
INNER JOIN payment ON orders.oid = payment.oid
INNER JOIN customer ON orders.cid = customer.cid
WHERE age < 30 AND mode = "Credit";

#q5. Display oid, amount, cname, pname, location of the orders whose payment is still pending or in process

SELECT orders.oid, cname, pname, amount, status, location FROM orders
CROSS JOIN products ON orders.pid = products.pid
CROSS JOIN customer ON orders.cid = customer.cid
CROSS JOIN payment ON orders.oid = payment.oid
WHERE status IN ("in process", "pending");

#q6. We have order table, want to also display details of product ordered and details of customer who placed the order

SELECT orders.cid, cname, pname FROM orders
INNER JOIN customer ON orders.cid = customer.cid
INNER JOIN products ON orders.pid = products.pid;
