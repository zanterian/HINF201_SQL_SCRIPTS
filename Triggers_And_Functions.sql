/* Procedure to be used to add a time to the table Time - this makes it easier*/
CREATE OR REPLACE PROCEDURE Insert_Into_Time (date_in IN DATE) IS
BEGIN
	INSERT INTO TIME (t) VALUES (date_in);
END;
/
-- Boolean-like function -- 1 for True, 0 for false
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
/
-- Boolean-like function -- 1 for True, 0 for false
CREATE OR REPLACE FUNCTION Check_If_Visit_Possible (date_in IN DATE, doctor_id IN CHAR(4)) RETURN NUMBER
IS
	return_value NUMBER;

	DATE docto_employed 
AS
	SELECT d_employed_date
	FROM Doctor
	WHERE Doctor.d_id = doctor_id;

BEGIN
	
	IF doctor_employed < date_in  THEN
		RETURN 1;
	END IF;
	RETURN 0;
END;
/
	
/*****************************************************************************/
/************************** Doctor Table Triggers ****************************/
/*****************************************************************************/
-- Make sure that the time Primary Key exists
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
/*****************************************************************************/
/************************** Patient_Additional Table Triggers  ***************/
/*****************************************************************************/
-- Make sure the time Primary Key exists
CREATE OR REPLACE TRIGGER Pat_Addi_Time_Trigger
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
/*****************************************************************************/
/************************** Patient_Visit Table Triggers *********************/
/*****************************************************************************/
-- 
CREATE OR REPLACE TRIGGER Patient_Visit_Trigger
BEFORE INSERT ON Patient_Visit
FOR EACH ROW
DECLARE
	date_check NUMBER;
	appointment_check NUMBER;
BEGIN
	date_check := Check_Time_Table(:new.pv_t);
	appointment_check := Check_If_Visit_Possible (:new.pv_t,:new.pv_d_id);
	IF appointment_check = 0 THEN 
		raise_application_error(-20001,'Appointment Cannot Be Before Doctor Employed Date');
	END IF;
	IF date_check = 0 THEN
		Insert_Into_Time(:new.pv_t);
	END IF;
END;
/
