DROP TABLE StudentInterviewJobwCompanyContact;
DROP TABLE StudentGetsJob;
DROP TABLE AppContainsCoverLetter;
DROP TABLE JobApplication;
DROP TABLE JobContract;
DROP TABLE CompanyContact;
DROP TABLE Job;
DROP TABLE Employer;
DROP TABLE Resumé;
DROP TABLE CoverLetter;
DROP TABLE StudentDocument;
DROP TABLE Student;
DROP TABLE CoopAdvisor;

CREATE TABLE CoopAdvisor (
    CoopAdvisorAdvisorID INTEGER,
    CoopAdvisorFirstName CHAR(40),
    CoopAdvisorLastName CHAR(40),
    CoopAdvisorEmailAddress CHAR(40),
    CoopAdvisorPhoneNumber CHAR(30),
    PRIMARY KEY (CoopAdvisorAdvisorID)
);

CREATE TABLE Student (
    StudentID INTEGER,
    AdvisorID INTEGER NOT NULL,
    FirstName CHAR(40),
    LastName CHAR(40),
    Age INTEGER,
    Email CHAR(40),
    PhoneNumber CHAR(20),
    CurrentYear INTEGER,
    NumberofCompletedTerms INTEGER,
    JobPreferences CHAR(100),
    PRIMARY KEY (StudentID),
    FOREIGN KEY (AdvisorID) REFERENCES CoopAdvisor ON DELETE CASCADE
);

CREATE TABLE StudentDocument (
    DocumentID INTEGER,
    DocumentName CHAR(30),
    UploadDate DATE,
    UploadTime TIMESTAMP,
    StudentID INTEGER NOT NULL,
    PRIMARY KEY(DocumentID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID) ON DELETE CASCADE
);

CREATE TABLE Resumé (
    DocumentID INTEGER,
    PRIMARY KEY(DocumentID),
    FOREIGN KEY (DocumentID) REFERENCES StudentDocument ON DELETE CASCADE
);

CREATE TABLE CoverLetter (
    DocumentID INTEGER,
    PRIMARY KEY (DocumentID),
    FOREIGN KEY (DocumentID) REFERENCES StudentDocument (DocumentID) ON DELETE CASCADE
);

CREATE TABLE Employer (
    EmployerID INTEGER,
    EmployerName CHAR(50),
    Website Char(50),
    HeadQuarterLocation Char(20),
    PRIMARY KEY (EmployerID)
);

CREATE TABLE JobContract (
    DocumentID INTEGER,
    StudentID INTEGER,
    DatePosted DATE,
    TimePosted TIMESTAMP,
    SalaryOffered INTEGER,
    PositionOffered CHAR(20),
    EmployerID INTEGER NOT NULL, 
    PRIMARY KEY (DocumentID),
    FOREIGN KEY (EmployerID) REFERENCES Employer (EmployerID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID) ON DELETE CASCADE
);

CREATE TABLE Job (
    JobID INTEGER,
    EmployerID INTEGER NOT NULL,
    StartDate DATE,
    Title CHAR(50),
    JobDescription CHAR(400),
    PositionLength CHAR(50),
    DesiredProgram CHAR(50),
    Salary CHAR(50),
    PRIMARY KEY (JobID),
    FOREIGN KEY (EmployerID) REFERENCES Employer(EmployerID)
);

CREATE TABLE JobApplication (
    ApplicationID INTEGER,
    ApplicationName CHAR(20),
    StudentID INTEGER NOT NULL,
    ResumeDocumentID INTEGER NOT NULL,
    JobID INTEGER NOT NULL,
    ApplicationDate DATE,
    JobApplicationStatus CHAR(20) DEFAULT 'Pending',
    PRIMARY KEY (ApplicationID),
    FOREIGN KEY (StudentID) REFERENCES Student (StudentID) ON DELETE CASCADE,
    FOREIGN KEY (ResumeDocumentID) REFERENCES Resumé (DocumentID)  ON DELETE CASCADE, 
    FOREIGN KEY (JobID) REFERENCES Job (JobID)
);

CREATE TABLE CompanyContact (
    FirstName CHAR(40),
    LastName CHAR(40),
    PhoneNumber CHAR(40),
    EmailAddress CHAR(40),
    EmployerID INTEGER,
    PRIMARY KEY (FirstName, EmployerID),
    FOREIGN KEY (EmployerID) REFERENCES Employer (EmployerID) ON DELETE CASCADE
);

