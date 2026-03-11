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
    -CEIL(number):올림 ,FLOOR(num): 내림
    -SQRT() : 제곱근 반환하기
    
4. 중첩 서브쿼리
    - 서브쿼리 사용이유: 특정 컬럼 안에 있는 값을 어떤 연산 및 비교를 통해 새로운 값을 도출하려고 할 때, 
	  연산 및 비교대상이 필요!=> 해당 대상을 먼저 생성하고자 할 때 서브쿼리 사용
5. 상관 서브쿼리: 서브쿼리처럼 내,외부 서브쿼리 문장을 작성하긴 하나 내부쿼리문을 작성할 때, 외부쿼리문에서 값을 의존(참조)하는 방식 

6. 집합: UNION(중복된 값을 1번만 사용하는 구문) , UNION ALL (중복된 값을 모두 사용하는 구문)
		INTERSECT (교집합의 역할), EXCEPT(차집합의 역할)
        
7. 트랜잭션 & 롤백: TRANSACTION(= 거래)
	-어떤 쿼리 구문을 작성, 실수로 값을 누락 혹은 중복등을 했을 경우를 대비해서 트랜잭션을 설정해놓으면 
    -> 롤백을 통해 뒤로가기 가능!
    -> 트랜잭션 가운데 코드를 작성했다고 해서 해당 코드가 완전하게 적용된 것은 x
    -> 컴퓨터 안 임시메모리 공간 안에 임시적으로 코드가 기록되어있는 것.
    -> 임시메모리 공간 지속사용 시 컴퓨터 처리속도가 매우 느려짐.-> 더이상 저장을 못하게 되기도 함
    => 커밋 기능 => 임시 메모리 공간에 저장되어있는 코드가 정상적인 메모리 공간에 할당
    => 커밋을 하는 순간 롤백은 불가
        
        
*/

CATEGORY NAME
TITLE
PRICE
STOCK


-- SELECT * FROM customer LIMIT 10;
-- UPDATE customer
-- SET first_name = "DAVE";