use company;
/*1. Write an SQL statement to create a table named Departments with the following columns:
dept_id (Primary Key, INT)
department_name (VARCHAR(50))
2. Alter the Employees table to add a new column email of type VARCHAR(100).
3.Insert three employee records into the Employees table with emp_id, first_name, last_name, salary, and department_id.
4.Write an SQL statement to update the salary of all employees in department 101 by 15%.
5.Delete all employees whose salary is less than 40,000
6. Write a query to display the total salary of all employees using the SUM() function.
7.Write a query to display the highest and lowest salary in the Employees table using MAX() and MIN().
8.Write a query to display employee names in uppercase using the UPPER() function.
9.. Write a query using an INNER JOIN to display employees along with their department names.
10. Write a query using a LEFT JOIN to display all employees, even if they do not belong to any department.
*/

CREATE TABLE department(dept_id INT NOT NULL PRIMARY KEY,department_name VARCHAR(50));

-- 2. Alter the Employees table to add a new column email of type VARCHAR(100).
alter table employe add email varchar(100);

-- 3.Insert three employee records into the Employees table with emp_id, first_name, last_name, salary, and department_id.
select * from employees;
insert into employees(EMP_ID,EMP_NAME,EMAIL,HIRE_DATE,SALARY,DEPT_ID)
values (106,'Clara','clara@xyz.com','2020-04-12',13000.65,3),
(107,'Dev','dev@xyz.com','2020-07-12',11000.65,3),
(108,'Peter','peter@xyz.com','2023-04-12',19000.65,1);

-- 4.Write an SQL statement to update the salary of all employees in department 101 by 15%.
update Employees set salary = salary * 1.15 where dept_id = 1;

  -- 5.Delete all employees whose salary is less than 40,000.
delete from Employees where salary < 10000;

-- 6. Write a query to display the total salary of all employees using the SUM() function.
select sum(salary) as total_salary from Employees;

-- 7.Write a query to display the highest and lowest salary in the Employees table using MAX() and MIN().
select max(salary) as highest_salary, 
min(salary) as lowest_salary 
from Employees;

-- 8.Write a query to display employee names in uppercase using the UPPER() function.
select upper(emp_name) as emp_name_upper from Employees;

-- 9. Write a query using an INNER JOIN to display employees along with their department names.
select e.emp_id, e.emp_name, e.salary, d.dept_name from Employees e 
inner join Departments d on e.dept_id = d.dept_id;

-- 10. Write a query using a LEFT JOIN to display all employees, even if they do not belong to any department.
select e.emp_id, e.emp_name, e.salary, d.dept_name
from Employees e 
left join Departments d 
on e.dept_id = d.dept_id;

-- 11. Write a query to find the total number of employees in the Employees table using an aggregate function.
select  count(*) as total_employees from Employees;

-- 12. Write a query to display the average salary of employees in each department using AVG().
select dept_id, avg(salary) as average_salary 
from Employees 
group by dept_id;

-- 13. Write a query to display employee names where the last 3 characters of their first name are shown using the SUBSTRING() (or RIGHT()) function.
 select emp_name, right(emp_name, 3) as last_char
 from employees;
 
 -- 14. Write a query to display the current date and time using a date/time function.
select now() as datetime;
select curdate();
select curtime();

-- 15. Write a query to display the length of each employee’s first name using the LENGTH() function.
select emp_name, length(emp_name) as length from Employees;











