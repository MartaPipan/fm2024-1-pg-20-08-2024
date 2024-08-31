CREATE TYPE task_status AS enum('done','reject', 'pending', 'processing');
CREATE TABLE tasks(
    id serial PRIMARY KEY,
    "body" varchar(256) NOT NULL,
    user_id int REFERENCES users(id),
    deadline timestamp,
    status task_status DEFAULT 'pending'
);

INSERT INTO tasks(body, user_id, deadline)
VALUES
('body1',1, '2024-08-26'),
('body2',27, '2024-08-21'),
('body3',39, '2024-08-28');


INSERT INTO tasks(body, user_id, deadline, status)
VALUES
('new body task',21, '2024-08-25', 'pending');


INSERT INTO tasks(body, user_id, deadline, status)
VALUES
('new body task new',24, null, 'pending');
SELECT* FROM tasks;

--add new column
ALTER TABLE tasks 
ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

--delete column
ALTER TABLE tasks
DROP COLUMN created_at;

--add new constraint
ALTER TABLE tasks 
ADD CHECK (created_at<= current_timestamp);

--delete constraint
ALTER TABLE tasks
DROP CONSTRAINT tasks_created_at_check;

ALTER TABLE tasks 
ADD CONSTRAINT check_created_at CHECK (created_at<= current_timestamp);
ALTER TABLE tasks
DROP CONSTRAINT check_created_at;



