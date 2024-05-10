# String Functions
/* String functions in SQL are a set of built-in functions that allow you to manipulate and operate on string
 (character) data. These functions provide various operations such as concatenation, substring extraction,
 pattern matching, and string manipulation. */
-- A) CHAR_LENGTH(str): This function returns the length of the given string str in characters.
SELECT CHAR_LENGTH('Hello, World!');

-- B) ASCII(str): This function returns the ASCII code value of the leftmost character in the string str.
SELECT ASCII('A');
SELECT ASCII('abc');

-- C) CONCAT(str1, str2, ...): This function concatenates two or more string values together.
SELECT CONCAT('Hello', ' ', 'World');

-- D) INSTR(str, substr): This function returns the position of the first occurrence
--    of the substring substr in the string str.
SELECT INSTR('Hello, World!', 'o');
SELECT INSTR('Hello, World!', 'x');



-- E) LCASE(str) or LOWER(str): These functions convert the given string str to lowercase.
SELECT LCASE('HELLO');
SELECT LOWER('SupPorT'); 

-- F) UCASE(str) or UPPER(str): These functions convert the given string str to uppercase.
SELECT UCASE('hello');
SELECT UPPER('SupPorT');

-- G) SUBSTR(str, start, length): This function extracts a substring from the string str starting at the position
--    start and with a length of length characters.
SELECT SUBSTR('Hello, World!', 8, 5);
SELECT SUBSTR('Hello, World!', 1, 5);

-- H) LPAD(str, len, padstr): This function pads the string str on the left side with the padstr string
--    repeated as many times as necessary to make the total length equal to len.
SELECT LPAD('Hello', 10, '*');

-- I) RPAD(str, len, padstr): This function pads the string str on the right side with the padstr string
--    repeated as many times as necessary to make the total length equal to len.
SELECT RPAD('Hello', 10, '*');

-- J) TRIM(str), RTRIM(str), LTRIM(str): These functions remove leading and/or trailing spaces from the string str.
--    TRIM removes leading and trailing spaces, RTRIM removes trailing spaces, and LTRIM removes leading spaces.
SELECT TRIM('   Hello, World!   ');
SELECT RTRIM('   Hello, World!   ');
SELECT LTRIM('   Hello, World!   ');

# Date and Time Functions
/* Date and time functions in SQL are a set of built-in functions that allow you to manipulate and perform
 operations on date and time data types. These functions help you extract components from date and time values,
 perform calculations, and format date and time information. */

-- A) CURRENT_DATE(): This function returns the current date in the format 'YYYY-MM-DD'.
SELECT CURRENT_DATE() AS today;
-- Output: 2023-05-01 (if the current date is May 1, 2023)

-- B) DATEDIFF(date1, date2): This function returns the number of days between two date values. 
-- The result can be positive or negative, depending on whether date1 is greater or less than date2.
SELECT DATEDIFF('2023-05-10', '2023-05-01') AS day_difference;
-- Output: 9

-- C) DATE(expression): This function extracts the date part from a date or datetime expression.
SELECT DATE('2023-05-01 12:34:56') AS result;
-- Output: 2023-05-01

-- D) CURRENT_TIME(): This function returns the current time in the format 'HH:MM:SS'.
SELECT CURRENT_TIME() AS now;
-- Output: 15:30:45 (if the current time is 3:30:45 PM)

-- E) LAST_DAY(date): This function returns the last day of the month for a given date.
SELECT LAST_DAY('2023-05-01') AS last_day_of_may;
-- Output: 2023-05-31

-- F) SYSDATE(): This function returns the current date and time as a value in the format 'YYYY-MM-DD HH:MM:SS'.
SELECT SYSDATE() AS `Timestamp`;
-- Output: 2023-05-01 15:45:23 (if the current date and time is May 1, 2023, 3:45:23 PM)

-- G) ADDDATE(date, interval): This function adds a time interval to a date value and returns the new date.
SELECT ADDDATE('2023-05-01', INTERVAL 7 DAY) AS one_week_later;
-- Output: 2023-05-08

# Numeric Functions
/* Numeric functions in SQL are a set of built-in functions that allow you to perform various mathematical
 operations and calculations on numeric data types, such as integers, floating-point numbers, and decimal values.
 These functions help you manipulate and analyze numerical data in your database tables. */
 
-- A) AVG(expression): This function returns the average value of the non-null values in a group.
--    It's commonly used with the GROUP BY clause.
SELECT AVG(price) AS avg_price
FROM products;

-- B) COUNT(expression): This function returns the number of non-null values in a group.
--    It can be used with or without the GROUP BY clause.
SELECT COUNT(*) AS total_products
FROM products;

-- C) POW(base, exponent): This function returns the value of base raised to the power of exponent.
SELECT POW(2, 3) AS result;
-- Output: 8

