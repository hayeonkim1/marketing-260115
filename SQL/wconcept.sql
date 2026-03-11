CREATE DATABASE IF NOT EXISTS wconcept_crawling
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE wconcept_crawling;

CREATE TABLE IF NOT EXISTS wconcept_data(
		brand VARCHAR(50) NOT NULL,
        product_name VARCHAR(100) NOT NULL,
        product_price INT NOT NULL,
        dis_rate INT NOT NULL,
        reviews_count INT NOT NULL    
);
DESC wconcept_data;

#1 판매가 기준 상위 20개 상품조회
SELECT product_name, product_price
FROM wconcept_data 
ORDER BY product_price DESC
LIMIT 20;

#2 할인율이 30% 이상인 상품 조회 & 내림차순 정렬
SELECT product_name, dis_rate
FROM wconcept_data
WHERE dis_rate >= 30
ORDER BY dis_rate DESC;

#3 특정 브랜드 (임의) 상품만 조회, 판매가 기준 오름차순 정렬
SELECT * FROM wconcept_data;

SELECT brand, product_price
FROM wconcept_data
WHERE brand = "시야쥬"
ORDER BY product_price ASC;

#4 리뷰수가 100 이상인 상품의 평균 판매가 조회
SELECT AVG(product_price)
FROM wconcept_data
WHERE reviews_count >= 100;

#5 브랜드별 상품수 & 평균할인률 구하고 상품수가 많은 브랜드 10개 조회
SELECT brand, COUNT(*), AVG(dis_rate) 
FROM wconcept_data
GROUP BY brand
ORDER BY COUNT(*) DESC
LIMIT 10;



