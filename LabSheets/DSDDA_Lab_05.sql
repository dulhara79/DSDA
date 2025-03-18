/**
* Type creation
*/
CREATE TYPE emp_t AS OBJECT (
    emp_id NUMBER,
    name VARCHAR2(50),
    email VARCHAR2(50),
    hire_date DATE,
    phoneno VARCHAR2(20),
    jobid VARCHAR2(20),
    salary NUMBER,
    commission NUMBER,
    managerid NUMBER,
    deptid NUMBER
)
/

CREATE TYPE cust_t AS OBJECT (
    id NUMBER,
    name VARCHAR2(50),
    age NUMBER,
    address VARCHAR2(100),
    salary NUMBER
)
/

CREATE TYPE course_t AS OBJECT (
    course_name   VARCHAR2(50),
    course_number NUMBER
)
/

CREATE TYPE student_courses_t AS OBJECT (
    enrollment_id   NUMBER,
    student_id      NUMBER,
    course_number   REF course_t,
    enrollment_date DATE
)
/


/**
* Table creation
*/
CREATE TABLE Employee OF emp_t (
  emp_id PRIMARY KEY
)
/

CREATE TABLE Customer of cust_t (
  id PRIMARY KEY
)
/

CREATE TABLE Courses OF course_t (
    PRIMARY KEY (course_name)
)
/

CREATE TABLE Student_courses OF student_courses_t (
    enrollment_id PRIMARY KEY,
    enrollment_date DEFAULT SYSDATE
)
/


/**
* Value insert
*/
-- Employee Table
INSERT INTO Employee VALUES (100, 'Stevan', 'SKING', TO_DATE('1987-06-20', 'YYYY-MM-DD'), '515.123.1269', 'IT_PROG', 2400, 0, NULL, 90)
/
INSERT INTO Employee VALUES (101, 'Thivyan', 'LDEHAAN', TO_DATE('1988-08-25', 'YYYY-MM-DD'), '515.123.4569', 'IT_PROG', 5600, 0, 100, 90)
/
INSERT INTO Employee VALUES (102, 'Jenny', 'AHUNOLD', TO_DATE('1987-07-17', 'YYYY-MM-DD'), '515.123.3697', 'FI_ACCOUNT', 8900, 0, 100, 60)
/
INSERT INTO Employee VALUES (103, 'Alex', 'BERNST', TO_DATE('1987-01-30', 'YYYY-MM-DD'), '515.123.1124', 'PU_MAN', 7800, 0, 102, 60)
/
INSERT INTO Employee VALUES (104, 'Bravon', 'DAUSTIN', TO_DATE('1987-11-21', 'YYYY-MM-DD'), '515.123.9698', 'ST_CLERK', 4500, 0, 103, 100)
/
INSERT INTO Employee VALUES (105, 'John', 'JDOE', TO_DATE('1990-05-15', 'YYYY-MM-DD'), '515.123.1111', 'ST_CLERK', 3000, 0, 103, 50)
/
INSERT INTO Employee VALUES (106, 'Jane', 'JSMITH', TO_DATE('1995-03-22', 'YYYY-MM-DD'), '515.123.2222', 'FI_ACCOUNT', 5000, 0, 102, 50)
/
INSERT INTO Employee VALUES (107, 'Mike', 'MJONES', TO_DATE('2000-10-10', 'YYYY-MM-DD'), '515.123.3333', 'IT_PROG', 4000, 0, 101, 90)
/
INSERT INTO Employee VALUES (108, 'Sara', 'SWILL', TO_DATE('1998-12-05', 'YYYY-MM-DD'), '515.123.4444', 'PU_MAN', 6000, 0, 103, 60)
/
INSERT INTO Employee VALUES (109, 'Tom', 'TCRUISE', TO_DATE('1989-07-19', 'YYYY-MM-DD'), '515.123.5555', 'ST_CLERK', 3500, 0, 104, 100)
/

