-- QUESTIONS
/* Employe(id INT,
    name VARCHAR,
    department VARCHAR,
    salary INT,
    manager_id INT,
    join_date DATE
) */

USE COMPANY;

CREATE TABLE EMPLOYE( ID INT UNIQUE, EMP_NAME varchar(50), DEPARTMENT VARCHAR(20), SALARY INT,
MANAGER_ID INT, JOIN_DATE DATE);

/*1. Get the second highest salary.
2. List all employees in each department with the highest salary.
3. Find employees without a manager.
4. Get department-wise average salary.
5. List employees who joined in the last 6 months.
6. Find employees who earn more than their manager.
7. Count the number of employees in each department.
8. Rank employees based on salary within each department.
9. Find the longest-serving employee(s).
10. Find duplicate employee names (if any).*/

INSERT INTO Employe (ID, EMP_name, department, salary, manager_id, join_date) VALUES
(1, 'Alice',     'HR',        60000, NULL,        '2020-01-15'),
(2, 'Bob',       'HR',        55000, 1,           '2021-03-20'),
(3, 'Charlie',   'Finance',   80000, NULL,        '2019-07-10'),
(4, 'David',     'Finance',   75000, 3,           '2022-02-01'),
(5, 'Eve',       'IT',        90000, NULL,        '2018-05-25'),
(6, 'Frank',     'IT',        85000, 5,           '2020-06-30'),
(7, 'Grace',     'Marketing', 70000, NULL,        '2021-08-12'),
(8, 'Heidi',     'Marketing', 72000, 7,           '2022-09-15'),
(9, 'Ivan',      'IT',        91000, 5,           '2023-01-10'),
(10,'Judy',      'Finance',   76000, 3,           '2024-01-01');
SELECT * FROM EMPLOYE;

-- 1. Get the second highest salary.
SELECT MAX(SALARY) FROM EMPLOYE
WHERE SALARY<(SELECT MAX(SALARY) FROM EMPLOYE);
SELECT * FROM Employe
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

-- 2. List all employees in each department with the highest salary.
 SELECT department, name, salary
FROM Employees e
WHERE salary = (
  SELECT MAX(salary)
  FROM Employees
  WHERE department = e.department
);

-- 4. Get department-wise average salary.
select DEPARTMENT ,AVG(SALARY) FROM employe
GROUP BY DEPARTMENT;

-- 3. Find employees without a manager.
SELECT * FROM EMPLOYE
WHERE MANAGER_ID IS NULL;
--
-- 5. List employees who joined in the last 6 months.
SELECT * FROM EMPLOYE
ORDER BY JOIN_DATE DESC;
SELECT * FROM Employe
WHERE join_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

-- 6. Find employees who earn more than their manager.
SELECT * FROM Employe;

-- 7. Count the number of employees in each department
SELECT DEPARTMENT, count(*) as employee_count from employe
group by DEPARTMENT;

-- 8. Rank employees based on salary within each department.
SELECT * FROM EMPLOYE;

-- 9. Find the longest-serving employee(s).
SELECT * FROM Employees
WHERE join_date = (SELECT MIN(join_date) FROM Employees);

-- 10. Find duplicate employee names (if any)
SELECT emp_name, COUNT(*) AS count
FROM Employees
GROUP BY name
HAVING COUNT(*) > 1;
