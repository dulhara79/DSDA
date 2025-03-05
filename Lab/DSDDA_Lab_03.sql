/*
* TYPE CREATION
*/
CREATE TYPE depend_t AS OBJECT (
depname varchar2(12),
gender char(1),
bdate date,
relationship varchar2(10)
)
/

CREATE TYPE dependTB_t AS TABLE OF depend_t
/

CREATE TYPE dept_t
/

CREATE TYPE emp_t AS OBJECT (
eno number(4),
ename varchar2(15),
edept REF dept_t,
salary number(8,2),
dependents dependTB_t
)
/

CREATE OR REPLACE TYPE dept_t AS OBJECT (
dno number(2),
dname varchar2(12),
mgr REF emp_t
)
/

CREATE TYPE proj_t AS OBJECT (
pno number(4),
pname varchar2(15),
pdept REF dept_t,
budget number(10,2)
)
/

CREATE TYPE work_t AS OBJECT (
wemp REF emp_t,
wproj REF proj_t,
since date,
hours number(4,2)
)
/

/*
* TABLE CREATION
*/
CREATE TABLE Dept of dept_t (
dno PRIMARY KEY
)
/

CREATE TABLE Emp OF emp_t (
eno PRIMARY KEY,
edept REFERENCES Dept
)
NESTED TABLE dependents STORE AS dependent_tb
/

ALTER TABLE Dept 
ADD CONSTRAINT fk_mgr FOREIGN KEY (mgr) REFERENCES Emp
/

CREATE TABLE Proj OF proj_t (
pno PRIMARY KEY,
pdept REFERENCES Dept
)
/

CREATE TABLE Works of work_t (
wemp REFERENCES Emp,
wproj REFERENCES Proj
)
/

/*
* GET DESCRIPTION ABOUT TYPES
*/
DESC emp_t
DESC dept_t
DESC proj_t
DESC work_t
DESC depend_t
DESC dependTB_T

/*
* GET DESCRIPTION ABOUT TABLES
*/
DESC Emp
DESC Dept
DESC Proj
DESC Works

/*
* INSERT DATA
*/
-- INSERT DEPARTMENT TABLE
INSERT INTO Dept VALUES (dept_t(1, 'IT', NULL))
/
INSERT INTO Dept VALUES (dept_t(2, 'Finance', NULL))
/
INSERT INTO Dept VALUES (dept_t(3, 'HR', NULL))
/

-- INSERT EMPLOYEE TABLE
INSERT INTO Emp VALUES (emp_t(1, 'Nimal', 
(SELECT ref(d) FROM Dept d WHERE d.dno = 1),
45000, dependTB_t(
depend_t('Nimal', 'M', TO_DATE('2001-10-25', 'YYYY-MM-DD'), 'CHILD')
)))
/
INSERT INTO Emp
VALUES (emp_t(2, 'Saman', (SELECT REF(d) FROM Dept d WHERE d.dno = 1), 
50000, dependTB_t(
depend_t('Nimali', 'F', TO_DATE('1977-02-22', 'YYYY-MM-DD'), 'SPOUSE')
)))
/
INSERT INTO Emp 
VALUES (emp_t(3, 'Kasun', 
(SELECT REF(d) FROM Dept d WHERE d.dno = 2), 
60000, dependTB_t(
depend_t('Kasuni', 'F', TO_DATE('1977-02-22', 'YYYY-MM-DD'), 'SPOUSE'),
depend_t('Nihal', 'M', TO_DATE('1999-10-23', 'YYYY-MM-DD'), 'CHILD')
)))
/
INSERT INTO Emp
VALUES (emp_t(4, 'Harendra', 
(SELECT REF(d) FROM Dept d WHERE d.dno = 3), 
100000, dependTB_t(
depend_t('KaNCHANA', 'F', TO_DATE('1977-02-22', 'YYYY-MM-DD'), 'SPOUSE'),
depend_t('Nihal', 'M', TO_DATE('1999-10-23', 'YYYY-MM-DD'), 'CHILD'),
depend_t('Kasuni', 'F', TO_DATE('2005-02-20', 'YYYY-MM-DD'), 'CHILD')
)))
/

-- UPDATE DEPARTMENT TABLE
UPDATE Dept d
SET d.mgr = (SELECT REF(e) FROM Emp e WHERE e.eno = 1)
WHERE d.dno = 1
/
UPDATE Dept d
SET d.mgr = (SELECT REF(e) FROM Emp e WHERE e.eno = 3)
WHERE d.dno = 2
/
UPDATE Dept d
SET d.mgr = (SELECT REF(e) FROM Emp e WHERE e.eno = 4)
WHERE d.dno = 3
/

-- INSERT PROJECT TABLE
INSERT INTO Proj VALUES (proj_t(1, 'A', 
(SELECT ref(d) FROM Dept d WHERE d.dno = 1),
70000))
/
INSERT INTO Proj VALUES (proj_t(2, 'B', 
(SELECT REF(d) FROM Dept d WHERE d.dno = 2),
100000))
/
INSERT INTO Proj VALUES (proj_t(3, 'C', 
(SELECT REF(d) FROM Dept d WHERE d.dno = 3),
130000))
/

-- INSERT WORKS TABLE
INSERT INTO Works VALUES (work_t(
(SELECT ref(e) FROM Emp e WHERE e.eno = 1),
(SELECT ref(p) FROM Proj p WHERE p.pno = 1), 
TO_DATE('2010-04-25', 'YYYY-MM-DD'), 10.00))
/
INSERT INTO Works VALUES (work_t(
(SELECT ref(e) FROM Emp e WHERE e.eno = 2),
(SELECT ref(p) FROM Proj p WHERE p.pno = 2),
TO_DATE('2024-10-31', 'YYYY-MM-DD'), 12.18))
/
INSERT INTO Works VALUES (work_t(
(SELECT ref(e) FROM Emp e WHERE e.eno = 3),
(SELECT ref(p) FROM Proj p WHERE p.pno = 2),
TO_DATE('2024-10-31', 'YYYY-MM-DD'), 12.18))
/
INSERT INTO Works VALUES (work_t(
(SELECT ref(e) FROM Emp e WHERE e.eno = 4),
(SELECT ref(p) FROM Proj p WHERE p.pno = 3),
TO_DATE('2025-01-31', 'YYYY-MM-DD'), 06.15))
/



/*
* DROP TABLES AND TYPES
*/
-- Drop tables
DROP TABLE Emp FORCE
/
DROP TABLE Dept FORCE
/
DROP TABLE Proj FORCE
/
DROP TABLE Work FORCE
/

-- Drop types
DROP TYPE depend_t FORCE
/
DROP TYPE dependTB_t FORCE
/
DROP TYPE emp_t FORCE
/
DROP TYPE dept_t FORCE
/
DROP TYPE proj_t FORCE
/
DROP TYPE work_t FORCE
/