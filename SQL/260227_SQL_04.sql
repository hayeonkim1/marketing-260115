-- JOIN : 가입하다, 결합하다
-- 서로다른 테이블을 결합하려고 할 때 
-- EX)
	-- A테이블  "키"  B테이블
-- 왜 굳이 테이블을 나눠서 관리하는가?
	-- 비효율적으로 너무 많은 컬럼을 사용하지 않기 위함
    -- 현업에서는 기본적으로 데이터 갯수가 몇만~몇백만 데이터 => row
    -- 컬럼 20~50개까지 늘어난다면 한번 실행할때 50* 100만개의 데이터를 수행하는 것 => 비효율
    
    
    -- JOIN의 2가지 종류
    
    -- 1) INNER JOIN : DEFUALT
    -- 2) OUTER JOIN : LEFT OUTER JOIN / RIGHT OUTER JOIN
    
SELECT * FROM items LIMIT 10;
SELECT * FROM items LIMIT 10;

SELECT * FROM items A
JOIN ranking B ON A.item_code = B.item_code
WHERE main_category ="ALL";
-- item_code로 JOIN을 하지만 출력은 각각의 item_code를 둘다 출력함.alter

-- ORDER BY, HAVING, JOIN 은 AS 허용
-- INNER JOIN에서 WHERE 절을 쓸때 -> 컬럼 내 조건을 따지고자 할때, 원칙적으로는 어떤 테이블의 컬럼인지 명시하는게 맞지만
-- 만약 해당 컬럼이 특정 테이블 한쪽에서만 사용중이라면 어떤테이블인지 작성하지 않아도 됨.
	-- EX) WHERE B.main_category ="ALL";
			-- -> main_category는 B에만 존재해서 "B."생략 가능
            

            
            