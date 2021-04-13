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

-- %TYPE

DESC hr.employees;

DECLARE
    v_type1 hr.employees.job_id%type;
    v_type2 v_type1%type;
    v_type3 hr.employees.job_id%type;
BEGIN
    v_type1 := 'IT_PROG';
    v_type2 := 'SA_MAN';
    v_type3 := NULL;
    DBMS_OUTPUT.PUT_LINE(v_type1);
    DBMS_OUTPUT.PUT_LINE(v_type2);
    DBMS_OUTPUT.PUT_LINE(v_type3 || '...');
END;


-- Variable scope

DECLARE
    v_outer1 varchar2(50) := 'Outside nested statement';
BEGIN

    DECLARE
        v_inner1 varchar2(50) := 'Inside nested statement';
    BEGIN
        DBMS_OUTPUT.PUT_LINE(v_inner1);
    END;

    DBMS_OUTPUT.PUT_LINE(v_outer1);
    -- this line will cause a error: DBMS_OUTPUT.PUT_LINE('v_inner1');
END;


-- Bind variables
	--  Oracle live doesn't suport the VARIABLE statement...

VARIABLE var_text VARCHAR2(50);
VARIABLE var_number NUMBER;
VARIABLE var_consulta NUMBER;

DECLARE
	v_text VARCHAR2(50	);
BEGIN
	:var_text := 'Testando';
	:var_number := 42;
	v_text := :var_text;
	dbms_output.put_line(v_text);
	dbms_output.put_line(:var_text);
	:var_consulta := 100;
END;
SELECT * FROM hr.employees WHERE employee_id = :var_consulta;



/******************************
        Section 5 - Control Structures         
******************************/

DECLARE
	v_inner NUMBER :=1;

BEGIN
    <<outer_l>>
	FOR v_outer IN 1..5 LOOP
		DBMS_OUTPUT.PUT_LINE('Outer loop: ' || v_outer);
		v_inner := 1; --reset the inner counter
		<<inner_l>>
		WHILE v_inner * v_outer <= 15 LOOP
			DBMS_OUTPUT.PUT_LINE('  Inner loop: ' || v_inner);
			v_inner := 1 + v_inner;
			exit inner_l when v_inner >10;
		END LOOP;
	END LOOP;
END;


-- GOTO statement

DECLARE
	v_text VARCHAR2(255) := 'I Wrote this message';
	v_count NUMBER :=1;

BEGIN
	<<need_to_write>>
	DBMS_OUTPUT.PUT_LINE(v_text);
	IF v_count < 5 THEN
		v_text := v_text || ', again';
		v_count := v_count + 1;
		GOTO need_to_write;
	ELSE
		DBMS_OUTPUT.PUT_LINE('That was silly');
	END IF;
END;



/******************************
        Section 6 - Using SQL in PL/SQL
******************************/


CREATE TABLE
	copy_emp1 
AS (
			SELECT
			*
		FROM
			hr.employees
  	 )
;

-- DML in PL/SQL

CREATE TABLE 
	employee_copy 
AS (
	SELECT 
		* 
	FROM 
		hr.employees
	)
;

BEGIN
    FOR i IN 207..216 LOOP
        INSERT INTO 
		employee_copy 
			(
            		employee_id,
			first_name, 
			last_name, 
			email, 
			hire_date, 
			job_id, 
			salary
			)
	VALUES
        	(
		i,
		'employee#'||i,
		'temp_emp', 
		'abc@def.com', 
		sysdate, 
		'IT_PROG', 
		1000
		)
		;
    END LOOP;
END;

-- Sequences

CREATE SEQUENCE 
    employee_id_seq
START WITH
    217
INCREMENT BY 
    1
;

BEGIN
    FOR i IN 1..12 LOOP
        INSERT INTO 
            employee_copy
                (
                employee_id,
                first_name,
                last_name,
                email, 
                hire_date, 
                job_id, 
                salary
            )
        VALUES
            (
            employee_id_seq.nextval, 
            'employee#'||employee_id_seq.nextval, 
            'temp_emp', 
            'abc@def.com', 
            sysdate, 
            'IT_PROG', 
            1000
            )
        ;
    END LOOP;
END;

SELECT 
    *
FROM
    employee_copy 
ORDER BY 
    employee_id DESC
;

DECLARE
    v_seq_num NUMBER;
    v_curr NUMBER;
BEGIN
    SELECT 
        employee_id_seq.nextval 
    INTO 
        v_seq_num 
    FROM
        dual
    ;
    v_curr := employee_id_seq.currval;
    DBMS_OUTPUT.PUT_LINE(v_seq_num);
    DBMS_OUTPUT.PUT_LINE(v_curr);
END
;
 

