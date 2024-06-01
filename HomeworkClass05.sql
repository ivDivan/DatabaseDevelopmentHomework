--HOMEWORK CLASS 05Homework 02.1

-- Create new procedure called CreateGrade
-- Procedure should create only Grade header info (not Grade Details)
-- Procedure should return the total number of grades in the system for the Student on input
--(from the CreateGrade)
--Procedure should return second resultset with the MAX Grade of all grades for the Student
--and Teacher on input (regardless the Course)

USE SEDC_ACADEMY_HOMEWORK
GO

SELECT * FROM Grade
SELECT * FROM Student
SELECT * FROM Course
GO


CREATE OR ALTER PROCEDURE usp_CreateGrade
(
@StudentId int,
@CourseId int,
@TeacherId int,
@Grade tinyint,
@Comment nvarchar(max),
@CreatedDate datetime,

@StudentGradesNumber int OUTPUT,
@StudentTeacherMaxGrade tinyint OUTPUT
)
AS
BEGIN

INSERT INTO dbo.Grade([StudentID],[CourseID],[TeacherID],[Grade],[Comment],[CreatedDate])
VALUES(@StudentId, @CourseId, @TeacherId, @Grade, @Comment, @CreatedDate)

SELECT @StudentGradesNumber = COUNT(*)
FROM dbo.Grade
WHERE StudentId = @StudentId

SELECT @StudentTeacherMaxGrade = MAX(Grade)
FROM dbo.Grade
WHERE StudentID = @StudentId AND TeacherID = @TeacherId

END
GO

DECLARE @NumberOfGrades int
DECLARE @MaxGrade tinyint

EXEC usp_CreateGrade 382, 22, 7, 9, 'Tirilimbambam', '2019-03-26 00:00:00.000', @NumberOfGrades OUTPUT, @MaxGrade OUTPUT
SELECT @NumberOfGrades as 'Total number of grades of Student'
SELECT @MaxGrade as 'Max grade for student from teacher'
GO

--HOMEWORK CLASS 05Homework 02.2
-- Create new procedure called CreateGradeDetail
-- Procedure should add details for specific Grade (new record for new AchievementTypeID,
--Points, MaxPoints, Date for specific Grade)
-- Output from this procedure should be resultset with SUM of GradePoints calculated with
--formula AchievementPoints/AchievementMaxPoints*ParticipationRate for specific Grade

USE SEDC_ACADEMY_HOMEWORK
GO

SELECT * FROM Grade
SELECT * FROM Student
SELECT * FROM Course
SELECT * FROM GradeDetails
SELECT * FROM AchievementType
GO

CREATE OR ALTER PROCEDURE usp_CreateGradeDetail
(
@GradeID int,
@AchievementTypeID int,
@AchievementPoints smallint,
@AchievementMAXPoints smallint,
@AchievementDate date
)
AS
BEGIN

INSERT INTO dbo.GradeDetails([GradeID], [AchievementTypeID], [AchievementPoints], [AchievementMaxPoints], [AchievementDate])
VALUES(@GradeID, @AchievementTypeID, @AchievementPoints, @AchievementMAXPoints, @AchievementDate)

SELECT  SUM(gd.AchievementPoints*a.ParticipationRate/gd.AchievementMaxPoints) AS TotalGradePoints
FROM dbo.GradeDetails gd
INNER JOIN dbo.AchievementType a ON gd.AchievementTypeID = a.ID
WHERE gd.GradeID = @GradeID
END

EXEC usp_CreateGradeDetail 0,2,77,100,'2019-04-13'
GO