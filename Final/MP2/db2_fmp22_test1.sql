DECLARE

  /*
    v_dept_id accepts standard numeric input like 30, 50, 100
    v_hire_date accepts date input but must be enclosed in quotes e.g. '02/01/2008'
  */
  v_dept_id employees.department_id%TYPE := &Department_ID;
  v_hire_date employees.hire_date%TYPE := &Hire_Date;
  
  CURSOR v_emp_dept_cursor(p_dept_id v_dept_id%TYPE, p_hire_date v_hire_date%TYPE) IS
    SELECT e.hire_date, e.employee_id, e.last_name, e.first_name, e.department_id, d.department_name
    FROM employees e, departments d
    WHERE e.hire_date <= p_hire_date AND e.department_id = p_dept_id AND d.department_id = p_dept_id;
  
BEGIN
  FOR cur_ptr IN v_emp_dept_cursor(v_dept_id, v_hire_date) LOOP
    DBMS_OUTPUT.PUT_LINE( 'Employee ID : ' || cur_ptr.employee_id ||
                          ' --- Last Name : ' || cur_ptr.last_name ||
                          ' --- First Name : ' || cur_ptr.first_name ||
                          ' --- Hire Date : ' || cur_ptr.hire_date ||
                          ' --- Department ID : ' || cur_ptr.department_id ||
                          ' --- Department Name : ' || cur_ptr.department_name);
  END LOOP;
END;