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
