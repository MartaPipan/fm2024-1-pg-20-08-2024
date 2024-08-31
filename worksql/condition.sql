-- is null
SELECT *
FROM phones
WHERE description IS NULL;

-- умовні конструкції if/elseif/else
/*
CASE
  WHEN cond1 = true THEN act1
  WHEN cond2 = true THEN act2
  ELSE act3
END
*/

SELECT email, (
  CASE
    WHEN "isMale" = true THEN 'male'
    ELSE 'female'
  END
) as gender
FROM users;

-- switch
/*
CASE key
  WHEN ex1 THEN act1
  WHEN ex1 THEN act2
  ELSE default
END
*/

SELECT email, birthday, (
  CASE extract(month from birthday)
    WHEN 1 THEN 'winter'
    WHEN 2 THEN 'winter'
    WHEN 3 THEN 'spring'
    WHEN 4 THEN 'spring'
    WHEN 5 THEN 'spring'
    WHEN 6 THEN 'summer'
    WHEN 7 THEN 'summer'
    WHEN 8 THEN 'summer'
    WHEN 9 THEN 'autumn'
    WHEN 10 THEN 'autumn'
    WHEN 11 THEN 'autumn'
    WHEN 12 THEN 'winter'
  END 
) as season
FROM users;


-- модель телефону, ціну і колонку зі значенням above , якщо ціна вища за середню і below, якщо нижча

SELECT model, price, (
  CASE
    WHEN price> (SELECT avg(price) FROM phones) THEN 'above'
    ELSE 'below'
  END
) as access
FROM phones;


--COALESCE
SELECT model, COALESCE(description, 'no info')
FROM phones;

--NULLIF
SELECT NULLIF(12,12);
SELECT NULLIF(NULL,12);
SELECT NULLIF(12,NULL);
SELECT NULLIF('12','qq');


-- users with orders
SELECT email
FROM users
WHERE id IN (SELECT DISTINCT "userId" FROM orders);
-- users without orders
SELECT email
FROM users
WHERE id NOT IN (SELECT DISTINCT "userId" FROM orders);


SELECT EXISTS (SELECT * FROM users WHERE id=45);