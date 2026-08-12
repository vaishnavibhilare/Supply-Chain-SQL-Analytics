create database sql_project;
use sql_project;

select * from products;
select * from warehouse;
select * from inventory;
select * from orders;
select * from order_details;
select * from suppliers;

SHOW COLUMNS FROM products;
ALTER TABLE products
CHANGE COLUMN `ï»¿product_id` product_id INT;
SHOW COLUMNS FROM products;


-- Question 1: Display all products
SELECT *
FROM products;

-- Question 2: Display product name, category and price
SELECT 
product_name,
category,
unit_price
FROM products;

-- Question 3: Display all customer orders
SELECT *
FROM orders;

-- Question 4: Display all suppliers
SELECT *
FROM suppliers;

-- Question 5: Display inventory information
SELECT *
FROM inventory;

-- Question 6: Find products from Electronics category
SELECT *
FROM products
WHERE category='Electronics';

-- Question 7: Find products having price greater than 5000
SELECT 
product_name,
unit_price
FROM products
WHERE unit_price > 5000;

-- Question 8: Find delivered orders
SELECT *
FROM orders
WHERE status='Delivered';

-- Question 9: Find cancelled orders
SELECT *
FROM orders
WHERE status='Cancelled';

-- Question 10: Find suppliers with rating above 4
SELECT 
supplier_name,
rating
FROM suppliers
WHERE rating > 4;

-- Question 11: Find inventory where stock is less than 50
SELECT *
FROM inventory
WHERE on_hand_qty < 50;

-- Question 12: Find orders between two dates
SELECT *
FROM orders
WHERE order_date 
BETWEEN '2024-01-01' AND '2024-12-31';

-- Question 13: Top 10 expensive products
SELECT 
product_name,
unit_price
FROM products
ORDER BY unit_price DESC
LIMIT 10;

-- Question 14: Cheapest products
SELECT *
FROM products
ORDER BY unit_price ASC
LIMIT 10;

-- Question 15: Latest orders
SELECT *
FROM orders
ORDER BY order_date DESC;

-- Question 16: Highest rated suppliers
SELECT 
supplier_name,
rating
FROM suppliers
ORDER BY rating DESC;

-- Question 17: Top selling products
SELECT 
product_id,
SUM(quantity) AS Total_quantity
FROM order_details
GROUP BY product_id
ORDER BY Total_quantity DESC
LIMIT 10;

-- Question 18: Count total products
SELECT COUNT(*) AS Total_products
FROM products;

-- Question 19: Average product price
SELECT AVG(unit_price) AS Average_price
FROM products;

-- Question 20: Maximum product price
SELECT MAX(unit_price) AS Maximum_price
FROM products;

-- Question 21: Minimum product price
SELECT MIN(unit_price) AS Minimum_price
FROM products;

-- Question 22: Total sales generated
SELECT 
ROUND(SUM(line_total),2) AS Total_sales
FROM order_details;

-- Question 23: Total quantity sold
SELECT 
SUM(quantity) AS Total_quantity
FROM order_details;

-- Question 24: Total sales category wise
SELECT 
p.category,
SUM(od.line_total) AS Sales
FROM order_details od
JOIN products p
ON od.product_id=p.product_id
GROUP BY p.category;

-- Question 25: Quantity sold product wise
SELECT 
product_id,
SUM(quantity) AS Total_quantity
FROM order_details
GROUP BY product_id;

-- Question 26: Number of orders by status
SELECT 
status,
COUNT(*) AS Total_orders
FROM orders
GROUP BY status;

-- Question 27: Supplier count by city
SELECT 
city,
COUNT(*) AS Supplier_count
FROM suppliers
GROUP BY city;

-- Question 28: Categories having sales above 1 lakh
SELECT 
p.category,
SUM(od.line_total) AS Sales
FROM order_details od
JOIN products p
ON od.product_id=p.product_id
GROUP BY p.category
HAVING SUM(od.line_total)>100000;

-- Question 29: Products selling more than 100 units
SELECT 
product_id,
SUM(quantity) AS Quantity
FROM order_details
GROUP BY product_id
HAVING SUM(quantity)>100;

-- Question 30: Customers placing more than 5 orders
SELECT 
customer_id,
COUNT(order_id) AS Orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id)>5;

-- Question 31: Display product details with supplier name
SELECT 
p.product_name,
p.category,
s.supplier_name
FROM products p
JOIN suppliers s
ON p.supplier_id = s.supplier_id;

