/* Well here am gonna type all the sql codes that the course team me 
and for sure not all of them but the neccesry one in order to build a 
a good summary and good back up learing source ! */

--SQL SELECT Queries (Visually Explained) for Beginners | All Essential Clauses | #SQL Course 4
-- * for all but u can also specify a column like CostumerId
-- Order of exuct is gona be From first then Select !
SELECT *
FROM customers ;

SELECT 
CustomerId ,
FirstName
FROM customers ;

-- Order of exuct is gona be From first then Where then Select !
SELECT 
*
FROM customers
WHERE Score != 0 ;


SELECT *
FROM customers
WHERE Country = 'USA' ;


-- Order of exuct is gona be From first then Order By then Select !
SELECT *
FROM customers
ORDER BY Score DESC ;


-- Order of exuct is gona be From first then Order By then Select !
-- well in order by sorting it follows the order specifyed by developer so here it force to sort by country 
-- then by score and the second sort counties the sorting respecting the first sort !
SELECT *
FROM customers
ORDER BY Country DESC , Score DESC ;

--its clear here that group by and Select Both excute before order by  :
SELECT 
Country ,
SUM(Score) 
FROM customers
GROUP BY Country 
ORDER BY SUM(Score)  DESC

SELECT 
Country ,
SUM(Score) AS Total_Score ,
COUNT(CustomerID) AS Ncustomer
FROM customers
GROUP BY Country 
ORDER BY Total_Score DESC

SELECT 
Country ,
SUM(Score) AS Total_Score ,
COUNT(CustomerID) AS Ncustomer
FROM customers
WHERE Score != 0 --Before aggregation
GROUP BY Country 
HAVING SUM(Score) < 1000 --After aggregation
ORDER BY Total_Score DESC

--Dont use Distinct for no reason u have to be sure that u got dublicates !
--Distinct excute after Select Not Before it !
SELECT DISTINCT
Country ,
Score
FROM customers 

--Top excut after Distinct So its like : SELECT , DISTINCT , TOP
SELECT DISTINCT TOP 3
*
FROM customers 

/* here the execution gona be like : 
1- From
2- WHERE
3- GROUP BY
4- HAVING
5- SELECT
6- DISTINCT
7- ORDER BY
8- TOP
*/
SELECT DISTINCT TOP 3
Country ,
SUM(Score) AS Total_Score ,
COUNT(CustomerID) AS Ncustomer
FROM customers
WHERE Score != 0 --Before aggregation
GROUP BY Country 
HAVING SUM(Score) < 1000 --After aggregation
ORDER BY Total_Score DESC

-- SQL DDL Commands (Visually Explained) | CREATE, ALTER, DROP | #SQL Course 5 :

--create
CREATE TABLE persons (
 id INT ,
 firstName VARCHAR(15) ,
 phone VARCHAR(10) ,
 date Date
 CONSTRAINT id_person PRIMARY KEY (id) 
 )

 --alter
 -- .add :
 ALTER TABLE persons
 ADD  email VARCHAR(20) NOT NULL
 -- .drop
 ALTER TABLE persons 
 DROP COLUMN date
 
 SELECT * 
 FROM persons

 --DELETE :
 DROP TABLE persons

 
--SQL DML Commands (Visually Explained) | INSERT, UPDATE, DELETE | #SQL Course 6

--INSERT :

INSERT INTO customers (id ,first_name ,  country)
VALUES (8 , 'mai' , 'maroco'  )

-- insert data from table to another one 


INSERT INTO persons (id , firstName , phone , date)
SELECT 
id ,
country ,
'uknown' ,
NULL
FROM customers 

SELECT * FROM persons

--update :

UPDATE persons 
SET phone = '0555805003'
WHERE id = 6

UPDATE persons 
SET phone = 'unkown'

--delete :

DELETE FROM persons ;
TRUNCATE TABLE persons ; -- way better and faster !

DELETE FROM persons 
WHERE firstName = 'USA' ;

SELECT * FROM persons

--SQL WHERE Conditions (Visually Explained) | AND, OR, NOT, LIKE, BETWEEN, IN | #SQL Course 7

--1. Comparison Operators**
SELECT * FROM customers WHERE country = 'Germany';
SELECT * FROM customers WHERE country <> 'Germany';
SELECT * FROM customers WHERE score > 500;
SELECT * FROM customers WHERE score >= 500;
SELECT * FROM customers WHERE score < 500;
SELECT * FROM customers WHERE score <= 500;

--2. Logical Operators**
SELECT * FROM customers WHERE country = 'USA' AND score > 500;
SELECT * FROM customers WHERE country = 'USA' OR score > 500;
SELECT * FROM customers WHERE NOT (score < 500);

--3. Range & Membership Operators**
SELECT * FROM customers WHERE score BETWEEN 100 AND 500;
SELECT * FROM customers WHERE country IN ('Germany', 'USA');


