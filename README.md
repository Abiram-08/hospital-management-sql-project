**🏥 Hospital Management SQL Analytics Project**

A beginner-friendly SQL project that simulates a Hospital Management System using MySQL. This project demonstrates database design, SQL querying, and business analysis through real-world healthcare scenarios.

**📌 Project Overview**

This project includes:

Database creation using MySQL
5 relational tables with foreign key relationships modeling a real hospital workflow
Sample healthcare data
20 SQL queries for business analysis
Query results with screenshots

**🗂 Database Schema**

TableDescriptionDepartmentsHospital departments (e.g., Cardiology, Neurology)DoctorsDoctor details, linked to a departmentPatientsPatient demographic and contact infoAppointmentsLinks patients to doctors with date/statusBillingPayment records linked to appointments

**Relationships:**
Departments (1) ───< (M) Doctors
Doctors (1) ───< (M) Appointments >─── (M) (1) Patients
Appointments (1) ───< (M) Billing

**🛠 SQL Concepts Used**

DDL (CREATE TABLE)
DML (INSERT)
SELECT, WHERE, ORDER BY
GROUP BY, HAVING
INNER JOIN
Aggregate Functions
CASE Statement
Subqueries
Window Functions (RANK, ROW_NUMBER)


**🔍 Sample Query**
Ranking doctors by number of appointments handled within each department:

sqlSELECT
    d.doctor_name,
    dept.department_name,
    COUNT(a.appointment_id) AS total_appointments,
    RANK() OVER (PARTITION BY dept.department_name ORDER BY COUNT(a.appointment_id) DESC) AS dept_rank
FROM Doctors d
JOIN Departments dept ON d.department_id = dept.department_id
JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_name, dept.department_name;
**
📊 Key Insights**

<!-- Fill in 1-3 findings from your actual query results, e.g.: -->
[Which department had the highest patient volume]
[Which doctor had the most appointments / highest revenue generated]
[Any notable trend, e.g., billing status breakdown, peak appointment days]


**📁 Project Files**

hospital_management_project.sql – Complete SQL script (schema + sample data + queries)
query1_result.png
query_result_2.png
query_result_3.png

**Learning_Outcomes**

Through this project, I practiced:

Relational database design and normalization
Writing SQL queries across DDL, DML, and analytical operations
Data analysis using SQL (aggregates, window functions, subqueries)
Business problem solving through query design
Working with MySQL Workbench

**🚀 How to Run**

Install MySQL (8.0+ recommended for window function support) and open MySQL Workbench.
Create a new database: CREATE DATABASE hospital_management;
Run the hospital_management_project.sql file — it creates all 5 tables and loads sample data.
Execute the queries in the same file (or the queries section) to view the results.

**👨‍💻 Author**
Abiram RT
🔗 LinkedIn: www.linkedin.com/in/abiram-rt-262438222

⭐ If you found this project helpful, feel free to star this repository.
