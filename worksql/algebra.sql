CREATE TABLE IF NOT EXISTS a(s VARCHAR(3), n int);
CREATE TABLE IF NOT EXISTS b(w VARCHAR(3));

INSERT INTO a VALUES ('qqq',1),('aaa',2),('zzz',3);
INSERT INTO b VALUES ('asd'),('wer'),('zzz');

SELECT * FROM a,b;

SELECT s FROM a
UNION
SELECT w FROM b;

SELECT * FROM b
UNION
SELECT s FROM a;


SELECT s FROM a
INTERSECT
SELECT w FROM b;

SELECT * FROM b
INTERSECT
SELECT s FROM a;



SELECT s FROM a
EXCEPT
SELECT w FROM b;

SELECT * FROM b
EXCEPT
SELECT s FROM a;






INSERT INTO users ("firstName", "lastName", email,"isMale",birthday,height, weight  )
VALUES ( 'Brad','Pitt','brad11@gmail.com',true,'2000-01-05',1.8,92.3),
( 'Fred','Pitt','brad31@gmail.com',true,'2000-08-05',1.8,72.3);


SELECT id FROM users
INTERSECT
SELECT "userId" FROM orders;

-- id користувачів які НЕ робили замовлень
SELECT id FROM users
EXCEPT
SELECT "userId" FROM orders;


SELECT email FROM users
WHERE id IN (
  SELECT id FROM users
  EXCEPT
  SELECT "userId" FROM orders
  )




-- SELECT s FROM a
-- INTERSECT
-- SELECT w FROM b;


SELECT *
FROM a
  INNER JOIN b ON a.s=b.w;