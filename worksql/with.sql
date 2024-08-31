-- дістати замовлення сума яких вище середньої суми
-- замовлення і його сума
SELECT pto."orderId", sum(pto.quantity*p.price)
FROM phones_to_orders pto 
  JOIN phones p ON pto."phoneId"=p.id
GROUP BY pto."orderId";
-- середню суму
SELECT avg(orders_cost.cost)
FROM(
  SELECT pto."orderId", sum(pto.quantity*p.price) as cost
  FROM phones_to_orders pto 
    JOIN phones p ON pto."phoneId"=p.id
  GROUP BY pto."orderId"
) as orders_cost;

-- замовлення сума яких вище середньої суми
SELECT *
FROM(
  SELECT pto."orderId", sum(pto.quantity*p.price) as cost
  FROM phones_to_orders pto 
    JOIN phones p ON pto."phoneId"=p.id
  GROUP BY pto."orderId"
) as orders_cost
WHERE orders_cost.cost > (
  SELECT avg(orders_cost.cost)
    FROM(
      SELECT pto."orderId", sum(pto.quantity*p.price) as cost
      FROM phones_to_orders pto 
        JOIN phones p ON pto."phoneId"=p.id
      GROUP BY pto."orderId"
    ) as orders_cost
)
ORDER BY orders_cost.cost;

-- оптимізація з with
WITH orders_cost AS (
  SELECT pto."orderId", sum(pto.quantity*p.price) as cost
  FROM phones_to_orders pto 
    JOIN phones p ON pto."phoneId"=p.id
  GROUP BY pto."orderId"  
)
SELECT oc.*
FROM orders_cost oc
WHERE oc.cost > (SELECT avg(oc.cost) FROM orders_cost as oc) --скалярний підзапит
ORDER BY oc.cost;



-- дістати пошту користувачів, у яких кількість замовлень більше середнього значення
-- пошта і кількість замовлень
-- середня кількість
-- збираємо до купи запит
-- оптимізуємо з with

