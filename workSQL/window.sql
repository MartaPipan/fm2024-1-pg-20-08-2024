--agregat function
SELECT users.id, users.email,count(orders.id)
FROM users
JOIN orders ON users.id = orders."userId"
GROUP BY users.id, users.email;

--window function
SELECT users.id, users.email, orders."createdAt" , count(orders.id) 
OVER (PARTITION BY orders."userId")
FROM users
JOIN orders ON users.id = orders."userId";

CREATE TABLE student_grades(
    name varchar,
    subject varchar,
    grade int
);
INSERT INTO student_grades VALUES
('Jim', 'ingles',18),
('Olga', 'france',15),
('Jack', 'spain',16),
('Jim', 'german',8),
('Ana', 'german',14),
('Luck', 'ingles',11),
('Sara', 'france',7),
('Maria', 'spain',9)

SELECT* FROM student_grades
ORDER BY subject;

INSERT INTO student_grades VALUES
('Jim', 'spain',12),
('Olga', 'mat',15),
('Jim', 'history',19),
('Olga', 'mat',17),
('Jack', 'geology',16),
('Jim', 'mat',8),
('Jack', 'history',16),
('Jim', 'art',8);

SELECT* FROM student_grades
ORDER BY name;


SELECT list of columns,window functions
FROM table/join table/subquery
WHERE filtering clause
ORDER BY list of columns/window 


SELECT name, subject, grade,
sum (grade) over (PARTITION BY name) as summa_grade,
avg (grade) over (PARTITION BY name) as avg_grade,
count (grade) over (PARTITION BY name) as count_grade,
min (grade) over (PARTITION BY name) as min_grade,
max (grade) over (PARTITION BY name) as max_grade
FROM student_grades;

