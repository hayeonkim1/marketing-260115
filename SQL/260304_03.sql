/* 지금까지 배움
- LEFT / RIGHT OUTER JOIN 
- SubQuery vs JOIN 
- WHERE절
- GROUP BY & HAVING 절

+ 시험에는 : 개념
*/

/* 지금부터
INDEX : 목차(색인)
-> 원하는 챕터를 바로 볼 수 있게하는 역할

ex) 100만개의 데이터 존재 (=> 100만개의 행으로 구성된 테이블)
93만 5천 2백 7번째 행의 데이터를 찾아올 경우: 
93만 5천 2백 6개의 행을 다 읽으면서 내려가야함.
=> Full Table Scan 방식 => 비효율적

인덱스(색인) 기능을 테이블 내 특정 컬럼에 적용!


Mysql 설정방법 2가지
-Clustered Index : 테이블을 생성하는 단계에서부터 인덱스로 시작한 요소 (primery key 자체가 인덱스)
-Secondary Index :  의도적으로 인덱스값을 생성하는 방법
	CREATE INDEX [인덱스명] ON users(email); 
	CREATE INDEx idx_email ON users(email);
    SELECT *FROM users WHERE email = "a@gmail.com"
		-> 인덱스를 필요에 의해서 설정했다가 필요가 없어지는 경우에는 제거 
        -> 인덱스 이름을 알아야 DROP이 가능
	*/
    
DROP DATABASE IF EXISTS sqldb;
CREATE DATABASE IF NOT EXISTS sqlDB;
USE sqlDB;

CREATE TABLE userTable(
	userID CHAR(8) NOT NULL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL,
    addr CHAR(2) NOT NULL,
    mobile1 CHAR(3),
    mobile2 CHAR(8),
    height INT,
    mDate DATE
);

SHOW TABLES; 
DESC userTable;
SHOW INDEX FROM userTable; 

/*  인덱스 속성 설명
-Non_unique : 0 = 중복불가 이나 1 = 중복가능 밖에 못 옴.
-Seq_in_index : 복합인덱스 설정 시 
	CREATE INDEX (addr, height, mDate)
	-> index가 여러개일 경우 찾아오는 우선순위
	ex) 복합 인덱스 => CREATE INDEX test_idx (user_id, mDate) FROM userTable;
	=> user_id 가 Seq:1 , mDate가 2일 것.
	결과:	(1, 2026-03-01)
	(1, 2026-03-02)
	(2, 2026-03-04)
	(2, 2026-03-05)
	-> WHERE user_id = 8 AND mDate = "2026-03-04"

-Collation : 정렬 
	-> A : Ascending 오름차순 //D 
-Cardinality : 현재 세팅된 인덱스 안에 몇개의 값이 들어와 있는가
*/

CREATE TABLE buyTable(
	num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    userID CHAR(8) NOT NULL,
    prodName CHAR(4),
    groupName CHAR(4),
    price INT NOT NULL,
    amount INT NOT NULL,
    FOREIGN KEY (userID) REFERENCES userTable(userID) #외래키도 인덱스 역할을 함.
    ); 

SHOW INDEX FROM buyTable;

-- 최초 테이블 생성 후 테이블 수정,변경,업데이트 > ALTER 명령어 사용
/*
ALTER TABLE <tblname> ADD COLUMN <추가할 컬럼명><추가할 컬럼 SCHEMA>
ALTER TABLE <tblname> MODIFY COLUMN <변경할 컬럼명> <번경할 컬럼 schema>
ALTER TABLE <tblname> CHANGE COLUMN <기존 컬럼명><변경컬럼명><변경할 컬럼 SCHEMA>

ALTER TABLE <tblname> ADD INDEX <인덱스 이름> (컬럼명)
ALTER TABLE <tblname> ADD CONSTRAINT TESTDate UNIQUE(mDate)
-> mDate라는 컬럼의 중복값 불허라는 제약을 추가하는 것.
-> 컬럼의 속성이 중복값 X이 될 경우 => index 처리

인덱스 버리기
ALTER TABLE <tblname> DROP INDEX <인덱스이름>
*/

ALTER TABLE userTable ADD CONSTRAINT TESTDate UNIQUE(mDate);
SHOW INDEX FROM userTable;

CREATE INDEX idx_name ON userTable(name);
ALTER TABLE userTable ADD INDEX inx_addr(addr);


# 인덱스 만드는 법: 1)Primery Key// 2)FORIEGN KEY // 3)ALTER UNIQUE() // 4)ADD INDEX // 5)CREATE INDEX
CREATE INDEX idx_group ON buyTable(groupName);
SHOW INDEX FROM buyTable;


DROP DATABASE IF EXISTS sqldb;

-- -------------------------------
CREATE DATABASE IF NOT EXISTS sqldb;
USE sqldb;

#테이블 생성 시 인덱스 설정하기
DROP TABLE userTable;
CREATE TABLE userTable(
	userID CHAR(8) NOT NULL PRIMARY KEY,
    name VARCHAR(10) UNIQUE NOT NULL, #-> UNIQUE한 값은 인덱스의 속성을 가짐
    birthYear INT NOT NULL,
    addr CHAR(2) NOT NULL,
    mobile1 CHAR(3),
    mobile2 CHAR(8),
    height INT,
    mDate DATE,
	INDEX idx_userTable_addr(addr) #addr 이라는 해당 컬럼을 인덱스화 하는 것
);
SHOW INDEX FROM userTable;

#인덱스 제거
ALTER TABLE userTable DROP INDEX idx_userTable_addr;


-- ---------------
CREATE DATABASE ecommerce;
USE ecommerce;
SHOW TABLES;
DESC product;
SELECT * FROM product;



