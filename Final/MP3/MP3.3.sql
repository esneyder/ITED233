DECLARE
  v_emp_last_name employees.last_name%type := &Employee_Last_Name;
  v_salary employees.salary%type;
  v_year NUMBER;
  conditions_met EXCEPTION;
BEGIN
  /*
  to get the hire date and salary of the
  employee being queried
  */
  SELECT salary, (TO_CHAR(hire_date, 'YYYY'))
  INTO v_salary, v_year 
  FROM employees
  WHERE last_name = v_emp_last_name;
  
  /*
  to get the number of years the employee
  has worked for the company
  v_year := current_year - employee_hire_date_year
  */
  v_year := (TO_CHAR(SYSDATE, 'YYYY')) - v_year;
  
  /*
  RAISE the exception when conditions
    year > 5 AND salary < 3500
  are MET
  */
  IF v_year > 5 AND v_salary < 3500
  THEN
    RAISE conditions_met;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Not due for a raise.');
  END IF;
  
EXCEPTION
  WHEN conditions_met THEN
    INSERT INTO analysis
    VALUES(v_emp_last_name, v_year, v_salary);
    DBMS_OUTPUT.PUT_LINE('Due for a raise.');
    DBMS_OUTPUT.PUT_LINE('Inserted into ANALYSIS table.');
    COMMIT;
END;