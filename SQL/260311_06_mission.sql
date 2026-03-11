/*
1. comedy, sports, family 카테고리의 category_id를 찾아서 카테고리명과 아이디를 같이 출력
*/
SELECT * FROM category; 
 
 #1)
SELECT category_id, name
FROM category 
WHERE 
	name = "Comedy" or
	name = "Sports" or 
    name = "Family";
 #2)   
SELECT name, category_id
FROM category 
WHERE name IN ("Comedy","Sports","Family");
	
-- 2.MISSION: film_category 테이블 안에서 film_id가 2인 영화의 카테고리 아이디 출력

SELECT * FROM film_category;
SELECT category_id
from film_category
WHERE film_id = 2;

/*
MISSION3: film_category 테이블에서 카테고리 id별 영화 수 조회
*/

SELECT category_id, COUNT(category_id) category_count 
FROM film_category 
GROUP BY category_id;

/*
MISSION4: 카테고리가 comedy인 영화 갯수를 조회.
*/
SELECT * FROM film_category;
SELECT * FROM category;

SELECT name, COUNT(film_id)
FROM film_category
JOIN category USING (category_id)
WHERE name = "Comedy";
-- ------ or ------
SELECT name, COUNT(*) comedy_count
FROM category
JOIN film_category USING (category_id)
WHERE name = "Comedy";
-- ----subquery로 풀기-----
SELECT COUNT(*) 
FROM film_category 
WHERE category_id IN (
	SELECT category_id FROM category
	WHERE name = "Comedy"
);


/*
MISSION5: Comedy, Sports, Family 각각의 카테고리별 영화갯수 조회 및 출력
*/

SELECT * FROM category; #name, category_id
SELECT * FROM film_category; #film_id, category_id

SELECT C.name, COUNT(*) category_count
FROM film_category F
JOIN category C USING(category_id)
WHERE 
	name = "Comedy" or name = "Sports" or name = "Family"
GROUP BY name;
-- ------subquery ----
SELECT 
	C.name,
    COUNT(*)
FROM (
	SELECT category_id, name
	FROM category
	WHERE name = "Comedy" or name = "Sports" or name = "FAMILY"
) C
JOIN film_category F USING (category_id)
GROUP BY C.category_id, C.name;
-- ----상관 서브쿼리------
SELECT C.name , 
	(
		SELECT COUNT(*)
        FROM film_category F
        WHERE C.category_id = F.category_id
	) film_count
FROM category C
WHERE C.name IN ("Comedy","Sports","Family");

/*
MISSION6: 각 카테고리별 영화의 수가 70 이상인 카테고리명을 조회, 출력
*/
SELECT * FROM  film;
SELECT * FROM category; #name, category_id
SELECT * FROM film_category; #film_id, category_id

SELECT 
	C.name, COUNT(*) category_count
FROM category C
JOIN film_category F USING(category_id)
GROUP BY C.category_id
HAVING category_count >= 70 ;

/*
MISSION7: 각 카테고리별 영화렌탈 횟수 조회,출력
*/
SELECT * FROM category; #category_id
SELECT * FROM film_category; #category_id, film_id
SELECT * FROM inventory;#film_id, inventory_id
SELECT * FROM rental; #inventory_id

SELECT C.name, COUNT(*) rental_count
FROM category C
JOIN film_category FC USING(category_id)
JOIN inventory I USING(film_id)
JOIN rental R USING (inventory_id)
GROUP BY C.category_id
ORDER BY rental_count DESC;

/*
[오늘의 미션] 3/11
1. Sakila DB > 한 번도 대여되지 않은 영화 찾기
2. 고객별 누적 결제금액을 등급 분류 & 등급별 상위 3명씩만 조회.출력
총 결제액 100이상 : VIP / 100미만 50이하 : GOLD / 50미만 : SILVER
JOIN (INNER), SubQuery, 상관 SubQuery, WITH, VIEW 어떤 것을 사용해도 무관함
*/
#1. 
-- title을 찾아오기 위해 film_id로 film, inventory innerjoin
-- 대여횟수 :0 => inventory_id 는 있지만 rental_id는 없는 영화 => inventory 랑 rental OUTERJOIN =>rental_id가 NULL인 영화 제목

SELECT * FROM film; #film_id, title
SELECT * FROM inventory;#film_id, inventory_id
SELECT * FROM rental; #inventory_id, rental_id

SELECT title
FROM film F
JOIN inventory I USING (film_id)
LEFT JOIN rental R USING (inventory_id)
WHERE rental_id IS NULL;
-- ---------------
#2.
/*고객별 누적 결제금액을 등급 분류 & 등급별 상위 3명씩만 조회.출력
총 결제액 100이상 : VIP / 100미만 50이하 : GOLD / 50미만 : SILVER
JOIN (INNER), SubQuery, 상관 SubQuery, WITH, VIEW 어떤 것을 사용해도 무관함*/
SELECT * FROM customer; #customer_id, name
SELECT * FROM payment; #customer_id ,amount

SELECT 
	CONCAT(first_name," ", last_name) full_name, 
    SUM(amount) total_amount
FROM customer C
JOIN payment P USING(customer_id)
GROUP BY C.customer_id;

SELECT 
	grade, 
FROM (
	SELECT 
		full_name,
		total_amount,
		CASE 
			WHEN total_amount >= 100 THEN "VIP"
			WHEN total_amount BETWEEN 50 AND 100 THEN "GOLD"
			ELSE "SILVER"
		END AS grade
	FROM(
		SELECT 
			CONCAT(first_name," ", last_name) full_name, 
			SUM(amount) total_amount
		FROM customer C
		JOIN payment P USING(customer_id)
		GROUP BY C.customer_id
		) customer
) customer_grade
GROUP BY grade;



SELECT 
	full_name,
    total_amount,
    CASE 
		WHEN total_amount >= 100 THEN "VIP"
		WHEN total_amount BETWEEN 50 AND 100 THEN "GOLD"
		ELSE "SILVER"
	END AS grade
FROM(
    SELECT 
	CONCAT(first_name," ", last_name) full_name, 
    SUM(amount) total_amount
FROM customer C
JOIN payment P USING(customer_id)
GROUP BY C.customer_id
) customer;
-- ------------------    