-- Customer Table
INSERT INTO Customer VALUES (1, 'Louvis', 23, 'Italy', 50000)
/
INSERT INTO Customer VALUES (2, 'Alvin', 36, 'Osbo', 65000)
/
INSERT INTO Customer VALUES (3, 'Teri', 55, 'Ohio', 66000)
/
INSERT INTO Customer VALUES (4, 'Hardic', 42, 'Mumbai', 55000)
/
INSERT INTO Customer VALUES (5, 'Koamal', 47, 'Delhi', 96000)
/
INSERT INTO Customer VALUES (6, 'Charles', 36, 'MP', 23000)
/
INSERT INTO Customer VALUES (7, 'Alice', 28, 'Paris', 70000)
/
INSERT INTO Customer VALUES (8, 'Bob', 40, 'London', 80000)
/
INSERT INTO Customer VALUES (9, 'Charlie', 30, 'Berlin', 45000)
/
INSERT INTO Customer VALUES (10, 'Diana', 35, 'Madrid', 62000)
/

-- Courses Table
INSERT INTO Courses VALUES ('Math', 1001)
/
INSERT INTO Courses VALUES ('Science', 2010)
/
INSERT INTO Courses VALUES ('History', 3100)
/
INSERT INTO Courses VALUES ('English', 4050)
/
INSERT INTO Courses VALUES ('Physics', 5060)
/
INSERT INTO Courses VALUES ('Chemistry', 6500)
/
INSERT INTO Courses VALUES ('Biology', 7002)
/
INSERT INTO Courses VALUES ('Art', 8080)
/
INSERT INTO Courses VALUES ('Music', 9023)
/
INSERT INTO Courses VALUES ('Economics', 1020)
/

-- Student_couses Table
INSERT INTO Student_courses VALUES (1000,
    101,
    (SELECT REF(c) FROM Courses c WHERE c.course_name = 'Math'),
    SYSDATE
)
/

INSERT INTO Student_courses VALUES (1001,
    101,
    (SELECT REF(c) FROM Courses c WHERE c.course_name = 'Science'),
    SYSDATE
)
/

INSERT INTO Student_courses VALUES (1002,
    101,
    (SELECT REF(c) FROM Courses c WHERE c.course_name = 'History'),
    SYSDATE
)
/

INSERT INTO Student_courses VALUES (1003,
    102,
    (SELECT REF(c) FROM Courses c WHERE c.course_name = 'English'),
    SYSDATE
)
/

INSERT INTO Student_courses VALUES (1004,
    102,
    (SELECT REF(c) FROM Courses c WHERE c.course_name = 'Physics'),
    SYSDATE
)
/

INSERT INTO Student_courses VALUES (1005,
    103,
    (SELECT REF(c) FROM Courses c WHERE c.course_name = 'Chemistry'),
    SYSDATE
)
/

INSERT INTO Student_courses VALUES (1006,
    103,
    (SELECT REF(c) FROM Courses c WHERE c.course_name = 'Biology'),
    SYSDATE
)
/

INSERT INTO Student_courses VALUES (1007,
    104,
    (SELECT REF(c) FROM Courses c WHERE c.course_name = 'Art'),
    SYSDATE
)
/

INSERT INTO Student_courses VALUES (1008,
    104,
    (SELECT REF(c) FROM Courses c WHERE c.course_name = 'Music'),
    SYSDATE
)
/

INSERT INTO Student_courses VALUES (1009,
    105,
    (SELECT REF(c) FROM Courses c WHERE c.course_name = 'Economics'),
    SYSDATE
)
/

-- Exercise 01
-- Write a procedure called UpdateCourse. It has one parameter called name_in. The procedure will lookup the course_number based on course name. If it does not find a match, it defaults the course number to 10000. It then inserts a new record into the student_courses table. 
-- Drop the procedure UpdateCourse 
CREATE PROCEDURE UpdateCourse(name_in IN VARCHAR2) IS
    course_num NUMBER;
BEGIN
    SELECT c.course_number INTO course_num
    FROM Courses c
    WHERE c.course_name = name_in;
EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        INSERT INTO Courses VALUES (name_in, 10000);
END UpdateCourse;
/





-- Drop tables
DROP TABLE Student_courses
/
DROP TABLE Courses
/
DROP TABLE Customer
/
DROP TABLE Employee
/

-- Drop types
DROP TYPE student_courses_t
/
DROP TYPE course_t
/
DROP TYPE cust_t
/
DROP TYPE emp_t
/
