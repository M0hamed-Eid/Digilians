CREATE DATABASE IF NOT EXISTS university_db;
USE university_db;


-- 1. Departments Table

CREATE TABLE Departments (
    dept_id     INT PRIMARY KEY AUTO_INCREMENT,
    dept_name   VARCHAR(100) NOT NULL,
    dept_head   VARCHAR(100)
);


-- 2. Students Table

CREATE TABLE Students (
    student_id   INT PRIMARY KEY AUTO_INCREMENT,
    full_name    VARCHAR(100) NOT NULL,
    gender       ENUM('Male','Female') NOT NULL,
    birth_date   DATE,
    dept_id      INT,
    enroll_year  YEAR,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);


-- 3. Instructors Table

CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name     VARCHAR(100) NOT NULL,
    email         VARCHAR(100) UNIQUE,
    dept_id       INT,
    hire_date     DATE,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);


-- 4. Courses Table

CREATE TABLE Courses (
    course_id    INT PRIMARY KEY AUTO_INCREMENT,
    course_name  VARCHAR(100) NOT NULL,
    dept_id      INT,
    credit_hours INT DEFAULT 3,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);



-- 5. Course Sections Table

CREATE TABLE Course_Sections (
    section_id    INT PRIMARY KEY AUTO_INCREMENT,
    course_id     INT,
    instructor_id INT,
    semester      VARCHAR(20),
    year          YEAR,
    room_number   VARCHAR(20),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id)
);



-- 6. Enrollments Table 

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id    INT,
    section_id    INT,
    grade         DECIMAL(4,1),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (section_id) REFERENCES Course_Sections(section_id)
);



-- 7. Attendance Table

CREATE TABLE Attendance (
    attendance_id  INT PRIMARY KEY AUTO_INCREMENT,
    student_id     INT,
    section_id     INT,
    attendance_date DATE,
    status         ENUM('Present', 'Absent') NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (section_id) REFERENCES Course_Sections(section_id)
);

-- ############################################################################################################

USE university_db;
-- INSERT DATA START


-- 1. Departments
INSERT INTO Departments (dept_name, dept_head) VALUES
('Computer Science',    'Dr. Ahmed Kamal'),
('Business Admin',      'Dr. Sara Nasser'),
('Engineering',         'Dr. Omar Fathy'),
('Media & Journalism',  'Dr. Layla Hassan'),
('Pharmacy',            'Dr. Hany Mostafa');

-- 2. Students 

INSERT INTO Students (full_name, gender, birth_date, dept_id, enroll_year) VALUES
('Ali Mohamed','Male','2001-03-15',1,2020),
('Nour Ahmed','Female','2002-07-22',1,2021),
('Khaled Samir','Male','2000-11-05',2,2019),
('Mariam Tarek','Female','2001-09-18',2,2020),
('Hassan Youssef','Male','2002-01-30',3,2021),
('Dina Mostafa','Female','2000-06-12',3,2019),
('Youssef Ibrahim','Male','2003-04-08',4,2022),
('Sara Adel','Female','2001-12-25',4,2020),
('Omar Khaled','Male','2002-08-14',1,2021),
('Aya Hassan','Female','2003-02-19',2,2022),
('Tarek Samy','Male','2001-05-03',3,2020),
('Reem Walid','Female','2000-10-27',4,2019),
('Mahmoud Ali','Male','2002-02-10',1,2021),
('Salma Essam','Female','2001-06-17',2,2020),
('Mostafa Nabil','Male','2000-12-01',3,2019),
('Heba Khaled','Female','2003-01-09',4,2022),
('Karim Samy','Male','2002-04-14',5,2021),
('Nada Hassan','Female','2001-08-23',5,2020);

-- 3. Instructors

