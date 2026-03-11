/*
중급 문법 마지막
> CONCAT() :컬럼간 문자열을 하나로 합쳐서 새로운 컬럼으로 출력
> GROUP_CONCAT() : 1개의 컬럼 내 여러개의 행이 존재하는 경우 , 그 각각의 행에 존재하는 문자열을 하나의 셀 안으로 합치고자 할 때
*/
SELECT 
	C.customer_id,
    CONCAT(C.first_name, " ", C.last_name) customer_name,
    GROUP_CONCAT(F.title ORDER BY F.title ASC) rented_movies
FROM customer C
JOIN rental R on C.customer_id = R.customer_id
JOIN inventory I on R.inventory_id = I.inventory_id
JOIN film F on I.film_id = F.film_id
GROUP BY C.customer_id;



SELECT 
	C.customer_id,
    CONCAT(C.first_name, " ", C.last_name) customer_name,
    GROUP_CONCAT(F.title ORDER BY F.title ASC SEPARATOR " / ") rented_movies
FROM customer C
JOIN rental R USING(customer_id)
JOIN inventory I USING(inventory_id)
JOIN film F USING(film_id)
GROUP BY C.customer_id;

-- MISSION: 각 배우들이 출연한 영화제목을 세미콜론을 구분자로 구분하여 하나의 셀에 출력해주세요.
-- 최종 출력되야할 값들은 영화배우아이디, 영화배우 이름(first,last name), 출연했던 영화제목 리스트
SELECT * FROM actor; #actor_id, name
SELECT * FROM film; #film_id, title
SELECT * FROM film_actor; #film_id, actor_id

SELECT 
	actor_id, 
    CONCAT(A.first_name," " , A.last_name)
FROM film
JOIN film_actor FA USING(film_id)
JOIN actor A USING(actor_id)
GROUP BY A.actor_id;


SELECT  #--> FROM actor 로 다시하기
	actor_id, 
    CONCAT(A.first_name," " , A.last_name) full_name,
    GROUP_CONCAT(F.title ORDER BY F.title SEPARATOR " ; ") films
FROM film
JOIN film_actor FA USING(film_id)
JOIN actor A USING(actor_id)
GROUP BY A.actor_id;






