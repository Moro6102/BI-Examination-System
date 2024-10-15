--insert branchs
insert into Branch (branch_id, branch_name, branch_location) 
values 
    (1, 'ITI Alexandria Branch', '12 Al-Mansheya Street, Alexandria'),
    (2, 'ITI Port Said Branch', '7 Abdelkader Street, Port Said'),
    (3, 'ITI Ismailia Branch', '3 El-Horreya Street, Ismailia'),
    (4, 'ITI Cairo Branch', '9 El-Sheikh Ali Street, Downtown, Cairo'),
    (5, 'ITI Beni Suef Branch', '45 Al-Nasr Street, Beni Suef'),
    (6, 'ITI Minia Branch', '10 Al-Hegaz Street, Minia'),
    (7, 'ITI Suhag Branch', '56 Al-Mahrusa Street, Suhag'),
    (8, 'ITI Qena Branch', '33 Al-Nasr Street, Qena'),
    (9, 'ITI Luxor Branch', '14 Karnak Street, Luxor'),
    (10, 'ITI Aswan Branch', '22 Corniche El-Nile, Aswan')

-----------------------------------------------------------------------------

--insert intakes
INSERT INTO Intake (intake_id, intake_name, intake_year) 
VALUES 
    (1, 'Intake Spring 2022', 2022),
    (2, 'Intake Summer 2022', 2022),
    (3, 'Intake Fall 2022', 2022),
    (4, 'Intake Winter 2023', 2023),
    (5, 'Intake Spring 2023', 2023),
    (6, 'Intake Summer 2023', 2023),
    (7, 'Intake Fall 2023', 2023),
    (8, 'Intake Winter 2024', 2024),
    (9, 'Intake Spring 2024', 2024),
    (10, 'Intake Summer 2024', 2024)

---------------------------------------------------------------------------------
--insert departments
INSERT INTO Department (dept_id, dept_name, dept_desc, branch_id, ins_id, HireDate) 
VALUES 
    (1, 'Software Development', 'Handles all software development projects', 1, NULL, NULL),
    (2, 'Quality Assurance', 'Ensures the quality of software through testing', 2, NULL, NULL),
    (3, 'Project Management', 'Manages software projects and client relationships', 3, NULL, NULL),
    (4, 'System Analysis', 'Analyzes and designs software systems', 4, NULL, NULL),
    (5, 'User Experience', 'Focuses on user interface and user experience design', 5, NULL, NULL),
    (6, 'Data Visualization', 'Focuses on data visualization and reporting', 6, NULL, NULL),
    (7, 'DevOps', 'Manages deployment and operations of software systems', 7, NULL, NULL),
    (8, 'Database Administration', 'Manages and maintains database systems', 8, NULL, NULL),
    (9, 'Cybersecurity', 'Ensures the security of software and systems', 9, NULL, NULL),
    (10, 'Business Analysis', 'Analyzes business needs and translates them into technical requirements', 10, NULL, NULL)

-----------------------------------------------------------------------------------

--insert tracks
INSERT INTO Track (track_id, track_name, dept_id, intake_id) 
VALUES 
    (1, 'Frontend Development', 1, 1),
    (2, 'Backend Development', 1, 2),
    (3, 'Manual Testing', 2, 3),
    (4, 'Automated Testing', 2, 4),
    (5, 'Agile Project Management', 3, 5),
    (6, 'Scrum Master', 3, 6),
    (7, 'Business Analysis', 4, 7),
    (8, 'Systems Engineering', 4, 8),
    (9, 'UX Design', 5, 9),
    (10, 'UI Design', 5, 10),
    (11, 'Data Analytics', 6, 1),
    (12, 'Business Intelligence', 6, 2),
    (13, 'Continuous Integration and Deployment', 7, 3),
    (14, 'Cloud Operations', 7, 4),
    (15, 'SQL Database Management', 8, 5),
    (16, 'NoSQL Database Management', 8, 6),
    (17, 'Network Security', 9, 7),
    (18, 'Application Security', 9, 8),
    (19, 'Requirements Engineering', 10, 9),
    (20, 'Data Analysis', 10, 10)

------------------------------------------------------------------------------------

--Bulk insert students
BULK INSERT Student
FROM 'F:\Academy\Power BI ITI (ITP program 4 Months)\21. Final Project\Final Project Docs\Students.csv'
WITH
(
	format = 'csv',
	datafiletype = 'char',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

--select * from Student

-------------------------------------------------------------------------------------

--Bulk insert instructors
BULK INSERT Instructor
FROM 'F:\Academy\Power BI ITI (ITP program 4 Months)\21. Final Project\Final Project Docs\Instructors.csv'
WITH
(
	format = 'csv',
	datafiletype = 'char',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

--select * from Instructor

-----------------------------------------------------------------------------------------

--Bulk insert Stud_enroll_course
BULK INSERT Stud_enroll_course
FROM 'F:\Academy\Power BI ITI (ITP program 4 Months)\21. Final Project\Final Project Docs\Stud_enroll_course.csv'
WITH
(
	format = 'csv',
	datafiletype = 'char',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

--select * from Stud_enroll_course

-----------------------------------------------------------------------------------

--Bulk insert Ins_teach_course
BULK INSERT Ins_teach_course
FROM 'F:\Academy\Power BI ITI (ITP program 4 Months)\21. Final Project\Final Project Docs\Ins_teach_course.csv'
WITH
(
	format = 'csv',
	datafiletype = 'char',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

--select * from Ins_teach_course