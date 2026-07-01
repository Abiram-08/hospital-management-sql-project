#HOSPITAL DATA BASE CREATING 
create database hospital_data;
use hospital_data;
#--------------------------------------------------------------------------------------------------------------------------------
#TABLE CREATING
create table departments(
dept_id int primary	key,
dept_name varchar(80) not null,
floor_no int default 1);

insert into departments (dept_id,dept_name,floor_no)
values(1,"Cardiology",2),(2,"Neurology",3),(3,"Orthopedics",1),(4,"Pediatrics",4),(5,"General Medicine",1);
select * from departments;
#----------------------------------------------------------------------------------------------------------------------------------
create table doctors(
doctor_id int primary key,
doctor_name varchar(100) not null,
dept_id int,
experience int check(experience >=0),
fee decimal(8,2) not null,
foreign key(dept_id)references departments(dept_id)
);

INSERT INTO doctors VALUES (1,'Dr. Arjun
Mehta',1,12,800.00),(2,'Dr. Priya Sharma',2,8,750.00), (3,'Dr. Ramesh
Nair',3,15,600.00),(4,'Dr. Sneha Iyer',4,5,500.00), (5,'Dr. Karthik Raj',5,3,400.00),(6,'Dr.
Divya Kumar',1,10,850.00), (7,'Dr. Manoj Pillai',2,6,700.00);
select * from doctors;
#---------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE patients ( patient_id INT PRIMARY KEY, patient_name VARCHAR(100) NOT NULL, age
INT CHECK (age > 0), gender VARCHAR(10), city VARCHAR(60), blood_group VARCHAR(5) ); 

INSERT INTO patients VALUES (101,'Arun Kumar',45,'Male','Chennai','B+'), (102,'Meena
Devi',32,'Female','Coimbatore','A+'), (103,'Ravi Shankar',60,'Male','Madurai','O+'),
(104,'Lakshmi Bai',28,'Female','Chennai','AB+'), (105,'Suresh G',52,'Male','Salem','B-'),
(106,'Ananya K',19,'Female','Trichy','A-'), (107,'Vijay P',38,'Male','Chennai','O-'),
(108,'Saranya R',47,'Female','Madurai','B+'), (109,'Mohan Das',70,'Male','Coimbatore','A+'),
(110,'Preethi S',25,'Female','Chennai','O+');
select * from patients;
#----------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE appointments ( appt_id INT PRIMARY KEY, patient_id INT, doctor_id INT, appt_date
DATE NOT NULL, status VARCHAR(20) DEFAULT 'Scheduled', diagnosis VARCHAR(150), FOREIGN KEY
(patient_id) REFERENCES patients(patient_id), FOREIGN KEY (doctor_id) REFERENCES
doctors(doctor_id) ); 

INSERT INTO appointments VALUES
(1001,101,1,'2024-01-10','Completed','Hypertension'),
(1002,102,2,'2024-01-12','Completed','Migraine'), 
(1003,103,3,'2024-01-15','Completed','KneePain'), 
(1004,104,4,'2024-01-18','Completed','Fever'),
(1005,105,1,'2024-02-01','Completed','Chest Pain'),
(1006,106,5,'2024-02-05','Completed','Cold & Cough'),
(1007,107,6,'2024-02-10','Completed','Arrhythmia'),
(1008,108,2,'2024-02-14','Cancelled','Headache'),
(1009,109,3,'2024-02-20','Completed','Fracture'),
(1010,110,4,'2024-03-01','Scheduled','Routine Checkup'),
(1011,101,6,'2024-03-05','Completed','Follow-up'),
(1012,103,1,'2024-03-10','Completed','Heart Check'),
(1013,105,7,'2024-03-15','Completed','Neurology Consult'),
(1014,102,5,'2024-03-18','Completed','General Checkup'),
(1015,107,3,'2024-03-22','Cancelled','Back Pain');
select * from appointments;
#---------------------------------------------------------------------------------------------------------------------------
CREATE TABLE billing ( bill_id INT PRIMARY KEY, appt_id INT, amount DECIMAL(10,2) NOT NULL,
paid_status VARCHAR(15) DEFAULT 'Unpaid', bill_date DATE, FOREIGN KEY (appt_id) REFERENCES
appointments(appt_id) ); 

INSERT INTO billing VALUES (2001,1001,800.00,'Paid','2024-01-10'),
(2002,1002,750.00,'Paid','2024-01-12'), (2003,1003,600.00,'Paid','2024-01-15'),
(2004,1004,500.00,'Paid','2024-01-18'), (2005,1005,800.00,'Paid','2024-02-01'),
(2006,1006,400.00,'Unpaid','2024-02-05'), (2007,1007,850.00,'Paid','2024-02-10'),
(2008,1009,600.00,'Paid','2024-02-20'), (2009,1011,850.00,'Paid','2024-03-05'),
(2010,1012,800.00,'Unpaid','2024-03-10'), (2011,1013,700.00,'Paid','2024-03-15'),
(2012,1014,400.00,'Paid','2024-03-18');
#----------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM departments;
SELECT * FROM doctors;
SELECT * FROM patients;
SELECT * FROM appointments;
SELECT * FROM billing;
#-----------------------------------------------------------------------------------------------------------------------------------
# BASIC LEVEL SQL QUERIES:
#1. List all patients with their name, age, and city
SELECT patient_name,age,city from patients order by age desc;

#2.Show all doctors along with their department name and consultation fee
SELECT doctor_name as Doctor_name,dept_name,fee as Consulting_Fee from doctors join 
departments on doctors.dept_id=departments.dept_id;

