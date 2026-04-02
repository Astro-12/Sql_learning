Markdown
# 📚 MySQL Workbench Learning Project: Library System

This repository contains my progress in learning MySQL Workbench through a hands-on Library Management System project. It covers the transition from basic SQL syntax to relational database management.

---

## 🛠 1. Database Administration
Basic commands to set up and manage the environment.

| Command | Description | Example |
| :--- | :--- | :--- |
| `CREATE DATABASE` | Creates a new schema. | `CREATE DATABASE IF NOT EXISTS librarydb;` |
| `USE` | Sets the active database (makes it bold in Workbench). | `USE librarydb;` |
| `DROP DATABASE` | Deletes the entire database and all its data. | `DROP DATABASE librarydb;` |

---

## 🏗 2. Data Definition (The Blueprint)
Commands used to define how data is structured and linked.

### Key Concepts
* **Primary Key (PK):** A unique ID for every row (e.g., `book_id`).
* **Foreign Key (FK):** A link that connects one table to another (e.g., `author_id` in the Books table).
* **Data Types:** * `INT`: Whole numbers.
    * `VARCHAR(size)`: Text/Strings.
    * `DATE`: Formatted as 'YYYY-MM-DD'.

### Example Table Structure
```sql
-- Creating the Authors table
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL,
    nationality VARCHAR(50)
);

-- Creating the Books table with a Relationship
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150),
    author_id INT,
    published_year INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);
```

## 📝 3. Data Manipulation (The Content)
How to interact with the data inside the tables.

Insert (Add Data)
Note: Always insert Parents (Authors) before Children (Books) to avoid Foreign Key errors.
```
SQL
INSERT INTO authors (author_name, nationality) 
VALUES ('J.K. Rowling', 'British');

INSERT INTO books (title, author_id, published_year) 
VALUES ('Harry Potter', 1, 1997);
Select (View Data)
SQL
-- View everything in a table
SELECT * FROM books; 

-- Filtered view
SELECT title FROM books WHERE published_year > 2000; 
Delete (Remove Data)
SQL
-- Removes a specific record
DELETE FROM authors WHERE author_id = 4;
```
## 4. Relational Logic (The "Join")
How to combine data from multiple tables to see relationships.
```
SQL
SELECT books.title, authors.author_name
FROM books
JOIN authors ON books.author_id = authors.author_id;
```
## Common Error Troubleshooting
Error 1007 (Database exists): Use CREATE DATABASE IF NOT EXISTS.

Error 1046 (No database selected): Run USE librarydb; or double-click the schema name.

Error 1452 (Foreign key constraint): You are trying to add a "child" row for a "parent" that doesn't exist. Check your IDs!

Error 1366 (Incorrect integer value): You tried to put text or an empty string "" into an INT column.
