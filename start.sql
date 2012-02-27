/* People Involved */
------------------- DOCTOR --------------------------------
CREATE TABLE Doctor(
	  d_id			NUMBER(4)
	, d_name		VARCHAR2(100) NOT NULL
	
	, CONSTRAINT pk_d_id 
		PRIMARY KEY(d_id)
);
------------------- Patient -------------------------------
CREATE TABLE Patient(
	  p_id 			NUMBER(10)
	, p_first_name 	VARCHAR2(100) NOT NULL
	, p_middle_name	VARCHAR2(100)
	, p_last_name	VARCHAR2(100) NOT NULL
	, p_d_id		NUMBER(4)
	
	, CONSTRAINT pk_p_id 
		PRIMARY KEY(p_id)
	
	, CONSTRAINT fk_p_d_id
		FOREIGN KEY(p_d_id)
		REFERENCES Doctor(d_id)
);
------------- Additional Info -----------------------------
CREATE TABLE Patient_Additional(
	  pa_p_id 		NUMBER(10)
	, pa_bd			DATE
	, pa_add1		VARCHAR2(200)
	, pa_add2		VARCHAR2(200)
	, pa_ph			NUMBER(12)

	, CONSTRAINT fk_pa_p_id
		FOREIGN KEY(pa_p_id)
		REFERENCES Patient(p_id)
	, CONSTRAINT fk_pa_bd
		FOREIGN KEY(pa_bd)
		REFERENCES TIME(t)
);
/* Data Entry */
----------------------- ICD -------------------------------
CREATE TABLE ICD_10_CA(
	  code			CHAR(50)
	, code_text		VARCHAR(2000)
	
	, CONSTRAINT pk_icd_code
		PRIMARY KEY(code)
);
---------------------- TIME -------------------------------
CREATE TABLE Time(
	  t				DATE
	
	, CONSTRAINT pk_t
		PRIMARY KEY(t)
);
/* Events */
----------------- Encounter -------------------------------
CREATE TABLE Encounter(
	  e_id			NUMBER(2)
	, e_type			VARCHAR2(100) NOT NULL	
	
	, CONSTRAINT pk_e_id
		PRIMARY KEY(e_id)
);
----------------- Patient Visits --------------------------
CREATE TABLE Patient_Visit(
	pv_id			NUMBER(10),
	pv_e_id			NUMBER(2),
	pv_p_id			NUMBER(10) NOT NULL,
	pv_d_id			NUMBER(4) NOT NULL,
	pv_t			DATE NOT NULL,
	pv_icd_code		CHAR(50),
	
	pv_description	VARCHAR2(2000),
	
	CONSTRAINT pk_pv_id
		PRIMARY KEY(pv_id),
	
	CONSTRAINT fk_pv_e_id
		FOREIGN KEY(pv_e_id)
		REFERENCES Encounter(e_id),
	CONSTRAINT fk_pv_p_id
		FOREIGN KEY(pv_p_id)
		REFERENCES Patient(p_id),
	CONSTRAINT fk_pv_d_id
		FOREIGN KEY(pv_d_id)
		REFERENCES Doctor(d_id),
	CONSTRAINT fk_pv_t
		FOREIGN KEY(pv_t)
		REFERENCES Time(t),
	CONSTRAINT fk_pv_icd_code
		FOREIGN KEY(pv_icd_code)
		REFERENCES ICD_10_CA(code)
);