CREATE TABLE AppContainsCoverLetter (
    ApplicationID INTEGER,
    DocumentID INTEGER,
    PRIMARY KEY (ApplicationID, DocumentID),
    FOREIGN KEY (ApplicationID) REFERENCES JobApplication (ApplicationID) ON DELETE CASCADE,
    FOREIGN KEY (DocumentID) REFERENCES CoverLetter (DocumentID) ON DELETE CASCADE
);

CREATE TABLE StudentGetsJob (
    StudentID INTEGER,
    JobID INTEGER,
    AcceptanceDate DATE,
    AcceptanceTime TIMESTAMP, 
    PRIMARY KEY (StudentID, JobID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID) ON DELETE CASCADE,
    FOREIGN KEY (JobID) REFERENCES Job(JobID)
);

CREATE TABLE StudentInterviewJobwCompanyContact (
    StudentID INTEGER,
    JobID INTEGER,
    CompanyContactFirstName CHAR(40),
    CompanyContactLastName CHAR(40),
    EmployerID INTEGER,
    InterviewTime TIMESTAMP,
    InterviewDate DATE,
    InterviewLocation CHAR(50),
    PRIMARY KEY (StudentID, JobID, CompanyContactFirstName, CompanyContactLastName, EmployerID),
    FOREIGN KEY (JobID) REFERENCES Job (JobID),
    FOREIGN KEY (StudentID) REFERENCES Student (StudentID) ON DELETE CASCADE,
    FOREIGN KEY (CompanyContactFirstName, EmployerID) REFERENCES CompanyContact (FirstName, EmployerID)
);

INSERT INTO CoopAdvisor VALUES (1, 'Chris', 'McKinnon', 'chris.mckinnon@gmail.com', '604-111-1111');
INSERT INTO CoopAdvisor VALUES (2, 'Emily', 'Anderson', 'emily.anderson@yahoo.com', '778-222-3333');
INSERT INTO CoopAdvisor VALUES (3, 'Michael', 'Smith', 'michael.smith@hotmail.com', '236-555-6666');
INSERT INTO CoopAdvisor VALUES (4, 'Sophia', 'Johnson', 'sophia.johnson@gmail.com', '604-888-9999');
INSERT INTO CoopAdvisor VALUES (5, 'Daniel', 'Lee', 'daniel.lee@yahoo.com', '778-111-2222');

INSERT INTO Student VALUES (1, 1, 'Nicholas', 'Fong', 20, 'nicholas.fong@gmail.com', '604-222-4444', 3, 5, 'Software Engineering');
INSERT INTO Student VALUES (2, 2, 'Cole', 'Rowell', 20, 'cole.rowell@gmail.com', '236-777-6666', 2, 3, 'Data Science');
INSERT INTO Student VALUES (3, 3, 'Anikait', 'Kapur', 20, 'anikait.kapur@hotmail.com', '778-101-9999', 4, 1, 'Product Management');
INSERT INTO Student VALUES (4, 4, 'John', 'Doe', 22, 'john.doe@gmail.com', '236-202-1111', 1, 1, 'Business Analysis');
INSERT INTO Student VALUES (5, 2, 'Jane', 'Smith', 19, 'jane.smith@gmail.com', '778-212-2222', 2, 3, 'Web Development');
INSERT INTO Student VALUES (6, 1, 'Nate', 'Diaz', 38, 'nate.diaz@yahoo.com', '604-333-3333', 4, 0, 'Chemical Engineering');
INSERT INTO Student VALUES (7, 2, 'Nick', 'Diaz', 40, 'nick.diaz@gmail.com', '604-333-6666', 2, 1, 'Mechanical Engineering');
INSERT INTO Student VALUES (8, 2, 'Jake', 'Paul', 26, 'jake.paul@gmail.com', '604-111-1111', 3, 3, 'Machine Learning');
INSERT INTO Student VALUES (9, 3, 'Robert', 'Johnson', 20, 'robert.johnson@yahoo.com', '778-987-6543', 2, 4, 'Finance');
INSERT INTO Student VALUES (10, 4, 'Sarah', 'Williams', 21, 'sarah.williams@gmail.com', '778-888-8888', 1, 2, 'Marketing');
INSERT INTO Student VALUES (11, 1, 'Michael', 'Brown', 22, 'michael.brown@gmail.com', '236-555-5555', 2, 3, 'Accounting');
INSERT INTO Student VALUES (12, 3, 'Sophia', 'Taylor', 27, 'sophia.taylor@yahoo.com', '604-666-2222', 4, 2, 'Electrical Engineering');
INSERT INTO Student VALUES (13, 4, 'James', 'Wilson', 22, 'james.wilson@gmail.com', '236-777-4444', 2, 1, 'Renewable Energy');
INSERT INTO Student VALUES (14, 2, 'Olivia', 'Martin', 18, 'olivia.martin@hotmail.com', '778-222-1111', 3, 4, 'Human Resources');
INSERT INTO Student VALUES (15, 2, 'Ethan', 'Chen', 19, 'ethan.chen@gmail.com', '236-666-7777', 4, 2, 'Web Development');
INSERT INTO Student VALUES (16, 3, 'Liam', 'Lee', 25, 'liam.lee@yahoo.com', '778-123-4567', 3, 0, 'Machine Learning');
INSERT INTO Student VALUES (17, 2, 'Emma', 'Dean', 16, 'emma.dean@gmail.com', '604-623-6478', 2, 1, 'Sales');
INSERT INTO Student VALUES (18, 1, 'Norah', 'Wong', 22, 'norah.wong@yahoo.com', '604-518-5235', 1, 2, 'Accounting');
INSERT INTO Student VALUES (19, 4, 'Ethan', 'Thompson', 23, 'ethan.thompson@hotmail.com', '778-314-5912', 2, 0, 'Data Science');
INSERT INTO Student VALUES (20, 3, 'Bruce', 'Klein', 20, 'bruce.klein@email.com', '604-475-9091', 3, 1, 'UX/UI Design');

