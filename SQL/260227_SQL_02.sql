CREATE DATABASE IF NOT EXISTS  sqlDB;
USE sqlDB;

-- index: 색인
-- ex) userTbl 저장된 데이터가 10만건일 경우 1사람 찾기위해서 10만번 일해야함. 
	-- >인덱싱으로 한번 자동검색 가능
-- 해당 인덱스가 불필요해질 경우 -> 제거 
-- 인덱스 이름이 필요함

CREATE TABLE userTbl(
	userId CHAR(8) NOT NULL PRIMARY KEY,
    name VARCHAR(10) NOT NULL UNIQUE,
    birthYear INT NOT NULL,
    addr CHAR(2) NOT NULL,
	mobile1 CHAR(3),
    mobile2 CHAR(3),
    height SMALLINT,
    mDate DATE,
    INDEX idx_userTbl_name (name),
    INDEX idx_userTbl_addr (addr)    
);

CREATE TABLE buyTbl (
	num INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    userId CHAR(8) NOT NULL,
    prodName CHAR(4),
    groupName CHAR(4),
    price INT NOT NULL,
    amount INT NOT NULL,
    FOREIGN KEY (userId) REFERENCES userTbl(userId)
);

-- FOREIGN KEY 로 설정하지 않아도 서로 다른 테이블끼리 연결은 가능
-- 역할: 무결점을 보완하기 위한 목적
-- 외래키 없이 JOIN 할 경우 -> 두 테이블에 동일한 키가 없었음에도 JOIN이 되버림 -> 에러가 아닌 NULL값이 나옴.
-- (+) 설정하면 향후에 인덱싱, 그룹설정 시 조건값으로 KEY 역할을 할 수 있는 것.
-- (+) FOREIGN KEY를 설정하면 에러발생 시 에러신호(참조할 수 있는 값 X)가 나옴. (버그 잡을때 유용)
-- (-) 외래키 설정 시 위계질서가 생성됨. 함부로 테이블 생성, 삭제등이 까다로워짐. 

SHOW TABLES;
DESC buyTbl;
DESC userTbl;

-- 값 채워넣기
INSERT INTO userTbl VALUES("HGD","홍길동", 2000, "서울", "010","123","180", "2000-01-01");
INSERT INTO buyTbl VALUES(DEFAULT, "HGD","조깅화", "신발", 10, 2);

SELECT * FROM userTbl;
SELECT * FROM buyTbl;

DELETE FROM userTbl WHERE userId = "HGD";