-- Question 32: Find products with supplier rating above 4
SELECT 
p.product_name,
s.supplier_name,
s.rating
FROM products p
JOIN suppliers s
ON p.supplier_id = s.supplier_id
WHERE s.rating > 4;

-- Question 33: Display order details with product information
SELECT 
od.order_id,
p.product_name,
od.quantity,
od.unit_price
FROM order_details od
JOIN products p
ON od.product_id = p.product_id;

-- Question 34: Display orders with customer and product details
SELECT 
o.order_id,
o.customer_id,
p.product_name,
od.quantity
FROM orders o
JOIN order_details od
ON o.order_id = od.order_id
JOIN products p
ON od.product_id = p.product_id;

-- Question 35: Find product stock available in warehouse
SELECT 
p.product_name,
w.warehouse_name,
i.on_hand_qty
FROM products p
JOIN inventory i
ON p.product_id=i.product_id
JOIN warehouse w
ON i.warehouse_id=w.warehouse_id;

-- Question 36: Find total inventory available product wise
SELECT 
p.product_name,
SUM(i.on_hand_qty) AS Available_Stock
FROM products p
JOIN inventory i
ON p.product_id=i.product_id
GROUP BY p.product_name;

-- Question 37: Display suppliers and their supplied products
SELECT 
s.supplier_name,
p.product_name
FROM suppliers s
JOIN products p
ON s.supplier_id=p.supplier_id;

-- Question 38: Find delivered orders with product details
SELECT 
o.order_id,
o.status,
p.product_name,
od.quantity
FROM orders o
JOIN order_details od
ON o.order_id=od.order_id
JOIN products p
ON od.product_id=p.product_id
WHERE o.status='Delivered';

-- Question 39: Find products with price higher than average price
SELECT 
product_name,
unit_price
FROM products
WHERE unit_price >
(
SELECT AVG(unit_price)
FROM products
);

-- Question 40: Find highest priced product
SELECT *
FROM products
WHERE unit_price =
(
SELECT MAX(unit_price)
FROM products
);

-- Question 41: Find products which are not ordered
SELECT 
product_id,
product_name
FROM products
WHERE product_id NOT IN
(
SELECT product_id
FROM order_details
);

-- Question 42: Find products having quantity sold greater than average quantity
SELECT 
product_id,
SUM(quantity) AS Total_Quantity
FROM order_details
GROUP BY product_id
HAVING SUM(quantity) >
(
SELECT AVG(quantity)
FROM order_details
);

-- Question 43: Find suppliers whose rating is greater than average supplier rating
SELECT 
supplier_name,
rating
FROM suppliers
WHERE rating >
(
SELECT AVG(rating)
FROM suppliers
);

-- Question 44: Rank products based on sales quantity
SELECT 
product_id,
SUM(quantity) AS Total_Quantity,
RANK() OVER
(
ORDER BY SUM(quantity) DESC
) AS Product_Rank
FROM order_details
GROUP BY product_id;

-- Question 45: Find running total of sales
SELECT 
order_id,
line_total,
SUM(line_total) OVER
(
ORDER BY order_id
) AS Running_Total
FROM order_details;

-- Question 46: Rank products category wise by price
SELECT
product_name,
category,
unit_price,
RANK() OVER
(
PARTITION BY category
ORDER BY unit_price DESC
) AS Price_Rank
FROM products;

-- Question 47: Find previous order amount using LAG()
SELECT
order_id,
line_total,
LAG(line_total)
OVER
(
ORDER BY order_id
) AS Previous_Sale
FROM order_details;

-- Question 48: Find highest quantity order for each product
SELECT *
FROM
(
SELECT
product_id,
order_id,
quantity,
ROW_NUMBER()
OVER
(
PARTITION BY product_id
ORDER BY quantity DESC
) AS Rank_No
FROM order_details
)t
WHERE Rank_No=1;

-- Question 49: Create procedure to check product inventory
DELIMITER //

CREATE PROCEDURE CheckInventory(IN p_id INT)

BEGIN

SELECT 
p.product_name,
SUM(i.on_hand_qty) AS Total_Stock

FROM products p

JOIN inventory i
ON p.product_id=i.product_id

WHERE p.product_id=p_id

GROUP BY p.product_name;

END //

DELIMITER ;


CALL CheckInventory(101);

-- Question 50: Create procedure for top selling products
DELIMITER //

CREATE PROCEDURE TopSellingProducts()

BEGIN

SELECT 
product_id,
SUM(quantity) AS Total_Sold

FROM order_details

GROUP BY product_id

ORDER BY Total_Sold DESC

LIMIT 5;

END //

DELIMITER ;


CALL TopSellingProducts();






