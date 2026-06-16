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
    created_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP 
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

# ChatGPT Generated Data for 'dummy' insertions into the database for Tableau purposes

USE ecommerce_marketplace;

INSERT IGNORE INTO `User` (user_id, name, email, password, signup_date) VALUES
(11, 'Maya Johnson', 'maya.johnson@example.com', 'pw11', '2026-02-01'),
(12, 'Omar Hassan', 'omar.hassan@example.com', 'pw12', '2026-02-03'),
(13, 'Aisha Khan', 'aisha.khan@example.com', 'pw13', '2026-02-05'),
(14, 'Ethan Brown', 'ethan.brown@example.com', 'pw14', '2026-02-07'),
(15, 'Fatima Noor', 'fatima.noor@example.com', 'pw15', '2026-02-09'),
(16, 'Noah Wilson', 'noah.wilson@example.com', 'pw16', '2026-02-11'),
(17, 'Layla Ahmed', 'layla.ahmed@example.com', 'pw17', '2026-02-13'),
(18, 'Daniel Lee', 'daniel.lee@example.com', 'pw18', '2026-02-15'),
(19, 'Hana Yusuf', 'hana.yusuf@example.com', 'pw19', '2026-02-17'),
(20, 'Marcus King', 'marcus.king@example.com', 'pw20', '2026-02-19'),
(21, 'Sarah Miller', 'sarah.miller@example.com', 'pw21', '2026-01-10'),
(22, 'Adam Carter', 'adam.carter@example.com', 'pw22', '2026-01-11'),
(23, 'Nadia Ali', 'nadia.ali@example.com', 'pw23', '2026-01-12'),
(24, 'Ben Davis', 'ben.davis@example.com', 'pw24', '2026-01-13'),
(25, 'Grace Moore', 'grace.moore@example.com', 'pw25', '2026-03-01'),
(26, 'Ibrahim Said', 'ibrahim.said@example.com', 'pw26', '2026-03-02'),
(27, 'Priya Patel', 'priya.patel@example.com', 'pw27', '2026-03-03'),
(28, 'Luis Garcia', 'luis.garcia@example.com', 'pw28', '2026-03-04'),
(29, 'Amira Osman', 'amira.osman@example.com', 'pw29', '2026-03-05'),
(30, 'Kevin Young', 'kevin.young@example.com', 'pw30', '2026-03-06');

INSERT IGNORE INTO `Product` (product_id, name, description, price, category, created_date) VALUES
(11, 'Bluetooth Speaker', 'Extra sample product for dashboard: bluetooth speaker', 44.99, 'Electronics', '2026-05-10'),
(12, 'Laptop Stand', 'Extra sample product for dashboard: laptop stand', 27.99, 'Electronics', '2026-02-20'),
(13, 'USB-C Hub', 'Extra sample product for dashboard: usb-c hub', 32.99, 'Electronics', '2026-02-22'),
(14, 'Wireless Keyboard', 'Extra sample product for dashboard: wireless keyboard', 49.99, 'Electronics', '2026-02-25'),
(15, 'Smart Watch', 'Extra sample product for dashboard: smart watch', 119.99, 'Electronics', '2026-03-01'),
(16, 'Air Fryer', 'Extra sample product for dashboard: air fryer', 89.99, 'Home', '2026-03-05'),
(17, 'Throw Blanket', 'Extra sample product for dashboard: throw blanket', 22.99, 'Home', '2026-03-08'),
(18, 'Storage Bins', 'Extra sample product for dashboard: storage bins', 18.99, 'Home', '2026-03-12'),
(19, 'Travel Pillow', 'Extra sample product for dashboard: travel pillow', 14.99, 'Travel', '2026-03-16'),
(20, 'Duffel Bag', 'Extra sample product for dashboard: duffel bag', 54.99, 'Travel', '2026-03-20'),
(21, 'Soccer Ball', 'Extra sample product for dashboard: soccer ball', 19.99, 'Sports', '2026-03-25'),
(22, 'Resistance Bands', 'Extra sample product for dashboard: resistance bands', 17.99, 'Sports', '2026-03-29'),
(23, 'Bike Water Cage', 'Extra sample product for dashboard: bike water cage', 11.99, 'Sports', '2026-04-02'),
(24, 'Planner', 'Extra sample product for dashboard: planner', 12.49, 'School', '2026-04-06'),
(25, 'Mechanical Pencils', 'Extra sample product for dashboard: mechanical pencils', 6.99, 'School', '2026-04-10'),
(26, 'Desk Organizer', 'Extra sample product for dashboard: desk organizer', 16.99, 'School', '2026-04-14'),
(27, 'Portable Fan', 'Extra sample product for dashboard: portable fan', 21.99, 'Home', '2026-04-18'),
(28, 'LED Light Strips', 'Extra sample product for dashboard: led light strips', 25.99, 'Electronics', '2026-04-22'),
(29, 'Rain Jacket', 'Extra sample product for dashboard: rain jacket', 59.99, 'Clothing', '2026-04-26'),
(30, 'Winter Beanie', 'Extra sample product for dashboard: winter beanie', 13.99, 'Clothing', '2026-05-01'),
(31, 'Graphic T-Shirt', 'Extra sample product for dashboard: graphic t-shirt', 18.99, 'Clothing', '2026-05-05');

