use sakila;
/*
mission18: 영화 Alone Trip에 출연한 배우들의 이름을 모두 출력
단 서브쿼리로 해결하기
*/
SELECT * FROM film LIMIT 10; #film_id, title
SELECT * FROM actor LIMIT 10; #actor_id, #name
SELECT * FROM film_actor LIMIT 10; #actor_id, film_id

#Alone Trip의 film_id
SELECT film_id
FROM film
WHERE title = "Alone Trip";

#film_id 17의 actor_id 찾기
SELECT actor_id
FROM film_actor
WHERE (
	SELECT film_id
	FROM film
	WHERE title = "Alone Trip"
);


#actor_id마다 배우 이름 찾아오기
SELECT 
	actor_id,
	CONCAT(first_name, " ",last_name)
FROM actor
WHERE actor_id IN(
	SELECT actor_id
	FROM film_actor
	WHERE (
		SELECT film_id
		FROM film
		WHERE title = "Alone Trip"
		)
);


/*
mission19: 2005년 8월 한달간 발생된 매출에 한해서, 매출을 발생시킨 스텝의 이름과 해당스텝이 발생시킨 매출을 조회
*/
SELECT * FROM payment limit 10; #staff_id, payment_id, rental_id, amount
SELECT * FROM staff limit 10; #staff_id, name

SELECT 
	CONCAT(S.first_name, " ",S.last_name) staff_member,
    SUM(amount) total_amount
FROM staff S
JOIN payment P USING(staff_id)
WHERE 
	YEAR(payment_date) = 2005 AND 
    MONTH(payment_date)=8
GROUP BY P.staff_id
ORDER BY total_amount DESC;

/*
mission20: 각 영화 장르별 평균 러닝타임(상영시간) 존재
해당 장르별 평균 상영시간이 모든 장르를 통합했을때의 평균 상영시간보다 큰 경우에 한해 
해당 장르와 상영시간을 조회
*/
SELECT * FROM film LIMIT 10; #length #film_id
SELECT * FROM film_category LIMIT 10; #film_id, category_id
SELECT * FROM category LIMIT 10; #category_id,name

#전체 장르 평균 상영시간
SELECT AVG(length) FROM film;

#장르별 평균상영시간
SELECT 
	C.name,
    AVG(F.length) category_runtime
FROM film F
JOIN film_category FC USING(film_id)
JOIN category C USING(category_id)
GROUP BY C.name
HAVING category_runtime > (
	SELECT AVG(length) FROM film
)
ORDER BY category_runtime DESC;

/*
mission21:
*/


