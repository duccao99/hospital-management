EXEC LBACSYS.CONFIGURE_OLS;
EXEC LBACSYS.OLS_ENFORCEMENT.ENABLE_OLS; 

SELECT STATUS FROM DBA_OLS_STATUS WHERE NAME = 'OLS_CONFIGURE_STATUS';


CONN LBACSYS/1;
EXECUTE SA_SYSDBA.CREATE_POLICY('ACCESS_NHANVIEN','OLS_NHANVIEN');
-- After create a policy - ACCESS_NHANVIEN_DBA ROLE

-- 
CREATE USER CONGTYVC IDENTIFIED BY CONGTYVC;
CREATE USER BOB IDENTIFIED BY BOB;
CREATE USER TIM IDENTIFIED BY TIM;
CREATE USER SCOTT IDENTIFIED BY SCOTT;

GRANT CREATE TABLE, UNLIMITED TABLESPACE TO CONGTYVC;
GRANT CREATE SESSION TO CONGTYVC,BOB,TIM,SCOTT;

CONN CONGTYVC/CONGTYVC;
CREATE TABLE VANCHUYEN(MAVC NUMBER,DIEMDEN VARCHAR2(100),LOAIHANG VARCHAR2(100));

GRANT SELECT, INSERT ON CONGTYVC.VANCHUYEN TO BOB, TIM, SCOTT;

CONN CONGTYVC/CONGTYVC;
INSERT INTO CONGTYVC.VANCHUYEN VALUES (100,'Nha Trang','Vu Khi Quan Su');
INSERT INTO CONGTYVC.VANCHUYEN VALUES (101,'Bien Hoa','Than Cui');
INSERT INTO CONGTYVC.VANCHUYEN VALUES (102,'Dong Nai','Pin');
INSERT INTO CONGTYVC.VANCHUYEN VALUES (103,'Can Tho','Vu Khi Quan Su');
INSERT INTO CONGTYVC.VANCHUYEN VALUES (104,'Ca Mau','May Bay Phan Luc');
INSERT INTO CONGTYVC.VANCHUYEN VALUES (105,'Tien Giang','Do Cuu Tro');

SELECT * FROM CONGTYVC.VANCHUYEN;

-- pre drop
CONN LBACSYS/1;
exec SA_SYSDBA.DROP_POLICY('OLS_POL1',FALSE);

-- Tạo chính sách,  level, nhãn, 
-- gán chính sách vào schema, bảng chính
-- gán chính sách cho user
CONN LBACSYS/1;
BEGIN
SA_SYSDBA.CREATE_POLICY(POLICY_NAME => 'OLS_POL1', COLUMN_NAME=>'LB_COL', DEFAULT_OPTIONS => 'NO_CONTROL');

-- level
-- compartment
-- group

SA_COMPONENTS.CREATE_LEVEL(policy_name => 'ols_pol1', level_num => 100, short_name => 'TS',long_name =>'Top Secret');
SA_COMPONENTS.CREATE_LEVEL(policy_name => 'ols_pol1', level_num => 75, short_name => 'S',long_name =>'Secret');
SA_COMPONENTS.CREATE_LEVEL(policy_name => 'ols_pol1', level_num => 50, short_name => 'C',long_name =>'Confidential');
SA_COMPONENTS.CREATE_LEVEL(policy_name => 'ols_pol1', level_num => 25, short_name => 'UC',long_name =>'UnClassified');

-- level:compartment:group - TS:XX:YY
SA_LABEL_ADMIN.CREATE_LABEL(policy_name => 'ols_pol1', label_tag => 95, label_value => 'TS', data_label => true);
SA_LABEL_ADMIN.CREATE_LABEL(policy_name => 'ols_pol1', label_tag => 65, label_value => 'S', data_label => true);
SA_LABEL_ADMIN.CREATE_LABEL(policy_name => 'ols_pol1', label_tag => 45, label_value => 'C', data_label => true);
SA_LABEL_ADMIN.CREATE_LABEL(policy_name => 'ols_pol1', label_tag => 20, label_value => 'UC', data_label => true);

SA_POLICY_ADMIN.APPLY_TABLE_POLICY(policy_name => 'ols_pol1',schema_name => 'congtyvc', table_name => 'vanchuyen', table_options => null, label_function => null, predicate => null );

