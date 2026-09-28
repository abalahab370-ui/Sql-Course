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
--SQL Window Functions Basics (Visually Explained) | PARTITION BY, ORDER BY, FRAME | #SQL Course 22 
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

/* 
SQL Window Aggregate Functions Summary:
- Aggregate functions (COUNT, SUM, AVG, MIN, MAX) perform calculations over a set of rows without collapsing them into a single output row (unlike GROUP BY).
- Syntax: FUNCTION(expression) OVER (PARTITION BY ... ORDER BY ...)
- All clauses (PARTITION BY, ORDER BY, and frame) are optional.
- Null handling is critical: COUNT(*) includes nulls, while others ignore them in calculations.
- Use cases: Overall metrics, category-based comparisons, data quality checks (finding duplicates), running totals, and moving averages.
*/

-- Example 1: Total and Category-level Count (03:00)
SELECT order_id, 
       COUNT(*) OVER() AS total_orders,
       COUNT(*) OVER(PARTITION BY customer_id) AS orders_by_customer
FROM orders;

-- Example 2: Running Total (45:39)
SELECT month, sales,
       SUM(sales) OVER(ORDER BY month) AS running_total
FROM sales_data;

-- Example 3: Moving Average (55:15)
SELECT product_id, sales,
       AVG(sales) OVER(PARTITION BY product_id ORDER BY order_date 
                       ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg
FROM orders;
--note : the default moving or running is set up only when u use order by without specifying the frame while if u use partition alone it not gonna apply it , the default frame seted by the order by is : rows between unbounded precedent and current row !s

-- SQL WINDOW RANKING FUNCTIONS SUMMARY
-- These functions help assign orders or segments to rows in a dataset.
-- They require an OVER clause with at least an ORDER BY.

-- 1. INTEGER-BASED RANKING (0:00:58)
-- Used for unique ID assignment, Top-N analysis, and gapless rankings.

ROW_NUMBER() OVER (ORDER BY sales DESC)

-- RANK() handles ties by giving them the same number, leaving gaps (0:10:13)
RANK() OVER (ORDER BY sales DESC)

-- DENSE_RANK() handles ties but keeps the sequence consecutive (0:14:18)
DENSE_RANK() OVER (ORDER BY sales DESC)

-- NTILE(n) divides data into n roughly equal buckets (0:35:21)
NTILE(4) OVER (ORDER BY sales DESC)

-- 2. PERCENTAGE-BASED RANKING (0:00:58)
-- Ideal for distribution and relative contribution analysis (normalized 0 to 1).

-- CUME_DIST() provides cumulative distribution, inclusive of current row (0:50:10)
CUME_DIST() OVER (ORDER BY sales DESC) --what its my rank percentage in this list like in the highest 1% or 40%

-- PERCENT_RANK() provides relative position, operating more exclusively (0:53:52)
PERCENT_RANK() OVER (ORDER BY sales DESC) -- how many are belowe it (row - 1)

select 
first_name,
credit_score,
cast(CUME_DIST_Ranking * 100 as varchar )+ '%' as CUME_DIST_Ranking ,
cast(precentage_ranking * 100 as varchar ) + '%' as precentage_ranking 
from (
select 
      [customer_id]
      ,[first_name]
      ,[last_name]
      , isnull(credit_score , 0) as[credit_score],
      CUME_DIST() over(order by credit_score DESC) as CUME_DIST_Ranking  ,
      PERCENT_RANK() over(order by credit_score DESC ) as precentage_ranking 
from customers
)t ;

/* 
   SQL Value Window Functions Summary (0:33)
   Purpose: Access data from other rows within a partition 
   to perform comparative analysis without self-joins.
   
   Required: ORDER BY is mandatory for all value functions.
   Optional: PARTITION BY (to group data).

   1. LEAD: Access a value from the following row(s).
   2. LAG: Access a value from the preceding row(s).
   3. FIRST_VALUE: Access the first value in the window frame.
   4. LAST_VALUE: Access the last value in the window frame.
*/

-- Example: Month-over-Month Sales Change (14:01)
SELECT 
    month, 
    sales AS current_sales,
    LAG(sales) OVER(ORDER BY month) AS previous_month_sales
FROM sales_data;

-- Example: Next Order Date for Retention (21:00)
SELECT 
    customer_id, 
    order_date,
    LEAD(order_date) OVER(PARTITION BY customer_id ORDER BY order_date) AS next_order
FROM orders;

-- Example: Highest/Lowest Sales with FIRST_VALUE/LAST_VALUE (29:36)
-- Note: LAST_VALUE requires a custom frame to work as expected
SELECT 
    product_id, 
    sales,
    FIRST_VALUE(sales) OVER(PARTITION BY product_id ORDER BY sales ASC) AS lowest_sales,
    LAST_VALUE(sales) OVER(PARTITION BY product_id ORDER BY sales ASC 
                           ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS highest_sales
FROM products;

/*
   Key Use Cases:
   - Time Series Analysis: Calculating month-over-month or year-over-year growth (14:26).
   - Customer Retention: Measuring time gaps between consecutive customer orders (21:02).
   - Comparative Analytics: Comparing individual records against extreme values (lowest/highest) 
     within a group (41:03).
*/
--SQL Techniques You Need in Every Project (Visually Explained) | #SQL Course26 
/* 
  SUMMARY: 5 ESSENTIAL SQL TECHNIQUES FOR PROJECT ARCHITECTURE 
  ------------------------------------------------------------

  1. THE PROBLEM (0:41 - 7:55)
     - Real-world database environments involve multiple roles (Analyst, Data Engineer, 
       Data Scientist) leading to:
       - Redundant logic in queries.
       - Performance bottlenecks due to unoptimized complexity.
       - Difficulty navigating complex physical data models.
       - Data security risks from unrestricted access.

  2. THE SOLUTIONS (7:56 - 18:07)
     - Five techniques to be covered: Subqueries, CTEs, Views, Temporary Tables, and CTAS.

  3. DATABASE ARCHITECTURE FUNDAMENTALS (7:56 - 17:06)
     - Server-side components:
       - Database Engine: The core for processing tasks.
       - Storage Hierarchy:
         - User Data: The main persistent data (e.g., Tables).
         - System Catalog: Metadata (information about data, e.g., Information Schema).
         - Temporary Data: Short-term storage (tempDB) for processing/sorting.
       - Memory hierarchy: Cache (fast, short-term) vs. Disk (slower, permanent).

  4. QUERY EXECUTION FLOW (17:07 - 18:07)
     - Client submits SQL -> Database Engine checks Cache -> If missing, reads from Disk -> 
       Returns results to client.

  NEXT STEPS: Deep dive into Subqueries (18:20).
*/

--SQL Subquery (Visually Explained) | Complete Guide with Correlated Subquery | #SQL Course 27

/* 
 * SQL SUBQUERY SUMMARY 
 * 
 * DEFINITION: A query nested inside another query (main/outer query).
 * PURPOSE: Break down complex tasks into logical, manageable steps.
 * 
 * TYPES BY DEPENDENCY:
 * 1. Non-Correlated: Independent, executed once. (56:25)
 * 2. Correlated: Relies on main query values, executed per row. (56:25)
 * 
 * USE CASES & EXAMPLES:
 */

-- 1. FROM CLAUSE (Creating temporary result sets)
-- Example: Ranking items based on aggregated data
SELECT * 
FROM (
    SELECT customer_id, SUM(sales) AS total_sales 
    FROM orders GROUP BY customer_id
) AS T;

-- 2. SELECT CLAUSE (Scalar subqueries to get single values)
-- Example: Showing total orders count next to product details
SELECT product_name, 
   (SELECT COUNT(*) FROM orders ) AS total_orders
FROM products p;

SELECT product_name, 
   (SELECT COUNT(*) FROM orders WHERE product_id = p.product_id ) AS total_orders
FROM products p;

-- 3. WHERE CLAUSE (Filtering with IN/ANY/ALL)
-- Example: Filtering based on a list of values

SELECT * FROM orders 
WHERE customer_id IN (SELECT customer_id FROM customers WHERE country = 'Germany');


SELECT * FROM orders 
WHERE customer_id NOT ANY (SELECT customer_id FROM customers WHERE country = 'Germany');


SELECT * FROM orders 
WHERE score < (SELECT avg() FROM customers);

-- 4. WHERE CLAUSE (EXISTS operator for correlated checks)
-- Example: Checking if a customer has placed any orders
SELECT * FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id);

/* 
 * IMPORTANT NOTES:
 * - Scalar subqueries MUST return exactly one value if used in SELECT. (24:08)
 * - SQL Server requires an alias for subqueries in the FROM clause. (11:38)
 * - Correlated subqueries are slower as they run for every row in the outer query. (1:06:13)
 * - Use parenthesis () to encapsulate all subqueries. (1:22)
 * - Debugging Tip: Highlight the subquery code block and execute to see intermediate results. (16:13)
 */

 --Practice Exercice ! 

 --Write a query that tracks customer purchasing habits over time
 select * FROM orders
/* so according to what i see i think i get to group each costumer orders into different windows , then i think i will exclude the peding orders from it  , so after that i got to do along with the partition an aggregation for the total amount then i must do a comparistion for the customer purchases ( first one and last one i think ) , and also i must calculate the arevage time the costumer took to place a second order ( it can be null since we gonna use lag ) , well we need a field that has a first purchase amount , also a field for amount_change means the diffrence between the current order and the , also 
amount_change
*/
--lets gooooooo ! 

use [Sales.db]

select 
t.OrdeRank , 
t.customer_id,
t.order_date, 
t.nextOrderDate,
cast(datediff(day , order_date , nextOrderDate) as varchar) + ' day'as SinceLastOrder ,
t.total_amount ,
Round(t.ArvSpend , 2 ) as ArvSpend,
t.prevouisAmount - t.total_amount as amount_change ,
t.first_order_amount
from (
select 
      ROW_NUMBER() over(PARTITION BY customer_id order by order_date asc) as  OrdeRank
      ,[customer_id]
      ,[order_date],
      lead(order_date) over(PARTITION BY customer_id order by order_date) as nextOrderDate
      ,[total_amount],
      lag(total_amount) over(PARTITION BY customer_id order by order_date) as prevouisAmount ,
      FIRST_VALUE(total_amount) over(PARTITION BY customer_id order by order_date asc) as first_order_amount
      ,[status] ,
      avg(ISNULL(total_amount , 0)) over(PARTITION BY customer_id) as ArvSpend
from orders 
where status = 'Completed' 
) as t ;

--second exercice !
--A correlated subquery executes once for every single row processed by the outer query.

select o.customer_id , o.total_amount
from orders as o
where total_amount >= (
   select 
   avg(ISNULL(total_amount , 0)) as ArvSpend
   from orders WHERE customer_id = o.customer_id 
   --added DISTINCT cuz its currently returning 3 rows or more with same value while i need only one row with one value (in over version not this one )
) ;

/* ============================================================================
   SQL CONTROLLER PATTERNS & QUICK REFERENCE
   ============================================================================

   1. WHERE 1=1 (Dynamic Query Anchor)
   ----------------------------------------------------------------------------
   - Purpose: Acts as a neutral condition that is always TRUE.
   - Why use it: Simplifies dynamic query construction in backend code (e.g., Express).
   - Benefit: Allows every optional filter condition to safely begin with "AND ...",
     eliminating extra IF checks to see if "WHERE" was already included.
   - Performance: Zero impact; the query optimizer ignores 1=1 automatically.

   2. LIKE @searchTerm (Pattern Matching / Partial Search)
   ----------------------------------------------------------------------------
   - Purpose: Performs partial text searches (e.g., search bars returning partial matches).
   - Wildcards:
       '%' -> Matches zero or more characters.
       '_' -> Matches exactly one character.
   - Security Tip: Pass wildcards through parameterized inputs in JavaScript:
       request.input('searchTerm', sql.VarChar, `%${search}%`);
     Never concatenate `%` directly inside raw query strings to prevent SQL Injection.

   3. OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY (Pagination)
   ----------------------------------------------------------------------------
   - Purpose: Implements API pagination by skipping and retrieving specific row sets.
   - Mechanics:
       OFFSET @offset ROWS         --> Skips the specified number of rows.
       FETCH NEXT @limit ROWS ONLY   --> Takes only the next batch of rows.
   - Math Formula:
       offset = (currentPage - 1) * limit
   - Golden Rule: SQL Server REQUIRES an 'ORDER BY' clause when using OFFSET / FETCH NEXT.

   ============================================================================ */

--SQL Course 28 - Data with Baraa
/*
========================================================================
SQL CTE (Common Table Expression) - Comprehensive Guide
Based on: SQL Course 28 - Data with Baraa
========================================================================

1. WHAT IS A CTE?
   - A Common Table Expression (CTE) is a temporary named result set.
   - Think of it as a virtual table that exists only during the execution 
     of a single query.
   - Purpose: Simplify, organize, and improve readability of complex queries.
   - Unlike subqueries (which are often bottom-up), CTEs are written top-down,
     making them more modular and easier to debug.

2. KEY ADVANTAGES:
   - Readability: Breaks complex queries into small, logical sections.
   - Modularity: Each CTE handles a specific piece of the logic.
   - Reusability: You can reference the same CTE multiple times within 
     the main query, unlike standard subqueries.

3. TYPES OF CTEs:

   A. STANDALONE CTE (Non-Recursive)
      - Executed once; independent from other CTEs.
      - Syntax:
        WITH CTE_Name AS (
            SELECT ... FROM ...
        )
        SELECT * FROM CTE_Name;

   B. MULTIPLE CTEs
      - Use commas to separate definitions. Only the first needs the 'WITH' keyword.
      - Syntax:
        WITH CTE1 AS (SELECT ...),
             CTE2 AS (SELECT ... FROM CTE1)
        SELECT * FROM CTE1 JOIN CTE2 ...;

   C. NESTED CTE
      - A CTE that references a previous CTE within the same query.
      - Reduces redundancy by building a chain of logic.

   D. RECURSIVE CTE
      - Uses self-reference to loop/iterate until a condition is met.
      - Use Case: Hierarchical data (e.g., employee-manager structures).
      - Structure: Anchor Member (initial select) + UNION ALL + Recursive Member.
      - Important: Always define a breaking condition to avoid infinite loops.
      - Limitation: Max default recursions in SQL Server is 100 (can override 
        with OPTION (MAXRECURSION n)).

4. BEST PRACTICES & TIPS:
   - Refactoring: Aim for 3-5 CTEs per query. If more than 5, consider if 
     the query is too complex and needs to be split or turned into a View.
   - Cleanup: SQL automatically destroys the virtual table once the query 
     finishes.
   - Execution: The DB engine caches the CTE result in memory for use by 
     subsequent steps in the main query.

========================================================================
*/

-- Example of a basic Recursive CTE (Number Sequence 1 to 20)
WITH RECURSIVE_SEQ AS (
    -- Anchor Query
    SELECT 1 AS my_number
    UNION ALL
    -- Recursive Query
    SELECT my_number + 1
    FROM RECURSIVE_SEQ
    WHERE my_number < 20 -- Break condition
)
SELECT * FROM RECURSIVE_SEQ
OPTION (MAXRECURSION 100);

-- exercice for CTES !! :

with total_amount_purchase as (
   --so here we got to calculate the amount and do partition by customer_id !!
 select 
 customer_id,
 MONTH(order_date) as date_Month,
 sum(isnull(total_amount , 0)) as consuming,
 count(customer_id)  as order_count
 from orders
 GROUP BY customer_id , Month(order_date)
) 
--the main querie !
select * 
from total_amount_purchase 
where consuming >= 500;

--Done 
--Exercice 02 !!:

with CustomerTotals as (
   --we have to do two things , total spend and order count for each customer !
   select 
   customer_id ,
   sum(isnull(total_amount , 0)) as totalSpend ,
   count(1) as orderCount
   from orders
   GROUP BY customer_id
) ,
CompanyAverage as (
   --overall average spend from CustomerTotals !
   Select 
   avg(isnull(totalSpend , 0) ) as overAllAverge 
   from CustomerTotals
)
select 
*
from CustomerTotals as c
WHERE totalSpend > (SELECT overAllAverge FROM CompanyAverage);

--Done 
--Exercice 3 !:
-- Setup Employees Table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    manager_id INT NULL
);

