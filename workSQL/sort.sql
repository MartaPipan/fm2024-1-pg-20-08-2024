SELECT id, email, height
FROM users
ORDER BY height DESC;

SELECT id, email, height
FROM users
ORDER BY height ASC;

SELECT id, email, height
FROM users
ORDER BY height ASC
LIMIT 1;

SELECT id, email, height
FROM users
ORDER BY height DESC
LIMIT 1;

SELECT id, email, height, birthday
FROM users
ORDER BY height ASC, birthday DESC, email ASC;

SELECT
EXTRACT (year from age(birthday)) as "age", 
"firstName"
FROM users
ORDER BY  "age" ASC, "firstName" DESC;

SELECT
EXTRACT (year from age(birthday)) as "age", 
"firstName"
FROM users
WHERE EXTRACT(year from age(birthday))<40
ORDER BY  "age" ASC, "firstName" DESC;


SELECT *
FROM
(SELECT
EXTRACT (year from age(birthday)) as "age", 
"firstName"
FROM users)
WHERE "age"<40
ORDER BY  "age" ASC, "firstName" DESC;

SELECT
    "firstName",
    birthday,
    EXTRACT(YEAR FROM age(birthday)) AS years,
    EXTRACT(MONTH FROM age(birthday)) AS months,
    EXTRACT(DAY FROM age(birthday)) AS days
FROM users
ORDER BY 
    years DESC,
    months DESC,
    days DESC,
    "firstName" ASC;

SELECT count(*) as "amount",
EXTRACT (year from age(birthday)) as "age"
FROM users
GROUP BY "age"
ORDER BY "amount"; 

SELECT count(*) as "amount",
EXTRACT (year from age(birthday)) as "age"
FROM users
GROUP BY "age"
HAVING count(*)>2
ORDER BY "amount" DESC;   

SELECT*
FROM
(SELECT count(*) as "amount",
EXTRACT (year from age(birthday)) as "age"
FROM users
GROUP BY "age")
WHERE "amount">2
ORDER BY "amount" DESC;   

SELECT count(*) as "conte", brand
FROM phones
GROUP BY brand
HAVING count(*)<5
ORDER BY "conte";

SELECT  "phoneId", sum(quantity)as summa
FROM phones_to_orders
GROUP BY "phoneId"
ORDER BY summa DESC
LIMIT 5;

--variant with HAVING
SELECT  "phoneId", sum(quantity)as summa
FROM phones_to_orders
GROUP BY "phoneId"
HAVING sum(quantity) BETWEEN 130 AND 140
ORDER BY summa DESC;
--variant with WERE
SELECT*
FROM
(SELECT  "phoneId", sum(quantity)as summa
FROM phones_to_orders
GROUP BY "phoneId")
WHERE "summa" BETWEEN 130 AND 140
ORDER BY summa DESC;

--calculate quantity user (month of --birthday), show months with more 5users
SELECT
    COUNT(*) AS summ,
    EXTRACT(month FROM (birthday)) AS months
FROM
    users
GROUP BY
    EXTRACT(month FROM (birthday))
HAVING
    COUNT(*) > 3
ORDER BY
    summ DESC;


--1calculate symbols in email, start. in 'a', 2group in quantity and select with quantity <25;

--1
SELECT LENGTH (email) AS length
FROM users
WHERE email ILIKE 'a%'
GROUP BY length;

--2 add count
SELECT count(*), LENGTH (email) AS length
FROM users
WHERE email  ILIKE 'a%'
GROUP BY length;

--3
SELECT count(*), LENGTH (email) AS length
FROM users
WHERE email ILIKE 'a%' AND LENGTH(email)<25
GROUP BY length;


--task2 with HAVING count>1
SELECT count(*), LENGTH (email) AS length
FROM users
WHERE email ILIKE 'a%'
GROUP BY length
HAVING count(*)>1;

--task2 with WHERE
SELECT *
FROM 
(
    SELECT COUNT(*) AS user_count, LENGTH(email) AS length
    FROM users
    WHERE email ILIKE 'a%'
    GROUP BY length
) 
WHERE user_count > 1;
Цей запит вибирає ті адреси електронної пошти, які починаються з "a" і зустрічаються більше одного разу в таблиці users.

--task3
--calculate people with height 
--height<1.35
SELECT height, count(*) as "amount"
FROM users
WHERE height<1.35 AND email ILIKE 'a%'
GROUP BY height;

--variant with HAVING
SELECT height, count(*) as "amount"
FROM users
GROUP BY height
HAVING count(*)>2;

--variant with WHERE
SELECT* FROM
 (SELECT height, count(*) as "amount"
 FROM users
 GROUP BY height)
 WHERE "amount">2;




