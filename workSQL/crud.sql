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