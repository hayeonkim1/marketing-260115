/*
CASE: 경우 WHERN ~할때 => 같이 실행


*/

SELECT * FROM film LIMIT 10;
-- 특정 조건에 따라 분류하고 싶음

SELECT title,
CASE 
	WHEN rental_rate < 1 THEN "Cheap"
    WHEN rental_rate BETWEEN 1 AND 3 THEN "Moderate"
    ELSE "Expensive"
END AS price_category
FROM film;


-- mission: WITH 절 활용, 각 등급별 영화 상영시간의 평균길이를 출력하세요


SELECT * FROM film;
# 등급별 평균길이
SELECT rating, AVG(length) FROM film GROUP BY rating;

#with절 사용
WITH avgfilmlength AS (
	SELECT rating, AVG(length) 
	FROM film GROUP BY rating
)
SELECT * FROM avgfilmlength;


-- mission: customer 테이블의 고객별 active 여부에 따라 Active 혹은 Inactive 로 출력alter
SELECT * FROM customer LIMIT 10;

SELECT active, 
CASE
	WHEN active = 1 THEN "Active"
    ELSE "Inactive"
END AS customeractive
FROM customer;

-- MISSION: 영화 등급별 평균 대여기간을 WITH 가상 테이블을 활용해서 계산 및 출력alter
SELECT rating, AVG(rental_duration) FROM film GROUP BY rating;

WITH avgrental AS (
	SELECT rating, AVG(rental_duration) 
    FROM film GROUP BY rating
)
SELECT * FROM avgrental;

-- mission: with 절을 사용해서, 고객별 총 결제액을 계산 후 해당 결제 금액 구간에 따라 다음과 같이 카테고리를 분류해주세요.
-- 0-50 : low
-- 51-100 : Medium 
-- 100초과 : High

SELECT * FROM payment;

WITH cus_payment AS (
	SELECT customer_id, SUM(amount) S 
    FROM payment GROUP BY customer_id
)
SELECT customer_id, S, 
CASE 
	WHEN S BETWEEN 0 AND 50 THEN "LoW" 
    WHEN S BETWEEN 51 AND 100 THEN "Medium"
    ELSE "HIGH"
END AS payment_status
FROM cus_payment;