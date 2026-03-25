USE sakila;

/*
MISSION13: 최근 젊은 가족단위의 매출이 저도해서 가족들이 볼만한 영화들을 추려서 마케팅을 하려고 합니다
현재 우리가 가지고 있는 영화들 증에서 장르가 가족인 영화리스트(제목)만 조회, 출력해주세요

*/

SELECT * FROM category; #category_id, category
SELECT * FROM film_category; #category_id, film_id
SELECT * FROM film; # film_id,film title

SELECT F.title
FROM film F
JOIN film_category FC USING(film_id)
JOIN category C USING(category_id)
WHERE F.name = "Family"; 

/*
MISSION14: 현재 우리가 가지고있는 영화들 중 가장 인기가 많은 영화 100개만 조회, 영화제목, 대여횟수 출력
*/

SELECT * FROM film LIMIT 10; #film_id
SELECT * FROM rental LIMIT 10; #rental_id , inventory_id
SELECT * FROM inventory LIMIT 10; #film_id, invetory_id
SELECT * FROM payment LIMIT 10; #rental_id, payment_id

SELECT 
	film_id, F.title, COUNT(*) rentals
FROM film F
JOIN inventory I USING(film_id)
JOIN rental R USING(inventory_id)
GROUP BY film_id
ORDER BY rentals DESC
LIMIT 100;

/*
MISSION15: 연말이 되어 각 국가 내 도시별 매장 매출에 따라 인센티브를 제공하려합니다.
국가 > 도시별 총 매출을 기준으로 데이터를 조회,출력 
출력대상: 국가,도시, 총매출액
*/

SELECT * FROM country LIMIT 10; #country, country_id
SELECT * FROM city LIMIT 10; #country_id, city_id, city
SELECT * FROM address LIMIT 10; # city_id,address_id,
SELECT * FROM store; # address_id, store_id,
SELECT * FROM customer LIMIT 10; #store_id, customer_id 
SELECT * FROM payment LIMIT 10; # customer_id

SELECT 
	CONCAT(CO.country," ", CI.city) zone,
	S.store_id,
    ROUND(SUM(P.amount)) total_amount
FROM country CO
JOIN city CI USING(country_id)
JOIN address A USING(city_id)
JOIN store S USING(address_id)
JOIN customer C USING(store_id)
JOIN payment P USING(customer_id)
GROUP BY S.store_id;

/*
MISSION16: 지금까지의 렌탈한 기록을 기준으로 최상위 주요고객 10명에게 감사의 선물을 발신할 예정입니다.
최상위 주요 고객의 주소, 이메일, 해당 고객의 렌탈 결제 총 금액을 출력,조회
최상위 주요 고객 자격기준: 렌탈 결제 금액순(내림차순)

-렌탈비용 합계
*/
SELECT * FROM address LIMIT 10; #address_id
SELECT * FROM customer LIMIT 10; #address_id,store_id,customer_id
SELECT * FROM rental LIMIT 10; # customer_id, rental_id, invetroy_id
SELECT * FROM payment LIMIT 10; # rental_id,customer_id


SELECT 
	CONCAT(first_name, " ", last_name) full_name,
	A.adress,
    SUM(P.amount) total_amount
FROM payment P
JOIN customer C USING(customer_id)
JOIN address A USING(address_id)
GROUP BY P.customer_id
ORDER BY total_amount DESC
LIMIT 10;


/*
MISSION17:영어를 모국어로 사용중인 영화 중 , 영화제목이 K 또는 Q로 시작하는 영화의 제목을 조회,출력
*/
SELECT * FROM film LIMIT 10; #title, film_id, language_id
SELECT * FROM language LIMIT 10; #language_id ,name

SELECT F.title
FROM film F
JOIN language L USING(language_id)
WHERE L.name = "English" AND (F.title LIKE "K%" OR F.title LIKE "Q%");

#L_: 갯수만큼/ L%: 뒤에 갯수와 무관하게 L

