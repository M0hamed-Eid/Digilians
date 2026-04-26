-- create database

CREATE DATABASE IF NOT EXISTS university_db;
USE university_db;

-- Departments Table

CREATE TABLE Departments (
    dept_id     INT PRIMARY KEY AUTO_INCREMENT,
    dept_name   VARCHAR(100) NOT NULL,
    dept_head   VARCHAR(100)
);


-- Students Table

CREATE TABLE Students (
    student_id   INT PRIMARY KEY AUTO_INCREMENT,
    full_name    VARCHAR(100) NOT NULL,
    gender       ENUM('Male','Female') NOT NULL,
    birth_date   DATE,
    dept_id      INT,
    enroll_year  YEAR,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);


--  Courses Table

CREATE TABLE Courses (
    course_id    INT PRIMARY KEY AUTO_INCREMENT,
    course_name  VARCHAR(100) NOT NULL,
    dept_id      INT,
    credit_hours INT DEFAULT 3,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);


-- Enrollments Table

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id    INT,
    course_id     INT,
    semester      VARCHAR(20),
    grade         DECIMAL(4,1),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id)  REFERENCES Courses(course_id)
);


-- ############################################################################################################

USE university_db;

INSERT INTO Departments (dept_name, dept_head) VALUES
('Computer Science',    'Dr. Ahmed Kamal'),
('Business Admin',      'Dr. Sara Nasser'),
('Engineering',         'Dr. Omar Fathy'),
('Media & Journalism',  'Dr. Layla Hassan');

INSERT INTO Students (full_name, gender, birth_date, dept_id, enroll_year) VALUES
('Ali Mohamed',      'Male',   '2001-03-15', 1, 2020),
('Nour Ahmed',       'Female', '2002-07-22', 1, 2021),
('Khaled Samir',     'Male',   '2000-11-05', 2, 2019),
('Mariam Tarek',     'Female', '2001-09-18', 2, 2020),
('Hassan Youssef',   'Male',   '2002-01-30', 3, 2021),
('Dina Mostafa',     'Female', '2000-06-12', 3, 2019),
('Youssef Ibrahim',  'Male',   '2003-04-08', 4, 2022),
('Sara Adel',        'Female', '2001-12-25', 4, 2020),
('Omar Khaled',      'Male',   '2002-08-14', 1, 2021),
('Aya Hassan',       'Female', '2003-02-19', 2, 2022),
('Tarek Samy',       'Male',   '2001-05-03', 3, 2020),
('Reem Walid',       'Female', '2000-10-27', 4, 2019);


INSERT INTO Courses (course_name, dept_id, credit_hours) VALUES
('Introduction to Programming', 1, 3),
('Database Systems',            1, 3),
('Data Structures',             1, 3),
('Marketing Principles',        2, 3),
('Financial Accounting',        2, 3),
('Thermodynamics',              3, 4),
('Structural Analysis',         3, 4),
('Media Writing',               4, 3),
('Digital Journalism',          4, 3),
('Calculus',                    1, 3);



INSERT INTO Enrollments (student_id, course_id, semester, grade) VALUES
(1,  1,  'Fall 2020',   85.0),
(1,  2,  'Spring 2021', 90.0),
(1,  10, 'Fall 2020',   78.0),
(2,  1,  'Fall 2021',   92.0),
(2,  3,  'Spring 2022', 88.0),
(3,  4,  'Fall 2019',   70.0),
(3,  5,  'Spring 2020', 65.0),
(4,  4,  'Fall 2020',   80.0),
(4,  5,  'Spring 2021', 75.0),
(5,  6,  'Fall 2021',   60.0),
(5,  7,  'Spring 2022', 55.0),
(6,  6,  'Fall 2019',   95.0),
(6,  7,  'Spring 2020', 88.0),
(7,  8,  'Fall 2022',   72.0),
(7,  9,  'Spring 2023', 68.0),
(8,  8,  'Fall 2020',   85.0),
(8,  9,  'Spring 2021', 90.0),
(9,  1,  'Fall 2021',   77.0),
(9,  2,  'Spring 2022', 83.0),
(10, 4,  'Fall 2022',   91.0),
(10, 5,  'Spring 2023', 86.0),
(11, 6,  'Fall 2020',   74.0),
(11, 7,  'Spring 2021', 69.0),
(12, 8,  'Fall 2019',   93.0),
(12, 9,  'Spring 2020', 87.0);

-- ########################################################################################################################

USE university_db;

SELECT d.dept_name, COUNT(s.student_id) AS total_students
FROM Departments d
JOIN Students s ON d.dept_id = s.dept_id
GROUP BY d.dept_name
ORDER BY total_students DESC;


SELECT c.course_name, ROUND(AVG(e.grade), 2) AS avg_grade
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
ORDER BY avg_grade DESC;

SELECT semester, COUNT(*) AS total_enrollments
FROM Enrollments
GROUP BY semester
ORDER BY total_enrollments DESC;

SELECT s.full_name, ROUND(AVG(e.grade), 2) AS avg_grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.full_name
ORDER BY avg_grade DESC;

SELECT gender, COUNT(*) AS count
FROM Students
GROUP BY gender;

SELECT enroll_year, COUNT(*) AS new_students
FROM Students
GROUP BY enroll_year
ORDER BY enroll_year;