INSERT IGNORE INTO `Inventory` (inventory_id, product_id, quantity, last_updated) VALUES
(11, 11, 8, '2026-05-20 09:00:00'),
(12, 12, 22, '2026-05-20 09:00:00'),
(13, 13, 14, '2026-05-20 09:00:00'),
(14, 14, 9, '2026-05-20 09:00:00'),
(15, 15, 5, '2026-05-20 09:00:00'),
(16, 16, 18, '2026-05-20 09:00:00'),
(17, 17, 40, '2026-05-20 09:00:00'),
(18, 18, 12, '2026-05-20 09:00:00'),
(19, 19, 35, '2026-05-20 09:00:00'),
(20, 20, 6, '2026-05-20 09:00:00'),
(21, 21, 28, '2026-05-20 09:00:00'),
(22, 22, 7, '2026-05-20 09:00:00'),
(23, 23, 4, '2026-05-20 09:00:00'),
(24, 24, 55, '2026-05-20 09:00:00'),
(25, 25, 90, '2026-05-20 09:00:00'),
(26, 26, 11, '2026-05-20 09:00:00'),
(27, 27, 16, '2026-05-20 09:00:00'),
(28, 28, 3, '2026-05-20 09:00:00'),
(29, 29, 10, '2026-05-20 09:00:00'),
(30, 30, 2, '2026-05-20 09:00:00'),
(31, 31, 13, '2026-05-20 09:00:00');

