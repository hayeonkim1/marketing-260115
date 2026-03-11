/*
1) 가상 테이블 생성방법 :VIEW
2) 가상 테이블 생성방법 :WITH

> VIEW : 임시 (목적성) 가상테이블 생성 -> 데이터를 컴퓨터 메모리에 기록
> WITH : 메모리 공간에 저장 X, 선 쿼리구문을 실행하고 가져오는 형식 => 쿼리구문이 종료하면 종료
 -> 메모리에 부담은 줄지만 반복적으로 끌어올 수 없음
 WITH => CTE구문 = COMMON TABLE EXPRESSION
*/

SELECT * FROM film LIMIT 10;
SELECT * FROM inventory LIMIT 10;

SELECT F.film_id, title 
FROM film F
JOIN (SELECT DISTINCT film_id FROM inventory I) IV 
ON F.film_id =IV.film_id;


SELECT F.film_id, F.title 
FROM film F
JOIN (SELECT DISTINCT film_id FROM inventory I) IV 
USING (film_id);
-- => 서브쿼리 + 조인

WITH FilmInventory  AS (
SELECT DISTINCT film_id FROM inventory
) 
SELECT F.film_id, F.title 
FROM film F
JOIN FilmInventroy FI Using  (film_id);

-- with > 서브쿼리 & 상관서브쿼리 & 조인
-- Bigquery // WITHw