--4. Pattern Search (LIKE)**
SELECT * FROM customers WHERE first_name LIKE 'M%';
SELECT * FROM customers WHERE first_name LIKE '%n';
SELECT * FROM customers WHERE first_name LIKE '%r%';
SELECT * FROM customers WHERE first_name LIKE '__r%';


--SQL Joins Basics (Visually Explained) | INNER, LEFT, RIGHT, FULL | #SQL Course 8

-- 1. No Join: Retrieving data from two tables separately
SELECT * FROM customers;
SELECT * FROM orders;

-- 2. INNER JOIN: Returns only rows with matches in both tables
SELECT c.id, c.first_name, o.order_id, o.sales
FROM customers AS c
INNER JOIN orders AS o ON c.id = o.customer_id;

-- 3. LEFT JOIN: Returns all rows from the left table (customers) 
-- and matching rows from the right table (orders). Nulls appear if no match.
SELECT c.id, c.first_name, o.order_id, o.sales
FROM customers AS c
LEFT JOIN orders AS o ON c.id = o.customer_id;

-- 4. RIGHT JOIN: Returns all rows from the right table (orders) 
-- and matching rows from the left table (customers).
SELECT c.id, c.first_name, o.order_id, o.sales
FROM customers AS c
RIGHT JOIN orders AS o ON c.id = o.customer_id;

-- 5. FULL JOIN: Returns all rows from both tables, with nulls for missing matches.
SELECT c.id, c.first_name, o.order_id, o.sales
FROM customers AS c
FULL JOIN orders AS o ON c.id = o.customer_id;

--Best Practice: The instructor notes that *LEFT JOIN* is generally preferred over *RIGHT JOIN* for readability and consistency; you can achieve the same result as a *RIGHT JOIN* simply by swapping the table order and using a *LEFT JOIN* 


--Advanced SQL Joins (Visually Explained) | ANTI, CROSS | #SQL Course 9

--1. LEFT ANTI JOIN (Returns customers without orders)

SELECT *
FROM customers AS C
LEFT JOIN orders AS O ON C.customer_id = O.customer_id
WHERE O.customer_id IS NULL;

--2. RIGHT ANTI JOIN (Returns orders without customers)

SELECT *
FROM customers AS C
RIGHT JOIN orders AS O ON C.customer_id = O.customer_id
WHERE C.customer_id IS NULL;

--3. ALTERNATIVE TO RIGHT ANTI JOIN (Using LEFT JOIN)

SELECT *
FROM orders AS O
LEFT JOIN customers AS C ON O.customer_id = C.customer_id
WHERE C.customer_id IS NULL;

--4. FULL ANTI JOIN (Returns non-matching rows from both sides)

SELECT *
FROM customers AS C
FULL JOIN orders AS O ON C.customer_id = O.customer_id
WHERE C.customer_id IS NULL OR O.customer_id IS NULL;

--5. ADVANCED INNER JOIN (Returns customers with orders, using LEFT JOIN and filter)

SELECT *
FROM customers AS C
LEFT JOIN orders AS O ON C.customer_id = O.customer_id
WHERE O.customer_id IS NOT NULL;

--6. CROSS JOIN (All possible combinations)

SELECT *
FROM customers
CROSS JOIN orders;

--SQL SET Operators (Visually Explained) | UNION, UNION ALL, EXCEPT, INTERSECT | #SQL Course 11

--1. PURPOSE:
   /*
   - Set operators  (UNION, UNION ALL, EXCEPT, INTERSECT) 
     combine ROWS from multiple queries.
   - Joins combine COLUMNS side-by-side.

--2. MANDATORY RULES:
   - Same number of columns in each query.
   - Data types must be compatible.
   - Same order of columns in each query.
   - The first query determines the column names/aliases.
   - ORDER BY is only allowed ONCE at the very end. 
   */

--3. THE OPERATORS:

   -- UNION: Combines all rows and REMOVES duplicates.
      SELECT FirstName, LastName FROM  Sales.Customers
      UNION
      SELECT FirstName, LastName FROM  Sales.Employees;

   -- UNION ALL: Combines all rows INCLUDING duplicates.
      -- Faster performance since no duplicate check occurs.
      SELECT FirstName, LastName FROM Sales.Customers
      UNION ALL
      SELECT FirstName, LastName FROM  Sales.Employees;

   -- EXCEPT (or MINUS): Returns distinct rows from Query 1 
      -- that are NOT in Query 2.
      SELECT FirstName, LastName FROM  Sales.Employees
      EXCEPT
      SELECT FirstName, LastName FROM  Sales.Customers;

   -- INTERSECT: Returns only rows common to both queries.
      SELECT FirstName, LastName FROM  Sales.Employees
      INTERSECT
      SELECT FirstName, LastName FROM  Sales.Customers;

