--agregat function
SELECT users.id, users.email,count(orders.id)
FROM users
JOIN orders ON users.id = orders."userId"
GROUP BY users.id, users.email;

--window function
SELECT users.id, users.email, orders."createdAt" , count(orders.id) 
OVER (PARTITION BY orders."userId")
FROM users
JOIN orders ON users.id = orders."userId";

CREATE TABLE student_grades(
    name varchar,
    subject varchar,
    grade int
);
INSERT INTO student_grades VALUES
('Jim', 'ingles',18),
('Olga', 'france',15),
('Jack', 'spain',16),
('Jim', 'german',8),
('Ana', 'german',14),
('Luck', 'ingles',11),
('Sara', 'france',7),
('Maria', 'spain',9)

SELECT* FROM student_grades
ORDER BY subject;

INSERT INTO student_grades VALUES
('Jim', 'spain',12),
('Olga', 'mat',15),
('Jim', 'history',19),
('Olga', 'mat',17),
('Jack', 'geology',16),
('Jim', 'mat',8),
('Jack', 'history',16),
('Jim', 'art',8);

SELECT* FROM student_grades
ORDER BY name;


SELECT list of columns,window functions
FROM table/join table/subquery
WHERE filtering clause
ORDER BY list of columns/window 


SELECT name, subject, grade,
sum (grade) over (PARTITION BY name) as summa_grade,
avg (grade) over (PARTITION BY name) as avg_grade,
count (grade) over (PARTITION BY name) as count_grade,
min (grade) over (PARTITION BY name) as min_grade,
max (grade) over (PARTITION BY name) as max_grade
FROM student_grades;



--email & count of orders in email:
SELECT users.id, users.email,count(orders.id)
FROM users
JOIN orders ON users.id=orders."userId"
GROUP by users.id, users.email;

--with func OVER(PARTITION BY)
SELECT users.*, orders.*,
count(orders.id) OVER (PARTITION BY orders."userId")
FROM users
JOIN orders ON users.id=orders."userId";

SELECT users.id, users.email,orders."createdAt", 
count(orders.id) OVER (PARTITION BY orders."userId")
FROM users
JOIN orders ON users.id=orders."userId";

--sum of orders with phone & phone
--Віконна функція дозволяє обчислити суму для кожного рядка без зміни кількості рядків у результаті.
--Результат покаже всі телефони з їх ціною та кількістю для кожного замовлення, але також додасть стовпець із загальною сумою для кожного замовлення.
SELECT 
    p.id, 
    p.model, 
    p.price, 
    pto."orderId", 
    SUM(p.price * pto.quantity) 
        OVER (PARTITION BY pto."orderId") AS total_order_price
FROM phones p
JOIN phones_to_orders pto ON p.id = pto."phoneId";


--with GROUP
--GROUP BY об'єднує всі рядки, які мають однакові значення у згрупованих стовпцях (наприклад, телефони та замовлення), і обчислює загальну суму для цих груп.
--Результат цього запиту покаже один рядок для кожного унікального поєднання телефону та замовлення з їх загальною сумою.

SELECT 
    p.id, 
    p.model, 
    p.price, 
    pto."orderId", 
    SUM(p.price * pto.quantity) AS total_price
FROM phones p
JOIN phones_to_orders pto ON p.id = pto."phoneId"
GROUP BY p.id, p.model, p.price, pto."orderId"; 


--результати не будуть однаковими.

--Запит з віконною функцією поверне кожен телефон з окремого замовлення, але для кожного рядка буде показана загальна сума для всього замовлення. Тобто кожен рядок матиме свою кількість телефонів, а в додатковому стовпці буде відображена загальна вартість замовлення.

--Запит з GROUP BY поверне агреговані дані для кожної пари "телефон-замовлення", і кожен рядок буде представляти підсумкову вартість для конкретного телефону в конкретному замовленні.

--Віконна функція повертає всі рядки з повторюваною інформацією про загальну суму для кожного замовлення.
--GROUP BY зменшить кількість рядків, оскільки дані будуть згруповані за телефонами і замовленнями.

--total price sort of model in order5
SELECT 
    p.id, 
    p.model, 
    p.price, 
    pto."orderId", 
    SUM(p.price * pto.quantity) AS total_price
FROM phones p
JOIN phones_to_orders pto ON p.id = pto."phoneId"
WHERE pto."orderId"=5
GROUP BY p.id, p.model, p.price, pto."orderId";

--total price all models in order 5
SELECT
    p.id, 
    p.model, 
    p.price, 
    pto."orderId", 
    SUM(p.price * pto.quantity) 
        OVER (PARTITION BY pto."orderId") AS total_order_price
FROM phones p
JOIN phones_to_orders pto ON p.id = pto."phoneId"
WHERE pto."orderId"= 5;


--sort windows func with OBDER BY (with acumulation in running)
--(add price *quantity next model...)
SELECT
    p.id, 
    p.model, 
    p.price, 
    pto."orderId", 
    SUM(p.price * pto.quantity) 
        OVER (PARTITION BY pto."orderId" ORDER BY p.id) AS total_order_price
FROM phones p
JOIN phones_to_orders pto ON p.id = pto."phoneId"
WHERE pto."orderId"= 5;

SELECT
    p.id, 
    p.model, 
    p.price, 
    pto."orderId", 
    SUM(p.price * pto.quantity) 
        OVER (PARTITION BY pto."orderId" ORDER BY p.id) AS total_order_price
FROM phones p
JOIN phones_to_orders pto ON p.id = pto."phoneId"
WHERE pto."orderId"= 5;

--order by p.id all price in order 
--used:   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING

SELECT
    p.id, 
    p.model, 
    p.price, 
    pto."orderId", 
    SUM(p.price * pto.quantity) 
        OVER (PARTITION BY pto."orderId" ORDER BY p.id ROWS
BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS total_order_price
FROM phones p
JOIN phones_to_orders pto ON p.id = pto."phoneId"
WHERE pto."orderId"= 5;