INSERT INTO StudentDocument VALUES (1, 'Resume_Nicholas_Fong', TO_DATE('2023-07-27', 'YYYY-MM-DD'), TO_TIMESTAMP('09:30:00', 'HH24:MI:SS'), 1);
INSERT INTO StudentDocument VALUES (2, 'Resume_Cole_Rowell', TO_DATE('2023-02-10', 'YYYY-MM-DD'), TO_TIMESTAMP('10:15:00', 'HH24:MI:SS'), 2);
INSERT INTO StudentDocument VALUES (3, 'Resume_Anikait_Kapur', TO_DATE('2023-05-12', 'YYYY-MM-DD'), TO_TIMESTAMP('18:00:00', 'HH24:MI:SS'), 3);
INSERT INTO StudentDocument VALUES (4, 'Resume_John_Doe', TO_DATE('2022-12-03', 'YYYY-MM-DD'), TO_TIMESTAMP('23:00:00', 'HH24:MI:SS'), 4);
INSERT INTO StudentDocument VALUES (5, 'Resume_Jane_Smith', TO_DATE('2023-08-07', 'YYYY-MM-DD'), TO_TIMESTAMP('01:00:00', 'HH24:MI:SS'), 5);
INSERT INTO StudentDocument VALUES (6, 'CoverLetter_Nicholas_Fong', TO_DATE('2023-03-10', 'YYYY-MM-DD'), TO_TIMESTAMP('09:45:00', 'HH24:MI:SS'), 1);
INSERT INTO StudentDocument VALUES (7, 'CoverLetter_Cole_Rowell', TO_DATE('2023-05-16', 'YYYY-MM-DD'), TO_TIMESTAMP('10:30:00', 'HH24:MI:SS'), 2);
INSERT INTO StudentDocument VALUES (8, 'CoverLetter_Anikait_Kapur', TO_DATE('2023-06-22', 'YYYY-MM-DD'), TO_TIMESTAMP('17:00:00', 'HH24:MI:SS'), 3);
INSERT INTO StudentDocument VALUES (9, 'CoverLetter_John_Doe', TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_TIMESTAMP('03:15:00', 'HH24:MI:SS'), 4);
INSERT INTO StudentDocument VALUES (10, 'CoverLetter_Jane_Smith', TO_DATE('2023-02-02', 'YYYY-MM-DD'), TO_TIMESTAMP('12:30:00', 'HH24:MI:SS'), 5);
INSERT INTO StudentDocument VALUES (11, 'CoverLetter_Nicholas_Fong2', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_TIMESTAMP('09:45:00', 'HH24:MI:SS'), 1);
INSERT INTO StudentDocument VALUES (12, 'CoverLetter_Nate_Diaz', TO_DATE('2023-03-25', 'YYYY-MM-DD'), TO_TIMESTAMP('10:30:00', 'HH24:MI:SS'), 6);
INSERT INTO StudentDocument VALUES (13, 'Resume_Jake_Paul', TO_DATE('2022-05-01', 'YYYY-MM-DD'), TO_TIMESTAMP('17:00:00', 'HH24:MI:SS'), 8);
INSERT INTO StudentDocument VALUES (14, 'Resume_Robert_Johnson', TO_DATE('2022-09-12', 'YYYY-MM-DD'), TO_TIMESTAMP('15:15:00', 'HH24:MI:SS'), 9);
INSERT INTO StudentDocument VALUES (15, 'CoverLetter_Anikait_Kapur2', TO_DATE('2022-08-24', 'YYYY-MM-DD'), TO_TIMESTAMP('06:30:00', 'HH24:MI:SS'), 3);

