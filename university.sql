-- Create Database
CREATE DATABASE IF NOT EXISTS university_db;
USE university_db;

-- Students Table
CREATE TABLE IF NOT EXISTS Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    BirthDate DATE,
    EnrollmentDate DATE
);

-- Departments Table
CREATE TABLE IF NOT EXISTS Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

-- Courses Table
CREATE TABLE IF NOT EXISTS Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    DepartmentID INT,
    Credits INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Instructors Table
CREATE TABLE IF NOT EXISTS Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Enrollments Table
CREATE TABLE IF NOT EXISTS Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Insert Data
INSERT INTO Students VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '2000-01-15', '2022-08-01'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '1999-05-25', '2021-08-01');

INSERT INTO Departments VALUES
(1, 'Computer Science'),
(2, 'Mathematics');

INSERT INTO Courses VALUES
(101, 'Introduction to SQL', 1, 3),
(102, 'Data Structures', 2, 4);

INSERT INTO Instructors VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@univ.com', 1),
(2, 'Bob', 'Lee', 'bob.lee@univ.com', 2);

INSERT INTO Enrollments VALUES
(1, 1, 101, '2022-08-01'),
(2, 2, 102, '2021-08-01');

-- Queries

SELECT * FROM Students;

SELECT * FROM Students
WHERE EnrollmentDate > '2022-01-01';

SELECT * FROM Courses
WHERE DepartmentID = 2
LIMIT 5;

SELECT CourseID, COUNT(StudentID) AS total_students
FROM Enrollments
GROUP BY CourseID;

SELECT StudentID
FROM Enrollments
WHERE CourseID IN (101, 102);

SELECT SUM(Credits) AS total_credits
FROM Courses;

SELECT COUNT(*) 
FROM Instructors
WHERE DepartmentID = 1;

SELECT c.DepartmentID, COUNT(e.StudentID) AS total_students
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.DepartmentID;

SELECT s.FirstName, c.CourseName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID;

SELECT s.FirstName, c.CourseName
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
LEFT JOIN Courses c ON e.CourseID = c.CourseID;

SELECT StudentID
FROM Enrollments
WHERE CourseID IN (
    SELECT CourseID
    FROM Enrollments
    GROUP BY CourseID
    HAVING COUNT(*) > 1
);

SELECT StudentID, YEAR(EnrollmentDate) AS year
FROM Students;

SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Students;

SELECT StudentID,
CASE
    WHEN EnrollmentDate < '2022-01-01' THEN 'Old Student'
    ELSE 'New Student'
END AS status
FROM Students;
