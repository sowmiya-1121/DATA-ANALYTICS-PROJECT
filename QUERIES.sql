CREATE DATABASE ecommerce_db;
USE ecommerce_db;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50)
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    stock INT
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    total_amount DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers (name, email, city) VALUES
('Sowmiya', 'sowmiya@gmail.com', 'Chennai'),
('Arun', 'arun@gmail.com', 'Bangalore'),
('Priya', 'priya@gmail.com', 'Hyderabad'),
('Rahul', 'rahul@gmail.com', 'Mumbai'),
('Karthik', 'karthik@gmail.com', 'Coimbatore'),
('Divya', 'divya@gmail.com', 'Delhi'),
('Vijay', 'vijay@gmail.com', 'Chennai'),
('Anjali', 'anjali@gmail.com', 'Pune');

INSERT INTO products (name, price, stock) VALUES
('Laptop', 55000, 10),
('Smartphone', 20000, 25),
('Headphones', 2000, 50),
('Smartwatch', 5000, 30),
('Tablet', 30000, 15),
('Keyboard', 1500, 40),
('Mouse', 800, 60),
('Monitor', 12000, 20);

INSERT INTO orders (customer_id, total_amount, order_date) VALUES
(1, 55000, '2026-07-01'),
(2, 20000, '2026-07-02'),
(3, 7000, '2026-07-03'),
(4, 12000, '2026-07-05'),
(5, 30000, '2026-07-06'),
(6, 1500, '2026-07-07'),
(7, 800, '2026-07-08'),
(8, 5000, '2026-07-09');

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 6),   -- Laptop
(2, 2, 5),   -- Smartphone
(3, 3, 3),   -- Headphones
(3, 4, 2),   -- Smartwatch
(4, 8, 4),   -- Monitor
(5, 5, 2),   -- Tablet
(6, 6, 2),   -- Keyboard
(7, 7, 3),   -- Mouse
(8, 4, 5);   -- Smartwatch

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;

UPDATE products
SET price = 48000
WHERE product_id = 1;


SELECT c.name AS customer, p.name AS product, oi.quantity
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

SELECT SUM(total_amount) FROM orders;

-- Top customer (highest spending)
SELECT c.name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC;

-- Most sold product
SELECT p.name, SUM(oi.quantity) AS total_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.name
ORDER BY total_sold DESC;

DELIMITER //

CREATE TRIGGER reduce_stock
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;
END //

DELIMITER ;
SELECT * FROM products;
INSERT INTO order_items (order_id, product_id, quantity)
VALUES (1, 1, 2);


