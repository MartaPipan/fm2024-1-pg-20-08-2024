CREATE TYPE task_status AS ENUM('done','reject','pending','processing');

CREATE TABLE tasks(
  id serial PRIMARY KEY,
  body varchar(256) NOT NULL,
  user_id int REFERENCES users(id),
  deadline timestamp,
  status task_status
);

INSERT INTO tasks(body,user_id,deadline)
VALUES ('body1', 1, '2024-08-26'),('body2', 11, '2024-08-26'),('body3', 41, '2024-08-26');

INSERT INTO tasks(body,user_id,deadline, status)
VALUES ('new body task',1, NULL, 'pending');

SELECT * FROM tasks;

-- add new column
ALTER TABLE tasks
ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

-- delete new column
ALTER TABLE tasks
DROP COLUMN created_at;

-- add new constraint
ALTER TABLE tasks
ADD CHECK(created_at<=current_timestamp);

ALTER TABLE tasks
ADD CONSTRAINT "check_created_at" CHECK("created_at"<=current_timestamp);

-- delete new constraint
ALTER TABLE tasks
DROP CONSTRAINT tasks_created_at_check;

ALTER TABLE tasks
DROP CONSTRAINT check_created_at;

-- set not null
UPDATE tasks
SET status='done'
WHERE status IS NULL;

ALTER TABLE tasks
ALTER COLUMN status SET NOT NULL;

-- delete not null
ALTER TABLE tasks
ALTER COLUMN status DROP NOT NULL;



-- set default
ALTER TABLE tasks
ALTER COLUMN deadline SET DEFAULT current_timestamp;
ALTER TABLE tasks
ALTER COLUMN status SET DEFAULT 'pending';

INSERT INTO tasks(body,user_id, status)
VALUES ('new body task',29, 'processing');

-- delete default
ALTER TABLE tasks
ALTER COLUMN status DROP DEFAULT;


-- update type
ALTER TABLE tasks
ALTER COLUMN body TYPE text;


-- rename
ALTER TABLE tasks
RENAME COLUMN body TO content;

ALTER TABLE tasks
RENAME TO user_tasks;


SELECT * FROM user_tasks;




-- додати колонку вага до таблиці users
-- numeric(4,1)  default (height-1)*100
--  1.98-1=0.98*100=98  

ALTER TABLE "users"
ADD COLUMN "weight" numeric(4,1);

UPDATE users
SET "weight"=("height"-1)*100;

ALTER TABLE "users"
ALTER COLUMN "weight" SET NOT NULL;