INSERT IGNORE INTO `Transaction` (transaction_id, user_id, date, total_amount, status) VALUES
(13, 21, '2026-01-25 10:05:00', 30.47, 'completed'),
(14, 22, '2026-02-01 11:15:00', 41.97, 'completed'),
(15, 23, '2026-02-07 14:20:00', 89.98, 'completed'),
(16, 24, '2026-02-12 16:45:00', 46.98, 'completed'),
(17, 21, '2026-02-18 13:10:00', 63.97, 'completed'),
(18, 22, '2026-02-24 09:35:00', 83.96, 'completed'),
(19, 23, '2026-02-28 18:25:00', 133.97, 'completed'),
(20, 24, '2026-03-01 12:00:00', 84.97, 'completed'),
(21, 1, '2026-03-05 09:00:00', 19.99, 'completed'),
(22, 2, '2026-03-06 12:07:00', 114.98, 'completed'),
(23, 3, '2026-03-07 15:14:00', 599.94, 'completed'),
(24, 4, '2026-03-08 18:21:00', 175.96, 'completed'),
(25, 5, '2026-03-09 11:28:00', 259.96, 'completed'),
(26, 6, '2026-03-10 14:35:00', 8.99, 'completed'),
(27, 7, '2026-03-11 17:42:00', 39.98, 'completed'),
(28, 8, '2026-03-12 10:49:00', 121.96, 'completed'),
(29, 9, '2026-03-13 13:56:00', 129.97, 'completed'),
(30, 10, '2026-03-14 16:03:00', 79.97, 'completed'),
(31, 11, '2026-03-15 09:10:00', 89.98, 'completed'),
(32, 12, '2026-03-16 12:17:00', 140.95, 'completed'),
(33, 13, '2026-03-17 15:24:00', 53.97, 'completed'),
(34, 14, '2026-03-18 18:31:00', 79.96, 'completed'),
(35, 15, '2026-03-19 11:38:00', 110.96, 'completed'),
(36, 16, '2026-03-20 14:45:00', 119.97, 'completed'),
(37, 17, '2026-03-21 17:52:00', 48.98, 'completed'),
(38, 18, '2026-03-22 10:59:00', 269.96, 'completed'),
(39, 19, '2026-03-23 13:06:00', 99.95, 'completed'),
(40, 20, '2026-03-24 16:13:00', 70.97, 'completed'),
(41, 1, '2026-03-25 09:20:00', 89.98, 'completed'),
(42, 2, '2026-03-26 12:27:00', 49.97, 'completed'),
(43, 3, '2026-03-27 15:34:00', 22.98, 'completed'),
(44, 4, '2026-03-28 18:41:00', 110.96, 'completed'),
(45, 5, '2026-03-29 11:48:00', 114.95, 'completed'),
(46, 6, '2026-03-30 14:55:00', 39.99, 'completed'),
(47, 7, '2026-03-31 17:02:00', 189.96, 'completed'),
(48, 8, '2026-04-01 10:09:00', 127.96, 'completed'),
(49, 9, '2026-04-02 13:16:00', 118.95, 'completed'),
(50, 10, '2026-04-03 16:23:00', 154.96, 'completed'),
(51, 11, '2026-04-04 09:30:00', 19.99, 'completed'),
(52, 12, '2026-04-05 12:37:00', 57.96, 'completed'),
(53, 13, '2026-04-06 15:44:00', 109.97, 'completed'),
(54, 14, '2026-04-07 18:51:00', 329.95, 'completed'),
(55, 15, '2026-04-08 11:58:00', 45.98, 'completed'),
(56, 16, '2026-04-09 14:05:00', 8.99, 'completed'),
(57, 17, '2026-04-10 17:12:00', 139.96, 'completed'),
(58, 18, '2026-04-11 10:19:00', 159.97, 'completed'),
(59, 19, '2026-04-12 13:26:00', 132.48, 'completed'),
(60, 20, '2026-04-13 16:33:00', 145.97, 'completed'),
(61, 1, '2026-04-14 09:40:00', 69.98, 'completed'),
(62, 2, '2026-04-15 12:47:00', 124.98, 'completed'),
(63, 3, '2026-04-16 15:54:00', 77.96, 'completed'),
(64, 4, '2026-04-17 18:01:00', 84.97, 'completed'),
(65, 5, '2026-04-18 11:08:00', 224.95, 'completed'),
(66, 6, '2026-04-19 14:15:00', 32.99, 'completed'),
(67, 7, '2026-04-20 17:22:00', 287.95, 'completed'),
(68, 8, '2026-04-21 10:29:00', 277.45, 'completed'),
(69, 9, '2026-04-22 13:36:00', 67.96, 'completed'),
(70, 10, '2026-04-23 16:43:00', 93.97, 'completed'),
(71, 11, '2026-04-24 09:50:00', 44.99, 'completed'),
(72, 12, '2026-04-25 12:57:00', 45.98, 'completed'),
(73, 13, '2026-04-26 15:04:00', 42.98, 'completed'),
(74, 14, '2026-04-27 18:11:00', 71.97, 'completed'),
(75, 15, '2026-04-28 11:18:00', 99.95, 'completed'),
(76, 16, '2026-04-29 14:25:00', 179.98, 'completed'),
(77, 17, '2026-04-30 17:32:00', 150.95, 'completed'),
(78, 18, '2026-05-01 10:39:00', 224.96, 'completed'),
(79, 19, '2026-05-02 13:46:00', 137.96, 'completed'),
(80, 20, '2026-05-03 16:53:00', 179.94, 'completed'),
(81, 1, '2026-05-04 09:00:00', 59.97, 'completed'),
(82, 2, '2026-05-05 12:07:00', 129.95, 'completed'),
(83, 3, '2026-05-06 15:14:00', 60.98, 'completed'),
(84, 4, '2026-05-07 18:21:00', 314.96, 'completed'),
(85, 5, '2026-05-08 11:28:00', 74.98, 'completed'),
(86, 6, '2026-05-09 14:35:00', 59.98, 'completed'),
(87, 7, '2026-05-10 17:42:00', 124.96, 'completed'),
(88, 8, '2026-05-11 10:49:00', 114.98, 'completed'),
(89, 9, '2026-05-12 13:56:00', 154.97, 'completed'),
(90, 10, '2026-05-13 16:03:00', 55.97, 'completed'),
(91, 11, '2026-05-14 09:10:00', 44.99, 'completed'),
(92, 12, '2026-05-15 12:17:00', 92.97, 'completed');

