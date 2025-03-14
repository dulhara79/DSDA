-- Modify Company table and add Purchase table
CREATE TABLE Company (
    cid NUMBER PRIMARY KEY,
    cname VARCHAR2(30) UNIQUE,
    stockPrice NUMBER
)
/

CREATE TABLE Purchase (
    pid NUMBER PRIMARY KEY,
    cid NUMBER,
    clientName VARCHAR2(50),
    purchaseDate DATE,
    quantity NUMBER,
    FOREIGN KEY (cid) REFERENCES Company(cid)
)
/

-- Insert data into Company table
INSERT INTO Company (cid, cname, stockPrice) VALUES (1, 'IBM', 72)
/
INSERT INTO Company (cid, cname, stockPrice) VALUES (2, 'Microsoft', 150)
/
INSERT INTO Company (cid, cname, stockPrice) VALUES (3, 'Apple', 170)
/
INSERT INTO Company (cid, cname, stockPrice) VALUES (4, 'Google', 135)
/
INSERT INTO Company (cid, cname, stockPrice) VALUES (5, 'Amazon', 145)
/
INSERT INTO Company (cid, cname, stockPrice) VALUES (6, 'Tesla', 210)
/
INSERT INTO Company (cid, cname, stockPrice) VALUES (7, 'Facebook', 110)
/
INSERT INTO Company (cid, cname, stockPrice) VALUES (8, 'Intel', 50)
/
INSERT INTO Company (cid, cname, stockPrice) VALUES (9, 'AMD', 90)
/
INSERT INTO Company (cid, cname, stockPrice) VALUES (10, 'NVIDIA', 230)
/

-- Insert data into Purchase table
INSERT INTO Purchase (pid, cid, clientName, purchaseDate, quantity) VALUES (1, 1, 'Alice', TO_DATE('1999-06-15', 'YYYY-MM-DD'), 200)
/
INSERT INTO Purchase (pid, cid, clientName, purchaseDate, quantity) VALUES (2, 2, 'Bob', TO_DATE('2001-12-10', 'YYYY-MM-DD'), 150)
/
INSERT INTO Purchase (pid, cid, clientName, purchaseDate, quantity) VALUES (3, 3, 'Charlie', TO_DATE('2003-05-21', 'YYYY-MM-DD'), 300)
/
INSERT INTO Purchase (pid, cid, clientName, purchaseDate, quantity) VALUES (4, 4, 'David', TO_DATE('1998-07-30', 'YYYY-MM-DD'), 250)
/
INSERT INTO Purchase (pid, cid, clientName, purchaseDate, quantity) VALUES (5, 5, 'Eve', TO_DATE('2000-11-11', 'YYYY-MM-DD'), 180)
/
INSERT INTO Purchase (pid, cid, clientName, purchaseDate, quantity) VALUES (6, 6, 'Frank', TO_DATE('2002-08-19', 'YYYY-MM-DD'), 220)
/
INSERT INTO Purchase (pid, cid, clientName, purchaseDate, quantity) VALUES (7, 7, 'Grace', TO_DATE('2001-03-05', 'YYYY-MM-DD'), 160)
/
INSERT INTO Purchase (pid, cid, clientName, purchaseDate, quantity) VALUES (8, 8, 'Hank', TO_DATE('1997-09-09', 'YYYY-MM-DD'), 270)
/
INSERT INTO Purchase (pid, cid, clientName, purchaseDate, quantity) VALUES (9, 9, 'Ivy', TO_DATE('1996-04-18', 'YYYY-MM-DD'), 280)
/
INSERT INTO Purchase (pid, cid, clientName, purchaseDate, quantity) VALUES (10, 10, 'Jack', TO_DATE('2000-02-22', 'YYYY-MM-DD'), 190)
/

-- Check success fully inserted or not
SELECT * 
FROM Company c
/

SELECT *
FROM Purchase p
/

-- Exercise 01
-- Write a PL/SQL to get the current price of a stock belongs to company ‘IBM’. Store the company name (‘IBM’) in a variable.
DECLARE
    var_copany_name VARCHAR2(30) := 'IBM';
    var_stock_price NUMBER;
BEGIN
    SELECT c.stockPrice INTO var_stock_price
    FROM Company c
    WHERE c.cname = var_copany_name;

    DBMS_OUTPUT.PUT_LINE('Name of the company is: ' || var_copany_name);
END;
/

-- Exercise 02
-- Write a PL/SQL to display a message for a given stock of ‘IBM’ company according to the following criteria.
--     Current price < 45 - ‘Current price is very low !’
--     45<=Current price < 55 -  price is low !’
--     55<=Current price < 65 -  price is medium !’
--     65<=Current price < 75 -  price is medium high !’
--     75<=Current price - ‘Current price is high !’
-- Store the company name in a variable.
DECLARE
    var_copany_name VARCHAR2(30) := 'IBM';
    var_current_price NUMBER;
    var_statement VARCHAR2(100);
BEGIN
    SELECT c.stockPrice INTO var_current_price
    FROM Company c
    WHERE c.cname = var_copany_name;

    IF var_current_price < 45 THEN
        var_statement := 'Current price is very low !';
    ELSIF var_current_price < 55 THEN
        var_statement := 'Price is low !';
    ELSIF var_current_price < 65 THEN
        var_statement := 'Price is medium !';
    ELSIF var_current_price < 75 THEN
        var_statement := 'Price is medium high !';
    ELSIF var_current_price >= 75 THEN
        var_statement := 'Current price is high !';
    ELSE
        var_statement := 'Invalid price';
    END IF;

    DBMS_OUTPUT.PUT_LINE(var_statement);
END;
/

