DECLARE
  v_hire_date_from employees.hire_date%TYPE := &Hire_Date_From;
  v_hire_date_to employees.hire_date%TYPE := &Hire_Date_To;
  
  v_hire_date employees.hire_date%TYPE;
  v_employee_id employees.employee_id%TYPE;
  v_last_name employees.last_name%TYPE;
  v_first_name employees.first_name%TYPE;
  v_department_id employees.department_id%TYPE;
  v_department_name departments.department_name%TYPE;
  
  v_record_counter NUMBER;
  
  CURSOR v_emp_dept_cursor(p_hire_date_from v_hire_date_from%TYPE, p_hire_date_to v_hire_date_to%TYPE) IS
    SELECT e.hire_date, e.employee_id, e.last_name, e.first_name, e.department_id, d.department_name
    FROM employees e, departments d
    WHERE e.hire_date >= p_hire_date_from AND e.hire_date <= p_hire_date_to AND e.department_id = d.department_id;
  
  hire_date_error EXCEPTION;
  no_record_retrieved EXCEPTION;
  other_error EXCEPTION;
  
BEGIN

  SELECT COUNT(*) INTO v_record_counter FROM employees WHERE hire_date >= v_hire_date_from AND hire_date <= v_hire_date_to;

  IF v_hire_date_to < v_hire_date_from THEN
    RAISE hire_date_error;
  ELSIF v_record_counter = 0 THEN
    RAISE no_record_retrieved;
  ELSIF v_record_counter > 0 THEN
    OPEN v_emp_dept_cursor(v_hire_date_from, v_hire_date_to);
    DBMS_OUTPUT.PUT_LINE('RECORD/S THAT HAVE MET THE CRITERIA :');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------');
  LOOP
    FETCH v_emp_dept_cursor INTO v_hire_date, v_employee_id, v_last_name, v_first_name, v_department_id, v_department_name;
    IF v_emp_dept_cursor%NOTFOUND THEN
      DBMS_OUTPUT.PUT_LINE('A total of ' || v_emp_dept_cursor%ROWCOUNT || ' record/s were listed.');
      EXIT;
    ELSE
      DBMS_OUTPUT.PUT_LINE('Employee ID : ' || v_employee_id);
      DBMS_OUTPUT.PUT_LINE('Last Name : ' || v_last_name);
      DBMS_OUTPUT.PUT_LINE('First Name : ' || v_first_name);
      DBMS_OUTPUT.PUT_LINE('Hire Date : ' || v_hire_date);
      DBMS_OUTPUT.PUT_LINE('Department ID : ' || v_department_id);
      DBMS_OUTPUT.PUT_LINE('Department Name : ' || v_department_name);
      DBMS_OUTPUT.PUT_LINE('---------------------------------------');
    END IF;
  END LOOP;
  ELSE
    RAISE other_error;
  END IF;
  
EXCEPTION
  WHEN hire_date_error THEN
    DBMS_OUTPUT.PUT_LINE('Hire Date Exception : Entered hire_date_to is less than the entered hire_date_from(or vice versa).');
  WHEN no_record_retrieved THEN
    DBMS_OUTPUT.PUT_LINE('No Record Retrieved Exception : There were no records retrieved based on the entered hire_date values.');
  WHEN other_error THEN
    DBMS_OUTPUT.PUT_LINE('Other Exception : Something went terribly wrong, sorry.');
END;