SA_USER_ADMIN.SET_LEVELS(policy_name => 'ols_pol1', user_name=>'bob',max_level=>'S',min_level=>'UC',def_level=>'S',row_level => 'S');
SA_USER_ADMIN.SET_LEVELS(policy_name => 'ols_pol1', user_name=>'tim',max_level=>'UC',min_level=>'UC',def_level=>'UC',row_level => 'UC');

END;
/



CONN CONGTYVC/CONGTYVC;
UPDATE CONGTYVC.vanchuyen set lb_col= char_to_label('ols_pol1','TS')WHERE lower(loaihang)='vu khi quan su';
UPDATE CONGTYVC.vanchuyen set lb_col= char_to_label('ols_pol1','S')WHERE lower(loaihang)='may bay phan luc';
UPDATE CONGTYVC.vanchuyen set lb_col= char_to_label('ols_pol1','C')WHERE lower(loaihang)='do cuu tro';
UPDATE CONGTYVC.vanchuyen set lb_col= char_to_label('ols_pol1','UC')WHERE lower(loaihang)='than cui';
UPDATE CONGTYVC.vanchuyen set lb_col= char_to_label('ols_pol1','UC')WHERE lower(loaihang)='pin';


CONN LBACSYS/1;
BEGIN
SA_SYSDBA.ALTER_POLICY(POLICY_NAME => 'OLS_POL1', DEFAULT_OPTIONS => 'READ_CONTROL, LABEL_DEFAULT');
SA_POLICY_ADMIN.REMOVE_TABLE_POLICY(policy_name => 'ols_pol1',schema_name => 'congtyvc', table_name => 'vanchuyen',drop_column => false );
SA_POLICY_ADMIN.APPLY_TABLE_POLICY(policy_name => 'ols_pol1',schema_name => 'congtyvc', table_name => 'vanchuyen' );
END;
/

CONN TIM/TIM;
SELECT * FROM CONGTYVC.vanchuyen;

---------------------------
-- Onboarding OLS Level
---------------------------
CREATE USER HR IDENTIFIED BY HR;
GRANT CREATE SESSION, CREATE TABLE, UNLIMITED TABLESPACE TO HR;

--DROP TABLE HR.EMPLOYEES;
CONN HR/HR;
CREATE TABLE EMPLOYEES(
    EMP_ID INT,
    EMP_NAME VARCHAR2(100),
    EMP_SAL INT
);

CONN HR/HR;
INSERT INTO HR.EMPLOYEES VALUES (100,'DUC',1111);
INSERT INTO HR.EMPLOYEES VALUES (101,'UYEN',22222);
INSERT INTO HR.EMPLOYEES VALUES (102,'HAI',22222);
INSERT INTO HR.EMPLOYEES VALUES (103,'TONS',22222);
INSERT INTO HR.EMPLOYEES VALUES (104,'HUY',22222);

CREATE ROLE HR_ROLE;
GRANT SELECT ON HR.EMPLOYEES TO HR_ROLE;

GRANT CONNECT, HR_ROLE TO SMAVRIS IDENTIFIED BY SMAVRIS;
GRANT CONNECT, HR_ROLE TO INEAU  IDENTIFIED BY INEAU ;
GRANT CREATE SESSION TO SMAVRIS,INEAU;
GRANT SELECT ON HR.EMPLOYEES TO SMAVRIS,INEAU;

CONN LBACSYS/1;
exec SA_SYSDBA.DROP_POLICY('HR_OLS_POL',FALSE);

-- create policy
CONN LBACSYS/1;
BEGIN
 SA_SYSDBA.CREATE_POLICY (
  policy_name      => 'HR_OLS_POL',
  column_name      => 'OLS_COL');
END;
/
EXEC SA_SYSDBA.ENABLE_POLICY ('HR_OLS_POL');

-- create levels
CONN LBACSYS/1;
BEGIN 
    SA_COMPONENTS.CREATE_LEVEL(
        policy_name => 'HR_OLS_POL',
        level_num => 150,
        short_name => 'HS',
        long_name => 'HIGHLY_SENSITIVE'
    );
    
     SA_COMPONENTS.CREATE_LEVEL(
        policy_name => 'HR_OLS_POL',
        level_num => 125,
        short_name => 'S',
        long_name => 'SENSITIVE'
    );
END;
/

