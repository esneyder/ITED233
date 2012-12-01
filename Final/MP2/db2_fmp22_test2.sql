DECLARE

  /*
    both v_hire_date_from and v_hire_date_to accepts DATE input but it
    must be enclosed in quotes e.g. '02/01/2008'
  */
  
  v_hire_date_from employees.hire_date%TYPE := &Hire_Date_From;
  v_hire_date_to employees.hire_date%TYPE := &Hire_Date_To;
  
  CURSOR v_emp_dept_cursor(p_hire_date_from v_hire_date_from%TYPE, p_hire_date_to v_hire_date_to%TYPE) IS
    SELECT e.hire_date, e.employee_id, e.last_name, e.first_name, e.department_id, d.department_name
    FROM employees e, departments d
    WHERE e.hire_date >= p_hire_date_from AND e.hire_date <= p_hire_date_to AND e.department_id = d.department_id;
  
BEGIN
  FOR cur_ptr IN v_emp_dept_cursor(v_hire_date_from, v_hire_date_to) LOOP
    DBMS_OUTPUT.PUT_LINE( 'Employee ID : ' || cur_ptr.employee_id ||
                          ' --- Last Name : ' || cur_ptr.last_name ||
                          ' --- First Name : ' || cur_ptr.first_name ||
                          ' --- Hire Date : ' || cur_ptr.hire_date ||
                          ' --- Department ID : ' || cur_ptr.department_id ||
                          ' --- Department Name : ' || cur_ptr.department_name);
  END LOOP;
END;