/* Drop Procedures,Functions,Triggers */
TRUNCATE TRIGGER Patient_Visit_Trigger;
TRUNCATE TRIGGER Pat_Addi_Time_Trigger;
TRUNCATE TRIGGER Doctor_Time_Trigger;
TRUNCATE FUNCTION Check_If_Visit_Possible;
TRUNCATE FUNCTION Check_Time_Table;
TRUNCATE PROCEDURE Insert_Into_Time;
/*Drop Events*/
TRUNCATE TABLE Patient_Visit;
TRUNCATE TABLE Encounter;
/*Drop People*/
TRUNCATE TABLE Patient_Additional;
TRUNCATE TABLE Patient;
TRUNCATE TABLE Doctor;
/* Drop Data Tables*/
TRUNCATE TABLE ICD_10_CA;
TRUNCATE TABLE TIME;

