# E-Commerce Marketplace Database

DROP DATABASE IF EXISTS ecommerce_marketplace;
CREATE DATABASE ecommerce_marketplace;
USE ecommerce_marketplace;

-- Dropping tables in reverse dependency order (safe re-run of queries)
DROP TABLE IF EXISTS `Review`;
DROP TABLE IF EXISTS `Inventory`;
DROP TABLE IF EXISTS `Transaction_Item`;
DROP TABLE IF EXISTS `Transaction`;
DROP TABLE IF EXISTS `Product`;
DROP TABLE IF EXISTS `User`;


-- Tables

CREATE TABLE `User` (
	user_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(150) NOT NULL,
    signup_date DATE NOT NULL
);

CREATE TABLE `Product` (
	product_id INT PRIMARY KEY,
    name VARCHAR (100) NOT NULL,
    description VARCHAR(500),
    price DECIMAL(10, 2) NOT NULL,
    category VARCHAR(50) NOT NULL,
    created_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP # had to add this for my Tableau assignment
);

CREATE TABLE `Inventory` (
	inventory_id INT PRIMARY KEY,
    product_id INT NOT NULL UNIQUE,
    quantity INT NOT NULL DEFAULT 0,
    last_updated DATETIME NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Product (product_id)
);

CREATE TABLE `Transaction` (
	transaction_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    date DATETIME NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL, # "completed", "pending", "cancelled", etc.
    FOREIGN KEY (user_id) REFERENCES User(user_id)
    );

