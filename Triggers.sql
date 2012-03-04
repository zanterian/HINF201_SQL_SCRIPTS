/* Trigger Creation */
CREATE OR REPLACE TRIGGER Doctor_Date_Check
BEFORE INSERT ON Doctor
DECLARE 
	l_count NUMBER;
BEGIN
	SELECT count(*)
	INTO l_count
	FROM Time
	WHERE TIME.t = :new.d_employed_date
	IF l_count = 0 THEN
		INSERT INTO TIME (t) VALUES (:new.d_employed_date);
	END IF
END;
