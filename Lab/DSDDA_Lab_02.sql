-- Type creation
CREATE TYPE Emp_t
/

CREATE TYPE Dept_t AS OBJECT (
    deptno NUMBER(4),
    deptname VARCHAR2(12),
    MGR REF Emp_t   -- Reference to an employee
)
/

CREATE OR REPLACE TYPE Emp_t AS OBJECT (
    empno NUMBER(4),
    empname VARCHAR2(15),
    EDEPT REF Dept_t,  -- Reference to a department
    Salary NUMBER(8,2)
) 
/

CREATE TYPE Proj_t AS OBJECT (
    prono NUMBER(4),
    proname VARCHAR2(15),
    PDEPT REF Dept_t,   -- Reference to a department
    budget NUMBER(10,2)
)
/

-- Table creation
CREATE TABLE Dept OF Dept_t (
    PRIMARY KEY (deptno)
)
/

CREATE TABLE Emp OF Emp_t (
    PRIMARY KEY (empno),
    EDEPT REFERENCES Dept
)
/

ALTER TABLE Dept ADD CONSTRAINT fk_mgr FOREIGN KEY (MGR) REFERENCES Emp
/

CREATE TABLE Proj OF Proj_t (
    PRIMARY KEY (prono),
    PDEPT REFERENCES Dept
)
/

-- Verify Table Structure
DESCRIBE Emp
/ 
DESCRIBE Dept
/  
DESCRIBE Proj
/

-- Insert Departments
INSERT INTO Dept VALUES (
    Dept_t(10, 'IT', NULL)
)
/
INSERT INTO Dept VALUES (
    Dept_t(20, 'Finance', NULL)
)
/
INSERT INTO Dept VALUES (
    Dept_t(30, 'HR', NULL)
)
/

-- Insert Employees (Assuming we set managers later)
INSERT INTO Emp VALUES (
    Emp_t(101, 'Kamal Perera', NULL, 120000.00)
)
/
INSERT INTO Emp VALUES (
    Emp_t(102, 'Nimal Silva', NULL, 110000.00)
)
/
INSERT INTO Emp VALUES (
    Emp_t(103, 'Sunil Fernando', NULL, 115000.00)
)
/

-- Update Managers (Assigning references)
UPDATE Dept d
SET d.MGR = (SELECT REF(e) FROM Emp e WHERE e.empno = 101)
WHERE d.deptno = 10
/

UPDATE Dept d
SET d.MGR = (SELECT REF(e) FROM Emp e WHERE e.empno = 102)
WHERE d.deptno = 20
/

UPDATE Dept d
SET d.MGR = (SELECT REF(e) FROM Emp e WHERE e.empno = 103)
WHERE d.deptno = 30
/

-- Update Employees to assign departments
UPDATE Emp e
SET e.EDEPT = (SELECT REF(d) FROM Dept d WHERE d.deptno = 10)
WHERE e.empno = 101
/

UPDATE Emp e
SET e.EDEPT = (SELECT REF(d) FROM Dept d WHERE d.deptno = 20)
WHERE e.empno = 102
/

UPDATE Emp e
SET e.EDEPT = (SELECT REF(d) FROM Dept d WHERE d.deptno = 30)
WHERE e.empno = 103
/

-- Insert Projects
INSERT INTO Proj VALUES (
    Proj_t(201, 'ERP System', (SELECT REF(d) FROM Dept d WHERE d.deptno = 10), 5000000.00)
)
/
INSERT INTO Proj VALUES (
    Proj_t(202, 'Audit', (SELECT REF(d) FROM Dept d WHERE d.deptno = 20), 2000000.00)
)
/
INSERT INTO Proj VALUES (
    Proj_t(203, 'Training Program', (SELECT REF(d) FROM Dept d WHERE d.deptno = 30), 1500000.00)
)
/
