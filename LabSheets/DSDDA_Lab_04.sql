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