INSERT IGNORE INTO `Transaction_Item` (item_id, transaction_id, product_id, quantity, unit_price) VALUES
(17, 13, 5, 2, 8.99),
(18, 13, 24, 1, 12.49),
(19, 14, 3, 1, 15.99),
(20, 14, 8, 2, 12.99),
(21, 15, 4, 1, 64.99),
(22, 15, 10, 1, 24.99),
(23, 16, 7, 1, 39.99),
(24, 16, 25, 1, 6.99),
(25, 17, 26, 2, 16.99),
(26, 17, 6, 1, 29.99),
(27, 18, 17, 2, 22.99),
(28, 18, 18, 2, 18.99),
(29, 19, 29, 2, 59.99),
(30, 19, 30, 1, 13.99),
(31, 20, 19, 2, 14.99),
(32, 20, 20, 1, 54.99),
(33, 21, 2, 1, 19.99),
(34, 22, 1, 1, 79.99),
(35, 22, 9, 1, 34.99),
(36, 23, 1, 3, 79.99),
(37, 23, 15, 3, 119.99),
(38, 24, 4, 2, 64.99),
(39, 24, 17, 2, 22.99),
(40, 25, 21, 1, 19.99),
(41, 25, 1, 3, 79.99),
(42, 26, 5, 1, 8.99),
(43, 27, 2, 1, 19.99),
(44, 27, 21, 1, 19.99),
(45, 28, 28, 2, 25.99),
(46, 28, 9, 1, 34.99),
(47, 28, 9, 1, 34.99),
(48, 29, 9, 2, 34.99),
(49, 29, 29, 1, 59.99),
(50, 30, 2, 2, 19.99),
(51, 30, 7, 1, 39.99),
(52, 31, 11, 2, 44.99),
(53, 32, 9, 3, 34.99),
(54, 32, 22, 2, 17.99),
(55, 33, 2, 2, 19.99),
(56, 33, 30, 1, 13.99),
(57, 34, 2, 3, 19.99),
(58, 34, 2, 1, 19.99),
(59, 35, 22, 1, 17.99),
(60, 35, 9, 2, 34.99),
(61, 35, 17, 1, 22.99),
(62, 36, 7, 3, 39.99),
(63, 37, 9, 1, 34.99),
(64, 37, 30, 1, 13.99),
(65, 38, 29, 3, 59.99),
(66, 38, 16, 1, 89.99),
(67, 39, 2, 2, 19.99),
(68, 39, 2, 3, 19.99),
(69, 40, 13, 1, 32.99),
(70, 40, 18, 2, 18.99),
(71, 41, 11, 2, 44.99),
(72, 42, 21, 1, 19.99),
(73, 42, 17, 1, 22.99),
(74, 42, 25, 1, 6.99),
(75, 43, 25, 1, 6.99),
(76, 43, 3, 1, 15.99),
(77, 44, 16, 1, 89.99),
(78, 44, 25, 3, 6.99),
(79, 45, 2, 2, 19.99),
(80, 45, 10, 3, 24.99),
(81, 46, 7, 1, 39.99),
(82, 47, 20, 1, 54.99),
(83, 47, 11, 3, 44.99),
(84, 48, 20, 2, 54.99),
(85, 48, 5, 2, 8.99),
(86, 49, 30, 2, 13.99),
(87, 49, 17, 2, 22.99),
(88, 49, 11, 1, 44.99),
(89, 50, 2, 1, 19.99),
(90, 50, 11, 3, 44.99),
(91, 51, 2, 1, 19.99),
(92, 52, 5, 2, 8.99),
(93, 52, 2, 2, 19.99),
(94, 53, 9, 2, 34.99),
(95, 53, 7, 1, 39.99),
(96, 54, 1, 3, 79.99),
(97, 54, 11, 2, 44.99),
(98, 55, 21, 1, 19.99),
(99, 55, 28, 1, 25.99),
(100, 56, 5, 1, 8.99),
(101, 57, 2, 1, 19.99),
(102, 57, 7, 3, 39.99),
(103, 58, 20, 2, 54.99),
(104, 58, 14, 1, 49.99),
(105, 59, 24, 1, 12.49),
(106, 59, 15, 1, 119.99),
(107, 60, 13, 2, 32.99),
(108, 60, 1, 1, 79.99),
(109, 61, 9, 2, 34.99),
(110, 62, 1, 1, 79.99),
(111, 62, 11, 1, 44.99),
(112, 63, 2, 1, 19.99),
(113, 63, 18, 2, 18.99),
(114, 63, 2, 1, 19.99),
(115, 64, 9, 1, 34.99),
(116, 64, 10, 2, 24.99),
(117, 65, 11, 3, 44.99),
(118, 65, 11, 2, 44.99),
(119, 66, 13, 1, 32.99),
(120, 67, 5, 2, 8.99),
(121, 67, 16, 3, 89.99),
(122, 68, 15, 2, 119.99),
(123, 68, 24, 3, 12.49),
(124, 69, 2, 2, 19.99),
(125, 69, 30, 2, 13.99),
(126, 70, 6, 1, 29.99),
(127, 70, 11, 1, 44.99),
(128, 70, 18, 1, 18.99),
(129, 71, 11, 1, 44.99),
(130, 72, 17, 1, 22.99),
(131, 72, 17, 1, 22.99),
(132, 73, 2, 1, 19.99),
(133, 73, 17, 1, 22.99),
(134, 74, 28, 2, 25.99),
(135, 74, 2, 1, 19.99),
(136, 75, 2, 3, 19.99),
(137, 75, 21, 2, 19.99),
(138, 76, 16, 2, 89.99),
(139, 77, 9, 1, 34.99),
(140, 77, 11, 2, 44.99),
(141, 77, 8, 2, 12.99),
(142, 78, 15, 1, 119.99),
(143, 78, 9, 3, 34.99),
(144, 79, 5, 2, 8.99),
(145, 79, 29, 2, 59.99),
(146, 80, 7, 3, 39.99),
(147, 80, 2, 3, 19.99),
(148, 81, 2, 3, 19.99),
(149, 82, 9, 2, 34.99),
(150, 82, 2, 3, 19.99),
(151, 83, 28, 1, 25.99),
(152, 83, 9, 1, 34.99),
(153, 84, 15, 2, 119.99),
(154, 84, 6, 1, 29.99),
(155, 84, 11, 1, 44.99),
(156, 85, 9, 1, 34.99),
(157, 85, 7, 1, 39.99),
(158, 86, 6, 2, 29.99),
(159, 87, 2, 1, 19.99),
(160, 87, 9, 3, 34.99),
(161, 88, 1, 1, 79.99),
(162, 88, 9, 1, 34.99),
(163, 89, 4, 2, 64.99),
(164, 89, 10, 1, 24.99),
(165, 90, 3, 1, 15.99),
(166, 90, 2, 2, 19.99),
(167, 91, 11, 1, 44.99),
(168, 92, 31, 2, 18.99),
(169, 92, 20, 1, 54.99);

