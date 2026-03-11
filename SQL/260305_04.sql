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
    
*/

#-ABS() : 절대값
SELECT ABS(-1) abs_num;

# - CEIL(number):올림 ,FLOOR(num): 내림
SELECT 
	CEIL(ABS(amount)),
    FLOOR(ABS(amount)),
    ROUND(amount, 1)
FROM payment
LIMIT 10;

# -SQRT() : 제곱근 반환하기
SELECT SQRT(4);
-- ---------
#MISSION 
-- payment테이블에서 결제금액(amount)이 5이하인 모든 결제건에 대해서 해당 결제금액을 절대값 적용. 출력alter
SELECT ABS(amount)
FROM payment
WHERE amount <= 5;
#2 
/*
film테이블에서 영화상영시간(길이)가 120분 이상인 모든 영화에 대해
영화상영시간의 제곱근을 계산, 출력
*/
SELECT
	title,
    ROUND(SQRT(length),2) SQRT_num
FROM film
WHERE length >= 120;
