-- Exercise 03 
-- Write three PL/SQLs to draw the following shape. Use all three types of loops in each PL/SQL. 
    -- 9 9 9 9 9 9 9 9 9 
    -- 8 8 8 8 8 8 8 8 
    -- 7 7 7 7 7 7 7 
    -- 6 6 6 6 6 6 
    -- 5 5 5 5 5 
    -- 4 4 4 4 
    -- 3 3 3 
    -- 2 2 
    -- 1 

-- FOR LOOP WITH LABLES
BEGIN
    <<i_loop>> FOR i in REVERSE 1..9 LOOP
        <<j_loop>> FOR j in 1..9 LOOP
            DBMS_OUTPUT.PUT(i || ' ');
            EXIT j_loop WHEN j = i;
        END LOOP;
        DBMS_OUTPUT.NEW_LINE;
    END LOOP;
END;
/

-- WHILE LOOP
DECLARE
    i NUMBER := 9;
    j NUMBER;
BEGIN
    WHILE i >= 1  LOOP
        j := 1;
        WHILE j <= i LOOP
            DBMS_OUTPUT.PUT(i || ' ');
            j := j + 1;
        END LOOP;
        DBMS_OUTPUT.NEW_LINE;
        i := i - 1;
    END LOOP;
END;
/

-- SIMPLE LOOP
DECLARE
    i NUMBER := 9;
    j NUMBER;
BEGIN
    LOOP
        j := 1;
        LOOP
            DBMS_OUTPUT.PUT(i || ' ');
            j := j + 1;
            EXIT WHEN j > i;
        END LOOP;
        DBMS_OUTPUT.NEW_LINE;
        i := i - 1;
        EXIT WHEN i = 0;
    END LOOP;
END;
/

-- Exercise 04 
-- The companies have decided to offer a bonus to the loyal clients who have purchased stocks of their company. A client who has purchased stocks before 1st January 2002 gets an additional 50 stocks as bonus. Those who have purchased stocks before 1st January 2001 get 100 stocks and for the purchases done before 1st January 2000 will be given 150 stocks as bonus. 
-- Write a PL/SQL block to update the purchase table. Increase the quantities as given above.  
-- You must use a cursor for loop for this.
DECLARE
    CURSOR stock_cur IS
        SELECT c.cname, p.purchaseDate, p.quantity, p.cid
        FROM Company c, Purchase p
        WHERE c.cid = p.cid;
    stock_rec stock_cur%ROWTYPE;
    
    var_stock_update_qty NUMBER;
    var_quantity_string VARCHAR2(200);
BEGIN
    FOR stock_rec in stock_cur LOOP
        var_quantity_string := 'Company name: ' || stock_rec.cname || ' || Stock purchase date: ' || stock_rec.purchaseDate || ' || Quantity: ' || stock_rec.quantity;

        IF stock_rec.purchaseDate < TO_DATE('2000-01-01', 'YYYY-MM-DD') THEN
            var_stock_update_qty := 150;
        ELSIF stock_rec.purchaseDate < TO_DATE('2001-01-01', 'YYYY-MM-DD') THEN
            var_stock_update_qty := 100;
        ELSIF stock_rec.purchaseDate < TO_DATE('2002-01-01', 'YYYY-MM-DD') THEN
            var_stock_update_qty := 50;
        ELSE
            var_stock_update_qty := 0;
        END IF;

        UPDATE Purchase p
        SET p.quantity = p.quantity + var_stock_update_qty
        WHERE p.cid = stock_rec.cid AND p.purchaseDate = stock_rec.purchaseDate;

        DBMS_OUTPUT.PUT_LINE(var_quantity_string || ' || Updated Quantity: ' || (stock_rec.quantity + var_stock_update_qty));
    END LOOP;
END;
/

-- Exercise 05 
-- Write a PL/SQL block with an explicit cursor to perform the same set of actions mentioned in exercise 04. 
-- You must use an explicit cursor and a while loop. 
DECLARE
    CURSOR stock_cur IS
        SELECT c.cname, p.purchaseDate, p.quantity, p.cid
        FROM Company c, Purchase p
        WHERE c.cid = p.cid;

    stock_rec stock_cur%ROWTYPE;

    var_stock_update_qty NUMBER;
    var_quantity_string VARCHAR2(200);
BEGIN
    OPEN stock_cur;

    FETCH stock_cur INTO stock_rec;

    WHILE stock_cur%FOUND LOOP
        var_quantity_string := 'Company name: ' || stock_rec.cname || ' || Stock purchase date: ' || stock_rec.purchaseDate || ' || Quantity: ' || stock_rec.quantity;

        IF stock_rec.purchaseDate < TO_DATE('2000-01-01', 'YYYY-MM-DD') THEN
            var_stock_update_qty := 150;
        ELSIF stock_rec.purchaseDate < TO_DATE('2001-01-01', 'YYYY-MM-DD') THEN
            var_stock_update_qty := 100;
        ELSIF stock_rec.purchaseDate < TO_DATE('2002-01-01', 'YYYY-MM-DD') THEN
            var_stock_update_qty := 50;
        ELSE
            var_stock_update_qty := 0;
        END IF;

        UPDATE Purchase p
        SET p.quantity = p.quantity + var_stock_update_qty
        WHERE p.cid = stock_rec.cid AND p.purchaseDate = stock_rec.purchaseDate;

        DBMS_OUTPUT.PUT_LINE(var_quantity_string || ' || Updated Quantity: ' || (stock_rec.quantity + var_stock_update_qty));

        FETCH stock_cur INTO stock_rec;
    END LOOP;

    CLOSE stock_cur;
END;
/

/**
* Drop constraints and tables
*/
ALTER TABLE Purchase DROP CONSTRAINT Purchase_cid_fkey;
DROP TABLE Purchase;
DROP TABLE Company;