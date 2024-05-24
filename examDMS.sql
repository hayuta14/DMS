Create database examDMS;
use examDMS
--Create table
drop table Students
drop table Classes
drop table Teachers
create table Students (
	StudentID int primary key IDENTITY(1,1),
	Firstname varchar(255),
	Lastname varchar(255),
	ClassID int not null,
	Birthdate date,
	CONSTRAINT FK_ClassID FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
)
create table Classes (
	ClassID int primary key IDENTITY(1,1),
	ClassName varchar(255),
	TeacherID int not null,
	CONSTRAINT FK_TeacherID FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID)
)
create table Teachers (
	TeacherID int primary key IDENTITY(1,1),
	Firstname varchar(255),
	Lastname varchar(255),
	Subject varchar(255),
)
--Add data
insert into Classes(ClassName,TeacherID) values
('LopA','1'),('LopB','2'),('LopC','3'),('LopD','2'),('LopE','1')
select * from Classes
insert into Teachers(Firstname,Lastname,Subject) values
('mai','DucAnh','Math'),
('Vu','DinhQuy','Physics'),
('Phan','TienAnh','Geography')
select * from Teachers
delete Students
insert into Students(Firstname,Lastname,ClassID,Birthdate) values
('Pham','A','2','2005-8-12'),
('Pham','B','3','1999-9-17'),
('Pham','C','4','1998-1-19'),
('Pham','D','5','2000-2-20'),
('Pham','E','6','2009-3-5'),
('Pham','F','4','2001-4-1'),
('Pham','G','2','1998-5-15'),
('Pham','H','5','1997-6-22'),
('Pham','I','6','2006-10-30'),
('Pham','J','3','2002-11-12')
--3 Data query
select * from Students
select * from Classes
select * from Teachers
--4 query condition
Select *
from Students
where YEAR(Birthdate)>=2000
--join query
Select s.*,c.ClassName,t.Firstname,t.Lastname
From Students s
Join Classes c on c.ClassID=s.ClassID
join Teachers t on t.TeacherID=c.TeacherID
order by s.Lastname asc
--updating data
update Students
Set Firstname='Jhon',Lastname='Doe'
where StudentID=3
--Delete data
delete
from Students
where StudentID=7
--procedure
CREATE PROCEDURE GetStudentsByClassAndSubject @p_ClassID int ,@p_Subject varchar(30)
as
    SELECT s.StudentID, s.Firstname, s.Lastname, s.Birthdate, c.ClassName, t.Firstname AS TeacherFirstname, t.Lastname AS TeacherLastname, t.Subject
    FROM Students s
    JOIN Classes c ON s.ClassID = c.ClassID
    JOIN Teachers t ON c.TeacherID = t.TeacherID
    WHERE s.ClassID = @p_ClassID AND t.Subject = @p_Subject
go 

--view
CREATE VIEW StudentsWithClassAndTeacher AS
SELECT
    s.StudentID,
    s.Firstname AS StudentFirstname,
    s.Lastname AS StudentLastname,
    s.Birthdate,
    c.ClassName,
    t.Firstname AS TeacherFirstname,
    t.Lastname AS TeacherLastname,
    t.Subject
FROM
    Students s
JOIN
    Classes c ON s.ClassID = c.ClassID
JOIN
    Teachers t ON c.TeacherID = t.TeacherID;

select * from StudentsWithClassAndTeacher