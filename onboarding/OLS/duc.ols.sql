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








