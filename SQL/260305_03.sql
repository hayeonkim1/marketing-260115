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
    
    
*/
SELECT NOW();
SELECT CURDATE();
SELECT CURTIME();

SELECT
	NOW() cur_date_time,
    CURDATE() date_time,
    CURTIME() cur_time;

SELECT
	rental_date,
    DATE_ADD(rental_date, INTERVAL 1 YEAR) dead_line,
    return_date
FROM rental
LIMIT 10;

SELECT
	rental_date,
    DATE_SUB(rental_date, INTERVAL 8 SECOND) dead_line,
    return_date
FROM rental
LIMIT 10;

SELECT
	COUNT(*)
FROM payment
WHERE EXTRACT(HOUR FROM payment_date) = 22;

SELECT
	EXTRACT(MONTH FROM payment_date) payment_month,
    COUNT(*) payment_count
FROM payment
GROUP BY payment_month
ORDER BY payment_count DESC;

SELECT
	*
FROM payment;





SELECT *
FROM payment;

SELECT 
	YEAR(payment_date) payment_year,
    MONTH(payment_date) payment_month,
    DAY(payment_date) payment_day,
	HOUR(payment_date) payment_hour,
    MINUTE(payment_date) payment_minute,
    SECOND(payment_date) payment_second
FROM payment;
-- ---------------
# DAYOFWEEK(): 한주에 해당일이 몇번인지 계산하는 함수
SELECT 
	DAYOFWEEK(payment_date) payment_dayofweek
FROM payment
LIMIT 10;

SELECT 
	DAYOFWEEK(payment_date) payment_dayofweek,
    COUNT(*) dayofweek
FROM payment
GROUP BY payment_dayofweek
ORDER BY dayofweek DESC;


SELECT 
	CASE DAYOFWEEK(payment_date)
		WHEN 1 THEN "일요일"
        WHEN 2 THEN "월요일"
        WHEN 3 THEN "화요일"
        WHEN 4 THEN "수요일"
        WHEN 5 THEN "목요일"
        WHEN 6 THEN "금요일"
        WHEN 7 THEN "토요일"
	END payment_dayname,   #-> CASE가 끝나면 반드시 END 필요
	COUNT(*) total_count
FROM payment
GROUP BY payment_dayname
ORDER BY total_count DESC;

-- -----------------------
# TIMESTAMPDIFF(unit, start_datetime, end_datetime) : start부터 end 날짜/시간 사이의 갭 
SELECT
	rental_date,
    return_date,
	TIMESTAMPDIFF(DAY,rental_date, return_date) rental_days
FROM rental
LIMIT 10;

SELECT
	rental_date,
    return_date,
	TIMESTAMPDIFF(WEEK,rental_date, return_date) rental_weeks
FROM rental
LIMIT 10;
-- ------------------
#DATE_FORMAT(date, format) : 날짜/시간 데이터를 특정 양식의 문자열로 반환
SELECT 
	rental_id,
    rental_date,
    DATE_FORMAT(rental_date, "%y-%m_%d") formatted_rental_date
FROM rental
LIMIT 10;

-- -------------------------
-- -------------------------
/*mission
rental 테이블에서 대여 시작 날짜가 2006년 1월 1일 이후인 모든 대여에 대해서
예상 반납 날짜를 대여날짜로부터 5일 뒤로 설정한 후 해당 테이블 값을 출력해주세요.
*/

SELECT 
	rental_date,
	DATE_ADD(rental_date, INTERVAL 5 DAY) deadline_date #지정날자부터 5일이 경과된 날
FROM rental
WHERE rental_date >= "2006-01-01";







