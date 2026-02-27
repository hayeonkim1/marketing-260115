-- HAVING 절 + GROUP BY
-- 그룹화가 되어진 요소를 집계함수를 가지고 조건비교를 할 때, 사용
-- 기본적인 조건절 문법 (WHERE) -> 테이블> 컬럼 속에서 조건을 적용할 때


-- GMARKET 인기판해 TOP 상품들
-- 능력있는 상품업체(provider)라면, 인기판매 상품 리스트에 복수의 상품이 랭크되어있지 않을가?
CREATE DATABASE IF NOT EXISTS bestproducts;
USE bestproducts;
SELECT COUNT(*) FROM items; #10201개 상품 크롤링 => 10201개의 판매자가 있는게 아닐것
SELECT * FROM items LIMIT 10;
SELECT * FROM ranking LIMIT 10;

SELECT provider, COUNT(*) AS provider_items
FROM items
# WHERE COUNT(*) >=   => 100 컬럼에서의 조건을 따지고 싶은것
WHERE 
	provider != "스마일배송" AND 
    provider <> "" # != 랑 <> 은 같은의미
GROUP BY provider HAVING COUNT(*) >= 100
ORDER BY provider_items DESC  # ORDER는 HAVING 뒤에 와야함
LIMIT 5;
