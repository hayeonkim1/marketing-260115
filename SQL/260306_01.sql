/*
DDL
DML
DCL
JOIN /INNER JOIN / LEFT JOIN /RIGHT JOIN
문자열 함수/ 날짜 / 숫자
서브쿼리 : 어떤 쿼리문을 작성하는데 있어서 사전에 필요한 자료를 독립적으로 취합함으로써 
		전체 쿼리문의 가독성을 높여주는 문법 (연결성 존재 x, 독립적 0)
        ex) 전체 학생의 점수와 나의 점수를 비교해야할 때 전체학생의 점수데이터의 평균점수 값을 서브쿼리화해서 내 점수와 비교
        
상관(연결-Correlated)서브쿼리 : 쿼리문안에 별도의 쿼리문
		내부의 쿼리문이 외부의 쿼리문에 있는 값에 영향을 받고 있음.
        ex) 전체 학생의 점수 데이터에서 1반 학생들만의 점수를 각각 참조해와서 반평균을 내고 내 점수와 비교하는 것
			=> 전체 학생데이터에서 1반 학생들의 점수를 끌어와야한다는 점에서 상관관계alter
	=> 전체 데이터는 엑셀 마지막셀에 점수들의 SUM 값만 나와있는 데이터. 그중에서 1반 점수를 각 셀에서 추출해와야 1반 평균 산정가능
*/

-- 각 고객 >  DVD 렌탈, 결재금액 지불// 그동안 결재한 금액 평균값보다 큰 금액으로 결제한 정보를 찾고싶음 
USE sakila;
SHOW TABLES;
SELECT * FROM payment LIMIT 10;

#1)고객의 한번 결제시 결제정보
SELECT customer_id, amount, payment_date
FROM payment p;

# 2)한 고객당 평균 지불 금액
SELECT customer_id, COUNT(*), AVG(amount)
FROM payment
GROUP BY customer_id;


-- ====> 두 쿼리 모두 payment라는 뿌리를 참조할
SELECT p1.customer_id, p1.amount, p1.payment_date
FROM payment p1
WHERE p.amount > (
	SELECT customer_id, COUNT(*), AVG(amount)
	FROM payment p2
	WHERE p2.customer_id = p1.customer_id
);


-- --------------------------------------
#film테이블에서 영화길이(length)의 평균값을 구해서 해당 영화길이보다 긴 영화들의 제목(title)을 찾아라
-- => 서브쿼리
SELECT 
	title
    length
FROM film 
WHERE length > (
	SELECT AVG(length)
    FROM film
);

#rental 테이블에서 고객별 대여 횟수보다 더 많은 대여를 한 고객들의 이름을 출력
SELECT * FROM customer LIMIT 10;
SELECT * FROM rental LIMIT 10;

# 1)고객별 대여횟수
SELECT customer_id, COUNT(*)
FROM rental
GROUP BY customer_id;

#2)평균 대여횟수
SELECT 
	AVG(rental_count)
FROM(
	SELECT COUNT(*) rental_count
	FROM rental
	GROUP BY customer_id
) rental_counts;


SELECT 
	CONCAT(first_name, " " , last_name) full_name
FROM customer
WHERE customer_id IN (             #join대신 서브쿼리 사용
	SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) > (
		SELECT 
		AVG(rental_count)
		FROM(
			SELECT COUNT(*) rental_count
			FROM rental
			GROUP BY customer_id
		) rental_counts
	)
);


-- 가장 많은 영화를 대여한 고객의 이름을 찾아보세요

SELECT * FROM customer; #고객정보
SELECT * FROM rental; #대여횟수

#1)
SELECT COUNT(*)
FROM rental
GROUP BY customer_id;

#2)
SELECT customer_id
FROM(
	SELECT customer_id, COUNT(*) rental_count
	FROM rental
	GROUP BY customer_id
    ORDER BY rental_count DESC
    LIMIT 1
)t;

#3)
SELECT 
	 CONCAT(first_name," ", last_name) 
FROM customer
WHERE customer_id = (
	SELECT customer_id
	FROM(
		SELECT customer_id, COUNT(*) rental_count
		FROM rental
		GROUP BY customer_id
		ORDER BY rental_count DESC
		LIMIT 1
	)t
);

-- ------------------------
#각 고객별 자신이 대여한 영화들의 평균 상영시간보다 긴 영화들의 제목을 찾아서 출력
-- 고객별 대여한 영화 상영시간
-- 평균 상영시간 
-- 평균보다 긴 영화
-- 제목출력

SHOW TABLES;
SELECT * FROM customer; #고객정보 /customer_id
SELECT * FROM film; #영화 길이 , 영화제목 /film_id
SELECT * FROM inventory; #재고 관련 정보 / film_id, inventroy_id
SELECT * FROM rental; #렌탈관련 정보 / customer_id, rental_id, inventroy_id


SELECT C.first_name, C.last_name, F.title
FROM customer C
JOIN rental R ON C.customer_id = R.customer_id
JOIN inventory I ON R.inventory_id = I.inventory_id
JOIN film F ON I.film_id = F.film_id
WHERE F.length > (
	SELECT AVG(F.length)
	FROM customer C
	JOIN rental R ON C.customer_id = R.customer_id
	JOIN inventory I ON R.inventory_id = I.inventory_id
	JOIN film F ON I.film_id = F.film_id
    WHERE C.customer_id = R.customer_id
);


/*
1) 서브쿼리: 쿼리문 안에 쿼리문 > 내부 쿼리문 작성 시, 독립적으로 쿼리문작성 
2) 상관서브쿼리: 쿼리문 안에 쿼리문 > 내부 쿼리문 작성 시, 외부 쿼리문의 값을 참조(상관)
*/















