/*-- VIEW : 가상 (테이블을 만들어서) 쿼리문 (을 작성한 것)
-- 1) SQL 쿼리문 (복잡), 간소화 -> 테이블 // 서브쿼리, 상관쿼리, 조인 문법 -> 구문을 읽기가 매우 복잡
-- 서브쿼리 > 미리 가상 테이블로 하나 만들어놓고 필요에 따라 불러올 수 있음
-- 2) 데이터 보안
-- 회사 인사데이터 담당자 > 인사데이터 > 내부 인트라넷 병가, 휴가, 인센티브
-- 외주 개발팀 섭외 //
-- VIEW => 원본 데이터를 가지고있는 테이블에서 중요한, 민감한 데이터 필터링한 임시 테이블

-- CREATE VIEW <생성하고자 하는 가상 테이블 이름> AS 쿼리문
*/
CREATE OR REPLACE VIEW ActorInfo AS
SELECT first_name, last_name
FROM actor WHERE actor_id < 100;

SELECT * FROM ActorInfo;

SHOW TABLES;

DROP VIEW ActorInfo;
DROP VIEW actor_info;
DROP VIEW myview;

-- VIEW를 통해서 가상 테이블 생성 -> 원본 테이블 (연결 // 상관)

CREATE OR REPLACE VIEW myview AS
SELECT * FROM customer
WHERE customer_id = 1;

SELECT * FROM myview;
SELECT * FROM customer LIMIT 1;

UPDATE customer SET first_name = "DAVE"
WHERE customer_id = 1;

UPDATE myview SET first_name = "MARY"
WHERE customer_id = 1;

RENAME TABLE myview TO myviewrename;

SHOW TABLES;

/*
ActorInfo 가상테이블 생성. actor 테이블에서 first_name, last_name 컬럼을 모두 포함!!
actor_id가 50미만인 배우만 포함시켜주세요!
*/




