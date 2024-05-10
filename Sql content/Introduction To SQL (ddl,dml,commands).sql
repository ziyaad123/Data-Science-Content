/* 
DATATYPES 
 NUMERIC DATA TYPE 
1) INT(size)
2) BIGINT(size)
3) FLOAT(size , d) here d is no.of digits after the decimal points.
4) DOUBLE
5) DECIMAL

 DATE AND TIME DATATYPE
1) DATE: FORMAT : YYYY-MM-DD
2) DATETIME: FORMAT : YYYY-MM-DD hh:mm:ss
3) TIME :FORMAT : hh:mm:ss
4) YEAR : FORMAT : 1901 to 2155, and 0000.

 STRING DATATYPES
1) CHAR 
2) VARCHAR
3) TEXT
 */
 
 -- Create database
create database amazon;

use amazon;

-- Products - pid, pname, price, stock, location (Mumbai or Delhi)
create table products
(
	pid int(3) primary key,
    pname varchar(50) not null,
    price int(10) not null,
    stock int(5),
    location varchar(30) check(location in ('Mumbai','Delhi'))
);

-- Customer - cid, cname, age, addr
create table customer
(
	cid int(3) primary key,
    cname varchar(30) not null,
    age int(3),
    addr varchar(50)
);

-- Orders - oid, cid, pid, amt
create table orders
(
	oid int(3) primary key,
    cid int(3),
    pid int(3),
    amt int(10) not null,
    foreign key(cid) references customer(cid),
    foreign key(pid) references products(pid)
);


-- Payment - pay_id, oid,amount, mode(upi, cerdit, debit), status
create table payment
(
	pay_id int(3) primary key,
    oid int(3),
    amount int(10) not null,
    mode varchar(30) check(mode in('upi','credit','debit')),
    status varchar(30),
    foreign key(oid) references orders(oid)
);


-- to delete table we use drop 
drop table products ;

-- to drop whole database we use command
drop database amazon;

-- from alter command we can add and modify the tables 
-- to add column in a table 
alter table customer
add phone varchar(10);

-- to delete a column 
alter table customer
drop column phone;

-- to rename column 
alter table orders
rename column amt to amount ;

-- to modify datatype or add conditions
alter table products
modify column price varchar(10) ;

alter table products
modify column location varchar(30) check(location in ('Mumbai','Delhi' , 'chennai')) ;

-- TURNCATE
-- The TRUNCATE TABLE command deletes the data inside a table, but not the table itself.
truncate table products ;

/*
CONSTRAINTS
NOT NULL - Ensures that a column cannot have a NULL value
UNIQUE - Ensures that all values in a column are different
PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
FOREIGN KEY - Prevents actions that would destroy links between tables
CHECK - Ensures that the values in a column satisfies a specific condition
DEFAULT - Sets a default value for a column if no value is specified
*/

-- implementation
alter table customer
modify column age int(2) not null;

alter table customer
modify column phone varchar(10) unique ;

alter table payment
modify column status varchar(30) check( status in ('pending' , 'cancelled' , 'completed'));

alter table products
modify column location varchar(30) default 'Mumbai' check(location in ('Mumbai','Delhi' , 'chennai')) ;

/*
DML (Data Manipulation Language) commands  focus on adding, updating, and deleting data within database tables.

INSERT: Adds new rows to a table. 
UPDATE:  This command can update one or multiple rows at once.
DELETE: it can delete one or multiple rows depending on the conditions provided.
 */

-- implementation
#Inserting values into products table
insert into products values(1,'HP Laptop',50000,15,'Mumbai');
insert into products values(2,'Realme Mobile',20000,30,'Delhi');
insert into products values(3,'Boat earpods',3000,50,'Delhi');
insert into products values(4,'Levono Laptop',40000,15,'Mumbai');
insert into products values(5,'Charger',1000,0,'Mumbai');
insert into products values(6, 'Mac Book', 78000, 6, 'Delhi');
insert into products values(7, 'JBL speaker', 6000, 2, 'Delhi');

#Inserting values into customer table
insert into customer (cid, cname, age, addr) values
(101,'Ravi',30,'fdslfjl'),
(102,'Rahul',25,'fdslfjl'),
(103,'Simran',32,'fdslfjl'),
(104,'Purvesh',28,'fdslfjl'),
(105,'Sanjana',22,'fdslfjl');

