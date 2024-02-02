-- Payroll Calculation --
use  sql_basics;

CREATE TABLE IF NOT EXISTS employee(
    employee_id INT,
    first_name VARCHAR(7),
    last_name VARCHAR(5),
    job_id VARCHAR(5),
    salary int,
    manager_id INT,
    department_id INT
);

CREATE TABLE IF NOT EXISTS department(
    department_id INT,
    department_name VARCHAR(13),
    location VARCHAR(5),
    manager_id INT,
    elocation_id INT
);

INSERT INTO employee VALUES (101,'ankit','jain','HP124',200000.00,2,24),
	(102,'sarvesh','patel','HP123',150000.00,2,24),
	(103,'krishna','gee','HP125',500000.00,5,44),
	(104,'rana','gee','HP122',250000.00,3,54),
	(105,'soniya','jain','HP121',400000.00,1,22),
	(106,'nithin','kumar','HP120',300000.00,4,34),
	(107,'karan','patel','HP126',300001.00,2,34),
	(108,'shilpa','jain','HP127',300001.00,5,24),
	(109,'mukesh','singh','HP128',300001.00,4,44);

INSERT INTO department VALUES (22,'admistration','uk',1,218),
	(24,'production','india',2,212),
	(34,'development','india',4,212),
	(44,'communication','usa',5,220),
	(54,'maintenance','usa',3,220);
    
select * from employee;
select * from department;

-- Write a query to create a view of the employee and department tables --

CREATE VIEW employee_department_view AS
SELECT 
    employee.employee_id,
    employee.first_name,
    employee.last_name,
    employee.job_id,
    employee.salary,
    employee.manager_id,    
    department.department_name
FROM employee
JOIN department ON employee.department_id = department.department_id;

select * from employee_department_view;

-- Write a query to display first name and last name of the employees from the employee table and an SQL basics view table
-- if the employee’s salary in the SQL basics table is greater than the salary in the employee table --

SELECT emp.first_name, emp.last_name
FROM employee emp
JOIN employee_department_view edv ON emp.employee_id = edv.employee_id
WHERE edv.salary > emp.salary;

-- Write a query to change the delimiter to // --

DELIMITER //
CREATE PROCEDURE my_procedure()
BEGIN
END;
//
DELIMITER ;

-- Write a query to create a stored procedure using an employee table if the salary is greater than or equal to 250000 --

DELIMITER //
CREATE PROCEDURE FilterHighSalaryEmployees()
BEGIN
    SELECT * FROM employee WHERE salary >= 250000;
END;
//
DELIMITER ;


-- Write a query to execute the stored procedure --

CALL FilterHighSalaryEmployees();

-- Write a query to create a stored procedure with one parameter using ORDER BY salary in descending order, and execute the stored procedure --

DELIMITER //
CREATE PROCEDURE GetEmployeesByDepartment(IN department_id_param INT)
BEGIN
    SELECT * FROM employee WHERE department_id = department_id_param ORDER BY salary DESC;
END;
//
DELIMITER ;

CALL GetEmployeesByDepartment(24);



