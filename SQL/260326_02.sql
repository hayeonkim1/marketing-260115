# RANK(), DENSE_RANK(), ROW_NUMBER()
# PARTITION : 칸막이
# UNBOUNDED PRECEDING : 파티션처리가 되어있는 부분집합(그룹) 내 첫번째 행부터~
# UNBOUNDED FOLLOWING : 파티션처리가 되어있는 부분집합(그룹) 내 마지막 행번째 까지~
# CURRENT ROW : 파티션처리가 되어있는 부분집합(그룹) 내부에 위치한 각각의 값 순회
# n PRECEDING/FOLLOWING: 현재 순회중인 해당 값을 기준으로 n번째 앞 또는 n번째 뒤
# 동일한 파티션 구분 > 파티션 내 정렬의 기준도 동일 > 각각의 세부값을 인식하는 관점이 개별적인 행 (row)인가,
# 혹은 각 행들의 공통된 부모 (range)인가에 따라 출력값이 달라질 수 있음
# 집계 함수의 대표 : SUM() -> 특정 컬럼 안에 있는 값을 모두 더하기 위한 목적
# SUM(), SUM() OVER()

WITH genre_revenue AS (
	SELECT
		C.name genre,
        SUM(P.amount) revenue
    FROM payment P
		JOIN rental R USING(rental_id)
		JOIN inventory I USING(inventory_id)
		JOIN film F ON I.film_id = F.film_id
		JOIN film_category FC ON F.film_id = FC.film_id
		JOIN category C USING(category_id)
	GROUP BY C.name
)
SELECT
	genre, revenue,
    SUM(revenue) OVER(
		ORDER BY revenue DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) cumulative_revenue,
    revenue / SUM(revenue) OVER() revenue_ratio
FROM genre_revenue
ORDER BY revenue DESC;

# RANK(), DENSE_RANK(), ROW_NUMBER()
# PARTITION : 칸막이
# UNBOUNDED PRECEDING : 파티션처리가 되어있는 부분집합(그룹) 내 첫번째 행부터~
# UNBOUNDED FOLLOWING : 파티션처리가 되어있는 부분집합(그룹) 내 마지막 행번째 까지~
# CURRENT ROW : 파티션처리가 되어있는 부분집합(그룹) 내부에 위치한 각각의 값 순회
# n PRECEDING/FOLLOWING: 현재 순회중인 해당 값을 기준으로 n번째 앞 또는 n번째 뒤
# 동일한 파티션 구분 > 파티션 내 정렬의 기준도 동일 > 각각의 세부값을 인식하는 관점이 개별적인 행 (row)인가,
# 혹은 각 행들의 공통된 부모 (range)인가에 따라 출력값이 달라질 수 있음
# 집계 함수의 대표 : SUM() -> 특정 컬럼 안에 있는 값을 모두 더하기 위한 목적
# SUM(), SUM() OVER()
# LEAD() : 특정 열을 기준으로 n번째 뒤에 있는 값을 가져올 때
# LAG() : 특정 열을 기준으로 n번째 앞에 있는 값을 가져올 때
# FIRST_VALUE() : 특정 열 > 파티션된 요소 안에서 첫번째 값을 가져올 때
# LAST_VALUE() : 특정 열 > 파티션된 요소 안에서 마지막번째 값을 가져올 때
# DATEDIFF() : 서로 다른 2개의 날짜의 갭 차이를 확인하고자 할 때
# PERCENT_RANK() : 각 행의 백분위 순위를 계산 (0~1)  ->전체를 기준으로 어느 구간/위치에 도달해있는가를 보기 위함 (몇등이야? 가 아닌 어느정도야?)
# CUME_DIST() : 각 행의 누적분포를 계산(0~1)   -> cumulative(누적) distribution(분포)    *누적분포: 밑에서부터 퍼센트 계산 (상위 2% =  98%)
# NTILE() : 각 행을 N개의 그룹으로 분할, 각 그룹에는 거의 같은 수가 분포되게 만듬 (EX. 100개의 행을 3개로 분할해라 => 34,33,33)


SELECT
	rental_id,
    rental_date,
    LAG(rental_id, 1, 0) OVER (ORDER BY rental_date) prev_rental,
    LEAD(rental_id, 1, 0) OVER (ORDER BY rental_date) next_rental
FROM rental;

SELECT
	DISTINCT I.film_id,
    FIRST_VALUE(R.rental_date) OVER (PARTITION BY I.film_id ORDER BY R.rental_date) first_rental,
    LAST_VALUE(R.rental_date) OVER (PARTITION BY I.film_id ORDER BY R.rental_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) last_rental
FROM rental R
JOIN inventory I USING(inventory_id);

USE sakila;
SELECT
	customer_id,
    rental_id,
    rental_date,
    DATEDIFF(
		rental_date,
        LAG(rental_date) OVER (PARTITION BY customer_id ORDER BY rental_date)
    ) days_since_last_rental
FROM rental
ORDER BY customer_id, rental_date;


#PERCENT_RANK()  
	# PERCENT_RANK() = (rank -1) / (전체행수 -1)
		#왜 굳이 분자에서 1을 빼야할까? -> 최소순위= 1등의 포지션 표기 0%지정하기 위함
        #왜 굳이 분모에서도 1을 빼야할까? 마지막 꼴등은 100%지점에 도달하게 하기 위함
# CUME_DIST()
#NTILE() 
SELECT 
	title, length,
    PERCENT_RANK() OVER (ORDER BY length) percent,
    CUME_DIST() OVER(ORDER BY length) cume,
    NTILE(4) OVER(ORDER BY length) group_movie
FROM film;

#NTILE() 
SELECT 
	customer_id, 
    CONCAT(first_name, " ",last_name),
	NTILE(4) OVER(ORDER BY customer_id) customer_group
FROM customer;
