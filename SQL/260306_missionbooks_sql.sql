CREATE DATABASE IF NOT EXISTS bookstoscrapeDB;
USE bookstoscrapeDB;
CREATE TABLE categories(
	category_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(30) NOT NULL
);

CREATE TABLE books(
	book_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(30) NOT NULL,
    category_id INT NOT NULL 
);

CREATE TABLE prices(
	price_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    price_info INT NOT NULL
);

CREATE TABLE inventroy(
	inventroy_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    stock_count INT NOT NULL
);