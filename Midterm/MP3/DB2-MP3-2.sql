DECLARE 
  v_max_deptno NUMBER(4); 
  v_dept_name departments.department_name%TYPE := 'Education';
  v_dept_id NUMBER(4); 
BEGIN
  SELECT MAX(department_id)
  INTO v_max_deptno
  FROM departments;
  v_dept_id := v_max_deptno + 10;
  INSERT INTO departments
  VALUES(v_dept_id, v_dept_name, NULL, NULL);
  dbms_output.put_line('The maximum department ID is : ' || v_max_deptno);
  dbms_output.put_line('SQL%ROWCOUNT gives ' || SQL%ROWCOUNT);
END; 
/