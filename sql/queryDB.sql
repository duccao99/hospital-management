----------------------
-- CREATE AN ADMIN
----------------------
ALTER SESSION  SET "_ORACLE_SCRIPT"=TRUE;  
DROP USER DUCCAO_ADMIN CASCADE;
CREATE USER DUCCAO_ADMIN IDENTIFIED BY DUCCAO_ADMIN;
GRANT CREATE SESSION TO DUCCAO_ADMIN WITH ADMIN OPTION;
GRANT CONNECT, RESOURCE, DBA TO DUCCAO_ADMIN WITH ADMIN OPTION;
GRANT CREATE USER TO DUCCAO_ADMIN WITH ADMIN OPTION;
GRANT ALTER USER TO DUCCAO_ADMIN WITH ADMIN OPTION;
GRANT DROP USER TO DUCCAO_ADMIN WITH ADMIN OPTION;
GRANT CREATE ROLE TO DUCCAO_ADMIN WITH ADMIN OPTION;
GRANT CREATE VIEW, CREATE TABLE TO DUCCAO_ADMIN WITH ADMIN OPTION;
GRANT EXECUTE ON DBMS_RLS TO DUCCAO_ADMIN;
GRANT EXECUTE ON SYS.DBMS_CRYPTO TO DUCCAO_ADMIN;
GRANT EXECUTE ON SYS.DBMS_OUTPUT TO DUCCAO_ADMIN;



DROP USER TONS_ADMIN CASCADE;
CREATE USER TONS_ADMIN IDENTIFIED BY TONS_ADMIN;
GRANT CREATE SESSION TO TONS_ADMIN WITH ADMIN OPTION;
GRANT CONNECT, RESOURCE, DBA TO TONS_ADMIN WITH ADMIN OPTION;
GRANT CREATE USER TO TONS_ADMIN WITH ADMIN OPTION;
GRANT ALTER USER TO TONS_ADMIN WITH ADMIN OPTION;
GRANT DROP USER TO TONS_ADMIN WITH ADMIN OPTION;
GRANT CREATE ROLE TO TONS_ADMIN WITH ADMIN OPTION;






-- A3. View the list of users in the system
SELECT * FROM Dba_users;
SELECT * FROM ALL_USERS ;

-- A4. Information about the privileges of each user  on data objects
SELECT * FROM  USER_TAB_PRIVS WHERE TABLE_NAME = 'CHAMCONG' OR  TABLE_NAME = 'BENHNHAN'
OR  TABLE_NAME = 'HOSOBENHNHAN' OR  TABLE_NAME = 'HOSODICHVU' OR  TABLE_NAME = 'HOADON'
OR  TABLE_NAME = 'NHANVIEN' OR  TABLE_NAME = 'DONVI' OR  TABLE_NAME = 'DONTHUOC'
OR  TABLE_NAME = 'DICHVU' OR  TABLE_NAME = 'CTHOADON' OR  TABLE_NAME = 'CTDONTHUOC'
OR  TABLE_NAME = 'THUOC';

SELECT * FROM USER_TAB_PRIVS;

-- A5. Information about the privileges of each role  on data objects
SELECT * FROM  Role_tab_privs WHERE TABLE_NAME = 'CHAMCONG' OR  TABLE_NAME = 'BENHNHAN'
OR  TABLE_NAME = 'HOSOBENHNHAN' OR  TABLE_NAME = 'HOSODICHVU' OR  TABLE_NAME = 'HOADON'
OR  TABLE_NAME = 'NHANVIEN' OR  TABLE_NAME = 'DONVI' OR  TABLE_NAME = 'DONTHUOC'
OR  TABLE_NAME = 'DICHVU' OR  TABLE_NAME = 'CTHOADON' OR  TABLE_NAME = 'CTDONTHUOC'
OR  TABLE_NAME = 'THUOC';

-- A6. Allows to create user
CREATE OR REPLACE PROCEDURE createUser(
    pi_username IN NVARCHAR2,
    pi_password IN NVARCHAR2)
