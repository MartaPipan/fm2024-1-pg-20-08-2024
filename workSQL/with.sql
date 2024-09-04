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

