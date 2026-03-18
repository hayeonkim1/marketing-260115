/*
MISSION12: 캐나다 고객들에게 이메일을 활용한 CRM마케팅을 진행하려고 합니다.
캐나다 지역 고객들의 이름,EMAIL 필요. 각 테이블 조회, 출력
*/
SELECT * FROM customer; #email, customer_id, name, address_id
SELECT * FROM address; #address_id, city_id
SELECT * FROM city; #city_id, country_id,
SELECT * FROM country; # country_id, country

SELECT 
	country,
	CONCAT(first_name, " ", last_name) full_name,
    email
FROM customer 
JOIN address USING(address_id)
JOIN city USING (city_id)
JOIN country USING (country_id)
WHERE country = "Canada";







