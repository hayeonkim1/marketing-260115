use sakila;
/*
[오늘의 미션] 3/25
1. sakila DB > 상대적으로 가장 최근에 영화를 반납한 상위 10명의 고객 이름과 해당 고객이 대여한 영화의 이름, 그리고 대여기간을 출력해주세요. (고객이름은 customer_name, 영화이름은 movie_title, 대여기간은 rental_duration으로 출력해주세요)
*/
SELECT * FROM customer LIMIT 3; #customer_id 
SELECT * FROM rental LIMIT 10; #customer_id, inventory_id
SELECT * FROM inventory LIMIT 3; #inventory_id, film_id,
SELECT * FROM film LIMIT 3; #film_id, title

SELECT 
	CONCAT(first_name," ", last_name) customer_name,
    title movie_title,
	rental_duration,
    TIMESTAMPDIFF(DAY, return_date,CURDATE()) recent_rental_days
FROM customer C
JOIN rental R USING(customer_id)
JOIN inventory I USING(inventory_id)
JOIN film F USING(film_id)
WHERE TIMESTAMPDIFF(DAY, return_date,CURDATE()) is NOT NULL
GROUP BY R.rental_id
ORDER BY recent_rental_days
LIMIT 10;




/*
2. sakila DB > 각 직원별 달성한 매출을 찾고, 각 직원이 달성한 매출이 회사 전체 매출 중 어느 정도 비율을 차지하는지 찾아주세요. 결과값은 직원ID, 직원이름, 각 직원의 매출, 회사 전체 매출에 대한 비율(%)로 보여주세요
*/
SELECT * FROM staff LIMIT 3; #staff_id, name
SELECT * FROM payment LIMIT 3; #staff_id, amount

SELECT
	S.staff_id,
    CONCAT(first_name, "", last_name) staff_name,
    SUM(P1.amount) staff_amount,
    ROUND(SUM(P1.amount) / (SELECT SUM(P2.amount) FROM payment P2) * 100 , 2) amount_rate
FROM staff S
JOIN payment P1 USING(staff_id)
GROUP BY S.staff_id;












