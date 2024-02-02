-- Employee Data Analysis --

CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    job_id varchar(10),
    salary int,
    manager_id INT,
    department_id INT
);

INSERT INTO employee VALUES (101,'ankit','jain','HP124',200000,2,24),
	(102,'sarvesh','patel','HP123',150000,2,24),
	(103,'krishna','gee','HP125',500000,5,44),
	(104,'rana','gee','HP122',250000,3,54),
	(105,'soniya','jain','HP121',400000,1,22),
	(106,'nithin','kumar','HP120',300000,4,34),
	(107,'karan','patel','HP126',300001,2,34),
	(108,'shilpa','jain','HP127',300001,5,24),
	(109,'mukesh','singh','HP128',300001,4,44);
    
    select * from employee;
    
-- Write a query to find the first name and salary of the employee whose salary is higher than the employee with the last name Kumar from the employee table --
    
    SELECT first_name, salary
FROM employee
WHERE salary > (SELECT salary FROM employee WHERE last_name = 'Kumar');

-- Write a query to display the employee id and last name of the employee whose salary is greater than the average salary from the employee table --

select employee_id,last_name from employee where salary > 
( select avg(salary) from employee);

-- Write a query to display the employee id, first name, and salary of the employees who earn a salary that is higher than the salary of all the shipping clerks (JOB_ID = HP122). Sort the results of the salary in ascending order --

SELECT employee_id, first_name, salary
FROM employee
WHERE salary > (SELECT MAX(salary) FROM employee WHERE job_id = 'HP122')
ORDER BY salary ASC;

-- Write a query to display the first name, employee id, and salary of the first three employees with highest salaries --

SELECT first_name, employee_id, salary
FROM employee
ORDER BY salary DESC
LIMIT 3;


