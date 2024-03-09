CREATE TABLE `Patients` (
  `PatientID` integer PRIMARY KEY AUTO_INCREMENT,
  `FirstName` varchar(255) NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `DOB` date NOT NULL,
  `Gender` enum(Male,Female,Other) NOT NULL,
  `Address` varchar(255),
  `Phone` char(9) NOT NULL
);

CREATE TABLE `Doctors` (
  `DoctorID` integer PRIMARY KEY AUTO_INCREMENT,
  `FirstName` varchar(255) NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `Specialization` varchar(255) NOT NULL,
  `Phone` char(9) NOT NULL,
  `DepartmentID` integer NOT NULL
);

CREATE TABLE `Departments` (
  `DepartmentID` integer PRIMARY KEY AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Location` varchar(255) NOT NULL
);

CREATE TABLE `Appointments` (
  `AppointmentID` integer PRIMARY KEY AUTO_INCREMENT,
  `PatientID` integer NOT NULL,
  `DoctorID` integer NOT NULL,
  `AppDate` date NOT NULL DEFAULT (now()),
  `Time` time NOT NULL DEFAULT (now()),
  `purpose` varchar(255) NOT NULL
);

CREATE TABLE `MedicalRecords` (
  `RecordID` integer PRIMARY KEY AUTO_INCREMENT,
  `PatientID` integer NOT NULL,
  `Date` date NOT NULL,
  `Diagnosis` varchar(255) NOT NULL,
  `Treatment` varchar(255),
  `DoctorID` integer NOT NULL
);

CREATE TABLE `Bills` (
  `BillID` integer PRIMARY KEY AUTO_INCREMENT,
  `PatientID` integer NOT NULL,
  `DateIssued` date NOT NULL,
  `TotalAmount` money NOT NULL,
  `Status` enum(Paid,Unpaid,Pending) NOT NULL
);

CREATE TABLE `Nurses` (
  `NurseID` integer PRIMARY KEY AUTO_INCREMENT,
  `FirstName` varchar(255) NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `AssignedDepID` integer NOT NULL
);

CREATE TABLE `Rooms` (
  `RoomID` integer PRIMARY KEY AUTO_INCREMENT,
  `DepartmentID` integer NOT NULL,
  `RoomType` enum(Single,Shared,ICU) NOT NULL,
  `Status` enum(Occupied,Available,Maintenance) NOT NULL
);

CREATE TABLE `Equipment` (
  `EquipmentID` integer PRIMARY KEY AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `DepartmentID` integer NOT NULL,
  `Status` enum(In Use,Available,Under Maintenance) NOT NULL
);

ALTER TABLE `Doctors` ADD FOREIGN KEY (`DepartmentID`) REFERENCES `Departments` (`DepartmentID`);

ALTER TABLE `Appointments` ADD FOREIGN KEY (`PatientID`) REFERENCES `Patients` (`PatientID`);

ALTER TABLE `Appointments` ADD FOREIGN KEY (`DoctorID`) REFERENCES `Doctors` (`DoctorID`);

ALTER TABLE `MedicalRecords` ADD FOREIGN KEY (`PatientID`) REFERENCES `Patients` (`PatientID`);

ALTER TABLE `MedicalRecords` ADD FOREIGN KEY (`DoctorID`) REFERENCES `Doctors` (`DoctorID`);

ALTER TABLE `Bills` ADD FOREIGN KEY (`PatientID`) REFERENCES `Patients` (`PatientID`);

ALTER TABLE `Nurses` ADD FOREIGN KEY (`AssignedDepID`) REFERENCES `Departments` (`DepartmentID`);

ALTER TABLE `Rooms` ADD FOREIGN KEY (`DepartmentID`) REFERENCES `Departments` (`DepartmentID`);

ALTER TABLE `Equipment` ADD FOREIGN KEY (`DepartmentID`) REFERENCES `Departments` (`DepartmentID`);
