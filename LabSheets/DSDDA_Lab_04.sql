-- 1. Create Tables
CREATE TABLE Department (
    DeptNo VARCHAR2(20) PRIMARY KEY,
    DeptName CHAR(20),
    Location VARCHAR2(20)
)
/

CREATE TABLE Employee (
    EmpNo VARCHAR2(20) PRIMARY KEY,
    fname CHAR(20),
    lname CHAR(20),
    address VARCHAR2(40),
    salary NUMBER,
    DeptNo VARCHAR2(20),
    CONSTRAINT fk_DeptNo FOREIGN KEY (DeptNo) REFERENCES Department(DeptNo)
)
/

CREATE TABLE Project (
    ProjNo CHAR(5) PRIMARY KEY,
    Project_Name VARCHAR2(20),
    DeptNo VARCHAR2(20),
    CONSTRAINT fk_ProjectDept FOREIGN KEY (DeptNo) REFERENCES Department(DeptNo)
)
/

CREATE TABLE Works_On (
    EmpNo VARCHAR2(20),
    ProjNo CHAR(5),
    DateWorked DATE,
    Hours NUMBER(2),
    PRIMARY KEY (EmpNo, ProjNo, DateWorked),
    CONSTRAINT fk_WorkEmp FOREIGN KEY (EmpNo) REFERENCES Employee(EmpNo),
    CONSTRAINT fk_WorkProj FOREIGN KEY (ProjNo) REFERENCES Project(ProjNo)
)
/

-- 2. Insert Data
INSERT INTO Department VALUES
('001', 'Accounts', 'Bangalore')
/
INSERT INTO Department VALUES
('002', 'IT', 'Mumbai')
/
INSERT INTO Department VALUES
('003', 'ECE', 'Mumbai')
/
INSERT INTO Department VALUES
('004', 'ISE', 'Mumbai')
/
INSERT INTO Department VALUES
('005', 'CSE', 'Delhi')
/

INSERT INTO Employee VALUES
('Emp01', 'John', 'Scott', 'Mysore', 45000, '003')
/
INSERT INTO Employee VALUES
('Emp02', 'James', 'Smith', 'Bangalore', 50000, '005')
/
INSERT INTO Employee VALUES
('Emp03', 'Edward', 'Hedge', 'Bangalore', 65000, '002')
/
INSERT INTO Employee VALUES
('Emp04', 'Santhosh', 'Kumar', 'Delhi', 80000, '002')
/
INSERT INTO Employee VALUES
('Emp05', 'Veena', 'M', 'Mumbai', 45000, '004')
/

INSERT INTO Project VALUES
('P01', 'IOT', '005')
/
INSERT INTO Project VALUES
('P02', 'Cloud', '005')
/
INSERT INTO Project VALUES
('P03', 'BankMgmt', '004')
/
INSERT INTO Project VALUES
('P04', 'Sensors', '003')
/
INSERT INTO Project VALUES
('P05', 'BigData', '002')
/

INSERT INTO Works_On VALUES
('Emp02', 'P03', TO_DATE('2018-10-02', 'YYYY-MM-DD'), 4)
/
INSERT INTO Works_On VALUES
('Emp01', 'P02', TO_DATE('2014-01-22', 'YYYY-MM-DD'), 13)
/
INSERT INTO Works_On VALUES
('Emp02', 'P02', TO_DATE('2020-06-19', 'YYYY-MM-DD'), 15)
/
INSERT INTO Works_On VALUES
('Emp02', 'P01', TO_DATE('2020-06-11', 'YYYY-MM-DD'), 10)
/
INSERT INTO Works_On VALUES
('Emp01', 'P04', TO_DATE('2009-02-08', 'YYYY-MM-DD'), 6)
/
INSERT INTO Works_On VALUES
('Emp02', 'P01', TO_DATE('2018-10-18', 'YYYY-MM-DD'), 18)
/
INSERT INTO Works_On VALUES
('Emp01', 'P05', TO_DATE('2011-09-02', 'YYYY-MM-DD'), 7)
/



/*
* Drop tables
*/
ALTER TABLE Works_On DROP CONSTRAINT fk_WorkEmp
/
ALTER TABLE Works_On DROP CONSTRAINT fk_WorkProj
/
ALTER TABLE Project DROP CONSTRAINT fk_ProjectDept
/
ALTER TABLE Employee DROP CONSTRAINT fk_DeptNo
/

DROP TABLE Works_On 
/
DROP TABLE Project 
/
DROP TABLE Employee 
/
DROP TABLE Department 
/
