DECLARE 
  v_max_deptno number(4); 
BEGIN
  SELECT MAX(DEPARTMENT_ID)
  INTO v_max_deptno
  FROM DEPARTMENTS;
  dbms_output.put_line('The maximum department ID is : ' || v_max_deptno);
END; 
/