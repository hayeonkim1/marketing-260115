-- 현업에서 데이터를 취급하는 포지션에 입사
-- 중고신입: OJT= On The Job Training
-- 데이터 분야는 특히 교육안해줌

-- 데이터 스캐닝: 각 테이블당 컬럼들간의 상관관계 분석 -> 컬럼 내 결측치 -> 어떤 타입으로 변환할지 결정 (EDA)



USE sakila;

SHOW TABLES;

DESC country;

-- 국가정보
SELECT *
FROM country
LIMIT 5;

-- 영화정보
SELECT * FROM film LIMIT 10;
-- 코드를 보고있는데 책을 읽고 있는 것 같은 느낌이 드는 코드가 있음 그게 좋은 거

-- 집계 함수 = 수치형(숫자형 데이터를 분류,집계)-> COUNT()
-- 처음부터 무조건 SELECT로 끌어오지 말고 COUNT로 데이터 개수를 확인하고 LIMIT 를 걸어서 수집하기
-- 시간의 흐름에 따라 데이터를 바라볼 수 있음
-- 일반적으로 데이터를 크게 2개의 부류로 나눌때 
-- 1) 수치형 - 범주형(그룹화 대상 ex)남/여, 10대/20대)
-- 범주형 데이터 -> 중복값을 최대한 경계

SELECT COUNT(*) FROM film;
SELECT DISTINCT rating FROM film; 

-- 언제 데이터인지 알아보기
SELECT DISTINCT release_year FROM film;

SELECT COUNT(*) FROM rental;

SELECT * FROM rental LIMIT 10;

-- 어떤 데이터를 수집, 생성하든-> 식별값이 필요 => ID가 가장 보편적
-- 검색조건 빠르게,  인덱싱 & 삭제. 업데이트에 도움
SELECT * FROM inventory LIMIT 10;

-- 조건절 // 
-- WHERE절 = 조건문
-- 문장, 미션을 세워놓고 -> 해결하기 위해 어떤 구문을 어떤 순서대로 사용할지를 머리 속 정리학습alter
-- => 많은 문제를 경험하는 것 밖에 공부방법이 없음
SELECT * FROM rental WHERE inventory_id = 367;


SELECT *FROM customer LIMIT 10;
SELECT COUNT(*) FROM customer;

-- 셜록홈즈: 2006년, 약 1만6천여개의 dvd 렌탈 데이터 정보, 실제대여고객수 599명
-- 수치형 데이터 : 집계함수 
-- 집계함수 : COUNT(), SUM(), AVG(), MAX(), MIN()
-- 범주형 데이터: DISTINCT

SELECT * FROM customer LIMIT 10;
SELECT COUNT(*) FROM customer;
SELECT MIN(customer_id) FROM customer;
SELECT AVG(customer_id) FROM customer;
SELECT SUM(customer_id) FROM customer;

SELECT * FROM payment LIMIT 10;
-- 아래 컬럼 내의 정보값을 보면서 구두로 설명-> 데이터를 ㅇ릭어내려감. => 데이터 리터러시 능력
-- 다양한 도메인 기초정보 & 지식 => 데이터가 무엇을 이야기하는가-> 수치를 보고 어떤 문제를 제기하고 해결책을 제안할 수 있는가

SELECT 
	SUM(amount) , AVG(amount), 
    MAX(amount), MIN(amount) 
FROM payment;
-- 경쟁사의 업계의 인기 상품들의 객단가를 통해 평균 금액 책정할 수 있음


-- SFW
SELECT * FROM rental 
WHERE inventory_id = 367 AND staff_id =1;

-- 그룹핑: 그룹화하는 것// 특정 조건에 따라 분류해야하는 상황
-- GROUP BY 사용 


-- !!SQL 순서!!
-- SELECT + 컬럼
-- FROM + 테이블명
-- WHERE + 조건
-- GROUP BY +컬럼 (--> 그룹화는 주로 WHERE 뒷순서)
-- ORDER BY +컬럼
-- LIMIT 출력 갯수(위에서부터 ) 


-- GROUP BY VS DISTINCT
SELECT rating, COUNT(*) FROM film 
GROUP BY rating;
-- -> 중복해서 노출된 데이터들을 공통된 패턴에 따라 하나의 그룹(폴더)에 담아놓은 상태

SELECT DISTINCT rating ,COUNT(*) FROM film; 
-- -> 중복된 값이라고 판단되는 요소들을 한번씩만 출력하자(-> 나머지는 제거)

SELECT 
	rating, COUNT(*)
FROM film
WHERE rating= "PG" OR rating = "G"
GROUP BY rating;

SELECT title, rating FROM film
WHERE rating = "G" OR rating = "PG"
ORDER BY rating DESC;

SELECT title, rating FROM film
WHERE rating = "G" OR raing = "PG"
GROUP BY rating
ORDER BY rating DESC;

-- GROUP BY를 통해 특정 컬럼을 그룹화했다면 해당 컬럼 외 값을 출력하고자 할때 그 요소 역시 집계함수로 설정해줘야함.
-- 만약, 출력하고자 하는 값들의 집계함수를 사용하지 않을 경우, 굳이 그룹화 불필요함!

SELECT title FROM film 
WHERE (rating= "G" OR rating = "PG") AND 
(release_year = 2006 OR release_year = 2007);

-- film 테이블에서 각 등급별 그룹화 후 해당 등급별 영화갯수,  출력
SELECT  rating, COUNT(*), AVG(rental_rate)
FROM film
GROUP BY rating;

-- 정렬 (내림 | 오름) -> DESC(내림)/ ASC(오름)
-- -> MySQL : 오름차순이 DEFAULT

-- AS
-- alias(별명, 약어) => as
SELECT
	rating,
    COUNT(*) AS total_films,
    AVG(rental_rate) as avg_rental_rate
FROM film
WHERE release_year = 2006 OR release_year = 2007
GROUP BY rating
ORDER BY AVG(rental_rate) DESC; 

-- AS 적용이 안되는 경우/되는 경우
-- SQL이 코드를 읽는 순서
-- FROM
-- WHERE 
-- GROUP BY
-- HAVING
-- SELECT
-- ORDER BY

-- SELECT 구문: 절대 AS로 정한 별명값을 쓸 수 없음 
-- HAVING -> 예외  : 그룹화 되어있는 요소의 조건 -> 


-- mission: 
-- 각 등급별 영화의 길이가 130분 이상인 영화의 갯수와 해당영화의 등급 출력alter
-- 내 답:
SELECT 
	rating, length, COUNT(*)
FROM film
WHERE length >= 130 
GROUP BY rating;

-- 정답:
SELECT rating, COUNT(*) AS film_count
FROM film 
WHERE length >= 130
GROUP BY rating
ORDER BY film_count DESC;
-- AS 는 생략이 가능





