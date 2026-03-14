CREATE DATABASE IF NOT EXISTS wconcept_crawling02
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_general_ci;

USE wconcept_crawling02;

CREATE TABLE IF NOT EXISTS brands (
	brand_id INT PRIMARY KEY AUTO_INCREMENT,
    brand_name VARCHAR(100) NOT NULL UNIQUE
);

SHOW TABLES;

SELECT * FROM brands;
SELECT * FROM products;

CREATE TABLE IF NOT EXISTS products (
	product_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_id INT NOT NULL,
    rank_no INT,
    product_name VARCHAR(255) NOT NULL,
    original_price INT,
    sale_price INT,
    discount_rate INT,
    rating FLOAT,
    review_count INT,
    like_count INT,
    product_url VARCHAR(500),
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id)
);



SHOW TABLES;
SELECT * FROM products;

#1. 판매가 기준, 상위 20개 브랜드, 상품조회

SELECT 
	P.product_id, 
	B.brand_name,
    P.product_name,
    P.sale_price 
FROM products P
JOIN brands B ON P.brand_id = B.brand_id
ORDER BY p.sale_price DESC
LIMIT 20;

#2 할인율이 30% 이상인 상품 조회 & 내림차순 정렬
SELECT 
	P.product_id,
    B.brand_name,
    P.product_name,
    P.original_price,
    P.discount_rate
FROM products P 
JOIN brands B USING(brand_id)
WHERE P.discount_rate >= 30
ORDER bY P.discount_rate DESC, P.sale_price DESC;  -- 동률발생시 2번재 기준으로 정렬



#3 특정 브랜드 (임의) 상품만 조회, 판매가 기준 오름차순 정렬
SELECT 
	P.product_id,
    B.brand_name,
    P.product_name,
    P.sale_price,
    P.discount_rate,
    P.review_count
FROM products P
JOIN brands B USING (brand_id)
WHERE B.brand_name = "프론트로우"
ORDER BY P.sale_price;

#4 리뷰수가 100 이상인 상품의 평균 판매가 조회
SELECT ROUND(AVG(P.sale_price),2) avg_sale_price
FROM product P
JOIN brands B USING (brand_id)
WHERE P.review_count >=100;


#5 브랜드별 상품수 & 평균할인률 구하고 상품수가 많은 브랜드 10개 조회
SELECT 
	B.brand_id,
    B.brand_name,
    COUNT(P.product_id) product_count,
    ROUND(AVG(P.discount_rate)) avg_discount_rate
FROM brands B
JOIN products P USING(brand_id)
GROUP BY B.brand_id
ORDER BY product_count DESC
LIMIT 10;

DROP DATABASE wconcept_db_v3;





/*[오늘의 미션] 3/13
wconcept > SQL 활용 다음과 같은 값을 조회.출력
카테고리별(의류, 가방, 신발, 액세서리) 평균 판매가, 평균 할인율*/

CREATE TABLE IF NOT EXISTS category(
	brand_id INT NOT NULL PRIMARY KEY,
    category VARCHAR(100) NOT NULL,
    category_id INT NOT NULL
);