INSERT INTO Resumé VALUES (1);
INSERT INTO Resumé VALUES (2);
INSERT INTO Resumé VALUES (3);
INSERT INTO Resumé VALUES (4);
INSERT INTO Resumé VALUES (5);
INSERT INTO Resumé VALUES (13);
INSERT INTO Resumé VALUES (14);

INSERT INTO CoverLetter VALUES (6);
INSERT INTO CoverLetter VALUES (7);
INSERT INTO CoverLetter VALUES (8);
INSERT INTO CoverLetter VALUES (9);
INSERT INTO CoverLetter VALUES (10);
INSERT INTO CoverLetter VALUES (11);
INSERT INTO CoverLetter VALUES (12);
INSERT INTO CoverLetter VALUES (15);

INSERT INTO Employer VALUES (1, 'ABC Tech', 'www.abctech.com', 'New York');
INSERT INTO Employer VALUES (2, 'XYZ Solutions', 'www.xyzsolutions.com', 'San Francisco');
INSERT INTO Employer VALUES (3, '123 Industries', 'www.123industries.com', 'Seattle');
INSERT INTO Employer VALUES (4, 'TechNinja', 'www.techninja.com', 'Chicago');
INSERT INTO Employer VALUES (5, 'BigData Corp', 'www.bigdatacorp.com', 'Austin');

INSERT INTO JobContract VALUES (1, 1, TO_DATE('2023-07-27', 'YYYY-MM-DD'), TO_TIMESTAMP('09:30:00', 'HH24:MI:SS'), 60000, 'Software Developer', 1);
INSERT INTO JobContract VALUES (2, 2, TO_DATE('2023-02-10', 'YYYY-MM-DD'), TO_TIMESTAMP('10:15:00', 'HH24:MI:SS'), 80000, 'Data Analyst', 2);
INSERT INTO JobContract VALUES (3, 3, TO_DATE('2023-05-12', 'YYYY-MM-DD'), TO_TIMESTAMP('18:00:00', 'HH24:MI:SS'), 75000, 'Product Manager', 3);
INSERT INTO JobContract VALUES (4, 4, TO_DATE('2022-12-03', 'YYYY-MM-DD'), TO_TIMESTAMP('23:00:00', 'HH24:MI:SS'), 50000, 'Business Analyst', 4);
INSERT INTO JobContract VALUES (5, 5, TO_DATE('2023-08-07', 'YYYY-MM-DD'), TO_TIMESTAMP('01:00:00', 'HH24:MI:SS'), 90000, 'Web Developer', 5);


INSERT INTO Job (JobID, EmployerID, StartDate, Title, JobDescription, PositionLength, DesiredProgram, Salary)
VALUES (1, 1, DATE '2023-08-15', 'Software Developer', 'Developing web applications', '6 months', 'Computer Science', '$60,000');

INSERT INTO Job (JobID, EmployerID, StartDate, Title, JobDescription, PositionLength, DesiredProgram, Salary)
VALUES (2, 2, DATE '2023-09-01', 'Data Analyst', 'Analyzing data trends', '4 months', 'Data Science', '$55,000');

INSERT INTO Job (JobID, EmployerID, StartDate, Title, JobDescription, PositionLength, DesiredProgram, Salary)
VALUES (3, 3, DATE '2023-08-20', 'Product Manager', 'Managing product development', '8 months', 'Business Administration', '$70,000');

INSERT INTO Job (JobID, EmployerID, StartDate, Title, JobDescription, PositionLength, DesiredProgram, Salary)
VALUES (4, 4, DATE '2023-08-10', 'Business Analyst', 'Analyzing business processes', '6 months', 'Business Analysis', '$50,000');

