CREATE TABLE pizza (
    id serial PRIMARY KEY,   
    name VARCHAR(255) NOT  NULL CHECK(name!=''),
    price NUMERIC(10, 2) NOT NULL,
    diameter INT NOT NULL 
);
--Завдання на INSERT:
--Додати нову піцу Маргарита, діаметр 18, ціна 50,4 грн:
INSERT INTO pizza (name, price, diameter)
VALUES ('margarita', 50.4, 18);

--Додати нову піцу Карбонара, діаметр 28, ціна 81 грн:
INSERT INTO pizza (name, price, diameter)
VALUES ('carbonara', 81, 28);

--Додати дві нові піци одним запитом: Цезар (38 см, 149 грн) та Пепероні (32 см, 116 грн):
INSERT INTO pizza (name, price, diameter)
VALUES 
('cesar', 149, 38),
('pipperoni', 116, 32);

--Завдання на UPDATE: Поставити ціну Маргариті 53 грн
UPDATE pizza
SET price = 53
WHERE name = 'margarita';

--Піці з id = 4 поставити діаметр 30, повернути всі оновлені дані:
UPDATE pizza
SET diameter = 30
WHERE id = 4
RETURNING *;

--Усім піцам, чия ціна більше за 100 грн, зробити її 130 грн, повернути всі оновлені дані:
UPDATE pizza
SET price = 130
WHERE price > 100
RETURNING *;

--Піці з id більше 2 і менше 5 включно поставити діаметр 22:
UPDATE pizza
SET diameter = 22
WHERE id > 2 AND id <= 5;

--Змінити Цезар на 4 сири та поставити ціну 180 грн:
UPDATE pizza
SET name = 'four_cheeses', price = 180
WHERE name = 'cesar';

--Завдання на SELECT: Вибрати піцу з id = 3:
SELECT * FROM pizza
WHERE id = 3;

--Вибрати піци із ціною менше 100 грн:
SELECT * FROM pizza
WHERE price < 100;

--Вибрати піци з ціною, не рівною 130 грн:
SELECT * FROM pizza
WHERE price != 130;

--Дізнатись ціну і діаметр Пепероні:
SELECT price, diameter FROM pizza
WHERE name = 'pepperoni';

--Вибрати піцу під назвою Маргарита:
SELECT * FROM pizza
WHERE name = 'margarita';

--Вибрати всі піци, крім тієї, яка називається Карбонара:
SELECT * FROM pizza
WHERE name != 'carbonara';

--Вибрати всі піци діаметром 22 та ціною менше 150 грн:
SELECT * FROM pizza
WHERE diameter = 22 AND price < 150;

--Вибрати піцу з діаметром від 25 до 33 включно:
SELECT * FROM pizza
WHERE diameter BETWEEN 25 AND 33;

--Вибрати піци з діаметром від 25 до 33 або з ціною від 100 до 200 грн:
SELECT * FROM pizza
WHERE (diameter BETWEEN 25 AND 33) OR (price BETWEEN 100 AND 200);

--Вибрати всі піци діаметром 22 або 180 грн:
SELECT * FROM pizza
WHERE diameter = 22 OR price = 180;

--Завдання на DELETE: Видалити піцу з id = 3:
DELETE FROM pizza
WHERE id = 3;

--Видалити Пепероні, повернути всі видалені дані:
DELETE FROM pizza
WHERE name = 'pepperoni'
RETURNING *;

--Видалити всі піци, які мають діаметр 18, повернути всі видалені дані:
DELETE FROM pizza
WHERE diameter = 18
RETURNING *;






