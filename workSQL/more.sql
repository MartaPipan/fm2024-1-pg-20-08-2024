--json
DROP TABLE cafes;
CREATE TABLE cafes IF NOT EXIST(
    id serial PRIMARY KEY,
    address jsonb
);
INSERT INTO cafes(address)
VALUES
('{
 "country":"Ukraine",
 "city":"Lviv",
  "street":"Lysenka", 
      "house":
          {"entrance":2,
           "floor":4,
           "apartment":45}
           }');

CREATE TABLE schools(
    id serial PRIMARY KEY,
    number int unique,
    name jsonb
)