/* 4. BEST PRACTICES:
   - Avoid using 'SELECT *'. Explicitly list columns to ensure
     the schema matches if tables change over time.
   - Use static columns to label source data (e.g., 
     'Source' as Table_Origin) to keep track of record origin.
*/

  SELECT
  'Order'AS sourceTable
  ,[OrderID]
  ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
  FROM  Sales.Orders
  UNION
  SELECT
  'OrderArchive' AS sourceTable
  ,[OrderID]
  ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
  FROM  Sales.OrdersArchive
  ORDER BY OrderID
/*
Consolidating Data: Merging similar tables (e.g., historical vs. current data) for uniform analysis (32:46).
Delta Identification: Using EXCEPT to find new records between data batches for efficient pipeline loading (42:29).
Data Validation: Using EXCEPT for migration testing to ensure no records were lost or corrupted between systems (44:29).
*/

--SQL String Functions (Visually Explained) | A Detailed Guide | #SQL Course 13
/*
Here are the SQL string functions covered in the video with their basic syntax:

* **CONCAT**: Combines multiple values into one. `CONCAT(string1, string2, ...)` (0:44)
* **UPPER**: Converts string to uppercase. `UPPER(string)` (3:14)
* **LOWER**: Converts string to lowercase. `LOWER(string)` (3:14)
* **TRIM**: Removes leading/trailing spaces. `TRIM(string)` (5:49)
* **REPLACE**: Swaps old characters for new ones. `REPLACE(string, old_value, new_value)` (11:16)
* **LENGTH**: Counts character total. `LENGTH(string)` (14:48)
* **LEFT**: Extracts characters from the start. `LEFT(string, number)` (16:32)
* **RIGHT**: Extracts characters from the end. `RIGHT(string, number)` (16:32)
* **SUBSTRING**: Extracts a portion starting at a specific position. `SUBSTRING(string, start_position, length)` (19:48)
*/

SELECT 
FirstName ,
LEN( FirstName ) as length ,
SUBSTRING( FirstName , 2 , LEN(FirstName) ) bombostring
FROM Sales.Customers


--SQL Number Functions (Visually Explained) | ROUND, ABS | #SQL Course 14

/*
The video covers two SQL numeric functions:
* **ROUND (0:14-1:46):** Simplifies decimal numbers. Rounds up if the next digit is $\ge 5$; stays same if $< 5$.
* **ABS (3:08-4:03):** Returns the positive value of any number, converting negatives to positives.
*/

--SQL Date & Time Functions | DATEPART, DATENAME, DATETRUNC, EOMONTH | #SQL Course 15

/* 
   SUMMARY OF SQL DATE & TIME FUNCTIONS 
   =====================================

   1. DATE COMPONENTS (0:22-3:57):
      - Date: Year, Month, Day.
      - Time: Hours, Minutes, Seconds.
      - Datetime/Timestamp: Combined date and time.

   2. DATA SOURCES (4:03-6:27):
      - Database columns, hardcoded strings, or GETDATE().

   3. KEY FUNCTIONS (6:28-34:16):
      - Extraction: DAY(), MONTH(), YEAR(), DATEPART(), DATENAME().
      - Manipulation: DATETRUNC() (granularity reset), EOMONTH() (month-end).

   4. PRACTICAL USE (34:16-39:20):
      - Aggregation: Grouping by specific time units (Year, Month).
      - Filtering: Using WHERE clauses for specific time windows.

   5. BEST PRACTICES (39:20-43:27):
      - Use integer-returning functions (DATEPART) for faster filtering.
      - Use DATENAME for readable reporting.
*/

SELECT 
OrderID ,
CreationTime ,
'Day ' + FORMAT(CreationTime , 'ddd MMM') + ' Q' + DATENAME(quarter , CreationTime ) + ' ' + format(CreationTime , 'yyyy hh:mm:ss tt' ) as bingo
FROM Sales.Orders


--SQL Date & Time Functions (Visually Explained) | FORMAT, CONVERT, CAST | #SQL Course 16

SELECT 
OrderID ,
CreationTime ,
'Day ' + FORMAT(CreationTime , 'ddd MMM') + ' Q' + DATENAME(quarter , CreationTime ) + ' ' + format(CreationTime , 'yyyy hh:mm:ss tt' ) as bingo
FROM Sales.Orders

SELECT 
CreationTime , 
LEFT(CONVERT(VARCHAR  , CreationTime) , LEN(CAST(CreationTime AS VARCHAR) ) - 8)
FROM Sales.Orders

SELECT 
CreationTime , 
CAST(CreationTime AS DATE)
FROM Sales.Orders

