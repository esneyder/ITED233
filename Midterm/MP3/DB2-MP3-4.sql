DECLARE 
  v_empno emp_temp.employee_id%TYPE := 176;
  v_asterisk emp_temp.stars%TYPE := NULL;
  sal emp_temp.salary%TYPE;
BEGIN
  FOR employees IN (SELECT * FROM emp_temp)
  LOOP
    sal := ROUND(employees.salary, -3);
    v_asterisk := NULL;
    WHILE sal > 0
      LOOP
        v_asterisk := v_asterisk || '*';
        sal := sal - 1000;
      END LOOP;
    UPDATE emp_temp
    SET stars = v_asterisk
    WHERE employee_id = employees.employee_id;
  END LOOP;
END; 
/
SELECT employee_id, salary, stars
FROM emp_temp;