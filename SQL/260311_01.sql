-- SET SQL_SAFE_UPDATES = 0;
-- START TRANSACTION;
-- UPDATE customer SET first_name = "DAVE";
-- SELECT * FROM customer LIMIT 10;

-- ROLLBACK;
-- SELECT * FROM customer LIMIT 10;

-- START TRANSACTION;

-- UPDATE customer SET first_name = "DAVE"
-- WHERE customer_id = 1;

-- COMMIT;

-- SELECT * FROM customer LIMIT 10;

-- ROLLBACK;

-- UPDATE customer SET first_name = "MARY"
-- WHERE customer_id = 1;

-- payment 테이블에서 payment_id가 1001인 amount를 3.99로 변경하는 트랜잭션을 설정, 실제로 커밋!

SELECT * FROM payment WHERE payment_id = 1001;

START TRANSACTION;

UPDATE payment SET amount = 2.99
WHERE payment_id = 1001;

COMMIT;
