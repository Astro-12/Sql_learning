## 🎮 Project: Game Inventory System (Many-to-Many)
This project manages player data and items using a junction table to allow many-to-many relationships.

### The Junction Table Logic
The `inventories` table links `players` and `items`, allowing a player to hold multiple items and a single item type to be owned by many players.

### Triple-Join Inventory Query
To generate a player's inventory screen, I use a triple join:
```sql
SELECT players.username, items.item_name, inventories.quantity
FROM inventories
JOIN players ON inventories.player_id = players.player_id
JOIN items ON inventories.item_id = items.item_id;
```
