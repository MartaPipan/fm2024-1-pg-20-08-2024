/* count (количество), 
 sum (сумму), 
 avg (среднее), 
 max (максимум)
 min (минимум)
 */

 SELECT max (weight)
 FROM users;


 SELECT sum ("weight")
 FROM users;

 SELECT avg ("weight")
 FROM users;

 SELECT count (*)
 FROM users
 WHERE "weight">90 AND "isMale"=false;
 
 SELECT* 
 FROM users
 WHERE "weight"=110.0;


 SELECT* 
 FROM users
 WHERE "weight"=(SELECT max ("weight") FROM users);

 SELECT*
 FROM users
 WHERE "height"=(SELECT min ("height")
 FROM users);


 SELECT min("weight"), id
  FROM users
  GROUP BY id;


 SELECT min("weight"), "isMale"
  FROM users
  GROUP BY "isMale";

 SELECT avg("weight") as "avgWeight", "isMale"
  FROM users
  GROUP BY "isMale";  

 SELECT min("weight") as "minWeight", "isMale"
  FROM users
  GROUP BY "isMale"; 

 SELECT min("weight") as "minWeight", "isMale"
  FROM users
  WHERE "firstName" ILIKE 'a%'
  GROUP BY "isMale";
  
 SELECT sum("weight") as "minWeight", "isMale"
  FROM users
  WHERE "firstName" ILIKE 'a%'
  GROUP BY "isMale"; 

 SELECT count (*), "isMale"
  FROM users
  GROUP BY "isMale"; 

 SELECT count (*), 
 EXTRACT (year FROM birthday)
 as "yearByBirthday"
 FROM users
 WHERE 
 EXTRACT(year FROM birthday)=1979
 GROUP BY "yearByBirthday";

 SELECT count (*), 
 EXTRACT (months FROM birthday)
 as "monthsByBirthday"
 FROM users
 GROUP BY "monthsByBirthday";

 SELECT count (*),
 EXTRACT (months FROM birthday)
 as "monthsByBirthday", "isMale"
 FROM users
 GROUP BY "monthsByBirthday", "isMale"; 

 SELECT count (*),"isMale"
 FROM users
 WHERE "weight">1.8
 GROUP BY "isMale"; 


SELECT sum (quantity)
FROM phones_to_orders;

SELECT sum (quantity), "phoneId"
FROM phones_to_orders
GROUP BY "phoneId";

SELECT sum (quantity), "orderId"
FROM phones_to_orders
GROUP BY "orderId";

SELECT avg(price)
FROM phones;

SELECT avg(price), "brand"
FROM phones
GROUP BY "brand";

SELECT count(model), "brand"
FROM phones
GROUP BY "brand";

SELECT count(*), "userId"
FROM orders
GROUP BY "userId";

SELECT count(model), brand
FROM phones
WHERE brand ILIKE 's%'
GROUP BY brand;