INSERT IGNORE INTO `Review` (review_id, user_id, product_id, rating, comment, date) VALUES
(11, 1, 1, 5, 'Works well and I would buy it again.', '2026-03-10 10:00:00'),
(12, 2, 2, 4, 'Good value for the price.', '2026-03-12 11:00:00'),
(13, 3, 3, 4, 'Useful product for daily use.', '2026-03-14 12:00:00'),
(14, 4, 4, 5, 'Quality was better than expected.', '2026-03-16 13:00:00'),
(15, 5, 5, 3, 'Shipping was fast and the item worked.', '2026-03-18 14:00:00'),
(16, 6, 6, 5, 'Pretty good overall.', '2026-03-20 15:00:00'),
(17, 7, 7, 4, 'Helpful for school and work.', '2026-03-22 16:00:00'),
(18, 8, 8, 4, 'Simple product but it does the job.', '2026-03-24 10:00:00'),
(19, 9, 9, 5, 'I liked the design and quality.', '2026-03-26 11:00:00'),
(20, 10, 10, 3, 'Not perfect, but still useful.', '2026-03-28 12:00:00'),
(21, 11, 11, 5, 'Works well and I would buy it again.', '2026-03-30 13:00:00'),
(22, 12, 12, 4, 'Good value for the price.', '2026-04-01 14:00:00'),
(23, 13, 13, 4, 'Useful product for daily use.', '2026-04-03 15:00:00'),
(24, 14, 14, 5, 'Quality was better than expected.', '2026-04-05 16:00:00'),
(25, 15, 15, 3, 'Shipping was fast and the item worked.', '2026-04-07 10:00:00'),
(26, 16, 16, 5, 'Pretty good overall.', '2026-04-09 11:00:00'),
(27, 17, 17, 4, 'Helpful for school and work.', '2026-04-11 12:00:00'),
(28, 18, 18, 4, 'Simple product but it does the job.', '2026-04-13 13:00:00'),
(29, 19, 20, 5, 'I liked the design and quality.', '2026-04-15 14:00:00'),
(30, 20, 21, 3, 'Not perfect, but still useful.', '2026-04-17 15:00:00'),
(31, 1, 22, 5, 'Works well and I would buy it again.', '2026-04-19 16:00:00'),
(32, 2, 24, 4, 'Good value for the price.', '2026-04-21 10:00:00'),
(33, 3, 25, 4, 'Useful product for daily use.', '2026-04-23 11:00:00'),
(34, 4, 28, 5, 'Quality was better than expected.', '2026-04-25 12:00:00'),
(35, 5, 29, 3, 'Shipping was fast and the item worked.', '2026-04-27 13:00:00'),
(36, 6, 30, 5, 'Pretty good overall.', '2026-04-29 14:00:00'),
(37, 7, 31, 4, 'Helpful for school and work.', '2026-05-01 15:00:00'),
(38, 8, 1, 4, 'Simple product but it does the job.', '2026-05-03 16:00:00'),
(39, 9, 2, 5, 'I liked the design and quality.', '2026-05-05 10:00:00'),
(40, 10, 3, 3, 'Not perfect, but still useful.', '2026-05-07 11:00:00'),
(41, 11, 4, 5, 'Works well and I would buy it again.', '2026-05-09 12:00:00'),
(42, 12, 5, 4, 'Good value for the price.', '2026-05-11 13:00:00'),
(43, 13, 6, 4, 'Useful product for daily use.', '2026-05-13 14:00:00'),
(44, 14, 7, 5, 'Quality was better than expected.', '2026-05-15 15:00:00'),
(45, 15, 8, 3, 'Shipping was fast and the item worked.', '2026-05-17 16:00:00');

