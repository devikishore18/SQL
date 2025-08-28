-- shows version
select version();

show	databases;

-- creating a database named company
create database company;

-- to work with company database we use 'use'
use company;

-- Creating Table Employees
create table employees(emp_id int primary key auto_increment,
emp_name varchar(50) Not null, 
email varchar(50) unique,
hire_date date,
salary decimal(10,2),
dept_id int);

create table departments(dept_id int primary key auto_increment,
dept_name varchar(30) not null,
company_location varchar(30));

insert into employees(emp_id,emp_name,email,hire_date,salary,dept_id)
values(101,'Aadharsh','aadh101@xyz.com','2020-02-15',20000.01,1);

select * from employees;

insert into employees(emp_name,email,hire_date,salary,dept_id)
values ('Aadhira','aadhira@xyz.com','2022-01-15',10000.05,2),
('Aparna','aparna@xyz.com','2021-11-20',12000.03,1),
('Anand','anand@xyz.com','2024-05-29',9000.09,2),
('Balu','Balu@xyz.com','2019-02-4',15000.05,1);

-- Alter table
select * from employees;
alter table employees add column phone varchar(15);
alter table employees modify column salary decimal(12,3);
desc employees;
alter table employees drop column phone;

-- Update table
select * from employees;
update employees set salary = 60000.909 where emp_id= 101;

-- Delete 
delete from employees where emp_id= 102;

-- truncate
truncate table employees;

-- Drop
drop table employees;

select * from employees;
insert into departments(dept_name,company_location)
values('IT','chennai');
select * from departments;

-- Where Condition
select * from employees
where salary>10000;
select * from employees
where salary>17000 and dept_id=1;
select * from employees
where salary>17000 or dept_id=1;

insert into departments(dept_name,company_location)
values('HR','chennai'),
('HR','chennai'),
('FIN','coimbatore'),
('IT', 'coimbatore');

select * from employees
where not salary < 15000;
select * from employees
where dept_id in (1,2,3); 
select * from employees 
where salary between 15000 and 21000;
select * from employees
where email is null;
select * from employees
where email is not null;
select * from employees
order by salary;
select * from employees
order by salary desc;
select * from employees
order by dept_id asc ,salary desc;
select * from employees
limit 3;

-- aggregate
select * from employees;
-- sum
select sum(salary) as total_salary from employees;
-- count(*)
select count(*) as total_employee from employees;
-- count (distinct)
select count(distinct dept_id) as unique_dept from employees;
-- average 
select avg(salary) as avg_salary from employees;
-- min and max
select min(salary) as lowest_salary, max(salary) as highest_salary from employees;
-- groupby
select dept_id , count(*) as employee_count from employees group by dept_id;
-- groupby having
select dept_id , count(*) as employee_count from employees
group by dept_id
having count(*)>2;
select dept_id , count(*) as employee_count from employees
group by dept_id
having count(*)<2;
-- like
select * from employees where emp_name like 'b%';
-- SubQueries(select inside select)
select * from employees
where salary>(select avg(salary) from employees);

-- joins 
select * from employees;
select * from departments;
-- inner join
select e.emp_id, e.emp_name, d.dept_name, d.company_location from employees e inner join 
departments d on e.dept_id=d.dept_id;
-- left join
select e.emp_id, e.emp_name, d.dept_name, d.company_location from employees e left join 
departments d on e.dept_id=d.dept_id;
select * from employees e left join 
departments d on e.dept_id=d.dept_id;
-- right joins
select * from employees e right join 
departments d on e.dept_id=d.dept_id;

select e.emp_id, e.emp_name, d.dept_name, d.company_location from employees e right join 
departments d on e.dept_id=d.dept_id;

-- union
select emp_name as ename from employees union select dept_name  from departments;

-- self join
select e.emp_name, d.dept_id from employees e left join employees d on e.dept_id=d.dept_id;

select * from employe;

alter table employe add LAST_NAME varchar(50);
insert into employe (LAST_NAME) values('wonder');
/*ALTER TABLE table_name
DROP COLUMN column_name;*/

UPDATE employe set last_name= 'smith' where id=1;
UPDATE employe set last_name= 'Cat' where id=2;
UPDATE employe SET last_name = 'Williams' WHERE id = 3;
UPDATE employe SET last_name = 'Brown'    WHERE id = 4;
UPDATE employe SET last_name = 'Jones'    WHERE id = 5;
UPDATE employe SET last_name = 'Garcia'   WHERE id = 6;
UPDATE employe SET last_name = 'John' WHERE id = 7;
UPDATE employe SET last_name = 'Ash'    WHERE id = 8;
UPDATE employe SET last_name = 'Peter'    WHERE id = 9;
UPDATE employe SET last_name = 'Mary'   WHERE id = 10;
DELETE FROM employe
WHERE last_name = 'wonder';
set sql_safe_updates=0;

