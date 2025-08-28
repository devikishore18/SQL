-- joins
create database school;
use school;
CREATE TABLE student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    age INT,
    city VARCHAR(50)
);
CREATE TABLE mark (
    mark_id INT PRIMARY KEY,
    student_id INT,
    subject VARCHAR(50),
    score INT,
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);
-- Insert data into student table
INSERT INTO student (student_id, student_name, age, city) VALUES
(1, 'Alice', 20, 'New York'),
(2, 'Bob', 22, 'Los Angeles'),
(3, 'Charlie', 21, 'Chicago'),
(4, 'David', 23, 'Houston'),
(5, 'Eve', 20, 'Phoenix'),
(6, 'Frank', 22, 'Philadelphia'),
(7, 'Grace', 21, 'San Antonio'),
(8, 'Hannah', 23, 'San Diego'),
(9, 'Ian', 20, 'Dallas'),
(10, 'Jane', 22, 'San Jose');
INSERT INTO mark (mark_id, student_id, subject, score) VALUES
(1, 1, 'Math', 85),
(2, 1, 'Science', 90),
(3, 2, 'Math', 78),
(4, 3, 'History', 88),
(5, 4, 'Math', 92),
(6, 5, 'Science', 75),
(7, 6, 'History', 80),
(8, 7, 'Math', 70),
(9, 8, 'Science', 95),
(10, 10, 'History', 85);
select * from student;
select * from mark;

/* 1. Inner Join: Get students with their marks for all subjects.
2. Left Join: Get all students and their marks, include students with no marks.
3. Right Join: Get all marks and student details, including marks with no student (if any).
4. Full Outer Join: Get all students and marks, with matching or non-matching records.
5. Get students who have marks recorded (use Inner Join).
6. Get students who do NOT have any marks recorded (use Left Join and filter NULL).
7. Get total marks for each student (using Inner Join and GROUP BY).
8. Get the highest score of each student (using Inner Join and GROUP BY).
9. Get students with their Math subject score only (use Inner Join and WHERE).
10. Get students along with the number of subjects they have marks for.*/
-- 1. Inner Join: Get students with their marks for all subjects.
select s.student_id, s.student_name ,m.subject, m.score 
from student s inner join mark m 
on s.student_id=m.student_id;

-- 2. Left Join: Get all students and their marks, include students with no marks.
select s.student_id ,s.student_name, m.score 
from student s left join mark m
on m.student_id=s.student_id;

-- 3. Right Join: Get all marks and student details, including marks with no student (if any).
select s.student_id ,s.student_name, s.age, s.city ,m.score 
from student s right join mark m
on s.student_id=m.student_id;

-- 4. Full Outer Join: Get all students and marks, with matching or non-matching records.
-- Use UNION of LEFT and RIGHT JOIN to simulate FULL OUTER JOIN in MySQL
SELECT s.student_id, s.student_name, m.subject, m.score
FROM student s
LEFT JOIN mark m ON s.student_id = m.student_id
UNION
SELECT s.student_id, s.student_name, m.subject, m.score
FROM student s
RIGHT JOIN mark m ON s.student_id = m.student_id;

-- 5. Get students who have marks recorded (use Inner Join).
select s.student_id, s.student_name , m.score 
from student s inner join mark m 
on s.student_id= m.student_id;

-- 6. Get students who do NOT have any marks recorded (use Left Join and filter NULL).
select s.student_name from student s left join 
mark m on s.student_id=m.student_id
where m.student_id is null;

-- 7. Get total marks for each student (using Inner Join and GROUP BY).
select s.student_id, s.student_name, sum(m.score) as total 
from student s 
inner join mark m 
on s.student_id = m.student_id
group by s.student_id , s.student_name;

-- 8. Get the highest score of each student (using Inner Join and GROUP BY).
select s.student_id, s.student_name, max(m.score) as total 
from student s 
inner join mark m 
on s.student_id = m.student_id
group by s.student_id , s.student_name;

-- 9.Get students with their Math subject score only (use Inner Join and WHERE)
select * from mark;
select s.student_id, s.student_name, m.score as maths
from student s 
inner join mark m 
on s.student_id = m.student_id
where m.subject='Math';

-- 10. Get students along with the number of subjects they have marks for.
select s.student_id, s.student_name, count(m.subject) as noofsub
from student s 
inner join mark m 
on s.student_id = m.student_id
group by s.student_id, s.student_name;