IS    
    user_name  NVARCHAR2(20):= pi_username;
    pwd NVARCHAR2(20):= pi_password;
    li_count INTEGER :=0;
    lv_stmt VARCHAR(1000);
    BEGIN
    SELECT COUNT (1)
    INTO li_count
    FROM all_users
    WHERE username =UPPER(user_name);
    
    
    IF li_count !=0
    THEN 
        lv_stmt:='DROP USER ' ||user_name ||' CASCADE';
        EXECUTE IMMEDIATE (lv_stmt);      
    END IF;
    
    lv_stmt:='ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE ';
    EXECUTE IMMEDIATE (lv_stmt);
    
   -- lv_stmt:='CREATE USER ' || user_name|| ' IDENTIFIED BY ' || pwd|| ' DEFAULT TABLESPACE SYSTEM ';
    lv_stmt:='CREATE USER ' || user_name|| ' IDENTIFIED BY ' || pwd;

  --  DBMS_OUTPUT.put_line(lv_stmt);
    
    EXECUTE IMMEDIATE (lv_stmt);
    
     -- ****** Object: Roles for user ******
     lv_stmt:='GRANT CONNECT TO ' ||user_name;
         EXECUTE IMMEDIATE (lv_stmt);

-- PRIVILEGES resource, unlimited table 
     
         -- ****** Object: System privileges for user ******
--	lv_stmt := 'GRANT ALTER SESSION,
--	       	    	  CREATE ANY TABLE,
--	       	    	  CREATE CLUSTER,
--	            	  CREATE DATABASE LINK,
--	            	  CREATE MATERIALIZED VIEW,
--	       		  CREATE SYNONYM,
--	       		  CREATE TABLE,
--	       		  CREATE VIEW,
--	       		  CREATE SESSION,
--	       		  UNLIMITED TABLESPACE
--	       	    TO ' || user_name;

      --  EXECUTE IMMEDIATE ( lv_stmt );
      
          lv_stmt:='ALTER SESSION SET "_ORACLE_SCRIPT"=FALSE ';
    EXECUTE IMMEDIATE (lv_stmt);
       COMMIT;
    END createUser;
/


ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER USER_TEMP_04 IDENTIFIED BY USER_TEMP_04;
EXEC createUser('USER_TEMP_05','USER_TEMP_05');
SELECT * FROM all_users WHERE USERNAME = 'USER_TEMP_01';


-- A7 Allows to delete user
CREATE OR REPLACE PROCEDURE deleteUser(
    ip_username IN NVARCHAR2)
IS
user_name NVARCHAR2(20):=ip_username;
exec_commander VARCHAR(1000);
    BEGIN
        exec_commander := 'ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE ';
        EXECUTE IMMEDIATE (exec_commander);
        
       exec_commander :='DROP USER ' || user_name|| ' CASCADE ';
           EXECUTE IMMEDIATE (exec_commander);
          exec_commander := 'ALTER SESSION SET "_ORACLE_SCRIPT"=FALSE ';
        EXECUTE IMMEDIATE (exec_commander);
        COMMIT;    
    END deleteUser;
/

EXEC deleteUser('duc11');


-- A8. Allows to edit user
ALTER USER USER_TEMP_02 IDENTIFIED BY USER_TEMP_02;


-- A9. Allows to create role
CREATE OR REPLACE PROCEDURE proc_createRole(
    ip_rolename IN NVARCHAR2,
    ip_identify IN NVARCHAR2)
IS
role_name nvarchar2(20):= ip_rolename;
identify nvarchar2(20):= ip_identify;
exec_commander varchar(1000);
    BEGIN
        exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT"= TRUE';
        EXECUTE IMMEDIATE(exec_commander);
        
        exec_commander:='CREATE ROLE '||role_name ||' IDENTIFIED BY '||identify;
        EXECUTE IMMEDIATE(exec_commander);

          exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT"= FALSE';
        EXECUTE IMMEDIATE(exec_commander);
    COMMIT;
    END proc_createRole;
/
EXEC proc_createRole('role_temp_06','role_temp_06');

