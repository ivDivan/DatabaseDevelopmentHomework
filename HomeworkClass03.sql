USE [SEDC_ACADEMY_HOMEWORK]
GO


-- Calculate the count of all grades per Teacher in the system

SELECT t.FirstName, t.LastName, COUNT(Grade) as NumberOfGrades
FROM dbo.Grade g
JOIN dbo.Teacher t ON t.ID = g.TeacherID
GROUP BY t.FirstName, t.LastName
GO

-- Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)

SELECT t.FirstName, t.LastName, COUNT(Grade) as NumberOfGradesHundredStudents
FROM dbo.Grade g
JOIN dbo.Teacher t ON t.ID = g.TeacherID
WHERE StudentID < 100
GROUP BY t.FirstName, t.LastName
GO

-- Find the Maximal Grade, and the Average Grade per Student on all grades in the system

SELECT s.FirstName, s.LastName, MAX(Grade) as MaxGrade, AVG(Grade) as AvgGrade
FROM dbo.Grade g
JOIN dbo.Student s ON s.ID = g.StudentID
GROUP BY s.FirstName, s.LastName
GO

-- Calculate the count of all grades per Teacher in the system and filter only grade count greater then
--200

SELECT t.FirstName, t.LastName, COUNT(Grade) as NumberOfGradesMoreThanTwoHundred
FROM dbo.Grade g
JOIN dbo.Teacher t ON t.ID = g.TeacherID
GROUP BY t.FirstName, t.LastName
HAVING COUNT(Grade) > 200
GO

-- Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the
--system. Filter only records where Maximal Grade is equal to Average Grade

SELECT s.FirstName, s.LastName, COUNT(Grade) as NumberOfGrades, MAX(Grade) as MaxGrade, AVG(Grade) as AvgGrade
FROM dbo.Grade g
JOIN dbo.Student s ON s.ID = g.StudentID
GROUP BY s.FirstName, s.LastName
HAVING MAX(Grade) = AVG(Grade)
GO

-- List Student First Name and Last Name next to the other details from previous query

--SITE VAKA GI TERAV, I GORE E TAKA NAPRAVENO...

-- Create new view (vv_StudentGrades) that will List all StudentIds and count of Grades per student

DROP VIEW IF EXISTS vv_StudentGrades;
GO

CREATE VIEW vv_StudentGrades
AS
SELECT s.ID, COUNT(Grade) as NumberOfGrades
FROM dbo.Grade g
JOIN dbo.Student s ON s.ID = g.StudentID
GROUP BY s.ID
GO

-- Change the view to show Student First and Last Names instead of StudentID

ALTER VIEW vv_StudentGrades
AS
SELECT s.FirstName, s.LastName, COUNT(Grade) as NumberOfGrades
FROM dbo.Grade g
JOIN dbo.Student s ON s.ID = g.StudentID
GROUP BY s.FirstName, s.LastName
GO

-- List all rows from view ordered by biggest Grade Count

SELECT * FROM vv_StudentGrades
ORDER BY NumberOfGrades desc


-- END OF HOMEWORK

-- DOLE SE POMOSNI

SELECT * FROM Student
SELECT * FROM Teacher
SELECT * FROM Course
SELECT * FROM AchievementType
SELECT * FROM Grade
SELECT * FROM GradeDetails
GO