CREATE TABLE `Transaction_Item` (
	item_id INT PRIMARY KEY,
    transaction_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (transaction_id) REFERENCES Transaction(transaction_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE `Review` (
	review_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT NOT NULL,
    comment VARCHAR(500),
    date DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Inserting data

INSERT INTO `User` (user_id, name, email, password, signup_date) VALUES
(1, 'Kai Smith', 'kai@gmail.com', 'pw1', '2026-01-14'),
(2, 'Jay Walker', 'jay@gmail.com', 'pw2', '2026-01-15'),
(3, 'Cole Bucket', 'cole@gmail.com', 'pw3', '2026-01-16'),
(4, 'Nya Smith', 'nya@gmail.com', 'pw4', '2026-01-17'),
(5, 'Zane Julien', 'zane@gmail.com', 'pw5', '2026-01-18'),
(6, 'PIXEL Borg', 'PIXEL@gmail.com', 'pw6', '2026-01-19'),
(7, 'Lloyd Garmadon', 'lloyd@gmail.com', 'pw7', '2026-01-20'),
(8, 'Wyldfyre Heatwave', 'wyldfyre@gmail.com', 'pw8', '2026-01-21'),
(9, 'Sora Ana', 'sora@gmail.com', 'pw9', '2026-01-22'),
(10, 'Arin Nived', 'arin@gmail.com', 'pw10', '2026-01-23');

INSERT INTO `Product` (product_id, name, description, price, category, created_date) VALUES
(1, 'Wireless Headphones', 'Bluetooth headphones with noise reduction', 79.99, 'Electronics', '2026-01-05'),
(2, 'Phone Charger', 'Fast charging USB-C phone charger', 19.99, 'Electronics', '2026-01-08'),
(3, 'Water Bottle', 'Reusable stainless steel water bottle', 15.99, 'Home', '2026-01-12'),
(4, 'Running Shoes', 'Lightweight shoes for daily running', 64.99, 'Sports', '2026-01-15'),
(5, 'Notebook Pack', 'Pack of three college ruled notebooks', 8.99, 'School', '2026-01-18'),
(6, 'Desk Lamp', 'LED desk lamp with adjustable brightness', 29.99, 'Home', '2026-01-22'),
(7, 'Backpack', 'School and travel backpack with laptop pocket', 39.99, 'School', '2026-01-26'),
(8, 'Coffee Mug', 'Ceramic mug for hot drinks', 12.99, 'Home', '2026-02-01'),
(9, 'Gaming Mouse', 'USB gaming mouse with side buttons', 34.99, 'Electronics', '2026-02-08'),
(10, 'Yoga Mat', 'Non-slip exercise yoga mat', 24.99, 'Sports', '2026-02-15');

INSERT INTO `Inventory` (inventory_id, product_id, quantity, last_updated) VALUES
(1, 1, 40, '2026-05-01 08:00:00'),
(2, 2, 75, '2026-05-01 08:05:00'),
(3, 3, 60, '2026-05-01 08:10:00'),
(4, 4, 25, '2026-05-01 08:15:00'),
(5, 5, 100, '2026-05-01 08:20:00'),
(6, 6, 30, '2026-05-01 08:25:00'),
(7, 7, 45, '2026-05-01 08:30:00'),
(8, 8, 80, '2026-05-01 08:35:00'),
(9, 9, 20, '2026-05-01 08:40:00'),
(10, 10, 35, '2026-05-01 08:45:00');

INSERT INTO `Transaction` (transaction_id, user_id, date, total_amount, status) VALUES
(1, 1, '2026-02-20 10:30:00', 99.98, 'completed'),
(2, 2, '2026-02-22 11:15:00', 15.99, 'completed'),
(3, 3, '2026-03-01 14:00:00', 73.98, 'completed'),
(4, 4, '2026-03-05 09:45:00', 29.99, 'completed'),
(5, 5, '2026-03-10 16:20:00', 48.98, 'completed'),
(6, 6, '2026-03-12 13:10:00', 64.99, 'completed'),
(7, 7, '2026-04-01 12:00:00', 39.99, 'completed'),
(8, 8, '2026-04-04 15:30:00', 34.99, 'completed'),
(9, 9, '2026-04-10 17:25:00', 24.99, 'completed'),
(10, 10, '2026-04-15 18:45:00', 12.99, 'completed'),
(11, 1, '2026-05-01 10:00:00', 34.99, 'completed'),
(12, 2, '2026-05-03 11:00:00', 24.98, 'completed');

INSERT INTO `Transaction_Item` (item_id, transaction_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 1, 79.99),
(2, 1, 2, 1, 19.99),
(3, 2, 3, 1, 15.99),
(4, 3, 4, 1, 64.99),
(5, 3, 5, 1, 8.99),
(6, 4, 6, 1, 29.99),
(7, 5, 7, 1, 39.99),
(8, 5, 5, 1, 8.99),
(9, 6, 4, 1, 64.99),
(10, 7, 7, 1, 39.99),
(11, 8, 9, 1, 34.99),
(12, 9, 10, 1, 24.99),
(13, 10, 8, 1, 12.99),
(14, 11, 9, 1, 34.99),
(15, 12, 5, 1, 8.99),
(16, 12, 3, 1, 15.99);

INSERT INTO `Review` (review_id, user_id, product_id, rating, comment, date) VALUES
(1, 1, 1, 5, 'Great sound quality for the price honestly.', '2026-02-25 09:00:00'),
(2, 2, 3, 4, 'Good bottle and easy to carry!', '2026-02-26 10:00:00'),
(3, 3, 4, 5, 'Comfortable running shoes.', '2026-03-03 12:00:00'),
(4, 4, 6, 4, 'The lamp works well on my desk bruh.', '2026-03-07 13:00:00'),
(5, 5, 7, 5, 'This backpack has a lot of space!', '2026-03-12 15:00:00'),
(6, 6, 4, 4, 'Awesome shoes but a little too tight.', '2026-03-15 16:00:00'),
(7, 7, 7, 5, 'Firm backpack for school.', '2026-04-02 11:00:00'),
(8, 8, 9, 5, 'Mouse is smooth and sharp for gaming.', '2026-04-06 17:00:00'),
(9, 9, 10, 4, 'Yoga mat is comfortable and cool.', '2026-04-12 18:00:00'),
(10, 10, 8, 3, 'Mug is okay but smaller than expected tbh.', '2026-04-16 19:00:00');

-- Queries

# 1: List products in an inventory that are currently in stock
SELECT
    p.product_id,
    p.name,
    p.category,
    p.price,
    i.quantity,
    i.last_updated
FROM `Product` p
JOIN `Inventory` i
    ON p.product_id = i.product_id
WHERE i.quantity > 0
ORDER BY p.product_id;

# 2: Create a new product via insertion
INSERT INTO `Product` (product_id, name, description, price, category) VALUES
(11, 'Bluetooth Speaker', 'Portable speaker for music', 44.99, 'Electronics');

INSERT INTO `Inventory` (inventory_id, product_id, quantity, last_updated) VALUES
(11, 11, 50, '2026-05-10 09:00:00');


# 3: Modify inventory quantity
UPDATE `Inventory`
SET quantity = 35,
    last_updated = '2026-05-10 10:00:00'
WHERE product_id = 1;

# 4: Delete a product from inventory
DELETE FROM `Inventory`
WHERE product_id = 11;


# 5: Most popular products by time range
SELECT
    p.product_id,
    p.name,
    SUM(ti.quantity) AS total_units_sold
FROM `Transaction_Item` ti
JOIN `Transaction` t
    ON ti.transaction_id = t.transaction_id
JOIN `Product` p
    ON ti.product_id = p.product_id
WHERE t.date >= '2026-02-01' 
  AND t.date < '2026-05-31'
  AND t.status = 'completed'
GROUP BY p.product_id, p.name
ORDER BY total_units_sold DESC;


# 6: Least popular products by time range
SELECT
    p.product_id,
    p.name,
    COALESCE(SUM(ti.quantity), 0) AS total_units_sold
FROM `Product` p
LEFT JOIN `Transaction_Item` ti
    ON p.product_id = ti.product_id
LEFT JOIN `Transaction` t
    ON ti.transaction_id = t.transaction_id
    AND t.date BETWEEN '2026-02-01' AND '2026-05-31'
    AND t.status = 'completed'
GROUP BY p.product_id, p.name
ORDER BY total_units_sold ASC;

# 7: Inactive users (no purchase in 3+ months) and their past purchases
SELECT
    u.user_id,
    u.name,
    u.email,
    p.name AS normally_purchased_product,
    MAX(t.date) AS last_purchase_date
FROM `User` u
LEFT JOIN `Transaction` t
    ON u.user_id = t.user_id
LEFT JOIN `Transaction_Item` ti
    ON t.transaction_id = ti.transaction_id
LEFT JOIN `Product` p
    ON ti.product_id = p.product_id
WHERE u.user_id NOT IN (
    SELECT user_id
    FROM `Transaction`
    WHERE date >= DATE_SUB('2026-06-03', INTERVAL 3 MONTH)
      AND status = 'completed'
)
GROUP BY u.user_id, u.name, u.email, p.name
ORDER BY u.user_id;

-- Simple check queries to see if any data was inserted
SELECT 'User rows' AS table_name, COUNT(*) AS row_count FROM `User`;
SELECT 'Product rows' AS table_name, COUNT(*) AS row_count FROM `Product`;
SELECT 'Inventory rows' AS table_name, COUNT(*) AS row_count FROM `Inventory`;
SELECT 'Transaction rows' AS table_name, COUNT(*) AS row_count FROM `Transaction`;
SELECT 'Transaction_Item rows' AS table_name, COUNT(*) AS row_count FROM `Transaction_Item`;
SELECT 'Review rows' AS table_name, COUNT(*) AS row_count FROM `Review`;


