/*
count (кількість)
sum (суму)
avg (середнє)
max (максимум)
min (мінімум)
*/

SELECT max("weight")
FROM users;

SELECT sum("weight")
FROM users;

SELECT avg("weight")
FROM users;

SELECT count(*)
FROM users
WHERE "weight">90 AND "isMale"=false;

SELECT *
FROM users
WHERE weight=107.0;

SELECT *
FROM users
WHERE weight=(SELECT max("weight") FROM users);

SELECT *
FROM users
WHERE height=(SELECT min("height") FROM users);




SELECT sum("weight") as "sum weight", "isMale"
FROM users
WHERE "firstName" ILIKE 'a%'
GROUP BY "isMale";


-- кількість чоловіків і жінок
SELECT count(*) , "isMale"
FROM users
GROUP BY "isMale";


-- кількість людей 1979 року народження
SELECT count(*) , EXTRACT(year from birthday) AS yearbd
FROM users
WHERE EXTRACT(year from birthday)=1979
GROUP BY yearbd;


-- кількість людей народилося кожного місяця
SELECT COUNT(*) ,EXTRACT(month from birthday) AS "monthBday"
FROM users
GROUP BY "monthBday";

-- кількість male/female народилося кожного місяця
SELECT COUNT(*) ,EXTRACT(month from birthday) AS "monthBday", "isMale"
FROM users
GROUP BY "monthBday", "isMale";


-- кількість male/female у яких зріст більше 1.8

SELECT count(*), "isMale"
FROM users
WHERE height>1.8
GROUP BY "isMale";


-- кількість штук проданих телефонів 
SELECT sum(quantity)
FROM phones_to_orders;

-- кількість штук проданих телефонів по кожній позиції 
SELECT sum(quantity), "phoneId"
FROM phones_to_orders
GROUP BY "phoneId";


-- кількість штук проданих телефонів в кожному замовленні
SELECT sum(quantity), "orderId"
FROM phones_to_orders
GROUP BY "orderId";


-- середня ціна телефона
SELECT avg(price)
FROM phones;

-- середня ціна телефона по кожному бренду
SELECT avg(price), brand
FROM phones
GROUP BY brand;


-- кількість моделей по кожному бренду
SELECT count(id), brand
FROM phones
GROUP BY brand;


-- кількість замовлень коpистувача, який робив замовлення
SELECT count(id), "userId"
FROM orders
GROUP BY  "userId";



-- кількість моделей по кожному бренду назва якого починається на s

SELECT count(id), "brand" 
FROM phones 
WHERE brand ILIKE 's%' 
GROUP BY brand;

