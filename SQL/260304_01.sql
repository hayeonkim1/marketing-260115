-- OUTER JOIN 예제

USE sakila;

SHOW TABLES;

SELECT COUNT(*) FROM address;
SELECT COUNT(*) FROM customer;


SELECT * FROM address LIMIT 1;
SELECT * FROM customer LIMIT 1;  #address_id 만 중복

SELECT COUNT(*) FROM customer
RIGHT OUTER JOIN address
ON customer.address_id = address.address_id
WHERE customer_id IS NULL;