-- create data label
CONN LBACSYS/1;
BEGIN
    SA_LABEL_ADMIN.CREATE_LABEL(
        policy_name  => 'HR_OLS_POL',
        label_tag    => 140,
        label_value  => 'HS',
        data_label   => TRUE
    );
      SA_LABEL_ADMIN.CREATE_LABEL(
        policy_name  => 'HR_OLS_POL',
        label_tag    => 120,
        label_value  => 'S',
        data_label   => TRUE
    );
END; 
/

-- set user authorization for the OLS
CONN LBACSYS/1;
BEGIN 
    SA_USER_ADMIN.SET_LEVELS(
        policy_name  => 'HR_OLS_POL',
        user_name    => 'SMAVRIS', 
        max_level    => 'HS',
        min_level    => 'S'
      );
    SA_USER_ADMIN.SET_LEVELS(
        policy_name  => 'HR_OLS_POL',
        user_name    => 'INEAU', 
        max_level    => 'S',
        min_level    => 'S'
      );
END;
/

-- Apply the OLS policy to HR Schema
CONN LBACSYS/1;
BEGIN
  SA_POLICY_ADMIN.APPLY_TABLE_POLICY (
    policy_name    => 'HR_OLS_POL',
    schema_name    => 'HR', 
    table_name     => 'EMPLOYEES',
    table_options  => 'READ_CONTROL');
END;
/
BEGIN
   SA_POLICY_ADMIN.ENABLE_TABLE_POLICY (
      policy_name => 'HR_OLS_POL',
      schema_name => 'HR',
      table_name  => 'EMPLOYEES');
END;
/

-- add  the policy label to table HR.employees
CONN LBACSYS/1;
BEGIN
   SA_USER_ADMIN.SET_USER_PRIVS (
      policy_name => 'HR_OLS_POL',
      user_name   => 'HR',
      privileges  => 'READ');
END;
/

conn HR/HR;
UPDATE HR.EMPLOYEES 
SET OLS_COL= CHAR_TO_LABEL('HR_OLS_POL','HS')
WHERE EMP_ID IN (101,102,103,104);


conn HR/HR;
UPDATE HR.EMPLOYEES 
SET OLS_COL= CHAR_TO_LABEL('HR_OLS_POL','S')
WHERE EMP_ID NOT IN (101,102,103,104);


CONN SMAVRIS/SMAVRIS;
SELECT * FROM HR.EMPLOYEES ;

CONN INEAU/INEAU;
SELECT * FROM HR.EMPLOYEES ;


-- REMOVE POLICY
CONN LBACSYS/1;
BEGIN
  SA_SYSDBA.DROP_POLICY ( 
    policy_name  => 'HR_OLS_POL',
    drop_column  => TRUE);
END;
/
DROP ROLE HR_ROLE;
DROP USER INEAU;
DROP USER SMAVRIS;

---------------------------
-- End Onboarding OLS Level
---------------------------

---------------------------
-- Onboarding OLS Compartment
---------------------------
CREATE ROLE HR_ROLE;
GRANT SELECT ON HR.EMPLOYEES TO HR_ROLE;

GRANT CONNECT, HR_ROLE TO LLEAGULL  IDENTIFIED BY LLEAGULL ;
GRANT CREATE SESSION TO LLEAGULL;
GRANT SELECT ON HR.EMPLOYEES TO LLEAGULL;

GRANT CONNECT, HR_ROLE TO SMAVRIS IDENTIFIED BY SMAVRIS;
GRANT CONNECT, HR_ROLE TO INEAU  IDENTIFIED BY INEAU ;
GRANT CREATE SESSION TO SMAVRIS,INEAU;
GRANT SELECT ON HR.EMPLOYEES TO SMAVRIS,INEAU;

-- create policy
CONN LBACSYS/1;
BEGIN
 SA_SYSDBA.CREATE_POLICY (
  policy_name      => 'HR_OLS_POL',
  column_name      => 'OLS_COL');
END;
/
EXEC SA_SYSDBA.ENABLE_POLICY ('HR_OLS_POL');



-- create levels
CONN LBACSYS/1;
BEGIN 
    SA_COMPONENTS.CREATE_LEVEL(
        policy_name => 'HR_OLS_POL',
        level_num => 150,
        short_name => 'HS',
        long_name => 'HIGHLY_SENSITIVE'
    );
    
     SA_COMPONENTS.CREATE_LEVEL(
        policy_name => 'HR_OLS_POL',
        level_num => 125,
        short_name => 'S',
        long_name => 'SENSITIVE'
    );