-- STRING FUNCTIONS
-- CONCAT
SELECT CONCAT(EMP_NAME,' ',LAST_NAME) AS FULL_NAME FROM EMPLOYE;

-- LENGTH
SELECT EMP_NAME,LENGTH(EMP_NAME) FROM EMPLOYE;

-- UPPER/ LOWER
SELECT UPPER(EMP_NAME),LOWER(EMP_NAME) FROM EMPLOYE;

-- SUBSTRING
select substring(EMAIL,1,5) FROM EMPLOYEES;

-- DATE AND TIME
SELECT NOW();
select curdate();
select curtime();

select date_format(HIRE_DATE,'%D-%M-%Y') FROM EMPLOYEES;
SELECT EMP_NAME,HIRE_DATE,datediff(NOW(),HIRE_DATE) AS HOW_MANY_DAYS FROM EMPLOYEES;

-- Extract parts of date
SELECT 
    YEAR(hire_date) AS hire_year,
    MONTH(hire_date) AS hire_month,
    DAY(hire_date) AS hire_day
FROM employees;

SELECT EMP_NAME, HIRE_DATE, FLOOR(datediff(NOW(), HIRE_DATE)/365.25) AS HOW_MANY_YEARS FROM EMPLOYEES;

-- NUMERICAL FUNCTIONS
SELECT SALARY ,ROUND(SALARY,0), CEIL(SALARY/1000), FLOOR(SALARY/1000) FROM EMPLOYEES;
SELECT ABS(-100),POWER(2,3), SQRT(16);
SELECT greatest(10,3,20,5),least(10,3,20,5);

/*FUNCTIONS:
reusable, predefined routine that accepts input paramaeters, perform operations
and return a single value for a table*/

drop function if exists GetAnnualSalarysss;

DELIMITER //
CREATE FUNCTION GetAnnualSalarys(in_emp_id INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE AnnualSalary DECIMAL(12,2);
SELECT Salary * 12
    INTO AnnualSalary
    FROM Employe
    WHERE Employe.ID = in_emp_id
    LIMIT 1;
RETURN AnnualSalary;
END //
DELIMITER ;

select GetAnnualSalarys(2);

DELIMITER //
CREATE FUNCTION GetAnnualCompensations(
    in_emp_id INT,
    in_bonus_percentage DECIMAL(5,2)
)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE AnnualCompensation DECIMAL(12,2);
SELECT (Salary * 12) + (Salary * in_bonus_percentage / 100)
    INTO AnnualCompensation
    FROM Employe
    WHERE Employe.ID = in_emp_id
    LIMIT 1;
    RETURN AnnualCompensation;
end //
delimiter ;
drop function if exists GetAnnualCompensation;

select GetAnnualCompensations(2,20);
select * from employe;


DELIMITER //
CREATE FUNCTION GetEmployeeName(in_emp_id INT)
RETURNS varchar(50)
DETERMINISTIC
BEGIN
    DECLARE name varchar(50);
SELECT emp_name
    INTO name
    FROM Employe
    WHERE Employe.ID = in_emp_id
    LIMIT 1;
RETURN name;
END //
DELIMITER ;
select GetEmployeeName(2);


DELIMITER //
CREATE FUNCTION GetTax(
    in_emp_id INT,
    in_tax_percentage DECIMAL(5,2)
)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE taxamount DECIMAL(12,2);
SELECT (Salary * 12) *  (in_tax_percentage / 100)
    INTO taxamount
    FROM Employe
    WHERE Employe.ID = in_emp_id
    LIMIT 1;
    RETURN taxamount;
end //
delimiter ;
select GetTax(1, 5);

-- Get Net Annual Pay After Tax and Bonus

DELIMITER //
CREATE FUNCTION GetNetAnnualss(
    in_emp_id INT,
    in_tax_percentage DECIMAL(5,2),
    in_bonus_percentage decimal(5,2)
)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE netamount DECIMAL(12,2);
SELECT ((Salary * 12) + (Salary * in_bonus_percentage / 100))-(((Salary * 12)+ (salary * in_bonus_percentage / 100))* in_tax_percentage/100)
    INTO netamount
    FROM Employe
    WHERE Employe.ID = in_emp_id
    LIMIT 1;
    RETURN netamount;
end //
delimiter ;

select GetNetAnnualss(1,10,10);
select * from employe;