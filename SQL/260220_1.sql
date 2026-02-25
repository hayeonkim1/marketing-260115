-- 주석1: 
# 주석 2: 단문주석 -> MySQL 전용주석
/* 주석 3 : 복문주석 */
-- 반드시 SQL문법을 사용할때에는 종료구문에 세미코론 ;

/*
MySQL 접속시 이것부터 시작해라!

1. 데이터베이스 생성
CREATE DATABASE <dbname>;
> 데이터 베이스의 이름은 항상 직관적, 명시적 -> 누가봐도 한눈에 알아볼 수 있도록

CREATE DATABASE IF NOT EXISTS <dbname>;
-> 실수로 덮어쓰기 해버리면 그전 데이터 복구 불가.
-> 이렇게 하는게 안전함

CREATE DATABASE IF NOT EXISTS <dbname> 
CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci; 
이모지 등의 다양한 형태의 데이터가 깨지지않고 들어오게끔
-> 세미콜론만 없으면 줄바꿈해도 하나의 이어지는 코드로 인식
->UTF :  Unicode Transformation Format
각 나라의 언어는 국제적으로 약속된 코드형식으로 이루어져있음



2. 현재 MySQL 안에 생성된 데이터베이스 조회
SHOW DATABASES;
-> 왼쪽 schemas 에 볼드 처리가 되야 조회된 것. 

3. 데이터베이스 선택
USE <dbname>;
4. 선택된 데이터 베이스안에 테이블 생성

5. 데이터베이스 안에 생성된 테이블 조회 

6. 생성된 테이블 안에 데이터 저장.삽입

7. 데이터베이스 삭제
DROP DATABASE <dbname>;
> DROP DATABASE IF EXISTS <dbname>;


ctrl + enter : 단문실행
ctrl + shift + enter : 복문실행

*/

CREATE DATABASE digitalmkt;
CREATE DATABASE IF NOT EXISTS digitalmkt;

CREATE DATABASE IF NOT EXISTS digitalmkt
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

SHOW DATABASES;
USE digitalmkt;
DROP DATABASE digitalmkt;
DROP DATABASE IF EXISTS digitalmkt;



