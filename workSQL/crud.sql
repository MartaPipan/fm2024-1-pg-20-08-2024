UPDATE users
SET height=height+0.01
WHERE height<2.0;

UPDATE users
SET height=(height+0.01)
WHERE "isMale" IS TRUE
AND age(birthday) < make_interval(40)
RETURNING *;

SELECT * FROM users
WHERE id=4;

UPDATE users
SET "firstName"='Tom', email='tom.seahton@gmail.com'
WHERE id=4
RETURNING *;

UPDATE users
SET "firstName"='Bob', email='tom.seonbob@gmail.com'
WHERE id=6
RETURNING *;

UPDATE users
SET "firstName"='Alex', email='seal@gmail.com'
WHERE id=21
RETURNING id, "firstName", email;

UPDATE users
SET height=(height+0.01)
WHERE "isMale" IS FALSE
AND "firstName" ILIKE 's%'
RETURNING id, height, "isMale", "firstName";


SELECT id, email, "isMale", "lastName"
FROM users
WHERE  
"lastName" ILIKE '%d' OR
"lastName" ILIKE '%e' OR
"lastName" ILIKE '%s';

SELECT id, email, "isMale", "lastName"
FROM users
WHERE "lastName" SIMILAR TO '%(d|e|s)';

UPDATE users
SET email=concat(lower("lastName"),'.',lower("firstName"),id,'@gmail.com')
WHERE "isMale" IS TRUE
AND "lastName" SIMILAR TO '%(d|e|s)'
RETURNING id,"isMale", "lastName", email;

INSERT INTO users (
    "firstName",
    "lastName",
    email,
    "isMale",
    birthday,
    height
  )

    VALUES (
        'Otto',
        'Grand',
        'grand.otto53@gmail.com',
        true,
        '2000-01-12',
        1.9
      ), (
        'Anna',
        'Carolino',
        'carolino.anna52@gmail.com',
        false,
        '1996-11-03',
        1.72
      ),(
        'luis',
        'Carvalho',
        'carvalho.luis51@gmail.com',
        true,
        '2001-09-22',
        1.98
      ) RETURNING*;
      
SELECT id, email,"firstName"
FROM users
WHERE "firstName" ILIKE 'Anna';

SELECT id, email,"firstName"
FROM users
WHERE "firstName" ILIKE 'luis';

DELETE FROM users
WHERE "firstName" ILIKE 'luis'
RETURNING *;

DELETE FROM users
WHERE id=52
RETURNING *;

