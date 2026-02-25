CREATE DATABASE IF NOT EXISTS customer_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE customer_db;

CREATE TABLE IF NOT EXISTS customer(
	no INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    age TINYINT,
    phone VARCHAR(20), 
    email VARCHAR(30) NOT NULL,
    address VARCHAR(50)
    # PRIMARY KEY(no) 이렇게해도 됨
);

DESC customer;
SELECT *FROM customer;

/*
데이터 베이스 생성 후 테이블 생성-> 중요한 컬럼생성을 누락!!
최초에는 불필요했던 =>컬럼의 추가 생성이 필요! 

ALTER TABLE <tablename> ADD COLUMN <추가할 컬럼명> <추가할 컬럼 데이터형태(스키마)>
EX) ALTER TABLE customer ADD COLUMN job VARCHAR(10) NOT NULL;


최초에 컬럼을 생성했던 시점에서는 특정 컬럼이 작은 정수면 될 줄 알았는데
시간이 경과해서 큰 정수값을 허용해야하는 경우 => 컬럼의 타입 변경 필요!
ALTER TABLE <tablename> MODIFY COLUMN <변경할 컬럼명> <변경할 컬럼의 데이터 형태>
ALTER TABLE customer MODIFY COLUMN age INT NOT NULL;



최초 컬럼 생성때와는 달리 컬럼의 기능(성격)이 많이 변질
=> 컬럼명 변경 필요!!
ALTER TABLE <tablename> CHANGE COLUMN <기존 컬럼명> <변경할 컬럼명> <변경할 컬럼 데이터명>.
ALTER TABLE customer CHANGE COLUMN phone mobile VARCHAR(30) NOT NULL;



*/



