-- ==============================================
-- 🏥 Clinic Booking System - MySQL DBMS Project
-- Description: Complete schema for clinic booking, appointments & prescriptions
-- ==============================================

-- Drop tables if they already exist (for re-import safety)
DROP TABLE IF EXISTS Prescription_Medications;
DROP TABLE IF EXISTS Prescriptions;
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS Doctor_Specializations;
DROP TABLE IF EXISTS Specializations;
DROP TABLE IF EXISTS Medications;
DROP TABLE IF EXISTS Patients;
DROP TABLE IF EXISTS Doctors;

-- ==============================================
-- 👤 Patients Table
-- Stores patient personal information
-- ==============================================
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    address TEXT
);

-- ==============================================
-- 👨‍⚕️ Doctors Table
-- Stores doctor personal and contact details
-- ==============================================
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- ==============================================
-- 🩺 Specializations Table
-- Lists all possible medical specializations
-- ==============================================
CREATE TABLE Specializations (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- ==============================================
-- 🔁 Doctor-Specializations Table (M:M)
-- Associates doctors with one or more specializations
-- ==============================================
CREATE TABLE Doctor_Specializations (
    doctor_id INT,
    specialization_id INT,
    PRIMARY KEY (doctor_id, specialization_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE,
    FOREIGN KEY (specialization_id) REFERENCES Specializations(specialization_id) ON DELETE CASCADE
);

-- ==============================================
-- 📅 Appointments Table
-- Stores appointment bookings between patients and doctors
-- ==============================================
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason TEXT,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE
);

-- ==============================================
-- 📜 Prescriptions Table
-- Stores prescription notes tied to an appointment
-- ==============================================
CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    notes TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE
);

-- ==============================================
-- 💊 Medications Table
-- Stores master list of medications
-- ==============================================
CREATE TABLE Medications (
    medication_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- ==============================================
-- 💊🔗 Prescription_Medications Table (M:M)
-- Associates prescriptions with one or more medications
-- ==============================================
CREATE TABLE Prescription_Medications (
    prescription_id INT,
    medication_id INT,
    dosage VARCHAR(100),
    frequency VARCHAR(100),
    PRIMARY KEY (prescription_id, medication_id),
    FOREIGN KEY (prescription_id) REFERENCES Prescriptions(prescription_id) ON DELETE CASCADE,
    FOREIGN KEY (medication_id) REFERENCES Medications(medication_id) ON DELETE CASCADE
);

