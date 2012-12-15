CREATE OR REPLACE PROCEDURE UPD_JOB(
  job_id_p IN JOBS.job_id%TYPE,
  new_title_p IN JOBS.job_title%TYPE 
) IS 
BEGIN 
  UPDATE JOBS
  SET job_title = new_title_p
  WHERE job_id = job_id_p;
  DBMS_OUTPUT.PUT_LINE('Update Success : '|| job_id_p || ' now has the job_title ' ||  new_title_p  || '.');
END;
/
DECLARE
  job_id_param JOBS.job_id%TYPE := '&Enter_Job_ID';
  new_title_param JOBS.job_title%TYPE;
  num_rows_return NUMBER;
  job_id_doesnt_exist EXCEPTION;
BEGIN
  SELECT COUNT(*)
  INTO num_rows_return
  FROM JOBS
  WHERE job_id = job_id_param;
  
  IF num_rows_return = 0 THEN
    RAISE job_id_doesnt_exist;
  ELSE
    new_title_param := '&Enter_New_Job_Title';
    UPD_JOB(job_id_param, new_title_param);
  END IF;

EXCEPTION
  WHEN job_id_doesnt_exist THEN
    DBMS_OUTPUT.PUT_LINE('Unknown Job ID Exception : Entered Job ID does not exist in the Database.');
END;
/
SELECT *
FROM JOBS;