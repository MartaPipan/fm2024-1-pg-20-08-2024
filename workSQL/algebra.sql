DROP TABLE a;
DROP TABLE b;
CREATE TABLE IF NOT EXISTS a( s varchar(3), n int);

CREATE TABLE IF NOT EXISTS b(
    w varchar(3)
);

INSERT INTO a VALUES('qqq',1),('aaa',2),('zzz',3);
INSERT INTO b VALUES('asd'),('wer'),('zzz');
--decart
SELECT* FROM a,b;

SELECT s FROM a 
UNION
SELECT w FROM b;


SELECT s FROM a 
INTERSECT
SELECT w FROM b;

SELECT s FROM a 
EXCEPT
SELECT w FROM b;
SELECT w FROM b
EXCEPT
SELECT s FROM a;


INSERT INTO users (
   "firstName",
    "lastName",
    email,
    "isMale",
    birthday,
    height,
    weight
  )
VALUES
('Brad','Pitt','brad11@gmail.com', true,'2000-01-05', 1.8, 92.3),
('Fred','Pitt','fred11@gmail.com', true,'2000-11-23', 1.74, 78.2);

SELECT  id FROM users
INTERSECT
SELECT "userId" FROM orders;

SELECT* FROM users;

SELECT  id FROM users
EXCEPT
SELECT "userId" FROM orders;

SELECT email FROM users
WHERE id IN(
    SELECT id FROM users
    EXCEPT 
    SELECT "userId" FROM orders
);

SELECT* 
FROM a
JOIN b ON a.s =b.w;