-- A10. Allows delete role
CREATE OR REPLACE PROCEDURE proc_deleteRole(
ip_rolename IN NVARCHAR2)
IS 
role_name NVARCHAR2(20):=ip_rolename;
exec_commander varchar(1000);
BEGIN
    exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE';
      EXECUTE IMMEDIATE(exec_commander);

    exec_commander:='DROP ROLE '|| role_name;
    EXECUTE IMMEDIATE (exec_commander);
    
      exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT"=FALSE';
      EXECUTE IMMEDIATE(exec_commander);
COMMIT;
END proc_deleteRole;
/
EXEC proc_deleteRole('ROLE_TEMP_07');


-- 
update all_user set username = 'USER_TEMP_01_updated' where username='USER_TEMP_01';


ALTER ROLE r1 IDENTIFIED BY r111;

-- CANNOT GRANT TO A ROLE WITH GRANT OPTION
-- GRANT SELECT ON CHAMCONG TO ROLE_TEMP_01 WITH GRANT OPTION;


-- A12. Grant user permission


-- Only INSERT, UPDATE, and REFERENCES privileges can be granted at the column level. 
-- When granting INSERT at the column level, you must include all the not null columns in the row.

ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER DUCCAO IDENTIFIED BY DUCCAO;
CREATE USER USER_TEMP_01 IDENTIFIED BY USER_TEMP_01;
CREATE USER USER_TEMP_02 IDENTIFIED BY USER_TEMP_02;
CREATE USER USER_TEMP_03 IDENTIFIED BY USER_TEMP_03;
GRANT CONNECT TO USER_TEMP_01;
GRANT CONNECT TO USER_TEMP_02;
GRANT CONNECT TO USER_TEMP_03;


GRANT ALL PRIVILEGES TO DUCCAO;
GRANT select, insert ON Employee TO duccao WITH GRANT OPTION;
GRANT SELECT, UPDATE(THANG) ON CHAMCONG TO DUCCAO WITH GRANT OPTION;

REVOKE SELECT, UPDATE ON CHAMCONG FROM DUCCAO;
GRANT  UPDATE(THANG) ON CHAMCONG TO DUCCAO WITH GRANT OPTION;
GRANT  SELECT(THANG) ON CHAMCONG TO DUCCAO WITH GRANT OPTION;
GRANT UPDATE(THANG) ON CHAMCONG TO USER_TEMP_02; 


SELECT * FROM  USER_TAB_PRIVS WHERE TABLE_NAME = 'CHAMCONG' OR  TABLE_NAME = 'BENHNHAN'
OR  TABLE_NAME = 'HOSOBENHNHAN' OR  TABLE_NAME = 'HOSODICHVU' OR  TABLE_NAME = 'HOADON'
OR  TABLE_NAME = 'NHANVIEN' OR  TABLE_NAME = 'DONVI' OR  TABLE_NAME = 'DONTHUOC'
OR  TABLE_NAME = 'DICHVU' OR  TABLE_NAME = 'CTHOADON' OR  TABLE_NAME = 'CTDONTHUOC'
OR  TABLE_NAME = 'THUOC';

-- GET ALL COLUMNS OF ALL TABLES
SELECT  column_name FROM USER_TAB_COLUMNS WHERE table_name = 'CHAMCONG';
SELECT  column_name FROM USER_TAB_COLUMNS WHERE table_name = 'BENHNHAN';
SELECT  column_name FROM USER_TAB_COLUMNS WHERE table_name = 'HOSOBENHNHAN';
SELECT  column_name FROM USER_TAB_COLUMNS WHERE table_name = 'HOSODICHVU';
SELECT  column_name FROM USER_TAB_COLUMNS WHERE table_name = 'HOADON';
SELECT  column_name FROM USER_TAB_COLUMNS WHERE table_name = 'NHANVIEN';
SELECT  column_name FROM USER_TAB_COLUMNS WHERE table_name = 'DONVI';
SELECT  column_name FROM USER_TAB_COLUMNS WHERE table_name = 'DICHVU';
SELECT  column_name FROM USER_TAB_COLUMNS WHERE table_name = 'CTHOADON';
SELECT  column_name FROM USER_TAB_COLUMNS WHERE table_name = 'CTDONTHUOC';
SELECT  column_name FROM USER_TAB_COLUMNS WHERE table_name = 'THUOC';




