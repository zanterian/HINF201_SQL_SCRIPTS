/* Procedure to be used to add a time to the table Time - this makes it easier*/
CREATE OR REPLACE PROCEDURE Insert_Into_Time (date_in IN DATE) IS
BEGIN
	INSERT INTO TIME (t) VALUES (date_in);
END;
/
CREATE OR REPLACE FUNCTION Check_Time_Table (date_in IN DATE) RETURN NUMBER 
IS
	count_t NUMBER;
BEGIN
	SELECT count(*)
	INTO count_t
	FROM Time
	WHERE Time.t = date_in;
	RETURN count_t;
END;
/********************************************************************/
/* Doctor Table Trigger */
CREATE OR REPLACE TRIGGER Doctor_Time_Trigger
BEFORE INSERT ON Doctor
FOR EACH ROW
DECLARE
	date_check NUMBER;
BEGIN
	date_check := Check_Time_Table(:new.d_employed_date);
	IF date_check = 0 THEN
		Insert_Into_Time(:new.d_employed_date);	
	END IF;

END;
/

/* Patient BD Trigger  */
CREATE OR REPLACE TRIGGER Patient_Additional_Time_Trigger
BEFORE INSERT ON Patient_Additional
FOR EACH ROW
DECLARE 
	date_check NUMBER;
BEGIN
	date_check := Check_Time_Table(:new.pa_bd);
	IF date_check = 0 THENN
		Insert_Into_Time(:new.pa_bd);
	END IF;
END;
/
/* Patient Visits */
CREATE OR REPLACE TRIGGER Patient_Visit_Trigger
BEFORE INSERT ON Patient_Visit
FOR EACH ROW
DECLARE
	date_check NUMBER;
BEGIN
	date_check := Check_Time_Table(:new.pv_t);
	IF date_check = 0 THEN
		Insert_Into_Time(:new.d_employed_date);
	END IF;
END;
/
