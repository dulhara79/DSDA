-- (a) Write ORacle OR-SQL statements to develop the above databASe schema. 
-- Create TYPEs
CREATE TYPE dept_t
/

CREATE TYPE emp_t AS OBJECT (
eno NUMBER(4),
ename varchar(15),
edept REF dept_t,
salary NUMBER(8, 2)
)
/

CREATE OR REPLACE TYPE dept_t AS OBJECT (
dno NUMBER(2),
dname VARCHAR2(12),
mgr REF emp_t
)
/

CREATE TYPE proj_t AS OBJECT (
pno NUMBER(4),
pname VARCHAR2(15),
pdept REF dept_t,
budget NUMBER(10, 2)
)
/

-- Create TABLE
CREATE TABLE Dept of dept_t (
dno PRIMARY KEY
)
/

CREATE TABLE Emp of emp_t (
eno PRIMARY KEY,
edept REFERENCES Dept
)
/

ALTER TABLE Dept 
ADD CONSTRAINT fk_mgr FOREIGN KEY (mgr) REFERENCES Emp
/

CREATE TABLE Proj of proj_t (
pno PRIMARY KEY,
pdept REFERENCES Dept
)
/

-- (b) Insert sample data to Emp, Dept and Proj TABLEs in the above schema.

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

-- (c) Find the name and salary of managers of all departments. Display the department NUMBER, manager name and salary. 

SELECT d.mgr.ename AS Manager name, d.mgr.salary AS Salary
FROM Dept d
/

SELECT d.mgr.ename AS Manager_name, d.mgr.salary AS Salary
FROM Dept d
/

-- (d) FOR projects that have budgets over $50000, get the project name, and the name of the manager of the department in charge of the project.

SELECT p.pname, p.pdept.mgr.ename Manager_name
FROM Proj p
WHERE p.budget > 50000
/

-- (e) FOR departments that are in charge of projects, find the department NUMBER, department name and total budget of all its projects together.

SELECT p.pdept.dno dept_NUMBER, p.pdept.dname dept_name, SUM(p.budget) Total_budget
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

-- (g) Find the managers who control budget above $60,000. (Hint: The total amount a manager control is the sum of budgets of all projects belonging to the dept(s) fOR which the he/she is managing). Print the manager’s employee NUMBER and the total controlling budget.

SELECT p.pdept.mgr.eno manager_no, SUM(p.budget) total_budget
FROM Proj p
GROUP BY p.pdept.mgr.eno
HAVING SUM(p.budget) > 60000
/

-- (h) Find the manager who controls the largest amount. Print the manager’s employee NUMBER and the total controlling budget.

SELECT p.pdept.mgr.eno manager_NUMBER, SUM(p.budget) total_budget
FROM Proj p
GROUP BY p.pdept.mgr.eno
HAVING SUM(p.budget) >= (
			  SELECT MAX(total)
			  FROM (
				SELECT SUM(p1.budget) AS total
				FROM Proj p1
				GROUP BY p1.pdept.mgr.eno 
				)
			)
/

/*
* Drop tables and types
*/
-- Drop constraint
ALTER TABLE Dept DROP CONSTRAINT fk_mgr
/
-- Drop tables
DROP TABLE Emp FORCE
/
DROP TABLE Dept FORCE
/
DROP TABLE Proj FORCE
/
-- Drop types
DROP TYPE emp_t FORCE
/
DROP TYPE dept_t FORCE
/
DROP TYPE proj_t FORCE
/