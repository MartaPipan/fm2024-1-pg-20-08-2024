-- сортувати рядочки
-- сортувати групи

SELECT id, email, height, birthday
FROM users
ORDER BY height ASC, birthday DESC;

SELECT id, email, height
FROM users
ORDER BY height DESC
LIMIT 1;


SELECT id, email, height
FROM users
ORDER BY height DESC, email ASC;


-- відсортувати користувачів за віком і за іменем
SELECT id, EXTRACT(year from age(birthday)) AS "age" ,"firstName"
FROM users
WHERE EXTRACT(year from age(birthday)) <40
ORDER BY "age", "firstName";

SELECT *
FROM (
  SELECT id, EXTRACT(year from age(birthday)) AS "age" ,"firstName", age(birthday)
  FROM users
)
WHERE "age"<40
ORDER BY "age", "firstName";


-- рахуємо кількість людей певного віку і сортуємо за цією кількістю
SELECT count(*) as "amount", EXTRACT(year from age(birthday)) AS "age" 
FROM users
GROUP BY "age"
HAVING count(*) > 2
ORDER BY "amount" DESC;

SELECT * FROM
(
  SELECT count(*) as "amount", EXTRACT(year from age(birthday)) AS "age" 
  FROM users
  GROUP BY "age"
)
WHERE "amount" = 2
ORDER BY "age" DESC;


SELECT count(*) as "amount", EXTRACT(year from age(birthday)) AS "age" 
FROM users
GROUP BY "age"
HAVING EXTRACT(year from age(birthday)) < 30;


SELECT count(*) as "amount", EXTRACT(year from age(birthday)) AS "age" 
FROM users
WHERE EXTRACT(year from age(birthday)) < 30
GROUP BY "age";


-- порахувати кількість моделей телеіонфв по кожному бренду і вивести тільки ті, де кількість менше 5

SELECT count(*) AS "count", brand
FROM phones
GROUP BY brand
HAVING count(*)<5
ORDER BY "count" ASC;



-- вибрати 5 айді телефонів з найбільшою кількістю проданих
-- айді і кількість проданих
-- сортуємо від найбільшого до найменшого за кількістю
-- лишаємо 5

SELECT "phoneId", sum(quantity) as "summa"
FROM phones_to_orders
GROUP BY "phoneId"
ORDER BY "summa" DESC
LIMIT 5;


-- вибрати айді телефонів з  кількістю проданих від 130 до 140
-- 1 v
SELECT "phoneId", sum(quantity) as "summa"
FROM phones_to_orders
GROUP BY "phoneId"
HAVING sum(quantity) BETWEEN 130 AND 140;
-- 2 v
SELECT * FROM
(
  SELECT "phoneId", sum(quantity) as "summa"
  FROM phones_to_orders
  GROUP BY "phoneId"
) 
WHERE "summa" BETWEEN 130 AND 140;



-- порахувати кількість юзерів по місяцях народження і лишити ті місяці де кількість > 4
SELECT count(*), EXTRACT(month from birthday) as "month"
FROM users
GROUP BY "month"
HAVING count(*) > 4;


-- порахувати довжину пошт, які починаються з літери a
--1
-- згрупувати за кількістю однакових довжин і лишити ті де довжина менше 25
--2
-- лишити ті, де кількість більше 1



-- порахувати людей з однаковим зростом і 
-- лишити групи де зріст < 1.35

SELECT height , count(*) as amount
FROM users 
GROUP BY height
HAVING height<1.35; --AND email ILIKE 'a%' - не буде працювати

SELECT height , count(*) as amount
FROM users 
WHERE height<1.35 AND email ILIKE 'a%'
GROUP BY height;

-- лишити групи з кількістю людей > 2
SELECT height , count(*) as amount
FROM users 
GROUP BY height
HAVING count(*) > 2;

SELECT * FROM
(
  SELECT height , count(*) as amount
  FROM users 
  GROUP BY height
)
WHERE amount > 2;