-- A13. Grant Role Permission
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE ROLE ROLE_TEMP_01 IDENTIFIED BY ROLE_TEMP_01;
CREATE ROLE ROLE_TEMP_02 IDENTIFIED BY ROLE_TEMP_02;
CREATE ROLE ROLE_TEMP_03 IDENTIFIED BY ROLE_TEMP_03;
GRANT SELECT ON CHAMCONG TO ROLE_TEMP_01;
ALTER SESSION  SET "_ORACLE_SCRIPT"=TRUE;  
GRANT SELECT ON CHAMCONG TO ROLE_TEMP_01;

GRANT update(manv) ON CHAMCONG TO ROLE_TEMP_01 

SELECT * FROM  Role_tab_privs WHERE TABLE_NAME = 'CHAMCONG' OR  TABLE_NAME = 'BENHNHAN'
OR  TABLE_NAME = 'HOSOBENHNHAN' OR  TABLE_NAME = 'HOSODICHVU' OR  TABLE_NAME = 'HOADON'
OR  TABLE_NAME = 'NHANVIEN' OR  TABLE_NAME = 'DONVI' OR  TABLE_NAME = 'DONTHUOC'
OR  TABLE_NAME = 'DICHVU' OR  TABLE_NAME = 'CTHOADON' OR  TABLE_NAME = 'CTDONTHUOC'
OR  TABLE_NAME = 'THUOC';

-- A14. Grant Role To User
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
GRANT ROLE_NAME TO USER_NAME;
SELECT USERNAME FROM Dba_users;
SELECT ROLE FROM Dba_roles;






-- View All role
SELECT * FROM Dba_roles;

-- A19: Allows to edit user permissions 
-- solution: Revoke then re-grant
REVOKE SELECT ON CHAMCONG FROM DUCCAO ;
GRANT SELECT ON CHAMCONG TO ROLE_TEMP_02 WITH GRANT OPTION;
     


-- A20. Allows to edit role permissions - DOWN KNOW HOW TO ? ASK INSTRUUCTOR !!
SELECT * FROM  Role_tab_privs WHERE TABLE_NAME = 'CHAMCONG' OR  TABLE_NAME = 'BENHNHAN'
    OR  TABLE_NAME = 'HOSOBENHNHAN' OR  TABLE_NAME = 'HOSODICHVU' OR  TABLE_NAME = 'HOADON'
    OR  TABLE_NAME = 'NHANVIEN' OR  TABLE_NAME = 'DONVI' OR  TABLE_NAME = 'DONTHUOC'
    OR  TABLE_NAME = 'DICHVU' OR  TABLE_NAME = 'CTHOADON' OR  TABLE_NAME = 'CTDONTHUOC'
    OR  TABLE_NAME = 'THUOC';
REVOKE DELETE ON CHAMCONG FROM ROLE_TEMP_01;
GRANT DELETE ON CHAMCONG TO ROLE_TEMP_01;


-- cannot update a view    
-- cannot update a view    
-- cannot update a view    
UPDATE USER_TAB_PRIVS SET 
TABLE_NAME = 'CHAMCONG',
PRIVILEGE = 'UPDATE',
GRANTABLE ='NO'
WHERE 
GRANTEE = 'DUCCAO' AND
TABLE_NAME = 'CHAMCONG' AND
PRIVILEGE = 'SELECT';




-- A57. Admin has the privileges to enable  system-wide logging
alter session set "_ORACLE_SCRIPT"=true;  
CREATE USER ADMIN01 IDENTIFIED BY ADMIN01;

ALTER SYSTEM SET AUDIT_SYS_OPERATIONS=TRUE SCOPE=SPFILE;
EXEC SHOW_AUD;










--
-- USER IN SYSTEM
-- 