-- D) MIN(expression): This function returns the minimum value in a group. It's often used with the GROUP BY clause.
SELECT MIN(price) AS min_price
FROM products;

-- E) MAX(expression): This function returns the maximum value in a group. It's often used with the GROUP BY clause.
SELECT MAX(stock) AS max_stock, location
FROM products
GROUP BY location;

-- F) ROUND(number, [decimals]): This function rounds a number to a specified number of decimal places. 
--    If decimals is omitted, it rounds to the nearest integer.
SELECT ROUND(3.1416, 2) AS result; -- Output: 3.14
SELECT ROUND(3.1416) AS result; -- Output: 3

-- G) SQRT(number): This function returns the square root of a non-negative number.
SELECT SQRT(25) AS result; -- Output: 5

-- H) FLOOR(number): This function returns the largest integer value that is less than or equal to the given number.
SELECT FLOOR(3.8) AS result; -- Output: 3
SELECT FLOOR(-3.8) AS result; -- Output: -4


# QUESTIONS TO PRACTICE
/* String Functions:

1) What is the purpose of the CONCAT() function in SQL? Give an example of how to use it.
2) Explain the difference between LCASE() and LOWER() functions. Which one would you prefer to use and why?
3) How would you extract a substring from the 5th position to the 10th position (inclusive) from the string "Hello, World!"?
4) What is the purpose of the LPAD() and RPAD() functions? Provide an example of how to use them.
5) Write a SQL query to trim both leading and trailing spaces from the string ' Hello, World! '.

Date and Time Functions:

1) What is the difference between CURRENT_DATE() and SYSDATE() functions?
2) How would you calculate the number of days between two dates, say '2023-06-15' and '2023-07-20'?
3) Explain the purpose of the LAST_DAY() function with an example.
4) Write a SQL query to add 3 months to the current date.
5) How would you extract the time component (hours, minutes, seconds) from a datetime value?

Numeric Functions:

1) What is the difference between AVG() and COUNT() functions? When would you use each of them?
2) Write a SQL query to calculate the square root of 144.
3) How would you round the number 3.14159 to two decimal places?
4) Explain the purpose of the MIN() and MAX() functions. Give an example of how to use them with the GROUP BY clause.
5) Write a SQL query to calculate the power of 2 raised to the 5th power. */


# ANSWERS
/*
String Functions:

1) The CONCAT() function is used to concatenate (combine) two or more string values.
   Example: SELECT CONCAT('Hello', ' ', 'World'); will output "Hello World".
2) Both LCASE() and LOWER() convert a string to lowercase letters. LOWER() is the standard SQL function,
   while LCASE() is a MySQL-specific alias. It's generally recommended to use LOWER() for better portability
   across different databases.
3) To extract a substring from the 5th position to the 10th position (inclusive) from "Hello, World!",
   you can use the SUBSTR() function: SELECT SUBSTR('Hello, World!', 5, 6); This will output "o, Wor".
4) The LPAD() function pads a string with a specified string on the left side to make it a certain length.
   RPAD() does the same but on the right side. Example: SELECT LPAD('Hello', 10, '*'); will output "*****Hello".
5) To trim both leading and trailing spaces from ' Hello, World! ', you can use the TRIM() function:
   SELECT TRIM(' Hello, World! '); This will output "Hello, World!".

Date and Time Functions:

1) CURRENT_DATE() returns the current date, while SYSDATE() returns the current date and time.
2) To calculate the number of days between '2023-06-15' and '2023-07-20', you can use the DATEDIFF() function:
   SELECT DATEDIFF('2023-07-20', '2023-06-15'); This will output 35.
3) The LAST_DAY() function returns the last day of the month for a given date.
   Example: SELECT LAST_DAY('2023-05-01'); will output "2023-05-31".
4) To add 3 months to the current date, you can use the ADDDATE() or DATE_ADD() function:
   SELECT ADDDATE(CURRENT_DATE(), INTERVAL 3 MONTH);
5) To extract the time component from a datetime value, you can use the TIME() function:
   SELECT TIME('2023-05-01 12:34:56'); This will output "12:34:56".

Numeric Functions:

1) AVG() calculates the average value of a set of values, while COUNT() returns the number of rows/values.
   AVG() is used to find the mean, and COUNT() is used to count the number of rows or non-null values.
2) To calculate the square root of 144, you can use the SQRT() function: SELECT SQRT(144); This will output 12.
3) To round the number 3.14159 to two decimal places, you can use the ROUND() function:
   SELECT ROUND(3.14159, 2); This will output 3.14.
4) The MIN() function returns the minimum value, and the MAX() function returns the maximum value in a group
   of values. Example with GROUP BY:
   SELECT MIN(price) AS min_price, MAX(price) AS max_price, category FROM products GROUP BY category;
5) To calculate the power of 2 raised to the 5th power, you can use the POW() function:
   SELECT POW(2, 5); This will output 32.
*/