INSERT INTO employees VALUES
(1, 'Amine (CEO)', NULL),
(2, 'Sarah (VP of Tech)', 1),
(3, 'Karim (VP of Sales)', 1),
(4, 'Yacine (Senior Dev)', 2),
(5, 'Lina (Junior Dev)', 4);

--RECURSIVE CTES !:!
WITH OrgHierarchy as (
 --anchor querie !
 select 
 emp_id ,
 emp_name,
 manager_id,
 1 as "level"
 from employees
 where manager_id is null 

--recursive querie :
--so here we got to treat it as a loop more then the idea of a recusive function in programming, cuz the behaver matches more the loop onee , so the mean objective is to list each employee with an addition info which is level , if he didnt tell u that u will use recursive querie u may think about using window function firstly then u will understand that its impossible in this case , cuz the level info is not something that can be extructed using window function or any other function and from a programmer prespactive this will look more like a binnary tree and we do deal with this kind of problems usaully with recursive functions , and here we can use a loop so each time we bring the current value which is the emp id and manager id and we have to look for the employes that has this emp id as an manager id if so then we gonna insert them and increasing their lvl comparing to the first value ( the lvl 1 is for the COE) so in order to do that we have first to get out the idea of union all set cuz it will do the job of inserting in each repetion , so we have to focus more on what is below it which is the use of inner join in order to do this task , why inner join and between who and who ? , so we gonna join the table values with the the cte querie , each time the cte querie will pass to it the recursive value not the anchor value , so we are joining the recursing value with the full emp table , then we need to set the condition which is : on recursive.emp_id = tableOfEmpolyees_manager_id then at this case that means that join only the rows that matches , the manager id of the employeer needs to match the employer id from the recusive table , and we will add to the result a lvl info ( lvl + 1 (lvl is passed first of all by the anchor querie ) ) so in each repition we gonna have only the common rows that verify this condition of the inner join and also the result of each repetion will be Joined using Union all so it look how it must look so the recusive part is the one who is doing every thing starting from the first value and ending to the last value !

UNION ALL 

select 
 e.emp_id ,
 e.emp_name,
 e.manager_id,
 level + 1 as "level"
from employees AS e
INNER JOIN OrgHierarchy as o
on o.emp_id = e.manager_id

)
SELECT *
from OrgHierarchy

SELECT *
FROM employees
