use sakila;
/*
[오늘의 미션] 3/26

sakila DB > 고객별 결제 날짜에 따른 누적 결제 금액을 출력. 출력 시, 나타나야 하는 값 : 결제 id, 고객 id, 결제 날짜, 결제 금액, 누적 결제 금액
sakila DB > 영화 등급별 대여기간의 평균을 출력. 출력 시, 나타나야 하는 값 : 영화 id, 등급, 평균대여기간(대여시점 ~ 반납시점)
sakila DB > 각 직원별 대여날짜에 따른 대여횟수, 누적 대여횟수를 구하세요. 출력 시 나타나야 하는 값 : 대여 id, 직원 id, 대여날짜, 대여횟수, 누적 대여횟수
*/

#mission 1
SELECT * FROM rental LIMIT 5; #rental_id, customer_id, rental_date
SELECT * FROM payment LIMIT 5; #payment_id, customer_id, rnetal_id, amount, payment_date

SELECT 
	payment_id,
	customer_id,
    payment_date,
    amount,
    SUM(amount) OVER (PARTITION BY customer_id ORDER BY payment_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) culmulative_payment
FROM payment;

#mission2: sakila DB > 영화 등급별 대여기간의 평균을 출력. 출력 시, 나타나야 하는 값 : 영화 id, 등급, 평균대여기간(대여시점 ~ 반납시점)

SELECT * FROM rental LIMIT 5; #rental_id, customer_id,inventory_id rental_date, return_date,
SELECT * FROM inventory LIMIT 5; #inventory_id, film_id
SELECT * FROM film LIMIT 5; #fild_id, rating

SELECT 
	film_id,
    rating
 --   AVG(DATEDIFF(rental_date, return_date))
FROM rental R
JOIN inventory I USING(inventory_id)
JOIN film F USING(film_id);
GROUP BY rating;




