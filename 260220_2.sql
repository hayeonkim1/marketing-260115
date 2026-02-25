-- 테이블 생성
/*
1) 테이블 생성 시, 2가지 방법

CREATE TABLE <tablename> ();
CREATE TABLE IF NOT EXISTS <tablename>();
테이블 생성 시, () 안에 입력될 요소들이 바로 스키마 (약속된 타입 정의)
컬럼을 몇개 만들 것이고, 각 컬럼 내부에 입력될 값들이 어떤 타입으로 채워지게 할 것인가를 사전에 약속,정의

DROP TABLE <tablename>;
DROP TABLE IF EXISTS <tablename>;


PRIMARY KEY (id)
프라이머리 키를 다수 지정할 수 있지만 따로따로가 아닌 다수의 프라이머리키를 한쌍으로 지정하는 것임.
A OR B가 아닌 A AND B가 되는 것.

*/
CREATE TABLE IF NOT EXISTS digitalclass (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT, # UNSIGNED : 부호를 쓰지 않음 = 양수 #NOT NULL : 결측치(빈값)를 허용하지 않는다. 
	name VARCHAR(50),                       #AUTO_INCREAMENT : 데이터가 추가될때마다 식별값의 개수를 자동적으로 추가시켜라
    PRIMARY KEY (id)
    );    -- 두개의 컬럼을 만들고 하나는 int형태의 id, 하나는 50자 까지의 문자를 받음. + id를 프라이머리키로 지정
DESC digitalclass;

SELECT * FROM digitalclass;

DROP TABLE IF EXISTS digitalcalss;

CREATE TABLE IF NOT EXISTS mktclass(
	id INT 	UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    modelnumber VARCHAR(15) NOT NULL,
    series VARCHAR(30) NOT NULL,
    PRIMARY KEY(id)
);

DESC mktclass;

SELECT *FROM mktclass;



