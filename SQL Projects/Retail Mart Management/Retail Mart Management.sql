drop database if exists sql_basics;

create database sql_basics;
use sql_basics;

-- create a product table with fields as product code, product name, price, stock and category --
-- customer table with the fields as customer id, customer name, customer location, and customer phone number --
-- sales table with the fields as date, order number, product code, product name, quantity, and price --
 -- Write a query to insert values into the tables \--

create table Product(
product_code int,
product_name Varchar(30),
price int,
stock int,
category varchar(30)
);

drop table customer;

create table customer(
customer_id int,
customer_name varchar(40),
customer_location varchar(40),
customer_phonenumber int
);

drop table sales;

CREATE TABLE IF NOT EXISTS sales (
    order_date DATETIME,
    order_no VARCHAR(10),
    customer_id INT,
    customer_name VARCHAR(10),
    product_code INT,
    product_name VARCHAR(20),
    quantity INT,
    price INT
);

-- write a query to insert values in table --

INSERT INTO product VALUES (01,'tulip',198,5,'perfume'),
	(02,'cornoto',50,21,'icecream'),
	(03,'Pen',10,52,'Stationary'),
	(04,'Lays',10,20,'snacks'),
	(05,'mayanoise',90,10,'dip'),
	(06,'jam',105,10,'spread'),
	(07,'shampoo',5,90,'hair product'),
	(08,'axe',210,4,'perfume'),
	(09,'park avenue',901,2,'perfume'),
	(10,'wattagirl',201,3,'perfume'),
	(11,'pencil',4,10,'Stationary'),
	(12,'sharpener',5,90,'Stationary'),
	(13,'sketch pen',30,10,'Stationary'),
	(14,'tape',15,30,'Stationary'),
	(15,'paint',60,12,'Stationary'),
	(16,'chocolate',25,50,'snacks'),
	(17,'biscuts',60,26,'snacks'),
	(18,'mango',100,21,'fruits'),
	(19,'apple',120,9,'fruits'),
	(20,'kiwi',140,4,'fruits'),
	(21,'carrot',35,12,'vegetable'),
	(22,'onion',22,38,'vegetable'),
	(23,'tomato',21,15,'vegetable'),
	(24,'serum',90,4,'hair product'),
	(25,'conditioner',200,5,'hair product'),
	(26,'oil bottle',40,2,'kitchen utensil');

select * from product;

INSERT INTO customer VALUES (1111,'Nisha','kerala',8392320),
	(1212,'Oliver','kerala',4353891),
	(1216,'Nila','delhi',3323242),
	(1246,'Vignesh','chennai',1111212),
	(1313,'shiny','Maharastra',5454543),
	(1910,'Mohan','mumbai',9023941),
	(2123,'Biyush','Bombay',1253358),
	(3452,'Alexander','West Bengal',1212134),
	(3921,'Mukesh','Manipur',4232321),
	(5334,'Christy','pakistan',2311111),
	(9021,'Rithika','Kashmir',1121344),
	(9212,'Jessica','banglore',1233435),
	(9875,'Stephen','chennai',1212133);
    
   select * from customer; 
   
   INSERT INTO sales VALUES ('2016-07-24 00:00:00','HM06',9212,'Jessica',11,'pencil',3,30),
	('2016-10-19 00:00:00','HM09',3921,'Mukesh',17,'biscuits',10,600),
	('2016-10-30 00:00:00','HM10',9875,'Stephen',02,'cornoto',10,500),
	('2018-04-12 00:00:00','HM03',1212,'Oliver',20,'kiwi',3,420),
	('2018-05-02 00:00:00','HM05',1910,'Mohan',20,'kiwi',2,280),
	('2018-09-20 00:00:00','HM08',5334,'Chirsty',16,'chocolate',2,50),
	('2019-01-11 00:00:00','HM07',1246,'Vignesh',19,'apple',5,600),
	('2019-03-15 00:00:00','HM01',1910,'Mohan',05,'mayanoise',4,360),
	('2021-02-10 00:00:00','HM04',1111,'Nisha',25,'conditioner',5,1000),
	('2021-02-12 00:00:00','HM02',2123,'Biyush',03,'Pen',2,20);
    
    select * from sales;

-- query to add two new columns such as S_no and categories to the sales table --

ALTER TABLE sales
ADD S_no INT,
ADD categories VARCHAR(50);

-- Write a query to change the column type of stock in the product table to varchar--

ALTER TABLE product
MODIFY stock VARCHAR(50);

-- Write a query to change the table name from customer-to-customer details --

RENAME TABLE customer TO customer_details;

-- Write a query to drop the columns S_no and categories from the sales table --

ALTER TABLE sales
DROP COLUMN S_no,
DROP COLUMN categories;

-- Write a query to display order no, customer id, order date, price, and quantity from the sales table --

SELECT order_no, customer_id, order_date, price, quantity
FROM sales;

-- Write a query to display all the details in the product table if the category is stationary --

SELECT *
FROM product
WHERE category = 'stationary';

-- Write a query to display a unique category from the product table --

SELECT DISTINCT category
FROM product;

-- Write a query to display the sales details if quantity is greater than 2 and price is lesser than 500 from the sales table --

SELECT *
FROM sales
WHERE quantity > 2 AND price < 500;

-- Write a query to display the customer’s name if the name ends with a --

SELECT customer_name
FROM customer_details
WHERE customer_name LIKE '%a';

-- Write a query to display the product details in descending order of the price --

SELECT *
FROM product
ORDER BY price DESC;

-- Write a query to display the product code and category from similar categories that are greater than or equal to 2 --

SELECT product_code, category
FROM product
GROUP BY product_code, category
HAVING COUNT(*) >= 2;

-- Write a query to display the order number and the customer name to combine the results of the order and the customer tables including duplicate rows --

SELECT order_number, customer_name
FROM orders
UNION ALL
SELECT order_number, customer_name
FROM customers;