-- Bo phan tai nguyen & nhan su
alter session set "_ORACLE_SCRIPT"=true;  
CREATE USER user_tainguyen_nhansu_01 IDENTIFIED BY user_tainguyen_nhansu_01;
CREATE USER user_tainguyen_nhansu_02 IDENTIFIED BY user_tainguyen_nhansu_02;
CREATE USER user_tainguyen_nhansu_03 IDENTIFIED BY user_tainguyen_nhansu_03;
GRANT CONNECT TO user_tainguyen_nhansu_01;
GRANT CONNECT TO user_tainguyen_nhansu_02;
GRANT CONNECT TO user_tainguyen_nhansu_03;




-- Quan ly tai vu
CREATE USER user_quanly_taivu_01 IDENTIFIED BY user_quanly_taivu_01;
CREATE USER user_quanly_taivu_02 IDENTIFIED BY user_quanly_taivu_02;
CREATE USER user_quanly_taivu_03 IDENTIFIED BY user_quanly_taivu_03;
GRANT CONNECT TO user_quanly_taivu_01;
GRANT CONNECT TO user_quanly_taivu_02;
GRANT CONNECT TO user_quanly_taivu_03;



-- Quan ly chuyen mon
CREATE USER user_quanly_chuyenmon_01 IDENTIFIED BY user_quanly_chuyenmon_01;
CREATE USER user_quanly_chuyenmon_02 IDENTIFIED BY user_quanly_chuyenmon_02;
CREATE USER user_quanly_chuyenmon_03 IDENTIFIED BY user_quanly_chuyenmon_03;
GRANT CONNECT TO user_quanly_chuyenmon_01;
GRANT CONNECT TO user_quanly_chuyenmon_02;
GRANT CONNECT TO user_quanly_chuyenmon_03;



-- Bo phan tiep tan
CREATE USER user_tieptan_01 IDENTIFIED BY user_tieptan_01;
CREATE USER user_tieptan_02 IDENTIFIED BY user_tieptan_02;
CREATE USER user_tieptan_03 IDENTIFIED BY user_tieptan_03;
GRANT CONNECT TO user_tieptan_01;
GRANT CONNECT TO user_tieptan_02;
GRANT CONNECT TO user_tieptan_03;



-- Bac si
CREATE USER user_bacsi_01 IDENTIFIED BY user_bacsi_01;
CREATE USER user_bacsi_02 IDENTIFIED BY user_bacsi_02;
CREATE USER user_bacsi_03 IDENTIFIED BY user_bacsi_03;
GRANT CONNECT TO user_bacsi_01;
GRANT CONNECT TO user_bacsi_02;
GRANT CONNECT TO user_bacsi_03;


-- Phong tai vu
CREATE USER user_taivu_01 IDENTIFIED BY user_taivu_01;
CREATE USER user_taivu_02 IDENTIFIED BY user_taivu_02;
CREATE USER user_taivu_03 IDENTIFIED BY user_taivu_03;
GRANT CONNECT TO user_taivu_01;
GRANT CONNECT TO user_taivu_02;
GRANT CONNECT TO user_taivu_03;



-- Phong ban thuoc
CREATE USER user_banthuoc_01 IDENTIFIED BY user_banthuoc_01;
CREATE USER user_banthuoc_02 IDENTIFIED BY user_banthuoc_02;
CREATE USER user_banthuoc_03 IDENTIFIED BY user_banthuoc_03;
GRANT CONNECT TO user_banthuoc_01;
GRANT CONNECT TO user_banthuoc_02;
GRANT CONNECT TO user_banthuoc_03;




-- Bo phan ke toan
CREATE USER user_ketoan_01 IDENTIFIED BY user_ketoan_01;
CREATE USER user_ketoan_02 IDENTIFIED BY user_ketoan_02;
CREATE USER user_ketoan_03 IDENTIFIED BY user_ketoan_03;
GRANT CONNECT TO user_ketoan_01;
GRANT CONNECT TO user_ketoan_02;
GRANT CONNECT TO user_ketoan_03;

---
-- Create Role &  Grant policy to it
---

