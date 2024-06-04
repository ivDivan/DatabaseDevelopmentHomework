USE SEDC_ACADEMY_HOMEWORK
GO

--HOMEWORK REQUIREMENTS

-- Declare scalar variable for storing FirstName values
--   Assign value ‘Antonio’ to the FirstName variable
--   Find all Students having FirstName same as the variable

DECLARE @FirstName nvarchar(255)
SET @FirstName = 'Antonio'
SELECT *
FROM dbo.Student
WHERE FirstName = @FirstName
GO

-- Declare table variable that will contain StudentId, StudentName and DateOfBirth
--   Fill the table variable with all Female students

DECLARE @StudentList TABLE
(StudentId int, StudentName nvarchar(100), DateOfBirth date)

INSERT INTO @StudentList
SELECT ID, FirstName, DateOfBirth
FROM dbo.Student
WHERE GENDER = 'F'

SELECT * FROM @StudentList
GO

-- Declare temp table that will contain LastName and EnrolledDate columns
--   Fill the temp table with all Male students having First Name starting with ‘A’
--   Retrieve the students from the table which last name is with 7 characters

CREATE TABLE #MaleStudentList 
(LastName nvarchar(100), EnrolledDate date)

INSERT INTO #MaleStudentList
SELECT LastName, EnrolledDate
FROM dbo.Student
WHERE FirstName like '%A' AND Gender = 'M'

SELECT *
FROM #MaleStudentList
WHERE LEN(LastName) = 7
go

DROP TABLE #MaleStudentList
GO

-- Find all teachers whose FirstName length is less than 5 and
--   the first 3 characters of their FirstName and LastName are the same

SELECT *
FROM dbo.Teacher
WHERE LEN(FirstName) < 5 AND
LEFT(FirstName,3) = LEFT(LastName, 3)
GO

-- OVDE MALCE NEJASNO, TREBASE LI SCALAR FUNCTION DA NAPRAAM? PODOLE IMA KAKO PROBAV I SO FUNCTION...

DROP FUNCTION IF EXISTS dbo.fn_TeacherCheckName
GO

CREATE FUNCTION dbo.fn_TeacherCheckName (@FirstName nvarchar(100), @LastName nvarchar(100))
RETURNS nvarchar(255)
AS
BEGIN

DECLARE @Result bit

IF LEN(@FirstName) < 5 AND LEFT(@FirstName,3) = LEFT(@LastName, 3)
	SET @Result = 1
ELSE
	SET @Result= 0

RETURN @Result

END
GO

SELECT *
FROM dbo.Teacher
WHERE dbo.fn_TeacherCheckName(FirstName, LastName) = 1
GO


-- END OF HOMEWORK



SELECT * FROM Student
SELECT * FROM Teacher
SELECT * FROM Course
SELECT * FROM AchievementType
SELECT * FROM Grade
SELECT * FROM GradeDetails
GO