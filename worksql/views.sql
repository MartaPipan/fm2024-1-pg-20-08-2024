CREATE VIEW email_sezon AS (
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
  FROM users
);

SELECT * 
FROM email_sezon
WHERE season='winter';

SELECT season, count(*)
FROM email_sezon
GROUP BY season;

DELETE FROM users WHERE id=57 RETURNING *;

DROP VIEW email_total_cost;

CREATE VIEW email_total_cost AS (
  SELECT u.email, sum(p.price*pto.quantity) AS total
  FROM users u
    JOIN orders o ON u.id=o."userId"
    JOIN phones_to_orders pto ON o.id=pto."orderId"
    JOIN phones p ON pto."phoneId"=p.id
  GROUP BY u.email 
);

SELECT es.season, sum(etc.total) AS summa
FROM email_sezon es
  JOIN email_total_cost etc ON es.email=etc.email
GROUP BY es.season
ORDER BY summa DESC;