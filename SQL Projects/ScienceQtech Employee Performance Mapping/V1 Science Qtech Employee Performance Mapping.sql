create database project;
create database employee;



USE employee; -- Assuming you've created the 'employee' database

-- Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table, and make a list of employees and details of their department --
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
FROM emp_record_table;

-- Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
-- less than two
-- greater than four 
-- between two and four

USE employee; 

SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM emp_record_table
WHERE EMP_RATING < 2
   OR (EMP_RATING > 4 AND EMP_RATING BETWEEN 2 AND 4);
   
   SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING,
       CASE
           WHEN EMP_RATING < 2 THEN 'Less than two'
           WHEN EMP_RATING > 4 THEN 'Greater than four'
           WHEN EMP_RATING BETWEEN 2 AND 4 THEN 'Between two and four'
           ELSE 'Other'
       END AS RATING_CATEGORY
FROM emp_record_table;

-- Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table and then give the resultant column alias as NAME --

SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME
FROM emp_record_table
WHERE DEPT = 'Finance';

-- Write a query to list only those employees who have someone reporting to them. Also, show the number of reporters (including the President) --

SELECT E1.EMP_ID, E1.FIRST_NAME, E1.LAST_NAME, E1.MANAGER_ID, COUNT(E2.EMP_ID) AS NUM_REPORTERS
FROM emp_record_table E1
LEFT JOIN emp_record_table E2 ON E1.EMP_ID = E2.MANAGER_ID
GROUP BY E1.EMP_ID, E1.FIRST_NAME, E1.LAST_NAME, E1.MANAGER_ID
HAVING NUM_REPORTERS > 0
ORDER BY E1.EMP_ID;

SELECT E1.EMP_ID, E1.FIRST_NAME, E1.LAST_NAME, E1.DEPT,
       (SELECT COUNT(*) 
        FROM emp_record_table E2 
        WHERE E2.MANAGER_ID = E1.EMP_ID) AS NUM_REPORTERS
FROM emp_record_table E1
WHERE E1.EMP_ID IN ('President', 'CEO') OR E1.EMP_ID IN (
    SELECT DISTINCT MANAGER_ID 
    FROM emp_record_table 
    WHERE MANAGER_ID IS NOT NULL
);

-- Write a query to list down all the employees from the healthcare and finance departments using union. Take data from the employee record table.

SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
FROM emp_record_table
WHERE DEPT = 'healthcare'
UNION
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
FROM emp_record_table
WHERE DEPT = 'finance';

-- Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept.
-- Also include the respective employee rating along with the max emp rating for the department.

SELECT
    e.EMP_ID,
    e.FIRST_NAME,
    e.LAST_NAME,
    e.ROLE,
    e.DEPT,
    e.EMP_RATING,
    MAX(e.EMP_RATING) AS MAX_EMP_RATING
FROM emp_record_table e
GROUP BY e.DEPT, e.EMP_ID, e.FIRST_NAME, e.LAST_NAME, e.ROLE, e.EMP_RATING;

-- Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table --

SELECT
    ROLE,
    MIN(SALARY) AS MIN_SALARY,
    MAX(SALARY) AS MAX_SALARY
FROM emp_record_table
GROUP BY ROLE;

SELECT
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    ROLE,
    DEPT,
    SALARY,
    MIN(SALARY) OVER(PARTITION BY ROLE) AS MIN_SALARY_IN_ROLE,
    MAX(SALARY) OVER(PARTITION BY ROLE) AS MAX_SALARY_IN_ROLE
FROM emp_record_table;

-- Write a query to assign ranks to each employee based on their experience. Take data from the employee record table. use  windows function

SELECT
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    ROLE,
    DEPT,
    EXP,
    RANK() OVER(ORDER BY EXP DESC) AS EXPERIENCE_RANK
FROM emp_record_table;

-- Write a query to create a view that displays employees in various countries whose salary is more than six thousand.
 -- Take data from the employee record table. use window funtions too
 
 CREATE VIEW high_salary_employees AS
SELECT
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    COUNTRY,
    SALARY,
    DENSE_RANK() OVER(PARTITION BY COUNTRY ORDER BY SALARY DESC) AS SALARY_RANK
FROM emp_record_table
WHERE SALARY > 6000;

-- Write a nested query to find employees with experience of more than ten years.
--  Take data from the employee record table. use windows funtions

SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP
FROM (
    SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP,
           RANK() OVER(ORDER BY EXP DESC) AS experience_rank
    FROM emp_record_table
) AS ranked_employees
WHERE experience_rank > 10;

SELECT * FROM (    
SELECT *,       
RANK() OVER(ORDER BY EXP DESC) AS experience_rank
    FROM emp_record_table
) AS ranked_employees
WHERE experience_rank > 10;

-- Write a query to create a stored procedure to retrieve the details of the 
-- employees whose experience is more than three years. Take data from the employee record table.

DELIMITER //
CREATE PROCEDURE GetExperiencedEmployees()
BEGIN
    SELECT *
    FROM emp_record_table
    WHERE EXP > 3;
END //
DELIMITER ;

call GetExperiencedEmployees;

-- Write a query using stored functions in the project table to check whether the job profile 
-- assigned to each employee in the data science team matches the organization’s set standard.
-- The standard being:
-- For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
-- For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
-- For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
-- For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
-- For an employee with the experience of 12 to 16 years assign 'MANAGER'.

DELIMITER //
CREATE FUNCTION DetermineJobProfile(experience INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE jobProfile VARCHAR(50);    
    IF experience <= 2 THEN
        SET jobProfile = 'JUNIOR DATA SCIENTIST';
    ELSEIF experience <= 5 THEN
        SET jobProfile = 'ASSOCIATE DATA SCIENTIST';
    ELSEIF experience <= 10 THEN
        SET jobProfile = 'SENIOR DATA SCIENTIST';
    ELSEIF experience <= 12 THEN
        SET jobProfile = 'LEAD DATA SCIENTIST';
    ELSEIF experience <= 16 THEN
        SET jobProfile = 'MANAGER';
    END IF;
    
    RETURN jobProfile;
END //
DELIMITER ;


SELECT
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    ROLE,
    DEPT,
    EXP,
    DetermineJobProfile(EXP) AS JOB_PROFILE
FROM
    Data_science_team;
    
-- Create an index to improve the cost and performance of the query to 
-- find the employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.

use employee;
SELECT * FROM emp_record_table WHERE FIRST_NAME = 'Eric';

-- Write a query to calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating)--

SELECT *, 0.05 * SALARY * EMP_RATING AS Bonus
FROM emp_record_table;

-- Write a query to calculate the average salary distribution based on the continent and country. Take data from the employee record table.

SELECT CONTINENT, COUNTRY, AVG(SALARY) AS AverageSalary
FROM emp_record_table
GROUP BY CONTINENT, COUNTRY;