--A82 Grant policy to management deparment
--Quan ly tai nguyen & nhan su
alter session set "_ORACLE_SCRIPT"=true;
CREATE ROLE role_dep_ql_tainguyen_nhansu IDENTIFIED BY role_dep_ql_tainguyen_nhansu;
--Grant policy
GRANT INSERT, DELETE, UPDATE, SELECT ON NHANVIEN TO role_dep_ql_tainguyen_nhansu;
GRANT INSERT, DELETE, UPDATE, SELECT ON DONVI TO role_dep_ql_tainguyen_nhansu;
GRANT SELECT ON BENHNHAN TO role_dep_ql_tainguyen_nhansu;
GRANT SELECT ON CHAMCONG TO role_dep_ql_tainguyen_nhansu;
GRANT SELECT ON CTDONTHUOC TO role_dep_ql_tainguyen_nhansu;
GRANT SELECT ON CTHOADON TO role_dep_ql_tainguyen_nhansu;
GRANT SELECT ON DICHVU TO role_dep_ql_tainguyen_nhansu;
GRANT SELECT ON DONTHUOC TO role_dep_ql_tainguyen_nhansu;
GRANT SELECT ON HOADON TO role_dep_ql_tainguyen_nhansu;
GRANT SELECT ON HOSOBENHNHAN TO role_dep_ql_tainguyen_nhansu;
GRANT SELECT ON HOSODICHVU TO role_dep_ql_tainguyen_nhansu;
GRANT SELECT ON THUOC TO role_dep_ql_tainguyen_nhansu;
--Grant role to user
GRANT role_dep_ql_tainguyen_nhansu TO user_tainguyen_nhansu_01;
GRANT role_dep_ql_tainguyen_nhansu TO user_tainguyen_nhansu_02;
GRANT role_dep_ql_tainguyen_nhansu TO user_tainguyen_nhansu_03;

--A85 Quan ly tai vu
alter session set "_ORACLE_SCRIPT"=true; 
CREATE ROLE role_dep_ql_taivu IDENTIFIED BY role_dep_ql_taivu;
--Grant policy
GRANT INSERT,UPDATE ON DICHVU TO role_dep_ql_taivu;
GRANT INSERT,UPDATE ON HOADON TO role_dep_ql_taivu;
GRANT INSERT,UPDATE ON CTHOADON TO role_dep_ql_taivu;
GRANT SELECT ON BENHNHAN TO role_dep_ql_taivu;
GRANT SELECT ON CTDONTHUOC TO role_dep_ql_taivu;
GRANT SELECT ON DONTHUOC TO role_dep_ql_taivu;
GRANT SELECT ON HOSOBENHNHAN TO role_dep_ql_taivu;
GRANT SELECT ON HOSODICHVU TO role_dep_ql_taivu;
GRANT SELECT ON THUOC TO role_dep_ql_taivu;
GRANT SELECT ON NHANVIEN TO role_dep_ql_taivu;
GRANT SELECT ON CHAMCONG TO role_dep_ql_taivu;
GRANT SELECT ON DONVI TO role_dep_ql_taivu;
--Grant role to user
GRANT role_dep_ql_taivu TO user_quanly_taivu_01;
GRANT role_dep_ql_taivu TO user_quanly_taivu_02;
GRANT role_dep_ql_taivu TO user_quanly_taivu_03;


-- A82. Quan ly chuyen mon
alter session set "_ORACLE_SCRIPT"=true; 
CREATE ROLE role_dep_ql_chuyenmon IDENTIFIED BY role_dep_ql_chuyenmon;
--Grant policy
GRANT SELECT ON BENHNHAN TO role_dep_ql_chuyenmon;
GRANT SELECT ON CTDONTHUOC TO role_dep_ql_chuyenmon;
GRANT SELECT ON DONTHUOC TO role_dep_ql_chuyenmon;
GRANT SELECT ON HOSOBENHNHAN TO role_dep_ql_chuyenmon;
GRANT SELECT ON HOSODICHVU TO role_dep_ql_chuyenmon;
GRANT SELECT ON THUOC TO role_dep_ql_chuyenmon;
GRANT SELECT ON CHAMCONG TO role_dep_ql_chuyenmon;
--Grant role to user
GRANT role_dep_ql_chuyenmon TO user_quanly_chuyenmon_01;
GRANT role_dep_ql_chuyenmon TO user_quanly_chuyenmon_02;
GRANT role_dep_ql_chuyenmon TO user_quanly_chuyenmon_03;

