
CREATE SCHEMA work;

CREATE TABLE work."users"(
  id serial PRIMARY KEY,
  login varchar(16)
);

SELECT * FROM work.users;

SELECT * FROM public.users;