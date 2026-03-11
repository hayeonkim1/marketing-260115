-- SubQuery = 서브쿼리
-- SQL 구문안에 또하나의 SQL 구문을 작성하는 것.
-- 1) 동일한 테이블 안에서 조건식을 생성하고자 하는데, 조건의 기준값을 먼저 만들어놓고 시작해야하는 경우
/*
-- ex) 10사람의 나이값을 가지고 있는 테이블 존재
-- 전체나이 평균값을 기준으로 많은가 적은가 판단 
-- -> 먼저 평균값을 계산해줘야 10명의 나이를 판단할 수 있음.
*/

SELECT *
FROM users 
WHERE age > (
	SELECT AVG(age) FROM users
);

-- 대부분의 구문이 JOIN & SUBQUERY 가 모두 통용되는 경우
/*
- INNER JOIN을 쓰면 -> 모두 다 합친 후 해당 테이블에서 값을 찾아낸다.
 A : 20개  // B : 50개  => A + B 후 특정조건 매칭값을 찾음

-SUBQUERY를 쓰면 서로다른 2개 테이블에서 특정 1개 컬럼을 교집합으로 간주하고, 조건에 맞는 컬럼을 찾아온다.
 서브쿼리가 JOIN보다 빠르긴 하지만 상관서브쿼리 같이 어려워지면 굉장히 난해해지고 문법 가독성이 안좋아짐
*/

USE bestproducts;
SHOW TABLES;

SELECT * FROM items LIMIT 1;
SELECT DISTINCT sub_category FROM ranking;

#join으로
SELECT title 
FROM items I
INNER JOIN ranking R ON I.item_code = R.item_code
WHERE R.sub_category = "여성신발";

#subquery로
SELECT title 
FROM items
WHERE item_code IN 
	(SELECT item_code FROM ranking
    WHERE sub_category = "여성신발");

-- ----------------------------
SELECT * FROM items
WHERE 
	item_code = "102425348" OR 
    item_code = "104914497" OR
    item_code = "106332300";
DESC items; #--> item_code가 문자열 형태

# 위 코드 축약하기
SELECT * FROM items
WHERE item_code IN 
	("102425348", "104914497", "106332300");
-- ------------------------

SELECT MAX(dis_price)
FROM items
WHERE item_code IN 
	(SELECT item_code FROM ranking
    WHERE sub_category = "여성신발");

USE sakila;
SHOW TABLES;

SELECT * FROM category LIMIT 10;
SELECT * FROM film_category LIMIT 10;
DESC film_category;

-- --------
-- 각각의 장르가 몇번씩 쓰엿는지 찾기 => GROUP
# category_id가 5이상인 
SELECT category_id, COUNT(*) film_count
FROM film_category FC
WHERE FC.category_id > 
	(SELECT C.category_id FROM category C
    WHERE name = "comedy")
GROUP BY FC.category_id;

-- --------------
#mission
#bestproducts
#메인카테고리내 카테고리별 할인가격이 10만원 이상인 상품이 몇개있는지 출력
#join으로 문제 풀기

USE bestproducts;
SHOW TABLES;
SELECT * FROM items LIMIT 10; #할인가격 존재
SELECT * FROM ranking;  #카테고리 존재
 
SELECT main_category, COUNT(*) product_counts
FROM items I
JOIN ranking R ON I.item_code = R.item_code
WHERE I.dis_price >= 100000
GROUP BY R.main_category
ORDER BY product_counts DESC;
-- --------------------
#MISSION 2
#위 문제를 서브쿼리고 해결
SELECT main_category, COUNT(*) product_counts 
FROM items I
WHERE item_code IN
	(SELECT item_code FROM ranking R
    WHERE I.dis_price >= 100000)
GROUP BY main_category
ORDER BY product_counts;

SELECT main_category, COUNT(*) product_counts
from ranking R
WHERE R.item_code IN 
	(SELECT I.item_code FROM items I
    WHERE I.dis_price >= 10000)
GROUP BY R.main_category;
-- -------------------
#mission3
#dis_price 20만원 이상인 아이템들의 개수를 sub_category 별로 출력
-- join // 서브쿼리
#join
SELECT sub_category, COUNT(*) item_counts
FROM items I #dis_price 존재
JOIN ranking R ON I.item_code = R.item_code
WHERE I.dis_price >= 200000
GROUP BY R.sub_category
ORDER BY item_counts DESC;

#subquery
SELECT sub_category, COUNT(*) item_counts
FROM ranking R
WHERE item_code IN
	(SELECT I.item_code FROM items I
	WHERE I.dis_price >= 200000)
GROUP BY R.sub_category
ORDER BY item_counts DESC;
-- -----------------
#mission 4
#<메인카테고리와 서브카테고리>별 평균할인가격과 평균할인율을 출력해주세요
#-> 
SELECT 
	main_category, 
    sub_category,
    AVG(dis_price) avg_price,
	AVG(discount_percent) avg_discount
FROM ranking R
JOIN items I ON R.item_code = I.item_code  
GROUP BY R.main_category, R.sub_category;
-- -----------------
#mission 5
#판매자별 베스트 상품갯수, 평균할인가격, 평균 할인률을 갯수 기준 내림차순
SELECT 
	provider,
	COUNT(*) item_counts,
    ROUND(AVG(dis_price)) avg_price,
    ROUND(AVG(discount_percent),2) avg_discount
FROM ranking R
JOIN items I ON R.item_code = I.item_code
WHERE provider <> "" AND provider IS NOT NULL  #-> 빈 문자열이나 결측치가 아닌 것을 찾아오라
GROUP BY provider
ORDER BY item_counts DESC;
-- SQL -> NULL (결측치) -> 결측치 갯수 카운트 할 수 있는 코드 : IS NULL | IS NOT NULL
-- --------------------
#MISSION 6
#메인 카테고리별 상품갯수가 20개 이상인 판매자의 판매자별 평균할인가격,평균할인률, 상품갯수 출력
#
SELECT 
	R.main_category,
	provider,
	ROUND(AVG(dis_price),2) dis_price,
	ROUND(AVG(discount_percent),2) dis_percent,
    COUNT(*) item_count
FROM ranking R
JOIN items I ON R.item_code = I.item_code
GROUP BY R.main_category, provider
HAVING item_count >= 20;
-- ---------------
#mission7
#dis_price 가 5만원 이상인 상품들 중 main_category 별 평균 dis_price, discount_percent 출력하기
#앞에서부터 차근차근해
SELECT 
	main_category, 
	ROUND(AVG(dis_price)) dis_price,
    ROUND(AVG(discount_percent),2) dis_percent
FROM items I
JOIN ranking R ON I.item_code = R.item_code
WHERE dis_price >= 50000
GROUP BY main_category;

















