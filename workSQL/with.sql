--summa por order
SELECT pto."orderId", sum(pto.quantity*p.price) AS summa
FROM phones_to_orders AS pto 
JOIN phones AS p ON pto."phoneId"=p.id
GROUP BY "orderId";

--summa media de order
SELECT avg (orders_summa.summa) 
FROM (
    SELECT pto."orderId", sum(pto.quantity*p.price) AS summa
FROM phones_to_orders AS pto 
JOIN phones AS p ON pto."phoneId"=p.id
GROUP BY "orderId"
) as orders_summa;

--order with summa>avg(summa)
SELECT *
FROM (
    SELECT pto."orderId", sum(pto.quantity*p.price) AS summa
FROM phones_to_orders AS pto 
JOIN phones AS p ON pto."phoneId"=p.id
GROUP BY "orderId"
) as orders_summa
WHERE orders_summa.summa>
(SELECT avg (orders_summa.summa) 
FROM (
    SELECT pto."orderId", sum(pto.quantity*p.price) AS summa
FROM phones_to_orders AS pto 
JOIN phones AS p ON pto."phoneId"=p.id
GROUP BY "orderId"
) as orders_summa)
ORDER BY orders_summa.summa;

--optimization with WITH 

WITH orders_summa AS (
    SELECT pto."orderId", sum(pto.quantity*p.price) AS summa
    FROM phones_to_orders AS pto 
    JOIN phones AS p ON pto."phoneId"=p.id
    GROUP BY "orderId"
) 

SELECT orders_summa.*
FROM orders_summa
WHERE orders_summa.summa >
(SELECT avg (orders_summa.summa) 
FROM orders_summa)
ORDER BY orders_summa.summa;


--taskКроки:
--1.Обчислити кількість замовлень для кожного користувача.
--2.Обчислити середнє значення кількості замовлень.
--3.Отримати пошту користувачів, у яких кількість замовлень перевищує середнє значення.


-- 1.пошта і кількість замовлень

WITH email_order AS (
    SELECT u.email, count(o.id) AS order_count
    FROM users AS u
    JOIN orders AS o ON u.id=o."userId"
    GROUP BY u.email)

-- середня кількість замовлень
SELECT avg (email_order.order_count) AS avg_order_count
FROM email_order;

-- збираємо до купи запит
SELECT email_order*
FROM email_order
WHERE email_order.order_count > (SELECT avg (email_order.order_count) AS avg_order_count
FROM email_order);

-- оптимізуємо з with
WITH email_order AS (
    SELECT u.email, count(o.id) AS order_count
    FROM users AS u
    JOIN orders AS o ON u.id=o."userId"
    GROUP BY u.email
    )
SELECT email_order.*
FROM email_order
WHERE email_order.order_count > 
(SELECT avg (email_order.order_count)
FROM email_order)
ORDER BY email_order.order_count;
