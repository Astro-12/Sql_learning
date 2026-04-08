
CREATE DATABASE IF NOT EXISTS gameinventorydb;
USE gameinventorydb;

-- 1. DROP EXISTING TABLES TO ENSURE CLEAN BUILD
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS players, items, inventories, shop;
SET FOREIGN_KEY_CHECKS = 1;

-- 2. SCHEMA CREATION
CREATE TABLE players (
    player_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    level INT DEFAULT 1,
    coins INT DEFAULT 100
);

CREATE TABLE items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(50),
    rarity VARCHAR(20)
);

CREATE TABLE inventories (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT,
    item_id INT,
    quantity INT DEFAULT 1,
    FOREIGN KEY (player_id) REFERENCES players(player_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES items(item_id) ON DELETE CASCADE
);

CREATE TABLE shop (
    shop_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT,
    price INT,
    FOREIGN KEY (item_id) REFERENCES items(item_id) ON DELETE CASCADE
);

-- 3. DATA POPULATION
INSERT INTO players (username, level, coins) VALUES ('Lunacy', 10, 100), ('NoobMaster', 1, 50);
INSERT INTO items (item_name, rarity) VALUES ('Gravity Coil', 'Rare'), ('Bloxy Cola', 'Common'), ('Darkblade', 'Mythical');
INSERT INTO shop (item_id, price) VALUES (1, 50), (2, 10), (3, 500);

-- 4. SIMULATE TRANSACTIONS
SET SQL_SAFE_UPDATES = 0;

-- Lunacy gives 1 Bloxy Cola to NoobMaster
UPDATE inventories SET quantity = quantity - 1 WHERE player_id = 1 AND item_id = 2;
INSERT INTO inventories (player_id, item_id, quantity) VALUES (2, 2, 1) ON DUPLICATE KEY UPDATE quantity = quantity + 1;

-- NoobMaster buys a Gravity Coil
UPDATE players SET coins = coins - 50 WHERE player_id = 2;
INSERT INTO inventories (player_id, item_id, quantity) VALUES (2, 1, 1) ON DUPLICATE KEY UPDATE quantity = quantity + 1;

-- 5. GLOBAL ECONOMY REPORT
SELECT 
    p.username AS 'Player', 
    p.coins AS 'Balance', 
    i.item_name AS 'Item', 
    inv.quantity AS 'Qty'
FROM players p
LEFT JOIN inventories inv ON p.player_id = inv.player_id
LEFT JOIN items i ON inv.item_id = i.item_id;
