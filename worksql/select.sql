SELECT * FROM users;

SELECT "firstName", "lastName", "isMale"
FROM users
WHERE "isMale" IS NOT TRUE;

SELECT email, "isMale" 
FROM users 
WHERE "isMale"=TRUE;

-- дістати ім'я стать і дн усіх жінок з парними id
SELECT id, "firstName", "isMale", "birthday"
FROM users
WHERE "isMale"=FALSE AND id%2=0;

SELECT * 
FROM users
WHERE "firstName"='Amy' OR "firstName"='Jim';


SELECT * 
FROM users
WHERE "firstName" IN ('Amy', 'Jim', 'Pena');

SELECT id, "firstName"
FROM users
WHERE id NOT BETWEEN 15 AND 20;


SELECT id, email, birthday
FROM users
WHERE EXTRACT(YEAR from birthday)=1987;

-- пошта, дн усіх жінок народився взимку
SELECT id, email, birthday, "isMale"
FROM users
WHERE EXTRACT(month from birthday) IN (1,2,12) 
AND "isMale" IS NOT TRUE;

-- всі менше 30 років
SELECT id, email, birthday, "isMale",age(birthday)
FROM users
WHERE age(birthday) < make_interval(years=>30);

-- пошта, age, зріст, стать усіх чоловіків старше 40 років зі зростом менше 1.9
SELECT id, email, EXTRACT(year from age(birthday)) as age, height, "isMale"
FROM users
WHERE "isMale" IS TRUE 
  AND height<1.9 
  AND age(birthday)>make_interval(40);


-- всіх Amy або Jenny або Lisa або Marie молодше 40 років
SELECT * 
FROM (
  SELECT id, "firstName", EXTRACT(year from age(birthday)) as age
  FROM users
  WHERE "firstName" IN ('Amy','Jenny','Lisa','Marie')
)
WHERE age < 40;


-- 7

SELECT id, "firstName", height
FROM users
-- WHERE height>1.85
LIMIT 5
OFFSET 1*5;



SELECT id, "firstName"||' '||"lastName" as full_name
FROM users
LIMIT 10;

SELECT id, "firstName"||' '||null as full_name
FROM users
LIMIT 10;




SELECT id, concat("firstName",' ',"lastName") as full_name
FROM users
LIMIT 10;

SELECT id, concat("firstName",' ',null) as full_name
FROM users
LIMIT 10;

SELECT *
FROM (
  SELECT id, concat("lastName",' ',left("firstName",1),'.') as full_name
  FROM users
)
WHERE length(full_name)<8;


SELECT id, "firstName"
FROM users
WHERE "firstName" LIKE 'Aa%';


SELECT id, "firstName"
FROM users
WHERE "firstName" ILIKE '_a%';


SELECT id, "firstName"
FROM users
WHERE "firstName" ILIKE 'v%sa';


SELECT id, height
FROM users;