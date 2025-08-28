-- A trigger is a special procedure that automatically runs when certain events happen on a table or view.
create database department;
use department;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
)
    
INSERT INTO Employees(EmployeeID, Name, Salary) VALUES (1, 'John', 50000);
INSERT INTO Employees(EmployeeID, Name, Salary) VALUES (2, 'Alice', 60000);
INSERT INTO Employees(EmployeeID, Name, Salary) VALUES (3, 'Bob', -2000);  -- BEFORE INSERT wiltrg_before_insert_employeel set salary to 0

delimiter //
CREATE TRIGGER trg_before_insert_employees
BEFORE INSERT ON Employees
FOR EACH ROW
BEGIN
    -- Convert employee name to uppercase
    SET NEW.Name = UPPER(NEW.Name);
-- Correct negative salary
    IF NEW.Salary < 0 THEN
        SET NEW.Salary = 0;
    END IF;
end //
delimiter ;

INSERT INTO Employees(EmployeeID, Name, Salary) VALUES (4, 'abi', 80000);

DELIMITER $$
CREATE TRIGGER trg_before_update_employees
BEFORE UPDATE ON Employees
FOR EACH ROW
BEGIN
    -- Prevent negative salary
    IF NEW.Salary < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be negative!';
    END IF;
END$$
DELIMITER ;
INSERT INTO Employees(EmployeeID, Name, Salary) VALUES (5, 'geetha', -80000);

select * from Employees;


UPDATE Employees 
SET Salary = -5000 
WHERE EmployeeID = 5;

UPDATE Employees 
SET Name = 'JOHN', Salary = 70000 
WHERE EmployeeID = 4;

DELIMITER $$
CREATE TRIGGER trg_before_delete_employees
BEFORE DELETE ON Employees
FOR EACH ROW
BEGIN
IF OLD.Salary > 10000
 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete high-salary employee!';
    END IF;
END$$
DELIMITER ;

delete from employees where EmployeeID=4;

DELIMITER $$
CREATE TRIGGER trg_after_delete_employees
AFTER DELETE ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO Employee_Audit(EmployeeID, Action, ActionTime)
    VALUES (OLD.EmployeeID, 'AFTER DELETE', NOW());
END$$
DELIMITER ;

delete from employees where EmployeeID=3;

select * from employee_audit;

DELIMITER $$
CREATE TRIGGER trg_after_insert_employee
AFTER INSERT ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO Employee_Audit(EmployeeID, Action, ActionTime)
    VALUES (NEW.EmployeeID, 'AFTER INSERT', NOW());
END$$
DELIMITER ;

INSERT INTO Employees(EmployeeID, Name, Salary) VALUES (6, 'Renu', 50000);


select * from Employees;

select * from employee_audit;

DELIMITER $$
CREATE TRIGGER trg_after_update_employees
AFTER UPDATE ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO Employee_Audit(EmployeeID, Action, ActionTime)
    VALUES (NEW.EmployeeID, 'AFTER UPDATE', NOW());
END$$
DELIMITER ;


UPDATE Employees 
SET Name = 'JOHN', Salary = 90000 
WHERE EmployeeID = 4;
