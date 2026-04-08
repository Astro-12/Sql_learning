# 🎮 Project: Advanced Game Economy & Inventory System

A relational database system designed to manage players, items, and a functional in-game economy. This project focuses on **Many-to-Many** relationships and **Transactional Logic**.

##  Schema Architecture
* **Players:** Stores user info (username, level, coins).
* **Items:** A master catalog of all available game assets.
* **Inventories:** A junction table linking Players to Items to manage ownership.
* **Shop:** References the Item catalog to define pricing for an in-game store.

##  Key Features
- **Many-to-Many Logic:** Used a junction table (`inventories`) to efficiently track which player owns which items.
- **Transactional Economy:** Implemented "Atomic" updates—simultaneous changes to `players.coins` and `inventories.quantity` during trades and purchases.
- **Data Integrity:** Enforced `ON DELETE CASCADE` to ensure that removing a player or item automatically cleans up their inventory, preventing "orphaned" data.
- **Reporting:** Utilized `LEFT JOIN` and aggregate `GROUP BY` to generate real-time player economy dashboards.

##  Troubleshooting Log
- **Error 1175:** Resolved by utilizing `SET SQL_SAFE_UPDATES = 0;` for bulk updates.
- **Data Integrity:** Managed duplicate name issues by targeting updates and deletes via unique `player_id`.