INSERT INTO Instructors (full_name, email, dept_id, hire_date) VALUES
('Dr. Mohamed Ali','m.ali@uni.com',1,'2015-09-01'),
('Dr. Salma Hany','s.hany@uni.com',1,'2017-02-15'),
('Dr. Hossam Adel','h.adel@uni.com',2,'2014-06-20'),
('Dr. Rania Fathy','r.fathy@uni.com',2,'2018-11-10'),
('Dr. Karim Nabil','k.nabil@uni.com',3,'2013-03-05'),
('Dr. Mona Samir','m.samir@uni.com',3,'2019-07-22'),
('Dr. Yara Hassan','y.hassan@uni.com',4,'2016-01-18'),
('Dr. Tamer Khaled','t.khaled@uni.com',4,'2020-05-30'),
('Dr. Hany Reda','h.reda@uni.com',5,'2012-03-12');

-- 4. Courses
INSERT INTO Courses (course_name, dept_id, credit_hours) VALUES
('Introduction to Programming',1,3),
('Database Systems',1,3),
('Data Structures',1,3),
('Machine Learning',1,3),
('Marketing Principles',2,3),
('Financial Accounting',2,3),
('Business Analytics',2,3),
('Thermodynamics',3,4),
('Structural Analysis',3,4),
('Fluid Mechanics',3,4),
('Media Writing',4,3),
('Digital Journalism',4,3),
('Broadcasting',4,3),
('Pharmacology',5,4),
('Organic Chemistry',5,4);

-- 5. Course Sections
INSERT INTO Course_Sections (course_id, instructor_id, semester, year, room_number) VALUES
(1,1,'Fall',2020,'A101'),
(2,2,'Spring',2021,'B201'),
(3,1,'Spring',2022,'A102'),
(4,2,'Fall',2022,'A103'),
(5,3,'Fall',2019,'C301'),
(6,4,'Spring',2020,'C302'),
(7,3,'Fall',2021,'C303'),
(8,5,'Fall',2021,'D101'),
(9,6,'Spring',2022,'D102'),
(10,5,'Fall',2020,'D103'),
(11,7,'Fall',2022,'E201'),
(12,8,'Spring',2023,'E202'),
(13,7,'Fall',2021,'E203'),
(14,9,'Fall',2022,'F101'),
(15,9,'Spring',2023,'F102'),
(1,2,'Fall',2021,'A104'),
(2,1,'Spring',2022,'B202'),
(3,2,'Fall',2023,'A105'),
(5,4,'Fall',2022,'C304'),
(8,6,'Spring',2023,'D104');

-- 6. Enrollments 
INSERT INTO Enrollments (student_id, section_id, grade) VALUES
(1,1,85),(1,2,90),(1,16,88),
(2,16,92),(2,3,88),
(3,5,70),(3,6,65),
(4,5,80),(4,6,75),
(5,8,60),(5,9,55),
(6,10,95),(6,9,88),
(7,11,72),(7,12,68),
(8,11,85),(8,12,90),
(9,16,77),(9,17,83),
(10,19,91),(10,6,86),
(11,8,74),(11,9,69),
(12,11,93),(12,12,87),
(13,1,82),(13,4,79),
(14,5,88),(14,7,84),
(15,8,73),(15,10,70),
(16,11,91),(16,13,89),
(17,14,77),(17,15,80),
(18,14,85),(18,15,82);

-- 7. Attendance 
INSERT INTO Attendance (student_id, section_id, attendance_date, status) VALUES
(1,1,'2020-10-01','Present'),
(1,1,'2020-10-03','Absent'),
(1,1,'2020-10-05','Present'),
(2,16,'2021-10-02','Present'),
(2,16,'2021-10-04','Present'),
(3,5,'2019-10-01','Absent'),
(3,5,'2019-10-03','Present'),
(4,5,'2020-10-01','Present'),
(4,6,'2021-03-01','Present'),
(5,8,'2021-10-01','Absent'),
(5,8,'2021-10-03','Absent'),
(6,10,'2020-10-01','Present'),
(6,10,'2020-10-03','Present'),
(7,11,'2022-10-01','Present'),
(7,12,'2023-03-01','Absent'),
(8,11,'2020-10-01','Present'),
(8,12,'2021-03-01','Present'),
(9,16,'2021-10-01','Present'),
(9,17,'2022-03-01','Present'),
(10,19,'2022-10-01','Present'),
(10,6,'2023-03-01','Absent'),
(11,8,'2020-10-02','Present'),
(12,11,'2019-10-01','Present'),
(13,1,'2021-10-01','Absent'),
(14,5,'2022-10-01','Present'),
(15,8,'2020-10-01','Absent'),
(16,11,'2022-10-01','Present'),
(17,14,'2022-10-01','Present'),
(18,14,'2023-03-01','Present');


