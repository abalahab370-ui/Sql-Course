CREATE TABLE users (
    id INT,
    name VARCHAR(50),
    age INT,
    CONSTRAINT pk_users PRIMARY KEY (id)
);
Select *
from users ;

insert into users ( id ,name , age )
values (1 , 'mohammed' , 19);
insert into users ( id ,name , age )
values ( 2,'akram' , 17 ) ;
insert into users ( id ,name , age )
values ( 3,'iyad' , 11 ) ;

update  users 
      set age = 11 
      where id = 3
;

CREATE TABLE orders (
    Costumer_id INT,
    orderId VARCHAR(50),
    CreationDate DATE, 
    Sales int,
    CONSTRAINT pk_orders PRIMARY KEY (OrderId)
);

select *
from orders

INSERT into orders ( Costumer_id , orderId , CreationDate , Sales) 
values ( 3 , 3 , GETDATE() , 1)

update  orders 
      set orderId = 1 
      where Costumer_id = 1
;

select *
from orders ;
select *
from users ;

select u.[id]
      ,u.[name]
      ,u.[age]
      ,o.[Costumer_id]
      ,o.[orderId]
      ,o.[CreationDate]
      ,o.[Sales]
from users as u
CROSS JOIN orders as o

--training query  ! 


-- 1. CLEANUP IF EXISTS
IF OBJECT_ID('orders', 'U') IS NOT NULL DROP TABLE orders;
IF OBJECT_ID('customers', 'U') IS NOT NULL DROP TABLE customers;

-- 2. CREATE TABLES (DDL)
CREATE TABLE customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NULL,
    join_date DATE NOT NULL DEFAULT GETDATE(),
    credit_score INT NULL -- Contains NULLs on purpose!
);

CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT GETDATE(),
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 3. SEED DATA (DML)
INSERT INTO customers (first_name, last_name, email, join_date, credit_score) VALUES
('maria', 'salhi', 'maria@gmail.com', '2024-01-15', 750),
('martin', 'khedim', NULL, '2024-06-10', NULL), -- NULL score & email
('sara', 'benali', 'sara@yahoo.com', '2025-02-01', 620),
('khaled', 'amrani', 'khaled@gmail.com', '2026-01-20', NULL); -- NULL score

INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES
(1, '2026-02-01', 1200.50, 'Completed'),
(1, '2026-03-10', 450.00, 'Completed'),
(2, '2026-03-15', 85.00, 'Pending'),
(3, '2026-03-18', 600.00, 'Completed');
-- Note: Customer 4 (khaled) has 0 orders (testing LEFT JOIN)
SELECT *
from orders
--first exercice query : 

select 
customer_id ,
fullName ,
days_registered ,
email ,
credit_score ,
total_orders ,
total_spent,
case 
when total_spent > 1000 then 'VIP' 
when total_spent BETWEEN 500 and 1000 then 'silver'
else 'stander'
end AS category
from (
      select 
      c.[customer_id] ,
      UPPER(CONCAT(first_name ,' ' , last_name)) as fullName ,
      DATEDIFF(day ,join_date , GETDATE()) as days_registered 
      , isnull(trim(email) , 'No Email Provided') as email
      ,[join_date]
      , case when credit_score is null then 0 else credit_score end credit_score 
      ,sum (isnull (o.total_amount , 0)) as total_spent 
      ,count (o.order_id) as total_orders
      from customers  as c
      left join orders as o
      on c.customer_id = o.customer_id
      GROUP BY c.customer_id , c.join_date , c.first_name , c.last_name , c.email ,c.credit_score
) as c
;
SELECT *
from customers