/*[오늘의 미션] 3/5

MySQL > bestproducts DB 를 활용해서 다음 1개 문제를 해결하세요.
판매자별 판매중인 상품 가운데, 가장 랭킹 (숫자가 낮은게 높은것)이 높은 상품을 찾아서 출력해주세요.

=> 판매자별 가장 높은 랭킹을 찾되, 동률이 나올 시 특정 기준으로 1개의 값만 찾아올것
*/

USE bestproducts;
SELECT * FROM items; #판매자 존재
SELECT * FROM ranking; #아이템 랭킹 존재
#FK - item_code

-- 1) 판매자별 가장 높은 랭킹순위 찾기----- => 서브쿼리
SELECT 
	i.provider, 
    MIN(r.item_ranking) best_ranking
FROM items i
JOIN ranking r ON i.item_code = r.item_code
WHERE i.provider <> ""  #빈 문자열 제거
GROUP BY i.provider;

#하나의 판매자에 동일한 랭킹 상품들을 가졌을 경우 어떤기준으로 하나를 남길 것인가
-- 동률 중에 item_code 가 가장 낮은 것(/높을 걸로 해도 가능. 하나만 가져오면 됨)

-- 2) 판매자별 가장 작은 아이템코드 찾기 
SELECT
	i.provider,
	r.item_ranking,
	MIN(i.item_code) min_item_code
FROM ranking r
JOIN items i ON r.item_code = i.item_code
WHERE i.provider <> ""
GROUP BY i.provider, r.item_ranking;

-- 3) 판매자별 가장 높은 랭킹이면서 동시에 가장 작은 아이템코드를 가진 상품 찾기
SELECT
	i.provider,
	r.item_ranking,
	MIN(i.item_code) min_item_code
FROM ranking r
JOIN items i ON r.item_code = i.item_code
JOIN (
	SELECT
		i.provider,
		r.item_ranking,
		MIN(i.item_code) min_item_code
	FROM ranking r
	JOIN items i ON r.item_code = i.item_code
	WHERE i.provider <> ""
	GROUP BY i.provider, r.item_ranking
) x               #서브쿼리를 쓰려면 서브쿼리에 대한 이름을 꼭 지정해야함.
WHERE i.provider <> ""
GROUP BY i.provider, r.item_ranking;

-- 4) 해당 상품들을 찾아서 랭킹별 내림차순

SELECT 
	Y.provider,
    Y.item_ranking,
	t.title
FROM (
	SELECT
		i.provider,
		r.item_ranking,        
		MIN(i.item_code) min_item_code
	FROM ranking r
	JOIN items i ON r.item_code = i.item_code
	JOIN (
		SELECT
			i.provider,
			r.item_ranking,
			MIN(i.item_code) min_item_code
		FROM ranking r
		JOIN items i ON r.item_code = i.item_code
		WHERE i.provider <> ""
		GROUP BY i.provider, r.item_ranking
	) x 
		ON x.provider = i.provider 
		AND x.item_ranking = r.item_ranking              #서브쿼리를 쓰려면 서브쿼리에 대한 이름을 꼭 지정해야함.
	WHERE i.provider <> ""
	GROUP BY i.provider, r.item_ranking
) Y
JOIN items t ON y.min_item_code = t.item_code
ORDER BY Y.item_ranking ASC;

/*
1) 판매자별 가장 높은 랭킹순위 찾기 (MIN, JOIN, SUBQUERY)
 2) 판매자별 가장 작은 아이템코드 찾기 (MIN, JOIN, SUBQUERY)
3) 판매자별 가장 높은 랭킹이면서 동시에 가장 작은 아이템코드를 가진 상품 찾기 (JOIN, SUBQUERY)
4) 해당 상품들을 찾아서 랭킹별 내림차순 (GROUP BY)
*/





