-- Практична робота 5
-- Варіант 1 — Бібліотека
-- Перед виконанням зробіть резервну копію .db і перевірте структуру books.

PRAGMA foreign_keys = OFF;

-- Завдання 1: NOT NULL для genre
CREATE TABLE books_new (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    author TEXT NOT NULL,
    publication_year INTEGER,
    genre TEXT NOT NULL,
    copies_count INTEGER
);
INSERT INTO books_new SELECT * FROM books;
DROP TABLE books;
ALTER TABLE books_new RENAME TO books;

-- Завдання 2: UNIQUE для title
CREATE TABLE books_new (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL UNIQUE,
    author TEXT NOT NULL,
    publication_year INTEGER,
    genre TEXT NOT NULL,
    copies_count INTEGER
);
INSERT INTO books_new SELECT * FROM books;
DROP TABLE books;
ALTER TABLE books_new RENAME TO books;

-- Завдання 3: CHECK для copies_count
CREATE TABLE books_new (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL UNIQUE,
    author TEXT NOT NULL,
    publication_year INTEGER,
    genre TEXT NOT NULL,
    copies_count INTEGER CHECK (copies_count >= 0)
);
INSERT INTO books_new SELECT * FROM books;
DROP TABLE books;
ALTER TABLE books_new RENAME TO books;

-- Завдання 4: DEFAULT для copies_count, збережено CHECK
CREATE TABLE books_new (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL UNIQUE,
    author TEXT NOT NULL,
    publication_year INTEGER,
    genre TEXT NOT NULL,
    copies_count INTEGER DEFAULT 1 CHECK (copies_count >= 0)
);
INSERT INTO books_new SELECT * FROM books;
DROP TABLE books;
ALTER TABLE books_new RENAME TO books;

PRAGMA foreign_keys = ON;
SELECT * FROM books;

-- Перевірки порушень запускайте окремо, не всі разом:
-- NOT NULL (genre):
-- INSERT INTO books (title, author, publication_year, copies_count)
-- VALUES ('Тест NOT NULL', 'Тестовий автор', 2026, 1);

-- UNIQUE (title): замініть 'Кобзар' на назву, що вже є у таблиці:
-- INSERT INTO books (title, author, publication_year, genre, copies_count)
-- VALUES ('Кобзар', 'Інший автор', 2026, 'Тест', 1);

-- CHECK (має відхилити від'ємну кількість):
-- INSERT INTO books (title, author, publication_year, genre, copies_count)
-- VALUES ('Тест CHECK', 'Тестовий автор', 2026, 'Тест', -5);

-- CHECK (допустиме значення):
-- INSERT INTO books (title, author, publication_year, genre, copies_count)
-- VALUES ('Тест CHECK OK', 'Тестовий автор', 2026, 'Тест', 2);

-- DEFAULT: перевірте, що copies_count автоматично дорівнює 1:
INSERT INTO books (title, author, publication_year, genre)
VALUES ('Тест DEFAULT', 'Тестовий автор', 2026, 'Тест');
SELECT * FROM books WHERE title = 'Тест DEFAULT';

-- Завдання 5 (UPDATE, запускати окремо; має порушити CHECK):
-- UPDATE books SET copies_count = -5 WHERE id = 1;
