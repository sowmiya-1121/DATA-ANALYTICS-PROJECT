CREATE DATABASE hospital_db;
USE hospital_db;

-- Patients Table
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    city VARCHAR(50)
);

-- Doctors Table
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    specialization VARCHAR(50)
);

-- Appointments Table
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- Billing Table
CREATE TABLE billing (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    amount DECIMAL(10,2),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);


INSERT INTO patients (name, age, gender, city) VALUES
('Sowmiya', 22, 'F', 'Chennai'),
('Arun', 30, 'M', 'Bangalore'),
('Priya', 27, 'F', 'Hyderabad'),
('Rahul', 35, 'M', 'Mumbai'),
('Maha',45,'M','Chennai'),
('Sathya',28,'F','Dubai'),
('Heppz',37,'F','Tirunelveli'),
('Sayeesha',54,'F','Singapore'),
('Divya', 29, 'F', 'Delhi');

INSERT INTO doctors (name, specialization) VALUES
('Dr. Ravi', 'Cardiologist'),
('Dr. Anita', 'Dermatologist'),
('Dr. Hepzz','Gnaecologist'),
('Dr. Kumar', 'Orthopedic');

INSERT INTO appointments (patient_id, doctor_id, appointment_date) VALUES
(1, 1, '2025-07-20'),
(2, 2, '2025-07-21'),
(3, 1, '2025-07-22'),
(4, 3, '2025-07-23'),
(5, 2, '2025-07-24'),
(6, 4, '2025-09-08');

INSERT INTO billing (patient_id, amount) VALUES
(1, 500),
(2, 700),
(3, 500),
(4, 900),
(5, 600),
(5, 800);

select*from patients;
select*from doctors;
select*from appointments;
select*from billing;

SELECT p.name AS patient, d.name AS doctor, a.appointment_date
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id;

SELECT patient_id, COUNT(*) AS total_visits
FROM appointments
GROUP BY patient_id;

SELECT SUM(amount) AS total_revenue FROM billing;

SELECT doctor_id, COUNT(*) AS total_appointments
FROM appointments
GROUP BY doctor_id
ORDER BY total_appointments DESC;

DELIMITER //

CREATE TRIGGER after_appointment_insert
AFTER INSERT ON appointments
FOR EACH ROW
BEGIN
   INSERT INTO billing (patient_id, amount)
   VALUES (NEW.patient_id, 500);
END //

DELIMITER ;

INSERT INTO appointments (patient_id, doctor_id, appointment_date)
VALUES (1, 1, '2025-08-01');

