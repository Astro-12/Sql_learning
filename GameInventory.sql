-- 1. DATABASE SETUP
CREATE DATABASE IF NOT EXISTS gameinventorydb;
USE gameinventorydb;

-- 2. CREATE TABLES
-- Players Table
CREATE TABLE players (
    player_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    level INT DEFAULT 1
);

-- Items Catalog
CREATE TABLE items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(50),
    rarity VARCHAR(20)
);

-- Junction Table (The Inventory)
-- Connects many players to many items
CREATE TABLE inventories (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT,
    item_id INT,
    quantity INT DEFAULT 1,
    FOREIGN KEY (player_id) REFERENCES players(player_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES items(item_id) ON DELETE CASCADE
);

-- 3. UNLOCK SAFETY MODE 
-- Required for updating by username instead of ID
SET SQL_SAFE_UPDATES = 0;

-- 4. DATA POPULATION
-- Adding the Player
INSERT INTO players (username, level) VALUES ('Lunacy', 10);

-- Adding the Catalog Items
INSERT INTO items (item_name, rarity) VALUES 
('Gravity Coil', 'Rare'), 
('Bloxy Cola', 'Common'), 
('Darkblade', 'Mythical');

-- Populating the Inventory (Handshaking IDs)
-- Assuming Lunacy is ID 1 and items are 1, 2, 3
INSERT INTO inventories (player_id, item_id, quantity) VALUES 
(1, 1, 1), -- 1 Gravity Coil
(1, 2, 5), -- 5 Bloxy Colas
(1, 3, 1); -- 1 Darkblade

-- 5. SIMULATING GAMEPLAY (Update)
UPDATE players 
SET level = 11 
WHERE username = 'Lunacy';

-- 6. THE "INVENTORY SCREEN" REPORT (Triple Join)
SELECT 
    players.username, 
    items.item_name, 
    items.rarity, 
    inventories.quantity
FROM inventories
JOIN players ON inventories.player_id = players.player_id
JOIN items ON inventories.item_id = items.item_id
WHERE players.username = 'Lunacy';
