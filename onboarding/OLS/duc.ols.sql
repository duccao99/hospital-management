CREATE USER SCOTT IDENTIFIED BY SCOTT;
GRANT CREATE SESSION TO SCOTT;
GRANT CREATE TABLE TO SCOTT;

CONN SCOTT/SCOTT;
CREATE TABLE announcements (MESSAGE VARCHAR2(4000));

CONN LBACSYS/LBACSYS;
EXECUTE SA_SYSDBA.CREATE_POLICY('ACCESS_NHANVIEN','OLS_NHANVIEN');

select * from dba_users where username='LBACSYS';
SELECT VALUE FROM V$OPTION WHERE PARAMETER = 'Oracle Label Security';
select name, status, description from dba_ols_status;

EXEC LBACSYS.CONFIGURE_OLS;


CONN LBACSYS/LBACSYS;
BEGIN
 SA_SYSDBA.CREATE_POLICY (
  policy_name      => 'emp_ols_pol',
  column_name      => 'ols_col',
  default_options  => 'read_control, update_control');
END;
/

CONN LBACSYS/LBACSYS;
BEGIN
sa_sysdba.create_policy
(policy_name => 'ESBD',
column_name => 'rowlabel');
END;

--  -- This procedure registers Oracle Label Security.
EXEC LBACSYS.CONFIGURE_OLS;
 -- This procedure enables it.
EXEC LBACSYS.OLS_ENFORCEMENT.ENABLE_OLS;

SELECT * FROM DBA_OLS_STATUS WHERE NAME = 'OLS_CONFIGURE_STATUS';


grant all privileges to LBACSYS;
grant LBAC_DBA to LBACSYS;

shutdown immediate;
startup;



ALTER USER LBACSYS ACCOUNT UNLOCK IDENTIFIED BY LBACSYS;

/*
    Try again
*/
conn sys/1 as sysdba;
ALTER USER LBACSYS ACCOUNT UNLOCK IDENTIFIED BY 123123;

-- Account OLS DBA - ols_dba/1
-- pluggable db - xepdb1
-- still cannot access
-- give up