#Inserting values into orders table
insert into orders values(10001,102,3,2700);
insert into orders values(10002,104,2,18000);
insert into orders values(10003,105,5,900);
insert into orders values(10004,101,1,46000);


#inserting values into payments table
insert into payment values(1,10001,2700,'upi','completed');
insert into payment values(2,10002,18000,'credit','completed');
insert into payment values(3,10003,900,'debit','in process');

update product
set locaiton = 'chennai'
where pname = 'Mac Book' ;

delete from customer
where cname = 'Ravi';




/* 
QUESTIONS
-- 0)Make a new table employee with specified column id, name, position and salary.
-- 1)insert query adds a new row to the employees table with specific values for id, name, position, and salary.
-- 2)update query updates the salary of the employee with id = 1.
-- 3)delete query deletes the row from employees where id = 1.
-- 4)create a query that creates a table called students.
-- 5)create another table courses and set up a foreign key constraint in the students table.
	The foreign key constraint ensures that the course_id in students must refer to a valid course_id in the courses table.
-- 6)Alter the students table to add the foreign key constraint.
-- 7)insert some data into the students table while respecting the constraints.
-- 8)create a SELECT query that retrieves products based on numeric and date conditions.
-- 9)update a record and set the last_updated column to the current datetime.
-- 10)delete products with stock below a certain threshold.
*/







--  insert  query adds a new row to the employees table with specific values for id, name, position, and salary.
INSERT INTO employees (id, name, position, salary)
VALUES (1, 'John Doe', 'Software Engineer', 75000);

-- update query updates the salary of the employee with id = 1.
UPDATE employees
SET salary = 80000
WHERE id = 1;

-- delete query deletes the row from employees where id = 1.
DELETE FROM employees
WHERE id = 1;

--  create a query that creates a table called students with various constraints.
CREATE TABLE students (
  student_id INT PRIMARY KEY,       
  name VARCHAR(100) NOT NULL,        
  email VARCHAR(100) UNIQUE,       
  age INT CHECK (age >= 18),        
  course_id INT,                    
  grade CHAR(1) DEFAULT 'F'          
);

-- create another table courses and set up a foreign key constraint in the students table. 
-- The foreign key constraint ensures that the course_id in students must refer to a valid course_id in the courses table.
CREATE TABLE courses (
  course_id INT PRIMARY KEY,          
  course_name VARCHAR(100) NOT NULL   
);

-- Alter the students table to add the foreign key constraint
ALTER TABLE students
ADD CONSTRAINT fk_course
FOREIGN KEY (course_id)
REFERENCES courses (course_id)
ON DELETE CASCADE;  -- If a course is deleted, all related students are also deleted

--  insert some data into the students table while respecting the constraints.

INSERT INTO students (student_id, name, email, age, course_id, grade)
VALUES (1, 'Alice Johnson', 'alice@example.com', 21, 101, 'A');  

-- This will fail because 'student_id' is not unique
INSERT INTO students (student_id, name, email, age, course_id, grade)
VALUES (1, 'Bob Smith', 'bob@example.com', 22, 102, 'B');  

-- This will also fail because 'name' has a NOT NULL constraint
INSERT INTO students (student_id, email, age, course_id, grade)
VALUES (3, 'charlie@example.com', 19, 103, 'B'); 

-- This will fail because 'age' doesn't meet the CHECK constraint
INSERT INTO students (student_id, name, email, age, course_id, grade)
VALUES (4, 'David Brown', 'david@example.com', 16, 104, 'C');  

--  create a SELECT query that retrieves products based on numeric and date conditions.
-- Retrieve products with a price greater than 100 and released after January 1, 2022
SELECT * 
FROM products 
WHERE price > 100 AND release_date > '2022-01-01';

--   update a record and set the last_updated column to the current datetime.
-- Update product details and set the last_updated to the current timestamp
UPDATE products
SET price = 1100.00, last_updated = NOW()  
WHERE product_id = 1;

-- delete products with stock below a certain threshold.
-- Delete products with stock below 100
DELETE FROM products 
WHERE stock < 100;






