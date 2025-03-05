DSDDA LAB SHEET 02
__________________

-- (a) Write Oracle OR-SQL statements to develop the above database schema. 
-- Create types
create type dept_t
/

create type emp_t as object (
eno number(4),
ename varchar(15),
edept REF dept_t,
salary number(8, 2)
)
/

create or replace type dept_t as object (
dno number(2),
dname varchar2(12),
mgr REF emp_t
)
/

create type proj_t as object (
pno number(4),
pname varchar2(15),
pdept REF dept_t,
budget number(10, 2)
)
/

-- Create table
create table Dept of dept_t (
dno primary key
)
/

create table Emp of emp_t (
eno primary key,
edept references Dept
)
/

ALTER TABLE Dept 
ADD CONSTRAINT fk_mgr FOREIGN KEY (mgr) REFERENCES Emp;
/

create table Proj of proj_t (
pno primary key,
pdept references Dept
)
/

-- (b) Insert sample data to Emp, Dept and Proj tables in the above schema.

INSERT INTO Emp values (emp_t(1, 'Saman', NULL, 30000))
/
INSERT INTO Emp values (emp_t(2, 'Kamal', NULL, 34000))
/
INSERT INTO Emp values (emp_t(3, 'Nimal', NULL, 40000))
/
INSERT INTO Emp values (emp_t(4, 'Viraj', NULL, 50000))
/

INSERT INTO Dept VALUES (dept_t(1, 'DS',
(SELECT ref(e) FROM Emp e WHERE e.eno = 1)))
/
INSERT INTO Dept VALUES (dept_t(2, 'IT', 
(SELECT ref(e) FROM Emp e WHERE e.eno = 2)))
/
INSERT INTO Dept VALUES (dept_t(3, 'SE', 
(SELECT ref(e) FROM Emp e WHERE e.eno = 3)))
/

UPDATE Emp e
SET e.edept = (SELECT ref(d) FROM Dept d WHERE d.dno = 1)
WHERE e.eno = 1
/
UPDATE Emp e
SET e.edept = (SELECT ref(d) FROM Dept d WHERE d.dno = 2)
WHERE e.eno = 2
/
UPDATE Emp e
SET e.edept = (SELECT ref(d) FROM Dept d WHERE d.dno = 3)
WHERE e.eno = 3
/
UPDATE Emp e
SET e.edept = (SELECT ref(d) FROM Dept d WHERE d.dno = 3)
WHERE e.eno = 4
/

INSERT INTO Proj VALUES (proj_t(1, 'A', 
(SELECT ref(d) FROM Dept d WHERE d.dno = 1), 
52000))
/
INSERT INTO Proj VALUES (proj_t(2, 'B', 
(SELECT ref(d) FROM Dept d WHERE d.dno = 2), 
43000))
/
INSERT INTO Proj VALUES (proj_t(3, 'C', 
(SELECT ref(d) FROM Dept d WHERE d.dno = 3), 
50000))
/
INSERT INTO Proj VALUES (proj_t(4, 'D', 
(SELECT ref(d) FROM Dept d WHERE d.dno = 3), 
75000))
/
INSERT INTO Proj VALUES (proj_t(5, 'E', 
(SELECT ref(d) FROM Dept d WHERE d.dno = 2), 
65000))
/

-- (c) Find the name and salary of managers of all departments. Display the department number, manager name and salary. 

SELECT d.mgr.ename as Manager name, d.mgr.salary as Salary
FROM Dept d
/

SELECT d.mgr.ename as Manager_name, d.mgr.salary as Salary
FROM Dept d
/

-- (d) For projects that have budgets over $50000, get the project name, and the name of the manager of the department in charge of the project.

SELECT p.pname, p.pdept.mgr.ename Manager_name
FROM Proj p
WHERE p.budget > 50000
/

-- (e) For departments that are in charge of projects, find the department number, department name and total budget of all its projects together.

SELECT p.pdept.dno dept_number, p.pdept.dname dept_name, SUM(p.budget) Total_budget
FROM Proj p
GROUP BY p.pdept.dno, p.pdept.dname
/

-- (f) Find the manager’s name who is controlling the project with the largest budget

SELECT p.pdept.mgr.ename Manager_name
FROM Proj p
WHERE p.budget >= (
			SELECT MAX(p.budget)
			FROM Proj p
		  )
/

-- (g) Find the managers who control budget above $60,000. (Hint: The total amount a manager control is the sum of budgets of all projects belonging to the dept(s) for which the he/she is managing). Print the manager’s employee number and the total controlling budget.

SELECT p.pdept.mgr.eno manager_no, SUM(p.budget) total_budget
FROM Proj p
GROUP BY p.pdept.mgr.eno
HAVING SUM(p.budget) > 60000
/

-- (h) Find the manager who controls the largest amount. Print the manager’s employee number and the total controlling budget.

SELECT p.pdept.mgr.eno manager_number, SUM(p.budget) total_budget
FROM Proj p
GROUP BY p.pdept.mgr.eno
HAVING SUM(p.budget) >= (
			  SELECT MAX(total)
			  FROM (
				SELECT SUM(p1.budget) as total
				FROM Proj p1
				GROUP BY p1.pdept.mgr.eno 
				)
			)
/

/*
* Drop tables and types
*/
-- Drop tables
drop table Emp force
/
drop table Dept force
/
drop table Proj force
/
-- Drop types
drop type emp_t force
/
drop type dept_t force
/
drop type proj_t force
/