INSERT INTO Job (JobID, EmployerID, StartDate, Title, JobDescription, PositionLength, DesiredProgram, Salary)
VALUES (5, 5, DATE '2023-09-15', 'Web Developer', 'Creating responsive websites', '3 months', 'Web Development', '$45,000');

INSERT INTO CompanyContact VALUES ('Marcus', 'Lam', '111-222-3333', 'marcus.lam@abctech.com', 1);

INSERT INTO CompanyContact VALUES ('Emily', 'Smith', '444-555-6666', 'emily.smith@xyzinc.com', 2);

INSERT INTO CompanyContact VALUES ('Michael', 'Johnson', '777-888-9999', 'michael.johnson@techcorp.com', 3);

INSERT INTO CompanyContact VALUES ('David', 'Brown', '111-111-1111', 'david.brown@datasolutions.com', 4);

INSERT INTO CompanyContact VALUES ('Sarah', 'Wilson', '222-222-2222', 'sarah.wilson@webdevpro.com', 5);

INSERT INTO JobApplication (ApplicationID, ApplicationName, StudentID, ResumeDocumentID, JobID, ApplicationDate)
VALUES (1, 'Nicholas_Fong_App', 1, 1, 1, DATE '2023-07-27');

INSERT INTO JobApplication (ApplicationID, ApplicationName, StudentID, ResumeDocumentID, JobID, ApplicationDate)
VALUES (2, 'Cole_Rowell_App', 2, 2, 2, DATE '2023-07-27');

INSERT INTO JobApplication (ApplicationID, ApplicationName, StudentID, ResumeDocumentID, JobID, ApplicationDate)
VALUES (3, 'Anikait_Kapur_App', 3, 3, 3, DATE '2023-07-27');

INSERT INTO JobApplication (ApplicationID, ApplicationName, StudentID, ResumeDocumentID, JobID, ApplicationDate)
VALUES (4, 'John_Doe_App', 4, 4, 4, DATE '2023-07-27');

INSERT INTO JobApplication (ApplicationID, ApplicationName, StudentID, ResumeDocumentID, JobID, ApplicationDate)
VALUES (5, 'Jane_Smith_App', 5, 5, 5, DATE '2023-07-27');

INSERT INTO JobApplication (ApplicationID, ApplicationName, StudentID, ResumeDocumentID, JobID, ApplicationDate)
VALUES (6, 'Cole_Rowell_App', 2, 2, 3, DATE '2023-07-27');

INSERT INTO JobApplication (ApplicationID, ApplicationName, StudentID, ResumeDocumentID, JobID, ApplicationDate)
VALUES (7, 'Cole_Rowell_App', 2, 2, 4, DATE '2023-07-27');

INSERT INTO JobApplication (ApplicationID, ApplicationName, StudentID, ResumeDocumentID, JobID, ApplicationDate)
VALUES (8, 'Cole_Rowell_App', 2, 2, 5, DATE '2023-07-27');

INSERT INTO JobApplication (ApplicationID, ApplicationName, StudentID, ResumeDocumentID, JobID, ApplicationDate)
VALUES (9, 'Cole_Rowell_App', 2, 2, 1, DATE '2023-07-27');


INSERT INTO JobApplication (ApplicationID, ApplicationName, StudentID, ResumeDocumentID, JobID, ApplicationDate)
VALUES (10, 'Nicholas_Fong_App', 1, 1, 2, DATE '2023-07-27');
INSERT INTO JobApplication (ApplicationID, ApplicationName, StudentID, ResumeDocumentID, JobID, ApplicationDate)
VALUES (11, 'Nicholas_Fong_App', 1, 1, 3, DATE '2023-07-27');
INSERT INTO JobApplication (ApplicationID, ApplicationName, StudentID, ResumeDocumentID, JobID, ApplicationDate)
VALUES (12, 'Nicholas_Fong_App', 1, 1, 4, DATE '2023-07-27');
INSERT INTO JobApplication (ApplicationID, ApplicationName, StudentID, ResumeDocumentID, JobID, ApplicationDate)
VALUES (13, 'Nicholas_Fong_App', 1, 1, 5, DATE '2023-07-27');

