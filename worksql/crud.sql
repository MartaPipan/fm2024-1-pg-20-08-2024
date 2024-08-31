SELECT *
FROM users
WHERE id=23;

UPDATE users
SET height=("height" + 0.02)
WHERE "isMale" IS TRUE 
  AND age("birthday") < make_interval(40)
RETURNING *;

UPDATE users
SET "firstName"='Alex', email='alex@gmail.com'
WHERE id=23
RETURNING id, "firstName", email;

-- оновити зріст(+1см) всім жінкам ім'я яких починається на літеру s

UPDATE users
SET height=height+0.01
WHERE "firstName" ILIKE 's%'
RETURNING id, height, "isMale", "firstName";

-- оновити email усім чоловікам прізвище яких закінчується на літери d,e,s
-- lastname.firstname9@gmail.com

UPDATE users
SET email=concat(lower("lastName"),'.',lower("firstName"),id,'@gmail.com')
WHERE "isMale"=true 
  AND  "lastName"  SIMILAR TO '%(s|d|e)'
RETURNING id, email, "isMale", "lastName";


SELECT id, email, "isMale", "lastName"
FROM users
WHERE "lastName" ILIKE '%s' OR "lastName" ILIKE '%e' OR "lastName" ILIKE '%d';

SELECT id, email, "isMale", "lastName"
FROM users
WHERE "lastName"  SIMILAR TO '%(s|d|e)' ;



INSERT INTO users ( "firstName","lastName",email,"isMale", birthday,height)
VALUES 
('Otto','Grand','grand78@gmail.com', true,'2000-01-12',1.9),
('Noname','Noname','Noname8@gmail.com', true,'2000-01-12',1.9),
('Anna','Grand','grand028@gmail.com', false,'2002-01-12',1.9)
RETURNING *;


SELECT id,  "lastName"
FROM users
WHERE "lastName"  ILIKE 'n%';

DELETE FROM users
WHERE  "lastName"  ILIKE 'noname'
RETURNING *;

DELETE FROM users
WHERE id=53
RETURNING *;