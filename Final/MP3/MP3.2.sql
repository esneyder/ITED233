DECLARE
  i_manager_id EMPLOYEES.manager_id%TYPE := &Manager_ID;
  v_rec_count NUMBER;
  
  v_employee_id EMPLOYEES.employee_id%TYPE;
  v_employee_name VARCHAR(64);
  v_department_name DEPARTMENTS.department_name%TYPE;
  v_manager_id EMPLOYEES.manager_id%TYPE;
  v_manager_name VARCHAR(64);
  
  CURSOR c_employees(p_manager_id EMPLOYEES.manager_id%TYPE) IS
    SELECT e.employee_id, (e.first_name || ' ' || e.last_name) AS employee_name, d.department_name, e.manager_id, 
    ( SELECT (first_name || ' ' || last_name)
      FROM employees
      WHERE employee_id = p_manager_id ) manager_name
    FROM employees e, departments d
    WHERE e.department_id = d.department_id AND e.manager_id = p_manager_id;
    
  id_doesnt_exist EXCEPTION;
    
BEGIN
  /* Assign into v_rec_count the number of records with the manager_id input 
     v_rec_count = 0 means the entered manager ID does not exist */
  SELECT COUNT(*) INTO v_rec_count FROM employees WHERE manager_id = i_manager_id;
  IF v_rec_count = 0 THEN
    RAISE id_doesnt_exist;
  ELSE
    DBMS_OUTPUT.PUT_LINE('RECORD/S THAT HAVE MET THE CRITERIA :');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------');
    OPEN c_employees(i_manager_id);
    LOOP
      FETCH c_employees INTO v_employee_id, v_employee_name, v_department_name, v_manager_id, v_manager_name;
      EXIT WHEN c_employees%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('Employee ID : ' || v_employee_id);
      DBMS_OUTPUT.PUT_LINE('Employee Name : ' || v_employee_name);
      DBMS_OUTPUT.PUT_LINE('Department Name : ' || v_department_name);
      IF v_manager_id = NULL THEN
        DBMS_OUTPUT.PUT_LINE('Manager ID : Supervisor');
      ELSE
        DBMS_OUTPUT.PUT_LINE('Manager ID : ' || v_manager_id);
      END IF;
      DBMS_OUTPUT.PUT_LINE('Manager Name : ' || v_manager_name);
      DBMS_OUTPUT.PUT_LINE('---------------------------------------');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('A total of ' || c_employees%ROWCOUNT || ' record/s were listed.');
    CLOSE c_employees;
  END IF;

EXCEPTION
  WHEN id_doesnt_exist THEN
    DBMS_OUTPUT.PUT_LINE('Manager ID Exception : Record/s with Manager ID(' || i_manager_id || ') does not exist in the Database.');
END;