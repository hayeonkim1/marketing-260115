/*
MISSION8: comedy, sports, family 카테고리에 해당되는 영화들의 렌탈횟수 출력 
출력시 카테고리 이름, 렌탈횟수 출력
*/
USE sakila;

SELECT * FROM category; #category_id, name
SELECT * FROM film_category; #film_id, category_id
SELECT * FROM inventory; # film_id, inventory_id
SELECT * FROM rental; #inventory_id, rental_id

SELECT 
	c.name, COUNT(*) rental_count
FROM category C
JOIN film_category FC USING(category_id)
JOIN inventory I USING(film_id)
JOIN rental R USING(inventory_id)
WHERE name IN ("Comedy","Sports", "Family")
GROUP BY C.category_id
ORDER BY rental_count DESC;


/*
MISSION9: Comedy 카테고리인 영화들의 렌탈 횟수를 조회, 출력(서브쿼리로 해결)
*/
# 카테고리가 코미디인 영화들 먼저 정의
SELECT category_id 
FROM category
WHERE name = "Comedy";

SELECT * FROM category; #category_id, name
SELECT * FROM film_category; #film_id, category_id
SELECT * FROM inventory; # film_id, inventory_id
SELECT * FROM rental; #inventory_id, rental_id

#1차 연결점인 film_id로 film_category 연결
SELECT film_id
FROM film_category
WHERE category_id IN(
	SELECT category_id
	FROM category
	WHERE name = "Comedy"
); 

SELECT inventory_id FROM inventory
WHERE film_id IN (
	SELECT film_id
	FROM film_category
	WHERE category_id IN(
		SELECT category_id
		FROM category
		WHERE name = "Comedy"
	)
);

#최종
SELECT COUNT(*) comedy_rental_count FROM rental
WHERE inventory_id IN (
	SELECT inventory_id FROM inventory
	WHERE film_id IN (
		SELECT film_id
		FROM film_category
		WHERE category_id IN(
			SELECT category_id
			FROM category
			WHERE name = "Comedy"
		)
	)
);
/*
MISSION10: Comedy 카테고리 영화의 갯수를 조회, 출력하기
*/
SELECT * FROM category; #category_id, name
SELECT * FROM film_category; #film_id, category_id
SELECT * FROM inventory; # film_id, inventory_id
SELECT * FROM rental; #inventory_id, rental_id


SELECT * FROM category
WHERE name = "Comedy";

SELECT C.name, COUNT(*) comedy_film_count
FROM category C
JOIN film_category FC USING(category_id)
WHERE name = "Comedy";

/*
MISSION11: address 테이블에는 address_id가 존재하지만 customer 테이블에는 address_id가 존재하지 않는 데이터의 갯수를 출력해라
*/
SELECT COUNT(*) NULL_COUNT
FROM address
LEFT JOIN customer USING(address_id)
WHERE customer_id IS NULL; 

/*
[오늘의 미션] 3/12
Sakila DB > 카테고리별 대여횟수 TOP3인 영화 조회.찾기
Sakila DB > 월별 매출에 따른 증감률 구해서.출력 (현재매출 - 전월매출 / 전월매출) * 100
*/

SELECT * FROM film 

