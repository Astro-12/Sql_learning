-- =============================================
-- PROJECT: LIBRARY MANAGEMENT SYSTEM
-- =============================================

-- 1. DATABASE SETUP
CREATE DATABASE IF NOT EXISTS librarydb;
USE librarydb;

-- 2. CREATE TABLES (The Blueprint)
-- Authors Table (The Parent)
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL,
    nationality VARCHAR(50)
);

-- Members Table
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    join_date DATE DEFAULT (CURRENT_DATE)
);

-- Books Table (Child of Authors)
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150),
    author_id INT,
    published_year INT,
    status VARCHAR(20) DEFAULT 'Available',
    -- Advanced: Cascading Delete
    CONSTRAINT fk_author_cascade 
    FOREIGN KEY (author_id) REFERENCES authors(author_id) 
    ON DELETE CASCADE
);

-- Loans Table (Child of Books and Members)
CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    member_id INT,
    loan_date DATE,
    due_date DATE,
    -- Advanced: Cascading Delete
    CONSTRAINT fk_book_cascade 
    FOREIGN KEY (book_id) REFERENCES books(book_id) 
    ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);

-- 3. INSERT INITIAL DATA
INSERT INTO authors (author_name, nationality) VALUES 
('J.K. Rowling', 'British'),
('George Orwell', 'British'),
('Herman Melville', 'American');

INSERT INTO members (first_name) VALUES ('Alex'), ('Sam');

INSERT INTO books (title, author_id, published_year) VALUES 
('Harry Potter', 1, 1997),
('1984', 2, 1949),
('Moby Dick', 3, 1851);

-- 4. SAMPLE QUERIES (For Testing)
-- View all books with their authors
SELECT books.title, authors.author_name, books.status
FROM books
JOIN authors ON books.author_id = authors.author_id;

-- Check status counts
SELECT status, COUNT(*) AS total
FROM books
GROUP BY status;