-- Reception Role
alter session set "_ORACLE_SCRIPT"=true;  
CREATE ROLE role_dep_letan  IDENTIFIED BY role_dep_letan;
-- A83. Grant policy to reception department
GRANT INSERT, SELECT, UPDATE ON BENHNHAN TO role_dep_letan;
GRANT INSERT, SELECT, UPDATE ON HOSOBENHNHAN TO role_dep_letan;

-- content base access controll
-- SELECT MADV,TENDV FROM DICHVU;
CREATE OR REPLACE VIEW VW_RECEPTION_DICHVU
AS
SELECT MADV,TENDV FROM DICHVU;
GRANT SELECT ON VW_RECEPTION_DICHVU TO user_tieptan_01;
GRANT SELECT ON VW_RECEPTION_DICHVU TO user_tieptan_02;
GRANT SELECT ON VW_RECEPTION_DICHVU TO user_tieptan_03;
-- SELECT * FROM VW_RECEPTION_DICHVU;
-- not working, dont understant @_@


-- REVOKE SELECT ON THUOC FROM role_dep_letan;
GRANT role_dep_letan TO user_tieptan_01;
GRANT role_dep_letan TO user_tieptan_02;
GRANT role_dep_letan TO user_tieptan_03;

-- A84 role_doctor role
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE ROLE role_doctor IDENTIFIED BY role_doctor;
-- A44. Grant policy to role_doctor
GRANT INSERT, UPDATE (ketLuanCuaBacSi) ON HOSOBENHNHAN TO role_doctor;
GRANT INSERT, UPDATE (maKB,maDV,ngayGio) ON HOSODICHVU TO role_doctor;
-- Grant role to user - role_doctor
GRANT role_doctor TO user_bacsi_01;
GRANT role_doctor TO user_bacsi_02;
GRANT role_doctor TO user_bacsi_03;


--A86 Grant policy to pharmacy
--user_banthuoc_01
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
DROP ROLE role_dep_banthuoc;
CREATE ROLE role_dep_banthuoc IDENTIFIED BY role_dep_banthuoc;
GRANT SELECT ON THUOC TO role_dep_banthuoc;
-- Grant role to user - role_doctor
GRANT role_dep_banthuoc TO user_banthuoc_01;
GRANT role_dep_banthuoc TO user_banthuoc_02;
GRANT role_dep_banthuoc TO user_banthuoc_03;

-- Accounting role
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE ROLE role_dep_ketoan IDENTIFIED BY role_dep_ketoan;
-- A85. Grant policy to dep ketoan
GRANT INSERT, UPDATE, SELECT ON CHAMCONG TO role_dep_ketoan;
GRANT INSERT, UPDATE, SELECT ON CHAMCONG TO role_dep_ketoan;
-- Add role to user
GRANT role_dep_ketoan to user_ketoan_01;
GRANT role_dep_ketoan to user_ketoan_02;
GRANT role_dep_ketoan to user_ketoan_03;









-------------------
-- TEST
-------------------
SELECT * FROM CHAMCONG;
SELECT * FROM benhnhan;
SELECT * FROM hosobenhnhan;
SELECT * FROM hosodichvu;
SELECT * FROM hoadon;
SELECT MANV ,
HOTEN ,
LUONG ,
NGAYSINH ,
DIACHI ,
VAITRO ,
MADONVI  FROM nhanvien;
select luong from nhanvien;
SELECT * FROM donthuoc;
SELECT * FROM dichvu;
SELECT * FROM cthoadon;
SELECT * FROM donvi;
SELECT * FROM ctdonthuoc;
SELECT * FROM thuoc;
SELECT * FROM ALL_COL_PRIVS;
SELECT * FROM  DBA_ROLE_PRIVS;

