/*
1. 문자열 함수 : LENGTH(), UPPER(), LOWER(), CONCAT(), SUBSTRING()
2. 날짜/시간 함수 : NOW(), CURDATE(), CURTIME(), DATE_ADD(date, INTERVAL unit), DATE_SUB(date, INTERVAL unit),
				EXTRACT(field FROM source), YEAR(), MONTH(), DAY(), HOUR(), MINUTE(), SECOND(),
                DAYOFWEEK(), TIMESTAMPDIFF(unit, start_datetime, end_datetime), DATE_FORMAT(date, format)
- INTERVAL unit : YEAR, MONTH, DAY, HOUR, MINUTE, SECOND
- DAYOFWEEK(): 한주에 해당일이 몇번인지 계산하는 함수
	=> 일요일 = 1, 월요일=2, ...
- TIMESTAMPDIFF(unit, start_datetime, end_datetime) : start부터 end 날짜/시간 사이의 갭 
	-> YEAR, MONTH, DAY, HOUR, MINUTE, SECOND 사용 가능
- DATE_FORMAT(date, format) : 날짜/시간 데이터를 특정 양식의 문자열로 반환
	-%Y: 4자리 연도수 표기(2026)
    -%y: 2자리 연도수 표기(26)
    -%M: 영문 월 이름 표기(March)
    -%m: 월을 2자리수로 표기(01-12) 
    -%C: 월을 1자리수로 표기(1-12) 
    -%D: 일을 2자리 수 +영문 접미사 표기 (1st, 21st)
    -%d: 일을 2자리수 (01-31) 
    -%H: 시간을 24시간 형식으로 2자리수 (00-23) 
    -%h: 시간을 12시간 형식으로 2자리수 (01-12 AM/PM)
    -%I: 시간을 12시간 형식으로 1자리수(1-12) 
    -%i: 분을 2자리수 (00-59)
    -%S: 초를 2자리수 (00-59)
    
3. 숫자함수: ABS(number), CEIL(number) ,FLOOR(num), ROUND(number, decimals), SQRT()
	-ABS() : 절대값
    - CEIL(number):올림 ,FLOOR(num): 내림
    -SQRT() : 제곱근 반환하기
    
4. 중첩 서브쿼리
    - 서브쿼리 사용이유: 특정 컬럼 안에 있는 값을 어떤 연산 및 비교를 통해 새로운 값을 도출하려고 할 때, 
	  연산 및 비교대상이 필요!=> 해당 대상을 먼저 생성하고자 할 때 서브쿼리 사용
*/

-- MISSION: customer payment 테이블 활용 평균 결제 금액보다 더 많은 결재를 한 고객을 찾아서 고객의 풀네임 출력

SELECT * FROM customer;
SELECT * FROM payment LIMIT 10;

# 먼저 amount 금액의 평균 계산 => 그래야 각각의 amount값을 평균과 비교가능 

SELECT 
	AVG(amount) avg_amount
FROM payment; 

SELECT 
    CONCAT(first_name," ", last_name) full_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id 
    FROM payment
	WHERE amount > (
		SELECT AVG(amount) FROM payment
	)
);

-- -------------------
#평균 결제횟수보다 더 많은 결제를 한 고객을 찾아서 출력

#1고객별 결제횟수 = subquery1
SELECT  
	COUNT(*) payment_count
FROM payment
GROUP BY customer_id;

#2 평균결제횟수
SELECT 	
	AVG(payment_count)
FROM (
	SELECT COUNT(*) payment_count
	FROM payment
	GROUP BY customer_id
) payment_counts;
    
#3 중보값인 customer_id로 두 테이블 서브쿼리2로 붙이기
SELECT 
	CONCAT(first_name," ", last_name) FULLNAME
FROM customer
WHERE customer_id IN (
	SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING COUNT(*) > (
		SELECT AVG(payment_count)
		FROM (
			SELECT COUNT(*) payment_count
			FROM payment
			GROUP BY customer_id
		) payment_counts
    )
);

-- 위의 쿼리문을 통해 찾은 고객 = vip 고객
#MISSION : 가장 많은 결제를 한 고객을 찾기

#결제횟수
SELECT COUNT(*) payment_count
FROM payment
GROUP BY customer_id;


SELECT 
	CONCAT(first_name," ", last_name) FULLNAME
FROM customer
WHERE customer_id IN (
	SELECT customer_id
    FROM (
		SELECT COUNT(*) payment_count
		FROM payment
		GROUP BY customer_id
	 ) payment_counts
     ORDER BY payment_count DESC
) LIMIT 1;

