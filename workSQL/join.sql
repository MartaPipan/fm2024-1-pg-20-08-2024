--INNER JOIN
SELECT users.id, email, orders.id 
FROM users 
JOIN
orders ON users.id=orders."userId"
WHERE users.id=33;

SELECT u.id, u.email, o.id 
FROM users AS u
JOIN
orders AS o ON u.id=o."userId"
WHERE u.id=33;

--orders with sony
SELECT o.id, p.brand 
FROM orders AS o
JOIN phones_to_orders AS pto ON o.id=pto."orderId"
JOIN phones AS p ON p.id=pto."phoneId"
WHERE p.brand ILIKE 'sony'
GROUP BY o.id, p.brand;

SELECT o.id, p.brand, count(p.*) as amount 
FROM orders AS o
JOIN phones_to_orders AS pto ON o.id=pto."orderId"
JOIN phones AS p ON p.id=pto."phoneId"
GROUP BY o.id, p.brand
ORDER BY o.id, amount;

SELECT o.id, count(p.*) as amount 
FROM orders AS o
JOIN phones_to_orders AS pto ON o.id=pto."orderId"
JOIN phones AS p ON p.id=pto."phoneId"
GROUP BY o.id
ORDER BY o.id, amount;

SELECT o.id, p.brand, count(p.*) as amount 
FROM orders AS o
JOIN phones_to_orders AS pto ON o.id=pto."orderId"
JOIN phones AS p ON p.id=pto."phoneId"
GROUP BY o.id, p.brand
HAVING count(p.*)<2
ORDER BY o.id, amount;

INSERT INTO phones ("brand","model","price",quantity)
VALUES 
('Mybrand','Asd45',1234,10),
('Mybrand','XC', 4234, 20);


SELECT
FROM
JOIN
WHERE
    
--brend in sale
SELECT p.brand
FROM phones AS p
JOIN phones_to_orders AS pto ON p.id=pto."phoneId"
GROUP BY p.brand;

--brand & models in sale:
SELECT p.brand, p.model
FROM phones AS p
JOIN phones_to_orders AS pto ON p.id=pto."phoneId"
GROUP BY p.brand, p.model;

--quantity phones in sale
SELECT p.id,p.model, sum(pto.quantity)
FROM phones AS p
JOIN phones_to_orders AS pto ON p.id=pto."phoneId"
GROUP BY p.id, p.model
ORDER BY p.id;

--quantity phones in sale
SELECT p.id,p.model, sum(pto.quantity) as quantity
FROM phones AS p
JOIN phones_to_orders AS pto ON p.id=pto."phoneId"
GROUP BY p.id, p.model
ORDER BY quantity;

SELECT sum(quantity) FROM phones_to_orders;

--quantity info phones in in sale and is not sale
SELECT p.id,p.model, sum(pto.quantity)
FROM phones AS p
FULL OUTER JOIN phones_to_orders AS pto ON p.id=pto."phoneId"
GROUP BY p.id, p.model
ORDER BY p.id;



-- brand & models not sale:
-- phones AS p
-- phones_to_orders AS pto 
SELECT p.brand, p.model
FROM phones AS p
LEFT JOIN phones_to_orders AS pto ON p.id=pto."phoneId"
WHERE pto."phoneId" IS NULL
GROUP BY p.brand, p.model
ORDER BY p.brand;

SELECT* FROM phones;

--TASK 1
--email users(when by nokia)пошту користувачів, які купляли нокіа;
SELECT u.email 
FROM users AS u
JOIN orders AS o ON u.id = o."userId"
JOIN phones_to_orders AS pto ON o.id=pto."orderId"
JOIN phones AS p ON pto."phoneId"= p.id
WHERE p.brand ILIKE 'Iphone'
GROUP BY u.email;

--Task2
--id users (have >3orders) -- айді користувачів, у яких більше 3 замовлень;
SELECT "userId", count(id)
FROM orders 
GROUP BY "userId"
HAVING count(id)>3;

--  +if we need to users email:
SELECT o."userId", count(o.id), u.email
FROM users u
JOIN orders o ON u.id=o."userId"
GROUP BY o."userId", u.email
HAVING count(o.id)>3
ORDER BY o."userId";

--TASK3
--id orders phone (id of phone 23)+ email of users when by this phone);
SELECT o.id, u.email
FROM users u
JOIN orders o ON u.id=o."userId"
JOIN phones_to_orders pto ON o.id=pto."orderId"
WHERE pto."phoneId"=23;

-- айді замовлень з телефоном 22 i пошту користувачів
SELECT o.id, u.email
FROM users u
JOIN orders o ON u.id=o."userId"
JOIN phones_to_orders pto ON o.id=pto."orderId"
WHERE pto."phoneId"=22;

--TASK4
--id phone in sale with max quantity(limit5);
-- 5 телефонів, які купували з найбільшою кількістю)
SELECT p.model, sum(p.quantity) AS summa
FROM phones AS p
JOIN phones_to_orders pto ON p.id=pto."phoneId"
GROUP BY p.model
ORDER BY summa DESC
LIMIT 5;

--TASK5
--model, brand phones in order 56;
SELECT p.model, p.brand, pto."orderId"
FROM phones AS p
JOIN phones_to_orders pto ON p.id=pto."phoneId"
WHERE pto."orderId"=56;

--model of phones in order 56;
SELECT p.model
FROM phones_to_orders AS pto
JOIN phones p ON pto."phoneId"=p.id
WHERE pto."orderId"=56;

--TASK6
--email of user & quantity model buy user;
SELECT u.email, count(p.model) 
FROM users u
JOIN orders o ON u.id=o."userId"
JOIN phones_to_orders pto ON o.id=pto."orderId"
JOIN phones p ON pto."phoneId"=p.id
GROUP BY u.email;
Цей запит повертає електронну адресу кожного користувача разом із кількістю моделей телефонів, які вони замовили.

--TASK7.1
--email of user & quantity model buy user 25;
SELECT u.email, count(p.model) 
FROM users u
JOIN orders o ON u.id=o."userId"
JOIN phones_to_orders pto ON o.id=pto."orderId"
JOIN phones p ON pto."phoneId"=p.id
WHERE u.id =25
GROUP BY u.email;
--Цей запит повертає електронну адресу користувача 25 разом із кількістю моделей телефонів, які замов.

--TASK 7.2
SELECT u.email, count(pto."phoneId") 
FROM users u
JOIN orders o ON u.id=o."userId"
JOIN phones_to_orders pto ON o.id=pto."orderId"
WHERE u.id =25
GROUP BY u.email;
//*У першому запиті рахується кількість телефонів на основі phoneId, але без розрізнення моделей. Це просто підрахунок загальної кількості телефонів, які були замовлені.

У другому запиті підраховується кількість саме моделей телефонів. Цей запит більш деталізований, оскільки враховує інформацію про конкретні моделі з таблиці phones.

Таким чином, другий запит надає більш специфічну інформацію про те, скільки різних моделей телефонів було замовлено, тоді як перший запит просто підраховує загальну кількість телефонів, незалежно від моделі.
*//

--TASK8
--id order & price of order 
SELECT pto."orderId", SUM(pto.quantity * p.price) AS "totalPrice"
FROM phones_to_orders AS pto
JOIN phones AS p ON pto."phoneId" = p.id
GROUP BY pto."orderId"
ORDER BY "totalPrice" DESC;

