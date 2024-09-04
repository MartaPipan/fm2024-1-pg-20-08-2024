--is null
SELECT * 
FROM phones
WHERE description IS NULL;

-- умовні конструкції if/elseif/else
/*
CASE
  WHEN condition1 = true THEN action1
  WHEN condition2 = true THEN action2
  ELSE action3
END
*/

SELECT email,(
    CASE
    WHEN "isMale"=TRUE THEN 'male'
    ELSE 'female'
    END
) AS gender
FROM users;


-- умовні конструкції swith case
/*
CASE ext
  WHEN ex1 THEN action1
  WHEN ex2 THEN action2
  ELSE action3
END
*/
SELECT email, birthday, (
CASE extract(month from birthday)
  WHEN 1 THEN 'winter'
  WHEN 2 THEN 'winter'
  WHEN 3 THEN 'spring'
  WHEN 4 THEN 'spring'
  WHEN 4 THEN 'spring'
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

-- модель телефону, ціну і колонку зі значенням 
--above , якщо ціна вища за середню і below, якщо нижча

SELECT model, price,
(CASE
  WHEN price > (SELECT avg(price) FROM phones) THEN 'above'
  ELSE 'below'
  END
) AS access
FROM phones
ORDER BY access;

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

