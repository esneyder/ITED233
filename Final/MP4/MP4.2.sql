CREATE OR REPLACE PROCEDURE DEL_JOB(job_id_p IN JOBS.job_id%TYPE)
IS 
BEGIN 
  DELETE
  FROM JOBS
  WHERE job_id = job_id_p;
  DBMS_OUTPUT.PUT_LINE('Delete Success : '|| job_id_p || ' was successfully deleted from the Database.');
END;
/
DECLARE
  job_id_param JOBS.job_id%TYPE := '&Enter_Job_ID';
  num_rows_return NUMBER;
  job_id_doesnt_exist EXCEPTION;
  choice VARCHAR2(8);
BEGIN
  SELECT COUNT(*)
  INTO num_rows_return
  FROM JOBS
  WHERE job_id = job_id_param;
  
  IF num_rows_return = 0 THEN
    RAISE job_id_doesnt_exist;
  ELSE
    choice := '&Confirm_Deletion_Y_or_N';
    IF choice = 'Y' OR choice = 'y' THEN
      DEL_JOB(job_id_param);
    ELSE
      DBMS_OUTPUT.PUT_LINE('Delete aborted.');
    END IF;
  END IF;

EXCEPTION
  WHEN job_id_doesnt_exist THEN
    DBMS_OUTPUT.PUT_LINE('Unknown Job ID Exception : Entered Job ID does not exist in the Database. Delete aborted.');
END;
/
SELECT *
FROM JOBS;