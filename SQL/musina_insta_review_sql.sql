CREATE DATABASE IF NOT EXISTS instagram_review01
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE instagram_review01;

CREATE TABLE IF NOT EXISTS ig_tag_comments(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    brand VARCHAR(100) NOT NULL,
    post_url VARCHAR(255) NOT NULL,
    author_id VARCHAR(30) NOT NULL,
    comment_text TEXT NOT NULL
);
DESC ig_tag_comments;

SELECT * FROM ig_tag_comments;


