-- INNER JOIN

-- SELECT 
-- FROM 
--   JOIN  ON 
-- WHERE ; 

-- отримати замовлення користувача з id=33
SELECT users.id, users.email, orders.id
FROM users 
  JOIN orders ON users.id=orders."userId"
WHERE users.id=24; 


SELECT u.id, u.email, o.id as "orderID"
FROM users AS u
  JOIN orders AS o ON u.id=o."userId"
WHERE u.id=24; 


-- отримати усі замовлення з sony

SELECT o.id, p.brand, count(p.*) as amount
FROM orders AS o
  JOIN phones_to_orders AS pto ON o.id=pto."orderId"
  JOIN phones AS p ON pto."phoneId"=p.id
-- WHERE p.brand ILIKE 'sony'
GROUP BY o.id, p.brand
HAVING count(p.*)<2
ORDER BY o.id, amount; 


INSERT INTO phones (brand, model, price, quantity)
VALUES ( 'Mybrand',  'Asd 45', 1234, 10  ), ( 'Mybrand',  'ZX', 4234, 20  );


-- бренди та моделі, які купували 
SELECT p.brand, p.model
FROM phones AS p
  JOIN  phones_to_orders AS pto ON p.id=pto."phoneId"
GROUP BY p.brand, p.model
ORDER BY p.brand;



-- бренди, які не купували
SELECT p.brand, p.model
FROM phones AS p
  LEFT JOIN  phones_to_orders AS pto ON p.id=pto."phoneId"
WHERE   pto."phoneId" IS NULL
GROUP BY p.brand, p.model
ORDER BY p.brand;




-- кількість проданих телефонів
SELECT p.id, p.model, sum(pto.quantity) as quantity
FROM phones AS p
  JOIN  phones_to_orders AS pto ON p.id=pto."phoneId"
GROUP BY p.id
ORDER BY quantity;


-- кількість проданих телефонів
SELECT p.id, p.model, sum(pto.quantity) as quantity
FROM phones AS p
  FULL OUTER JOIN  phones_to_orders AS pto ON p.id=pto."phoneId"
GROUP BY p.id
ORDER BY quantity;



-- пошту користувачів, які купляли нокіа
SELECT  u.email
FROM users AS u
  JOIN orders AS o ON u.id=o."userId"
  JOIN phones_to_orders AS pto ON o.id=pto."orderId"
  JOIN phones AS p ON pto."phoneId"=p.id
WHERE p.brand ILIKE 'Iphone'
GROUP BY u.email; 


-- айді користувачів, у яких більше 3 замовлень
SELECT "userId", count(id)
FROM orders
GROUP BY "userId"
HAVING count(id)>3;


SELECT o."userId", count(o.id), u.email
FROM users u  
  JOIN orders o ON u.id=o."userId"
GROUP BY o."userId", u.email
HAVING count(o.id)>3;



-- айді замовлень з телефоном 22 i пошту користувачів
SELECT o.id, u.email
FROM users u  
  JOIN orders o ON u.id=o."userId"
  JOIN phones_to_orders pto ON o.id=pto."orderId"
WHERE pto."phoneId"=23;




-- 5 моделей телефонів, які купували з найбільшою кількістю
SELECT p.model, sum(p.quantity) as summa
FROM phones p
  JOIN phones_to_orders pto ON p.id=pto."phoneId"
GROUP BY   p.model
ORDER BY summa DESC
LIMIT 5;


-- дістати усі моделі телефонів конкретного замовлення 56







-- дістати пошту користувача і кількість моделей які він купляв
SELECT u."email", count(pto."phoneId")
FROM users u
    JOIN orders o ON u."id"=o."userId"
    JOIN phones_to_orders pto ON o."id"=pto."orderId"
WHERE u.id = 25
GROUP BY u."email";



-- айді замовлення і його загальну сумму
