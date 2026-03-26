# window function
# window = 창
# 기존 그룹 생성 > 그룹 내 연산처리를 하기 위한 목적 나온 신 문법
# DB > Table > scheme > data (column)
# 조회 > 그룹 > 서브쿼리, 상관서브쿼리, WITH, VIEW
# 낱개의 단일 데이터를 조회.수집
# 그룹단위의 복수의 데이터를 조회.수집
# 그룹단위가 많아질수록 쿼리문 작성 & 처리 > 2가지 불편함
# 1) 쿼리문을 작성하는 개발자의 전문지식, 노하우 에러, 버그
# 2) 서브쿼리, 상관서브쿼리 > 데이터가 많아질수록 속도저하
# 2018. 2 베타 -> 2018 6 정식

# RANK(), DENSE_RANK(), ROW_NUMBER()
# RANK() : 특정 컬럼 내 순위를 부여하는 함수
# > 순위를 부여하는데, 동일한 값이 발생 -> 공동 2등 3명
# 1등 1명, 2등 3명, 다음번째 등장하는 사람 5등
# DENSE_RANK() : 특정 컬럼 내 순위를 부여하는 함수
# DENSE = 빽빽하다, 촘촘한
# ROW_NUMBER() : 무조건 순번 지정	

USE sakila;
SELECT * FROM film LIMIT 10;
-- title, length

SELECT
	title, length,
    RANK() OVER (ORDER BY length DESC) ranking,
    DENSE_RANK() OVER (ORDER BY length DESC) dense_ranking,
    ROW_NUMBER() OVER (ORDER BY length DESC) row_nubers
FROM film
ORDER BY length DESC;

SELECT * FROM customer LIMIT 10;
-- customer_id, first_name, last_name
SELECT * FROM payment LIMIT 10;
-- customer_id, amount

SELECT
	C.customer_id,
	CONCAT(C.first_name, " ", C.last_name) customer_name,
    SUM(P.amount) total_amount,
    RANK() OVER (ORDER BY SUM(P.amount) DESC) ranking,
    DENSE_RANK() OVER (ORDER BY SUM(P.amount) DESC) dense_ranking,
    ROW_NUMBER() OVER (ORDER BY SUM(P.amount) DESC) row_numbers
FROM customer C
JOIN payment P USING (customer_id)
GROUP BY C.customer_id;

# PARTITION : 칸막이

# UNBOUNDED PRECEDING : 파티션처리가 되어있는 부분집합(그룹) 내 첫번째 행부터~
# UNBOUNDED FOLLOWING : 파티션처리가 되어있는 부분집합(그룹) 내 마지막 행번째 까지~
# CURRENT ROW : 파티션처리가 되어있는 부분집합(그룹) 내부에 위치한 각각의 값 순회
# n PRECEDING/FOLLOWING: 현재 순회중인 해당 값을 기준으로 n번째 앞 또는 n번째 뒤

SELECT * FROM rental LIMIT 10; -- customer_id, rental_date

SELECT
	customer_id,
    rental_date,
    COUNT(*) OVER (PARTITION BY customer_id ORDER BY rental_date) cumulative_rentals
FROM rental;

SELECT
	customer_id,
    rental_date,
    COUNT(*) OVER (PARTITION BY customer_id ORDER BY rental_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) cumulative_rentals
FROM rental;

SELECT
	customer_id,
    rental_date,
    COUNT(*) OVER (PARTITION BY customer_id ORDER BY rental_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_rentals
FROM rental;

SELECT
	customer_id,
    rental_date,
    COUNT(*) OVER (PARTITION BY customer_id ORDER BY rental_date
    ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) cumulative_rentals
FROM rental;

SELECT * FROM payment LIMIT 10; -- rental_id, amount
SELECT * FROM rental LIMIT 10; -- rental_id, customer_id

SELECT 
	R.customer_id,
    R.rental_date,
    P.amount,
    SUM(P.amount) OVER (PARTITION BY R.customer_id ORDER BY R.rental_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_payment_amount,
    AVG(P.amount) OVER (PARTITION BY R.customer_id ORDER BY R.rental_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) avg_payment_amount,
	AVG(P.amount) OVER (PARTITION BY R.customer_id ORDER BY R.rental_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) total_payment_amount
FROM rental R
JOIN payment P USING (rental_id)
ORDER BY R.customer_id;

SELECT 
	R.customer_id,
    R.rental_date,
    P.amount,
    
    SUM(P.amount) OVER (PARTITION BY R.customer_id ORDER BY DATE(R.rental_date)
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_payment_amount_01,
    
    DATE(R.rental_date),
    
    SUM(P.amount) OVER (PARTITION BY R.customer_id ORDER BY DATE(R.rental_date)
    RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_payment_amount_02,
    
    AVG(P.amount) OVER (PARTITION BY R.customer_id ORDER BY R.rental_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) avg_payment_amount,
	AVG(P.amount) OVER (PARTITION BY R.customer_id ORDER BY R.rental_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) total_payment_amount
FROM rental R
JOIN payment P USING (rental_id)
ORDER BY R.customer_id;

# 동일한 파티션 구분 > 파티션 내 정렬의 기준도 동일 > 각각의 세부값을 인식하는 관점이 개별적인 행 (row)인가,
# 혹은 각 행들의 공통된 부모 (range)인가에 따라 출력값이 달라질 수 있음