#3. Find all appointments that were cancelled.
SELECT appt_id,patient_name,doctor_name,appt_date,status
FROM appointments 
join 
patients on appointments.patient_id=patients.patient_id 
join doctors on appointments.doctor_id=doctors.doctor_id 
where status="Cancelled";

#4. List all patients from Chennai only
SELECT * FROM patients WHERE city="Chennai";
#----------------------------------------------------------------------------------------------------------------------------------
#level 2 aggregate functions
#5.Count total appointments per doctor. Show doctors with more than 1 appointment
select doctor_name,count(appt_id) as Total_Appointments from doctors join appointments on appointments.doctor_id=doctors.doctor_id 
group by doctor_name having count(appt_id)>1 order by total_appointments desc;

#6.Find total revenue collected per department (Paid bills only)
SELECT dept.dept_name, SUM(b.amount) AS total_revenue FROM billing b JOIN appointments a 
ON
b.appt_id = a.appt_id
JOIN doctors d 
ON a.doctor_id = d.doctor_id 
JOIN departments dept 
ON
d.dept_id = dept.dept_id 
WHERE b.paid_status = 'Paid' GROUP BY dept.dept_name ORDER BY
total_revenue DESC;

#7. Find the average consultation fee per department
SELECT dept.dept_name, round(avg(fee),2) as Avg_fee from doctors d join departments dept on d.dept_id=dept.dept_id group by dept.dept_name;

#8. Count patients by gender
SELECT gender, count(gender) from patients group by gender;
#------------------------------------------------------------------------------------------------------
# Date & String Function Queries

SELECT * FROM departments;
SELECT * FROM doctors;
SELECT * FROM patients;
SELECT * FROM appointments;
SELECT * FROM billing;

#9. List all appointments in February 2024 with patient and doctor name
select patient_name,doctor_name,appt_date as appointment_date from patients p join appointments a on p.patient_id=
a.patient_id join doctors d on a.doctor_id=d.doctor_id where appt_date between "2024-02-01" and "2024-02-29";

#10.Show each patient's name in UPPERCASE and their city in lowercase.
select upper(patient_name) as Patient_name ,lower(city) as City from patients;

#11.Find patients who are senior citizens (age 60 and above).
select * from patients where age>=60;

use hospital_data;
#Sub-query
#12.Find patients who have never booked an appointment
SELECT patient_name, city FROM patients WHERE patient_id NOT IN ( SELECT DISTINCT patient_id
FROM appointments );

#13.Find doctors whose fee is above the average fee of all doctors
select doctor_name,fee from doctors where fee >(SELECT AVG(fee) from doctors);

#14. Find the patient who had the highest billing amount
select patient_name,amount as highest_billing_amount from billing b join appointments a on b.appt_id=a.appt_id join patients p on
p.patient_id=a.patient_id where amount = (select max(amount) from billing);

#CASE WHEN & NULL Handling
#15.Label each patient's age as 'Child', 'Adult', or 'Senior'
SELECT patient_name, age,
CASE
WHEN age<18 THEN "Child"
WHEN age<60 THEN "Adult"
ELSE "Senior"
END AS Age_Group FROM patients;

#16. Show each bill with a 'Payment Status Label' — Paid as 'Cleared', Unpaid as 'Pending'.
SELECT bill_id,patient_name,amount,
CASE
WHEN paid_status="paid" THEN 'Cleared'
WHEN paid_status="Unpaid" THEN 'Uncleared'
ELSE 'Unkown'
END AS Payment_status_Label
FROM billing b JOIN appointments a ON b.appt_id=a.appt_id JOIN patients p on p.patient_id=a.patient_id;

#17. Rank doctors within each department by their consultation fee (highest first).
SELECT * FROM doctors;
SELECT * FROM departments;
SELECT doctor_name,dept_id,
fee, RANK() OVER(partition by dept_id order by fee desc) as Rank_Value FROM doctors;
#it is my idean. unsing join functions in windowfunctions.
SELECT d.doctor_id,d.doctor_name,dept.dept_id,dept.dept_name,d.fee, RANK()OVER(partition by dept_id order by fee desc) as Rank_values 
FROM doctors d join departments dept ON d.dept_id=dept.dept_id;

#18. Show each appointment with a running total of revenue billed (ordered by date).
select * from departments;
select * from billing;
select * from appointments;
select * from doctors;
select * from patients;
#new thinkoing
select a.appt_id,dept.dept_id,dept.dept_name,b.amount 
from appointments a join billing b 
on a.appt_id=b.appt_id join doctors d join departments dept on d.dept_id=dept.dept_id;

#18. Show each appointment with a running total of revenue billed (ordered by date).
select * from billing;
select * from appointments;
#my-answer
SELECT a.appt_id,b.amount,sum(b.amount) over(order by a.appt_date) as Running_total FROM billing b JOIN 
appointments a ON b.appt_id=a.appt_id;
# actual answer.
SELECT a.appt_id, b.amount, b.bill_date, SUM(b.amount) OVER ( ORDER BY
b.bill_date ) AS running_total FROM billing b JOIN appointments a ON b.appt_id = a.appt_id
JOIN patients p ON a.patient_id = p.patient_id;
#Find the top 1 highest paid bill per department using ROW_NUMBER.
select * from billing;
# orderby dept_id total revenuve
SELECT dept.dept_id,dept.dept_name,sum(b.amount) as Total_amount from departments dept join doctors d ON 
dept.dept_id=d.dept_id JOIN appointments a ON d.doctor_id=a.doctor_id JOIN billing b ON a.appt_id=b.appt_id group by dept.dept_id;