END;
/



-- create data label
CONN LBACSYS/1;
BEGIN
    SA_LABEL_ADMIN.CREATE_LABEL(
        policy_name  => 'HR_OLS_POL',
        label_tag    => 140,
        label_value  => 'HS',
        data_label   => TRUE
    );
      SA_LABEL_ADMIN.CREATE_LABEL(
        policy_name  => 'HR_OLS_POL',
        label_tag    => 120,
        label_value  => 'S',
        data_label   => TRUE
    );
END; 
/



-- Apply the OLS policy to HR Schema
CONN LBACSYS/1;
BEGIN
  SA_POLICY_ADMIN.APPLY_TABLE_POLICY (
    policy_name    => 'HR_OLS_POL',
    schema_name    => 'HR', 
    table_name     => 'EMPLOYEES',
    table_options  => 'READ_CONTROL');
END;
/
BEGIN
   SA_POLICY_ADMIN.ENABLE_TABLE_POLICY (
      policy_name => 'HR_OLS_POL',
      schema_name => 'HR',
      table_name  => 'EMPLOYEES');
END;
/

-- add  the policy label to table HR.employees
CONN LBACSYS/1;
BEGIN
   SA_USER_ADMIN.SET_USER_PRIVS (
      policy_name => 'HR_OLS_POL',
      user_name   => 'HR',
      privileges  => 'READ');
END;
/

conn HR/HR;
UPDATE HR.EMPLOYEES 
SET OLS_COL= CHAR_TO_LABEL('HR_OLS_POL','HS')
WHERE EMP_ID IN (101,102,103,104);


conn HR/HR;
UPDATE HR.EMPLOYEES 
SET OLS_COL= CHAR_TO_LABEL('HR_OLS_POL','S')
WHERE EMP_ID NOT IN (101,102,103,104);

-- set level for LLEAGULL
CONN LBACSYS/1;
BEGIN 
    SA_USER_ADMIN.SET_LEVELS(
        policy_name  => 'HR_OLS_POL',
        user_name    => 'LLEAGULL', 
        max_level    => 'HS',
        min_level    => 'S'
    );
END;
/


-- create two compartment  
CONN LBACSYS/1;
BEGIN 
    LBACSYS.sa_components.CREATE_COMPARTMENT (
        policy_name      => 'HR_OLS_POL',
        long_name        => 'HR',
        short_name       => 'HR',
        comp_num         =>  1000
    );
    
     SA_COMPONENTS.CREATE_COMPARTMENT (
    policy_name      => 'HR_OLS_POL',
    long_name        => 'LEGAL',
    short_name       => 'LEG',
    comp_num         =>  2000);
END;
/

-- create data label for compartment
CONN LBACSYS/1;
BEGIN 
    SA_LABEL_ADMIN.CREATE_LABEL(
        policy_name => 'HR_OLS_POL',
        label_tag => 1100,
        label_value => 'S:HR:',
        data_label => true
    );
    
     SA_LABEL_ADMIN.CREATE_LABEL(
        policy_name => 'HR_OLS_POL',
        label_tag => 1200,
        label_value => 'HS:HR:',
        data_label => true
    );
     SA_LABEL_ADMIN.CREATE_LABEL(
        policy_name => 'HR_OLS_POL',
        label_tag => 1300,
        label_value => 'HS:LEG:',
        data_label => true
    );
    
END;
/

-- assign the labels to the users
CONN LBACSYS/1;
BEGIN
   SA_USER_ADMIN.SET_USER_LABELS (
      policy_name    => 'HR_OLS_POL',
      user_name      => 'ineau', 
      max_read_label => 'S:HR:');

   SA_USER_ADMIN.SET_USER_LABELS (
      policy_name    => 'HR_OLS_POL',
      user_name      => 'smavris', 
      max_read_label => 'HS:HR,LEG:');

   SA_USER_ADMIN.SET_USER_LABELS (
      policy_name    => 'HR_OLS_POL',
      user_name      => 'lleagull', 
      max_read_label => 'HS:LEG:');
END;
/


conn LLEAGULL/LLEAGULL;
select * from hr.employees;











