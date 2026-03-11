/*
rental과 inventory 테이블을 join하고 ,film 테이이블에 있는 replacement_cost가 20$이상인 영화를 대여한 고객의 이름을 찾아 소문자로 출력해주세요

*/

SELECT * FROM rental; #inventory_id, customer_id
SELECT * FROM inventory; #inventory_id, film_id, store_id
SELECT * FROM film; #replacement_cost, title, film_id ,
SELECT * FROM customer; #customer_id > first_name, last_name


SELECT 
	C.first_name,C.last_name,
	LOWER(CONCAT(C.first_name," " ,C.last_name)) full_name
FROM customer C
JOIN rental R ON C.customer_id = R.customer_id
JOIN inventory I ON R.inventory_id = I.inventory_id
JOIN film F ON I.film_id = F.film_id
WHERE F.replacement_cost >= 20;

-- -------------------------
#mission2 : 영화 등급이 PG-13인 영화들중 영화의 설명문구의 길이가 평균이상인 영화들의 제목만 찾아ㅓ 출력
#=> 상관서브쿼리


SELECT * FROM rental; #inventory_id, customer_id
SELECT * FROM inventory; #inventory_id, film_id, store_id
SELECT * FROM film; #replacement_cost, title, film_id 
SELECT * FROM customer; #customer_id > first_name, last_name

#pg-13dls 영화들의 설명길이 
SELECT AVG(LENGTH(description)) des_length
FROM film F
WHERE rating = "PG-13";


SELECT title
FROM film F
WHERE rating = "PG-13" AND LENGTH(description) >=(
	SELECT AVG(LENGTH(description)) des_length
	FROM film F
	WHERE rating = "PG-13"
);

-- ------------------
#2005년 8월에 대여된 모든 DVD중 "R"등급에 해당하는 영화만 추출해서 영화들의 제목과 대여한 고객들의 이메일을 찾아서 출력하라
SELECT * FROM rental; #rental_date, inventory_id, customer_id
SELECT * FROM inventory; #inventory_id, film_id, store_id
SELECT * FROM film; #title, film_id 
SELECT * FROM customer; #customer_id, email
#출력대상 => 이메일

SELECT F.title, C.email 
FROM customer C
JOIN rental R ON C.customer_id = R.customer_id
JOIN inventory I ON R.inventory_id = I.inventory_id
JOIN film F ON I.film_id = F.film_id
WHERE 
	MONTH(R.rental_date) = 8
    AND YEAR(R.rental_date) = 2005
	AND F.rating = "R";

#join 할때 그 두테이블만 해당 키가 존재할 경우에는 USING을 통해  
SELECT F.title, C.email 
FROM customer C
JOIN rental R USING(customer_id)
JOIN inventory I USING(inventory_id)
JOIN film F USING(film_id)
WHERE 
	MONTH(R.rental_date) = 8
    AND YEAR(R.rental_date) = 2005
	AND F.rating = "R";

-- ------------------
#MISSION
/*각 고객별 가장 마지막에 결제한 날짜에서 30일 이전까지의 모든 결제 내역을 찾고 
해당 결제 내역에 대해 총 결제금액의 합과 결제 금액의 평균 값을 소숫점 둘째자리에서 반올림해서 출력하라.*/

SELECT * FROM rental; #last_update replacement_cost
SELECT * FROM inventory; #
SELECT * FROM film; #title, film_id 
SELECT * FROM customer; #customer_id, email
SELECT * FROM payment; #payment_date,customer_id, amount

#각 고객별 총 결제금액의 합, 평균값 추출
SELECT 
	customer_id, 
	ROUND(SUM(amount),1) customer_sum,
	ROUND(AVG(amount),1) customer_avg
FROM payment
GROUP BY customer_id;

#조건걸기
SELECT 
	customer_id, 
	ROUND(SUM(amount),1) customer_sum,
	ROUND(AVG(amount),1) customer_avg
FROM payment
WHERE payment_date >= DATE_SUB(
	(SELECT MAX(payment_date) FROM payment), INTERVAL 30 DAY
)
GROUP BY customer_id;

-- -----------------------
/*
MISSION: 영화 장르 중 공상과학영화 장르에 출연한 영화배우의 이름을 찾아서 출력하라. 출력시 배우의 이름은 성,이름을 연결해서 대문자로 출력
*/
SELECT * FROM actor; #first_name,last_name actor_id
SELECT * FROM film_actor; #actor_id, film_id
SELECT * FROM film_category; #film_id, category_id
SELECT * FROM category; #category_id #공상과학 = category_id 14

SELECT 
    UPPER(CONCAT(first_name," ", last_name)) actor_full_name,
    C.category_id
FROM actor A
JOIN film_actor FA ON A.actor_id = FA.actor_id
JOIN film_category FC ON FA.film_id = FC.film_id
JOIN category C ON FC.category_id = C.category_id
WHERE C.category_id = 14;