-- ########################################################################################################################

USE university_db;

-- Q: How many students are enrolled in each department?
-- Retrieves the number of students enrolled in each department, ordered from highest to lowest
SELECT d.dept_name, COUNT(s.student_id) AS total_students
FROM Departments d
JOIN Students s ON d.dept_id = s.dept_id
GROUP BY d.dept_name
ORDER BY total_students DESC;


-- Q: What is the average grade for each course?
-- Retrieves the average grade for each course, ordered from highest to lowest
SELECT c.course_name, ROUND(AVG(e.grade),2) AS avg_grade
FROM Courses c
JOIN Course_Sections cs ON c.course_id = cs.course_id
JOIN Enrollments e ON cs.section_id = e.section_id
GROUP BY c.course_name
ORDER BY avg_grade DESC;

-- Q: How many students enrolled each semester and year?
-- Retrieves the total number of enrollments per semester and year, ordered chronologically
SELECT cs.semester, cs.year, COUNT(*) AS total_enrollments
FROM Enrollments e
JOIN Course_Sections cs ON e.section_id = cs.section_id
GROUP BY cs.semester, cs.year
ORDER BY cs.year, cs.semester;

-- Q: What is the average grade for each student?
-- Retrieves the average grade for each student, ordered from highest to lowest
SELECT s.full_name, ROUND(AVG(e.grade),2) AS avg_grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.full_name
ORDER BY avg_grade DESC;

-- Q: What is the gender distribution among students?
-- Retrieves the total count of male and female students
SELECT gender, COUNT(*) AS total
FROM Students
GROUP BY gender;

-- Q: How many students joined the university each year?
-- Retrieves the number of students enrolled in each academic year, ordered chronologically
SELECT enroll_year, COUNT(*) AS total_students
FROM Students
GROUP BY enroll_year
ORDER BY enroll_year;

-- Q: Who are the top 5 best performing students?
-- Retrieves the top 5 students with the highest average grades
SELECT s.full_name, ROUND(AVG(e.grade),2) AS avg_grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.full_name
ORDER BY avg_grade DESC
LIMIT 5;

-- Q: Which students are failing with an average grade below 60?
-- Retrieves students whose average grade is below 60 (failing students)
SELECT s.full_name, ROUND(AVG(e.grade),2) AS avg_grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.full_name
HAVING avg_grade < 60;

-- Q: Which instructor has the highest average grade among their students?
-- Retrieves each instructor's average grade across all their taught sections, ordered from highest to lowest
SELECT i.full_name, ROUND(AVG(e.grade),2) AS avg_grade
FROM Instructors i
JOIN Course_Sections cs ON i.instructor_id = cs.instructor_id
JOIN Enrollments e ON cs.section_id = e.section_id
GROUP BY i.full_name
ORDER BY avg_grade DESC;

-- Q: Which course has the highest number of enrolled students?
-- Retrieves the total number of students enrolled in each course, ordered from most to least popular
SELECT c.course_name, COUNT(e.student_id) AS total_students
FROM Courses c
JOIN Course_Sections cs ON c.course_id = cs.course_id
JOIN Enrollments e ON cs.section_id = e.section_id
GROUP BY c.course_name
ORDER BY total_students DESC;

