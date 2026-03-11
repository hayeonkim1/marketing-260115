-- sakila : 과거 DVD 렌탈 사업모델, 가상 저장 데이터

USE sakila;
SHOW TABLES;

-- 문자열 함수 : LENGTH()
SELECT 
	title, 
    LENGTH(title) title_length
FROM film 
LIMIT 10;

-- 대소문자 변형 : UPPER() / LOWER()
SELECT 
	title, 
    UPPER (title) uppercased_title
FROM film 
LIMIT 10;

SELECT 
	title, 
    LOWER (title) lowercased_title
FROM film 
LIMIT 10;

-- 함수 내부의 또다른 함수 : Callback Function: 안쪽에 있는 함수부터 먼저 실행

SELECT 
	title, 
    LENGTH(UPPER(LOWER(title))) title_test  #--> 소문자가 된 이후에 다시 대문자가 되는 함수 실행. 그 후에 LENGTH 함수 실행
FROM film 
LIMIT 10;

-- CONCAT() :서로다른 문자열을 하나로 합치는 함수
SELECT 
	first_name, last_name, 
    CONCAT(first_name," ", last_name) full_name
    FROM actor 
    LIMIT 10;
    
-- SUBSTRING() :원래 문자열에서 일부만 추출
