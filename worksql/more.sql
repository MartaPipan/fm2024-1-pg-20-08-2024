-- json

DROP TABLE cafes;

CREATE TABLE cafes(
  id serial PRIMARY KEY,
  address jsonb
);

INSERT INTO cafes(address)
VALUES ('{"country":"Ukraine", "city":"Zp", "street":"Qwert", "house":{"pd":2, "fl":4, "app": 45}}');


CREATE TABLE schools(
  id serial PRIMARY KEY,
  number int unique,
  name jsonb
);