-- Q: What is the attendance rate for each student?
-- Retrieves the attendance rate percentage for each student, ordered from highest to lowest
SELECT s.full_name,
ROUND(SUM(CASE WHEN a.status='Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS attendance_rate
FROM Students s
JOIN Attendance a ON s.student_id = a.student_id
GROUP BY s.full_name
ORDER BY attendance_rate DESC;

-- Q: Which students have an attendance rate below 50%?
-- Retrieves students whose attendance rate is below 50%
SELECT s.full_name,
ROUND(SUM(CASE WHEN a.status='Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS attendance_rate
FROM Students s
JOIN Attendance a ON s.student_id = a.student_id
GROUP BY s.full_name
HAVING attendance_rate < 50;

-- Q: How many courses does each department offer?
-- Retrieves the total number of courses offered by each department
SELECT d.dept_name, COUNT(c.course_id) AS total_courses
FROM Departments d
JOIN Courses c ON d.dept_id = c.dept_id
GROUP BY d.dept_name;

-- Q: What is the hardest course based on average grades?
-- Retrieves the course with the lowest average grade (hardest course)
SELECT c.course_name, ROUND(AVG(e.grade),2) AS avg_grade
FROM Courses c
JOIN Course_Sections cs ON c.course_id = cs.course_id
JOIN Enrollments e ON cs.section_id = e.section_id
GROUP BY c.course_name
ORDER BY avg_grade ASC
LIMIT 1;

-- Q: Which instructor teaches the highest number of students?
-- Retrieves the total number of students taught by each instructor, ordered from highest to lowest
SELECT i.full_name, COUNT(e.student_id) AS total_students
FROM Instructors i
JOIN Course_Sections cs ON i.instructor_id = cs.instructor_id
JOIN Enrollments e ON cs.section_id = e.section_id
GROUP BY i.full_name
ORDER BY total_students DESC;

-- ################################################

-- Stored procedure that automatically generates 80 fake students with random departments and enrollment years
DROP PROCEDURE IF EXISTS generate_students;
DELIMITER $$
CREATE PROCEDURE generate_students()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 80 DO
        INSERT INTO Students (full_name, gender, birth_date, dept_id, enroll_year)
        VALUES (
            CONCAT('Student_', i),
            IF(MOD(i, 2) = 0, 'Male', 'Female'),
            DATE_ADD('2000-01-01', INTERVAL i DAY),
            FLOOR(1 + (RAND() * 5)),
            FLOOR(2019 + (RAND() * 4))
        );

        SET i = i + 1;
    END WHILE;

END $$
DELIMITER ;
CALL generate_students();


-- Stored procedure that automatically generates 100 random enrollment records with grades between 50 and 100
DROP PROCEDURE IF EXISTS generate_enrollments;
DELIMITER $$
CREATE PROCEDURE generate_enrollments()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 100 DO
        INSERT INTO Enrollments (student_id, section_id, grade)
        VALUES (
            FLOOR(1 + (RAND() * 98)),  -- students
            FLOOR(1 + (RAND() * 20)),  -- sections
            ROUND(50 + (RAND() * 50),1) -- grades 50–100
        );

        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;
CALL generate_enrollments();


-- Stored procedure that automatically generates 200 random attendance records with 70% present and 30% absent
DROP PROCEDURE IF EXISTS generate_attendance;
DELIMITER $$
CREATE PROCEDURE generate_attendance()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 200 DO
        INSERT INTO Attendance (student_id, section_id, attendance_date, status)
        VALUES (
            FLOOR(1 + (RAND() * 98)),
            FLOOR(1 + (RAND() * 20)),
            DATE_ADD('2022-01-01', INTERVAL (i * 2) DAY),
            IF(RAND() > 0.3, 'Present', 'Absent')
        );

        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;
CALL generate_attendance();

-- Q: Which students have both an average grade above 80 and an attendance rate above 80%?
-- Retrieves high-performing students who have both an average grade above 80 and an attendance rate above 80%
SELECT s.full_name,
       ROUND(AVG(e.grade),2) AS avg_grade,
       ROUND(SUM(CASE WHEN a.status='Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(a.attendance_id),2) AS attendance_rate
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Attendance a ON s.student_id = a.student_id
GROUP BY s.full_name
HAVING avg_grade > 80 AND attendance_rate > 80
ORDER BY avg_grade DESC;


-- Q: Which department has the highest academic performance based on average grades?
-- This query ranks departments based on average student grades
SELECT d.dept_name,
       ROUND(AVG(e.grade),2) AS avg_grade
FROM Departments d
JOIN Courses c ON d.dept_id = c.dept_id
JOIN Course_Sections cs ON c.course_id = cs.course_id
JOIN Enrollments e ON cs.section_id = e.section_id
GROUP BY d.dept_name
ORDER BY avg_grade DESC;


-- Q: How difficult is each course based on its average grade?
-- This query classifies courses based on their average grades
SELECT c.course_name,
       ROUND(AVG(e.grade),2) AS avg_grade,
       CASE 
           WHEN AVG(e.grade) < 70 THEN 'Hard'
           WHEN AVG(e.grade) BETWEEN 70 AND 85 THEN 'Medium'
           ELSE 'Easy'
       END AS difficulty
FROM Courses c
JOIN Course_Sections cs ON c.course_id = cs.course_id
JOIN Enrollments e ON cs.section_id = e.section_id
GROUP BY c.course_name
ORDER BY avg_grade ASC;


-- Q: Does student performance improve or decline over the years?
-- This query checks if student performance improves over time by year
SELECT s.full_name,
       cs.year,
       ROUND(AVG(e.grade),2) AS avg_grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Course_Sections cs ON e.section_id = cs.section_id
GROUP BY s.full_name, cs.year
ORDER BY s.full_name, cs.year;


-- Q: Which courses attract the most students?
-- This query finds courses with the highest number of enrolled students
SELECT c.course_name,
       COUNT(e.student_id) AS total_students
FROM Courses c
JOIN Course_Sections cs ON c.course_id = cs.course_id
JOIN Enrollments e ON cs.section_id = e.section_id
GROUP BY c.course_name
ORDER BY total_students DESC;


-- Q: Which instructor produces the best student results?
-- This query evaluates instructors based on their students' average grades
SELECT i.full_name,
       COUNT(e.student_id) AS total_students,
       ROUND(AVG(e.grade),2) AS avg_grade
FROM Instructors i
JOIN Course_Sections cs ON i.instructor_id = cs.instructor_id
JOIN Enrollments e ON cs.section_id = e.section_id
GROUP BY i.full_name
ORDER BY avg_grade DESC;

-- Q: Show all student records
select * from students;


-- Q: Which students are at risk due to both low grades and poor attendance?
-- This query identifies students who may be at risk (low performance and attendance)
SELECT s.full_name,
       ROUND(AVG(e.grade),2) AS avg_grade,
       ROUND(SUM(CASE WHEN a.status='Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(a.attendance_id),2) AS attendance_rate
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Attendance a ON s.student_id = a.student_id
GROUP BY s.full_name
HAVING avg_grade < 60 AND attendance_rate < 50;


-- Q: Which semester and year had the highest student activity?
-- This query finds the semester and year with the highest number of enrollments
SELECT cs.year,
       cs.semester,
       COUNT(e.enrollment_id) AS total_enrollments
FROM Course_Sections cs
JOIN Enrollments e ON cs.section_id = e.section_id
GROUP BY cs.year, cs.semester
ORDER BY total_enrollments DESC
LIMIT 1;


-- Q: Does higher attendance lead to better grades?
-- This query shows the relationship between attendance and average grades
SELECT 
    CASE 
        WHEN attendance_rate >= 80 THEN 'High Attendance'
        WHEN attendance_rate >= 50 THEN 'Medium Attendance'
        ELSE 'Low Attendance'
    END AS attendance_group,
    ROUND(AVG(avg_grade),2) AS avg_grade
FROM (
    SELECT s.student_id,
           ROUND(AVG(e.grade),2) AS avg_grade,
           ROUND(SUM(CASE WHEN a.status='Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(a.attendance_id),2) AS attendance_rate
    FROM Students s
    JOIN Enrollments e ON s.student_id = e.student_id
    JOIN Attendance a ON s.student_id = a.student_id
    GROUP BY s.student_id
) AS sub
GROUP BY attendance_group;


-- Q: Which department has the highest number of course enrollments?
-- This query finds which department has the highest number of enrollments
SELECT d.dept_name,
       COUNT(e.enrollment_id) AS total_enrollments
FROM Departments d
JOIN Courses c ON d.dept_id = c.dept_id
JOIN Course_Sections cs ON c.course_id = cs.course_id
JOIN Enrollments e ON cs.section_id = e.section_id
GROUP BY d.dept_name
ORDER BY total_enrollments DESC;