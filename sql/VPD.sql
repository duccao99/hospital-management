SET SERVEROUTPUT ON;
---------------------
-- Doctor Policy VPD
---------------------

-- 1. Only see patient information for their responsibility
-- VPD Function
CREATE OR REPLACE FUNCTION FUNC_VPD_POLICY_DOCTOR_SEE_PATIENT_INFO(
    v_schema IN VARCHAR2,
    v_object IN VARCHAR2
)
RETURN VARCHAR2 
AS
    predicate VARCHAR2(200);
    cur_user VARCHAR2(200);
BEGIN
    cur_user:= SYS_CONTEXT('USERENV','SESSION_USER');
    IF (INSTR(cur_user,'BACSI')<>0) THEN
      predicate:= 'TENBACSI = ' ||cur_user;
    ELSE
     predicate:= '';
    END IF;
    RETURN predicate;
END FUNC_VPD_POLICY_DOCTOR_SEE_PATIENT_INFO;
/
-- Test 1.2 real  func
-- SELECT FUNC_VPD_POLICY_DOCTOR_SEE_PATIENT_INFO('DUCCAO_ADMIN','HOSOBENHNHAN') FROM DUAL;



-- Apply VPD
-- ALTER SYSTEM SET "_allow_insert_with_update_check"=TRUE scope=spfile;
BEGIN 
DBMS_RLS.DROP_POLICY('DUCCAO_ADMIN', 'HOSOBENHNHAN', 'VPD_POLICY_DOCTOR_SEE_PATIENT_INFO'); 
END;
/

BEGIN
    DBMS_RLS.add_policy(
    object_schema    => 'DUCCAO_ADMIN', 
    object_name      => 'HOSOBENHNHAN',
    policy_name      => 'VPD_POLICY_DOCTOR_SEE_PATIENT_INFO',
    policy_function  => 'FUNC_VPD_POLICY_DOCTOR_SEE_PATIENT_INFO',
    statement_types => 'SELECT'
    );
END;
/


