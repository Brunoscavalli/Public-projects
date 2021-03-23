/******************************
Links:
PL/SQL course udemy course: https://www.udemy.com/course/plsql-beginner-to-advanced-become-a-perfect-plsql-developer/
Notes on: https://www.notion.so/PL-SQL-5bee0d78c37a4e689723d8d25bf66778
Oracle Live SQL: https://livesql.oracle.com/

******************************/


/******************************
	    Section 3
******************************/

-- PL/SQL Outputs

SET SERVEROUTPUT ON;
BEGIN
DBMS_OUTPUT.PUT_LINE('Hello world!');
    BEGIN
    DBMS_OUTPUT.PUT_LINE('PL/SQL');
    END;
END;


/******************************
	    Section 4
******************************/

-- Declaring variables p1

DECLARE
    v_text VARCHAR2(50) NOT NULL DEFAULT 'Hello world!';
    v_number NUMBER(10,6) NOT NULL :=50.42;
BEGIN
    v_text := 'PL/SQL'||(' course');
    DBMS_OUTPUT.PUT_LINE(v_text || ' beginner to advanced');
    DBMS_OUTPUT.PUT_LINE(v_number);
END;


--Declaring variables p2

DECLARE
    v_number2 BINARY_FLOAT NOT NULL :=50.42;
    v_date1 DATE NOT NULL :=SYSDATE;
    v_date2 DATE NOT NULL := '31-DEC-91';
    v_timestamp1 TIMESTAMP NOT NULL := SYSTIMESTAMP;
    v_timestamp2 TIMESTAMP(0) NOT NULL := '31-DEC-91 12:34:56';
    v_timestamp_tmz1 TIMESTAMP(0) WITH TIME ZONE NOT NULL := SYSTIMESTAMP;
    v_timestamp_tmz2 TIMESTAMP(0) WITH TIME ZONE NOT NULL := '31-DEC-91 12:34:56 pm +03:00';
    v_timestamp_ltmz1 TIMESTAMP(0) WITH LOCAL TIME ZONE NOT NULL := SYSTIMESTAMP;
    v_day_to_second1 INTERVAL DAY(2) TO SECOND(5) := '12 13:56:01.234';
    v_year_to_month1 INTERVAL YEAR(2) TO MONTH := '12-05';
    -- v_boolean1 BOOLEAN := TRUE;

BEGIN
    DBMS_OUTPUT.PUT_LINE('BINARY_FLOAT: ' || v_number2);
    DBMS_OUTPUT.PUT_LINE('SYSDATE: ' || v_date1 || '. DATE: ' || v_date2);
    DBMS_OUTPUT.PUT_LINE('SYSTIMESTAMP: ' || v_timestamp1 || '. TIMESTAMP: ' || v_timestamp2);
    DBMS_OUTPUT.PUT_LINE('SYSTIMESTAMP_TMZ: ' || v_timestamp_tmz1 || '. TIMESTAMP: ' || v_timestamp_tmz2);
    DBMS_OUTPUT.PUT_LINE('SYSTIMESTAMP_LTMZ: ' || v_timestamp_ltmz1);
    DBMS_OUTPUT.PUT_LINE('INTERVAL DAY TO SECOND: ' || v_day_to_second1);
    DBMS_OUTPUT.PUT_LINE('INTERVAL YEAR TO MONTH: ' || v_year_to_month1);
    -- DBMS_OUTPUT.PUT_LINE(SYS.DIUTIL.BOOL_TO_INT(v_boolean1));
END;


-- 