SELECT * FROM  USER_ROLE_PRIVS;
SELECT * FROM  DBA_TAB_PRIVS;

-- Check Current User logging Infor
SELECT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') FROM DUAL;
SELECT SYS_CONTEXT('USERENV','ISDBA') FROM DUAL;
SELECT SYS_CONTEXT('USERENV','CURRENT_USER') FROM DUAL;
SELECT SYS_CONTEXT('USERENV','SESSION_USER') FROM DUAL;
SELECT SYS_CONTEXT('USERENV','SYS_SESSION_ROLES') FROM DUAL;
SELECT SYS_CONTEXT('SYS_SESSION_ROLES', 'default') FROM DUAL;
SELECT * FROM ROLE_TAB_PRIVS;

SELECT * FROM HospitalManagement.NHANVIEN;


SELECT OBJECT_NAME, OBJECT_TYPE 
    FROM USER_OBJECTS;
    
-- watch owner of an object    
select owner from ALL_TABLES where TABLE_NAME ='DONTHUOC';
-- When login set Role !!
SET ROLE ROLE_DOCTOR IDENTIFIED BY ROLE_DOCTOR;
--  owner of table
SELECT * FROM SYS.DONTHUOC;
SELECT * FROM SYS.CTDONTHUOC;
SELECT * FROM sys.CHAMCONG;

ALTER ROLE R1 IDENTIFIED BY R11;
select * from all_users;


SET ROLE R2 IDENTIFIED BY R22;

select * from nhanvien;
select * from sys.user$ where name = 'DUCCAO_ADMIN';
select username, password from dba_users where username = 'DUCCAO_ADMIN';
 
DELETE  FROM VIEW_COLUMN_SELECT_USER WHERE USERNAME = 'A3';
SELECT *  FROM VIEW_COLUMN_SELECT_USER WHERE USERNAME = 'A3';


GRANT SELECT(MANV) ON NHANVIEN TO USER_TEMP_02;
SELECT MANV FROM NHANVIEN;


SELECT * FROM VIEW_COLUMN_SELECT_ROLE;

--- TESTING Encrypt View
--- TESTING Encrypt View
create table testing(
    username varchar2(200),
    pass varchar2(200)
);

INSERT INTO testing VALUES ('US01','US01');
INSERT INTO testing VALUES ('US02','US02');

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER USER_TEST IDENTIFIED BY USER_TEST;
GRANT CREATE SESSION TO USER_TEST;

CREATE OR REPLACE VIEW VW_USER_TEST
AS SELECT * FROM DUCCAO_ADMIN.testing;

GRANT SELECT ON VW_USER_TEST TO USER_TEST;

CONN USER_TEST/USER_TEST;
SELECT * FROM DUCCAO_ADMIN.VW_USER_TEST;
----
----


------------------
ALTER SESSION SET "_ORACLE_SCRIPT"= TRUE;


CREATE OR REPLACE VIEW VIEW_ROLE_NHANVIEN
AS  SELECT * FROM DUCCAO_ADMIN.NHANVIEN;

CREATE ROLE ROLE_VIEW_NHANVIEN IDENTIFIED BY ROLE_VIEW_NHANVIEN;


GRANT  ROLE_VIEW_NHANVIEN TO U1 WITH ADMIN OPTION;

GRANT SELECT ON DUCCAO_ADMIN.VIEW_ROLE_NHANVIEN TO ROLE_VIEW_NHANVIEN WITH  GRANT  OPTION;



select * from dba_users where username ='DUCCAO_ADMIN';
select * from all_policies;
SELECT * FROM DUCCAO_ADMIN.VIEW_COLUMN_SELECT_USER;
FROM DUCCAO_ADMIN.NHANVIEN ORDER BY manv;

SELECT MANV
FROM DUCCAO_ADMIN.NHANVIEN;

SELECT DISTINCT VAITRO
FROM DUCCAO_ADMIN.NHANVIEN;

-- check trace file
SELECT VALUE FROM V$DIAG_INFO WHERE NAME = 'Default Trace File';
-- check policy list
SELECT * FROM ALL_POLICIES ;








