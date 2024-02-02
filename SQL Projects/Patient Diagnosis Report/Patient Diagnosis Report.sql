-- Patient Diagnosis Report --

drop table patients;

CREATE TABLE patients (
	`date` DATETIME,
    patient_id VARCHAR(6) PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,
    age INT,
    weight FLOAT,
    gender VARCHAR(10),
    location VARCHAR(100),
    phone_number INT,
    disease VARCHAR(100),
    doctor_name VARCHAR(100),
    doctor_id INT
);

INSERT INTO patients VALUES ('2019-06-15 00:00:00','AP2021','Sarath',67,76,'Male','chennai',5462829,'Cardiac','Mohan',21),
	('2019-02-13 00:00:00','AP2022','John',62,80,'Male','banglore',1234731,'Cancer','Suraj',22),
	('2018-01-08 00:00:00','AP2023','Henry',43,65,'Male','Kerala',9028320,'Liver','Mehta',23),
	('2020-02-04 00:00:00','AP2024','Carl',56,72,'Female','Mumbai',9293829,'Asthma','Karthik',24),
	('2017-09-15 00:00:00','AP2025','Shikar',55,71,'Male','Delhi',7821281,'Cardiac','Mohan',21),
	('2018-07-22 00:00:00','AP2026','Piysuh',47,59,'Male','Haryana',8912819,'Cancer','Suraj',22),
	('2017-03-25 00:00:00','AP2027','Stephen',69,55,'Male','Gujarat',8888211,'Liver','Mehta',23),
	('2019-04-22 00:00:00','AP2028','Aaron',75,53,'Male','Banglore',9012192,'Asthma','Karthik',24);
    
    select * from patients;
    
    -- Write a query to display the total number of patients in the table --
    
    select count(*) as totalnumber_patients from patients;
    
-- Write a query to display the patient id, patient name, gender, and disease of the patient whose age is maximum --
    
SELECT patient_id, patient_name, gender, disease
FROM patients
WHERE age = (SELECT MAX(age) FROM patients);

-- Write a query to display patient id and patient name with the current date --

select patient_id, patient_name from patients where date = (curdate());

-- Write a query to display the old patient’s name and new patient's name in uppercase--

SELECT 
    UPPER(MAX(CASE WHEN date = (SELECT MIN(date) FROM patients) THEN patient_name END)) AS old_patients_name,
    UPPER(MAX(CASE WHEN date = (SELECT MAX(date) FROM patients) THEN patient_name END)) AS new_patients_name
FROM patients;

-- Write a query to display the patient’s name along with the length of their name --

select patient_name, length(patient_name) from patients;

-- Write a query to display the patient’s name, and the gender of the patient must be mentioned as M or F --

select patient_name, if( gender = 'Male','M','F') as Gender from patients;

-- Write a query to combine the names of the patient and the doctor in a new column --

SELECT CONCAT(patient_name, ' - ', doctor_name) AS patient_doctor_combined
FROM patients;

-- Write a query to display the patients’ age along with the logarithmic value (base 10) of their age --

SELECT age, LOG10(age) AS log_age
FROM patients;

-- Write a query to extract the year from the given date in a separate column --

SELECT date, YEAR(date) AS year_column
FROM patients;

-- Write a query to return NULL if the patient’s name and doctor’s name are similar else return the patient’s name --

SELECT 
    CASE WHEN patient_name = doctor_name THEN NULL ELSE patient_name END AS result
FROM patients;

-- Write a query to return Yes if the patient’s age is greater than 40 else return No --

select age, if( age>= 40, 'Yes', 'No') from patients;

-- Write a query to display the doctor’s duplicate name from the table --

SELECT doctor_name
FROM patients
GROUP BY doctor_name
HAVING COUNT(*) > 1;