SELECT 'User' AS table_name, COUNT(*) AS row_count FROM `User`
UNION ALL SELECT 'Product', COUNT(*) FROM `Product`
UNION ALL SELECT 'Inventory', COUNT(*) FROM `Inventory`
UNION ALL SELECT 'Transaction', COUNT(*) FROM `Transaction`
UNION ALL SELECT 'Transaction_Item', COUNT(*) FROM `Transaction_Item`
UNION ALL SELECT 'Review', COUNT(*) FROM `Review`;

# Adding new queries (replacing the old ones)
# 1. Current inventory
SELECT p.product_id, p.name AS product_name, p.category, p.price, i.quantity, i.last_updated
FROM Product p
JOIN Inventory i ON p.product_id = i.product_id
ORDER BY i.quantity DESC;

# 2. Low stock products
SELECT p.product_id, p.name AS product_name, p.category, i.quantity
FROM Product p
JOIN Inventory i on p.product_id = i.product_id
WHERE i.quantity <= 5
ORDER BY i.quantity ASC;

# 3. Most popular products
SELECT p.product_id, p.name AS product_name, p.category, SUM(ti.quantity) as total_sold
FROM Transaction_Item ti
JOIN `Transaction` t ON ti.transaction_id = t.transaction_id
JOIN Product p on ti.product_id = p.product_id
WHERE t.status = 'completed'
GROUP BY p.product_id, p.name, p.category
ORDER BY total_sold DESC;

