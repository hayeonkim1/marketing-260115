/* [오늘의 미션] 3/4

오늘 학습한 MySQL > bestproducts DB 를 활용해서 다음 2개 문제를 해결하세요.

1) 카테고리별(메인 + 서브카테고리) Top3 할인금액 (가장 많은 할인을 한 금액) 상품을 추출해서 출력해주세요.
2) 카테고리별(메인 + 서브카테고리) 할인률 상위 20% (할인을 많이한 기준) 상품만 추출해서 출력해주세요. */

USE bestproducts;
SELECT * FROM items LIMIT 10; 
SELECT * FROM ranking LIMIT 10;


#MISSION 1
SELECT 
	main_category,
    sub_category,
    I.discount_percent
FROM ranking R
JOIN items I ON R.item_code = I.item_code
GROUP BY main_category, sub_category;

-- HAVING discount_percent >= COUNT(discount_percent)*0.8;


SELECT *
FROM items I
JOIN ranking R ON I.item_code = R.item_code
GROUP BY main_category, sub_category;
-- --------------------------------------------------------
#정답
-- 카테고리 (메인+서브)별 할인율 상위20%
-- 1) 메인과 서브 카테고리가 모두 같은 상품들의 각각 개별적인 할인율
-- 2) 위 조건에 충족되는 상품들이 총 몇개? --> 20%에 해당되는 갯수 계산을 위해
-- 3) 위에서 계산된 갯수만큼만 높은 할인율을 기준으로 조회, 출력되도록

-- JOIN //  100개 상품가운데 기준값
#1)
USE bestproducts;
SELECT * FROM items LIMIT 10; 
SELECT * FROM ranking LIMIT 10;
#2)
SELECT 
	main_category,
    sub_category,
    COUNT(*)
FROM ranking
GROUP BY main_category, sub_category;

#3)
#아래의 코드를 BASE DATA로 깔아놓기 
SELECT 
	R.main_category,
    R.sub_category,
    R.item_ranking,
    I.item_code,
    I.title,
    I.discount_percent
FROM ranking R
JOIN items I ON R.item_code = I.item_code;

#4) BASE DATA 기반으로 subquery 사용
SELECT 
	A.main_category,
	A.sub_category,
	A.item_ranking,
	A.item_code,
	A.title,
	A.discount_percent
FROM (
	SELECT 
		R.main_category,
		R.sub_category,
		R.item_ranking,
		I.item_code,
		I.title,
		I.discount_percent
	FROM ranking R
	JOIN items I ON R.item_code = I.item_code
) A;



#5) 카테고리별 상위 20% 추출 코드
SELECT 
	R.main_category, 
    R.sub_category,
    CEIL(COUNT(*) * 0.2) top_k  #CEIL : 올림 처리 --> 각 카테고리 별 TOP20%의 갯수
FROM ranking R
GROUP BY R.main_category, R.sub_category;


#6) 두개의 코드(BASE DATA : A & top_k : C)를 하나로 조인
SELECT 
	A.main_category,
	A.sub_category,
	A.item_ranking,
	A.item_code,
	A.title,
	A.discount_percent,
    top_k
FROM (
	SELECT 
		R.main_category,
		R.sub_category,
		R.item_ranking,
		I.item_code,
		I.title,
		I.discount_percent
	FROM ranking R
	JOIN items I ON R.item_code = I.item_code
) A

INNER JOIN(
	SELECT 
		R.main_category, 
		R.sub_category,
		CEIL(COUNT(*) * 0.2) top_k  #CEIL : 올림 처리 --> 각 카테고리 별 TOP20%의 갯수
	FROM ranking R
	GROUP BY R.main_category, R.sub_category
) C ON A.main_category = C.main_category AND A.sub_category = C.sub_category;


#7) discount_percent 가 같은 메인-서브 카테고리 안의 100개의 

SELECT 
	A.main_category,
	A.sub_category,
	A.item_ranking,
	A.item_code,
	A.title,
	A.discount_percent
    top_k
FROM (
	SELECT 
		R.main_category,
		R.sub_category,
		R.item_ranking,
		I.item_code,
		I.title,
		I.discount_percent
	FROM ranking R
	JOIN items I ON R.item_code = I.item_code
) A

INNER JOIN(
	SELECT 
		R.main_category, 
		R.sub_category,
		CEIL(COUNT(*) * 0.2) top_k  #CEIL : 올림 처리 --> 각 카테고리 별 TOP20%의 갯수
	FROM ranking R
	GROUP BY R.main_category, R.sub_category
) C 
ON A.main_category = C.main_category 
AND A.sub_category = C.sub_category
#-> 나머지 99개의 상품중 7%보다 할인율이 높은 상품은 살아남음 & 그 안에서는 item_ranking값이 작은 20개가 살아남음
LEFT JOIN (           
	SELECT
		R.main_category,
        R.sub_category,
        R.item_ranking,
        I.item_code,
        I.discount_percent
    FROM ranking R
    JOIN item I  R.item_code = I.item_code
    ) B 
ON A.main_category = B.main_category 
AND A.sub_category = B.sub_category
AND (
	B.discount_percent > A.discount_percent
    # 할인율 값이 같아지는 경우에는 item_ranking을 비교해서 순위결정
	OR (B.discount_percent = A.discount_percent AND B.item_ranking < A.item_ranking)  
)
    # 그룹화 해서 전체 아이템코드 내에서 having절로 20개 찾아오기 위해 
GROUP BY A.main_category, A.sub_category, A.item_ranking, A.item_code, A.title, A.discount_percent, C.top_k
HAVING COUNT(b.item_code) < c.top_k
ORDER BY a.main_category, a.sub_category, a.discount_percent DESC;
-- -------------------------------------


SELECT
	a.main_category,
	a.sub_category,
	a.item_ranking,
	a.item_code,
	a.title,
	a.discount_percent
FROM (
	SELECT
		r.main_category,
		r.sub_category,
		r.item_ranking,
		i.item_code,
		i.title,
		i.discount_percent
	FROM ranking r
	INNER JOIN items i ON r.item_code = i.item_code
) a
INNER JOIN (
	SELECT
		r.main_category,
		r.sub_category,
		CEIL(COUNT(*) * 0.2) top_k
	FROM ranking r
	GROUP BY r.main_category, r.sub_category
) c
ON a.main_category = c.main_category
AND a.sub_category = c.sub_category
LEFT JOIN (
	SELECT
		r.main_category,
        r.sub_category,
        r.item_ranking,
        i.item_code,
        i.discount_percent
    FROM ranking r
    INNER JOIN items i ON r.item_code = i.item_code
) b
ON a.main_category = b.main_category
AND a.sub_category = b.sub_category
AND (
	b.discount_percent > a.discount_percent
    OR (b.discount_percent = a.discount_percent AND b.item_ranking < a.item_ranking)
)
GROUP BY a.main_category, a.sub_category, a.item_ranking, a.item_code, a.title, a.discount_percent, c.top_k
HAVING COUNT(b.item_code) < c.top_k
ORDER BY a.main_category, a.sub_category, a.discount_percent DESC;