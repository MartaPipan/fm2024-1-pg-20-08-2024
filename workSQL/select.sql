SELECT * FROM users;
SELECT "firstName","lastName", "isMale" FROM users;

SELECT * FROM users WHERE "isMale"=TRUE;
SELECT * FROM users WHERE "isMale" IS TRUE;
SELECT * FROM users 
WHERE "isMale" IS NOT TRUE;

SELECT email, "isMale" FROM users WHERE "isMale"=TRUE;


SELECT id, "firstName", "isMale", birthday FROM users 
WHERE "isMale"=false AND id%2=0;

SELECT * FROM users 
WHERE "firstName"='Amy';

SELECT * FROM users WHERE "firstName" IN ('Amy', 'Jim');
SELECT * FROM users WHERE "firstName" =  'Jim' OR "firstName" =  'Tom' 
OR "firstName" =  'Karen';

SELECT id, "firstName", "lastName" FROM users
WHERE id BETWEEN 15 AND 26;
SELECT id, "firstName", "lastName" FROM users
WHERE id NOT BETWEEN 10 AND 46;


SELECT id, "firstName", email, birthday
FROM "users" 
WHERE EXTRACT ( YEAR from birthday)=1987;

--    *users born in winner
SELECT id, email, birthday
FROM "users" 
WHERE EXTRACT ( MONTH from birthday) IN (1,2,12);
-- *female born in summer
SELECT id, email, birthday
FROM "users" 
WHERE EXTRACT ( MONTH from birthday) IN (6,7,8) AND "isMale" IS NOT TRUE;

--     * <30 years
SELECT id, email, birthday, "isMale"
FROM "users" 
WHERE age (birthday)<make_interval(30);

SELECT id, email, birthday, "isMale", age(birthday)
FROM "users" 
WHERE age (birthday)<make_interval(30);

SELECT id, email, birthday, "isMale", age(birthday)
FROM "users" 
WHERE age (birthday) < make_interval(years=>30,months=>11);

SELECT "firstName" 
FROM "users" 
WHERE "birthday" > '1987-09-09';

SELECT id, "firstName", email, birthday
FROM "users" 
WHERE "birthday" > '1986-12-31' AND
"birthday" < '1988-01-01';

--    email,age, hight, *mens >40years
SELECT id, email, EXTRACT(years from age(birthday)),height, "isMale"
FROM users WHERE "isMale" IS TRUE AND height<1.9 AND age(birthday)>make_interval(40);

SELECT id, email, EXTRACT(years from age(birthday)) as age,height, "isMale"
FROM users WHERE "isMale" IS TRUE AND height<1.9 AND age(birthday)>make_interval(40);

SELECT *
FROM users WHERE "firstName" IN ('Ana', 'Jenny', 'Amy', 'Marie') AND EXTRACT(years from age(birthday)) >40;


SELECT id,"firstName", "lastName", email, EXTRACT(years from age(birthday)) as age,"isMale"
FROM users WHERE "firstName" IN ('Amy', 'Jenny', 'Lisa', 'Marie') AND age(birthday)>make_interval(40);

SELECT*
FROM
(SELECT id,"firstName", "lastName", email, EXTRACT(years from age(birthday)) as age,"isMale"
FROM users WHERE "firstName" IN ('Amy', 'Jenny', 'Lisa', 'Marie')) 
WHERE age < 40;

SELECT* FROM users LIMIT 7;

SELECT* FROM users LIMIT 7 
OFFSET 7;

--(У SQL запиті OFFSET використовується для пропуску певної кількості рядків перед тим, як почати повертати результати.
--Запит SELECT * FROM users LIMIT 7 OFFSET 7; працює наступним чином:

--SELECT * FROM users: цей запит вибирає всі стовпці з таблиці users.

--LIMIT 7: обмежує кількість рядків, які будуть повернені, до 7.

--OFFSET 7: пропускає перші 7 рядків у результатах запиту, і лише після цього починає повертати наступні рядки.

--Таким чином, цей запит поверне рядки з 8 по 14 (включно) з таблиці users, пропускаючи перші 7 рядків.)


SELECT* FROM users LIMIT 7 
OFFSET 5;

-- 7 означає, що буде повернуто не більше 7 рядків.
--FFSET 5 означає, що пропустяться перші 5 рядків, і --запит поверне 7 наступних після них.


SELECT* FROM users LIMIT 7 
OFFSET 2*7;
--OFFSET 2*7: Оператор OFFSET вказує, скільки рядків потрібно пропустити перед тим, як почати повертати результати. У цьому випадку, ви пропускаєте 2*7 = 14 рядків.
--LIMIT 7: Оператор LIMIT визначає, скільки рядків потрібно повернути після пропуску рядків, вказаних OFFSET.


SELECT* FROM users  WHERE height>1.85 LIMIT 7;

--Pagination
SELECT* FROM users LIMIT 7 
OFFSET 0*7;
SELECT* FROM users LIMIT 7 
OFFSET 1*7;
SELECT* FROM users LIMIT 7 
OFFSET 2*7;
SELECT* FROM users LIMIT 7 
OFFSET 3*7;

--concatination
SELECT id, "firstName"||' '||"lastName" as "fullName"
FROM users;

SELECT id, "firstName"||' '||null as "fullName"
FROM users;

SELECT id,concat("firstName", ' ', null) as "fullName"
FROM users
LIMIT 10;

SELECT id,concat("lastName", ' ', left("firstName",1)) as "fullName"
FROM users
LIMIT 10;

SELECT id,concat("lastName", ' ', left("firstName",1),'.') as "fullName"
FROM users
LIMIT 10;

SELECT*
FROM(
    SELECT id,concat("lastName", ' ', left("firstName",1),'.') as "fullName"
FROM users)
WHERE length("fullName")<8;

SELECT id, "firstName" FROM users
WHERE "firstName" LIKE 'A%';

SELECT id, "firstName" FROM users
WHERE "firstName" ILIKE 'a%';

SELECT id, "firstName" FROM users
WHERE "firstName" ILIKE '%a';

SELECT id, "firstName" FROM users
WHERE "firstName" ILIKE '_a%';

SELECT id, "firstName" FROM users
WHERE "firstName" ILIKE '%sa';