# 4. Least popular products
SELECT p.product_id, p.name AS product_name, p.category, COALESCE(SUM(ti.quantity), 0) AS total_sold
FROM Product p
LEFT JOIN Transaction_Item ti ON p.product_id = ti.product_id
GROUP BY p.product_id, p.name, p.category
ORDER BY total_sold ASC;

# 5. Inactive users
SELECT u.user_id, u.name as user_name, u.email, MAX(t.date) AS last_purchase_date
FROM User u
LEFT JOIN `Transaction` t ON u.user_id = t.user_id
GROUP BY u.user_id, u.name, u.email HAVING last_purchase_date < '2026-03-03' OR last_purchase_date IS NULL
ORDER BY last_purchase_date;

# 6. Inactive users purchases
SELECT u.user_id, u.name as user_name, p.name as product_name, p.category, SUM(ti.quantity) AS total_bought
FROM user u
JOIN `Transaction` t ON u.user_id = t.user_id
JOIN Transaction_Item ti ON t.transaction_id = ti.transaction_id
JOIN Product p ON ti.product_id = p.product_id
WHERE u.user_id IN (
	SELECT u2.user_id
    FROM User u2
    LEFT JOIN `Transaction` t2 ON u2.user_id = t2.user_id
    GROUP BY u2.user_id
    HAVING MAX(t2.date) < '2026-03-03' OR MAX(t2.date) IS NULL
)
GROUP BY u.user_id, u.name, p.name, p.category
ORDER BY u.user_id, total_bought DESC;

# 7. Newest products
SELECT product_id, name AS product_name, category, price, created_date
FROM Product
ORDER BY created_date DESC;

# 8. Best categories
SELECT p.category, SUM(ti.quantity) as total_sold, SUM(ti.quantity * ti.unit_price) as total_revenue
FROM Transaction_Item ti
JOIN Product p ON ti.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;
