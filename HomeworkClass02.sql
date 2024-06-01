USE SEDC_ACADEMY_HOMEWORK
GO

-- Find all Students with FirstName = Antonio

SELECT *
FROM Student
WHERE FirstName = 'Antonio'
GO

-- Find all Students with DateOfBirth greater than ‘01.01.1999’

SELECT *
FROM Student
WHERE DateOfBirth >= '01.01.1999'
GO

-- Find all Students with LastName starting With ‘J’ enrolled in January/1998

SELECT *
FROM Student
WHERE LastName like 'J%'
and EnrolledDate >= '01.01.1998' and EnrolledDate <= '01.31.1998'
GO

-- List all Students ordered by FirstName

SELECT *
FROM Student
ORDER BY FirstName
GO

-- List all Teacher Last Names and Student Last Names in single result set. Remove duplicates

SELECT LastName
FROM Teacher
UNION
SELECT LastName
FROM Student
GO

-- Create Foreign key constraints from diagram or with script

ALTER TABLE Grade
WITH CHECK
ADD CONSTRAINT [FK_Teacher_Grade] FOREIGN KEY (TeacherID)
REFERENCES [dbo].[Teacher] ([ID])
GO

ALTER TABLE Grade DROP CONSTRAINT [FK_Teacher_Grade];

-- List all possible combinations of Courses names and AchievementType names that can be passed by student

SELECT c.Name as CourseName, a.Name as AchievementName
FROM dbo.Course c
CROSS JOIN dbo.AchievementType a
GO

-- List all Teachers without exam Grade

SELECT DISTINCT t.FirstName, t.LastName, t.ID
FROM dbo.Teacher t
LEFT JOIN dbo.Grade g on t.ID = g.TeacherID
WHERE g.Grade IS NULL
GO

-- End of homework

-- DOLE SE POMOSNI
SELECT * FROM Student
SELECT * FROM Teacher
SELECT * FROM Course
SELECT * FROM AchievementType
SELECT * FROM Grade
SELECT * FROM GradeDetails

SELECT * FROM Grade
ORDER BY TeacherID
GO