INSERT INTO JobApplication (ApplicationID, ApplicationName, StudentID, ResumeDocumentID, JobID, ApplicationDate)
VALUES (14, 'Anikait_Kapur_App', 3, 3, 1, DATE '2023-07-27');
INSERT INTO JobApplication (ApplicationID, ApplicationName, StudentID, ResumeDocumentID, JobID, ApplicationDate)
VALUES (15, 'Anikait_Kapur_App', 3, 3, 2, DATE '2023-07-27');
INSERT INTO JobApplication (ApplicationID, ApplicationName, StudentID, ResumeDocumentID, JobID, ApplicationDate)
VALUES (16, 'Anikait_Kapur_App', 3, 3, 4, DATE '2023-07-27');
INSERT INTO JobApplication (ApplicationID, ApplicationName, StudentID, ResumeDocumentID, JobID, ApplicationDate)
VALUES (17, 'Anikait_Kapur_App', 3, 3, 5, DATE '2023-07-27');

INSERT INTO JobApplication (ApplicationID, ApplicationName, StudentID, ResumeDocumentID, JobID, ApplicationDate)
VALUES (18, 'John_Doe_App', 4, 4, 1, DATE '2023-07-27');
INSERT INTO JobApplication (ApplicationID, ApplicationName, StudentID, ResumeDocumentID, JobID, ApplicationDate)
VALUES (19, 'John_Doe_App', 4, 4, 2, DATE '2023-07-27');
INSERT INTO JobApplication (ApplicationID, ApplicationName, StudentID, ResumeDocumentID, JobID, ApplicationDate)
VALUES (20, 'John_Doe_App', 4, 4, 3, DATE '2023-07-27');
INSERT INTO JobApplication (ApplicationID, ApplicationName, StudentID, ResumeDocumentID, JobID, ApplicationDate)
VALUES (21, 'John_Doe_App', 4, 4, 5, DATE '2023-07-27');

INSERT INTO AppContainsCoverLetter VALUES (1, 6);

INSERT INTO AppContainsCoverLetter VALUES (2, 7);

INSERT INTO AppContainsCoverLetter VALUES (3, 8);

INSERT INTO AppContainsCoverLetter VALUES (4, 9);

INSERT INTO AppContainsCoverLetter VALUES (5, 10);

INSERT INTO StudentGetsJob (StudentID, JobID, AcceptanceDate, AcceptanceTime)
VALUES (1, 1, DATE '2023-08-01', TIMESTAMP '2023-08-01 12:00:00');

INSERT INTO StudentGetsJob (StudentID, JobID, AcceptanceDate, AcceptanceTime)
VALUES (2, 2, DATE '2023-08-02', TIMESTAMP '2023-08-02 10:30:00');

INSERT INTO StudentGetsJob (StudentID, JobID, AcceptanceDate, AcceptanceTime)
VALUES (3, 3, DATE '2023-08-03', TIMESTAMP '2023-08-03 11:45:00');

INSERT INTO StudentGetsJob (StudentID, JobID, AcceptanceDate, AcceptanceTime)
VALUES (4, 4, DATE '2023-08-04', TIMESTAMP '2023-08-04 09:15:00');

INSERT INTO StudentGetsJob (StudentID, JobID, AcceptanceDate, AcceptanceTime)
VALUES (5, 5, DATE '2023-08-05', TIMESTAMP '2023-08-05 15:00:00');

INSERT INTO StudentInterviewJobwCompanyContact VALUES (1, 1, 'Marcus', 'Lam', 1, TO_TIMESTAMP('2023-07-30 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-07-30', 'YYYY-MM-DD'), 'ABC Tech Office');

INSERT INTO StudentInterviewJobwCompanyContact VALUES (2, 2, 'Emily', 'Smith', 2, TO_TIMESTAMP('2023-07-31 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-07-31', 'YYYY-MM-DD'), 'XYZ Inc Office');

INSERT INTO StudentInterviewJobwCompanyContact VALUES (3, 3, 'Michael', 'Johnson', 3, TO_TIMESTAMP('2023-08-01 10:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-08-01', 'YYYY-MM-DD'), 'TechCorp Office');

INSERT INTO StudentInterviewJobwCompanyContact VALUES (4, 4, 'David', 'Brown', 4, TO_TIMESTAMP('2023-08-02 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-08-02', 'YYYY-MM-DD'), 'Data Solutions Office');

INSERT INTO StudentInterviewJobwCompanyContact VALUES (5, 5, 'Sarah', 'Wilson', 5, TO_TIMESTAMP('2023-08-03 13:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-08-03', 'YYYY-MM-DD'), 'WebDev Pro Office');