/* 
   SQL Data Transformation Summary:
   1. FORMAT(): Changes visual appearance (Date/Number to String).
   2. CONVERT(): Handles data type casting & formatting (requires style ID).
   3. CAST(): Strictly for changing data types (standard SQL compliant).
*/

--SQL Date & Time Functions (Visually Explained) | DATEADD, DATEDIFF, ISDATE | #SQL Course 17

/* 
   SQL Date & Time Functions Summary:
   
   1. DATEADD(part, interval, date): Adds/subtracts time intervals (years, months, days) to/from a date (0:00-4:43).
   2. DATEDIFF(part, start_date, end_date): Calculates the difference between two dates in the specified unit (4:43-14:48).
   3. ISDATE(expression): Validates if a value is a date format, returning 1 for true or 0 for false (14:48-22:13).
   4. LAG() : Give me the value from the previous row.
   LAG(column) OVER (ORDER BY column)
   These functions are essential for time-based analysis, data cleanup, and calculating durations or ages.
*/

SELECT
    OrderDate,
    PreviousOrderDate,
    DATEDIFF(day, PreviousOrderDate, OrderDate) AS DaysBetween
FROM
(
    SELECT
        OrderDate,
        LAG(OrderDate) OVER (ORDER BY OrderDate) AS PreviousOrderDate
    FROM Sales.Orders
)t;

SELECT 
OrderDate ,
cast (OrderDate as date )
From
(
SELECT 
'2025'AS OrderDate 
UNION
SELECT 
'2025-12-23' 
UNION
SELECT 
'2025-10-23' 
UNION
SELECT 
'10-23' 
)t
where isdate(OrderDate) = 1 ;

-- or we can do :


SELECT 
OrderDate ,
case when (isdate(OrderDate) = 1 ) then cast (OrderDate as date ) 
else '2008-4-28'
end as castDay
From
(
SELECT 
'2025'AS OrderDate 
UNION
SELECT 
'2025-12-23' 
UNION
SELECT 
'2025-10-23' 
UNION
SELECT 
'10-23' 
)t


--SQL NULL Functions | COALESCE, ISNULL, NULLIF, IS (NOT) NULL | #SQL Course 18

/*
 1. ISNULL(col, default): Replaces NULL with a static value (03:23).
    Example: SELECT ISNULL(address, 'N/A') FROM Orders;

 2. COALESCE(val1, val2, ...): Returns the first non-NULL value in a list (07:35).
    Example: SELECT COALESCE(shipping, billing, 'Unknown') FROM Orders;

 3. NULLIF(val1, val2): Returns NULL if the two values are equal (37:01).
    Example: SELECT Sales / NULLIF(quantity, 0) FROM Orders; -- Prevents div by zero

 4. IS NULL / IS NOT NULL: Used in WHERE clauses to filter for missing data (42:58).
    Example: SELECT * FROM Customers WHERE score IS NULL;
*/

--SQL NULL vs Empty String vs Blank Space (Visually Explained) | #SQL Course 19

/* 
   SUMMARY: NULL vs Empty String vs Blank Space (0:00 - 14:37)
   
   1. NULL: Represents an 'unknown' value; marker, not a data type.
      Best for performance and storage efficiency.
   2. Empty String (' '): Known as 'nothing'; length is zero.
   3. Blank Space (' '): A string with one or more space characters; 
      length > 0. Considered 'evil' in data quality.

   DATA POLICIES (6:01 - 14:37):
   - Policy 1: Use TRIM() to remove spaces, leaving NULLs or empty strings.
   - Policy 2 (Recommended for Storage): Convert empty strings/spaces to NULL 
     using TRIM() + NULLIF().
   - Policy 3 (Recommended for Reporting): Standardize NULLs/empty strings 
     to a display value like 'Unknown' using COALESCE().
*/

/* 
   SQL WINDOW FUNCTIONS SUMMARY
   
   Window functions perform calculations across a set of rows related to the current row, 
   maintaining individual row detail, unlike GROUP BY (00:36).

   Key Components:
   - Window Function: Aggregate (SUM, AVG), Ranking (RANK), or Value (LEAD) (14:04).
   - OVER Clause: Defines the window context. Required for all window functions (17:16).
   - PARTITION BY: Divides data into groups. If omitted, the entire set is one window (18:05).
   - ORDER BY: Sorts rows within each partition (28:05).
   - FRAME Clause: Specifies a subset of rows within a partition (33:52).

   Core Rules:
   1. Can only be used in SELECT and ORDER BY clauses (46:52).
   2. Window functions cannot be nested (48:20).
   3. Can be used with GROUP BY if columns are identical in both (50:00).
*/

-- Code Example: Window Function Usage


-- Example: Calculating a running total partitioned by category
SELECT 
    order_id,
    product_id,
    sales,
    SUM(sales) OVER (PARTITION BY product_id ORDER BY order_date) AS running_total_sales
FROM sales_orders;
