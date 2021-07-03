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
GRANT AUDIT_ADMIN TO DUCCAO_ADMIN;


ALTER SESSION  SET "_ORACLE_SCRIPT"=TRUE;  
DROP USER DUCCAO_ADMIN_CHINA CASCADE;
CREATE USER DUCCAO_ADMIN_CHINA IDENTIFIED BY DUCCAO_ADMIN_CHINA;
GRANT CREATE SESSION TO DUCCAO_ADMIN_CHINA WITH ADMIN OPTION;
GRANT CONNECT, RESOURCE, DBA TO DUCCAO_ADMIN_CHINA WITH ADMIN OPTION;
GRANT CREATE USER TO DUCCAO_ADMIN_CHINA WITH ADMIN OPTION;
GRANT ALTER USER TO DUCCAO_ADMIN_CHINA WITH ADMIN OPTION;
GRANT DROP USER TO DUCCAO_ADMIN_CHINA WITH ADMIN OPTION;
GRANT CREATE ROLE TO DUCCAO_ADMIN_CHINA WITH ADMIN OPTION;
GRANT CREATE VIEW, CREATE TABLE TO DUCCAO_ADMIN_CHINA WITH ADMIN OPTION;
GRANT EXECUTE ON DBMS_RLS TO DUCCAO_ADMIN_CHINA;
GRANT EXECUTE ON SYS.DBMS_CRYPTO TO DUCCAO_ADMIN_CHINA;
GRANT EXECUTE ON SYS.DBMS_OUTPUT TO DUCCAO_ADMIN_CHINA;
GRANT AUDIT_ADMIN TO DUCCAO_ADMIN_CHINA;


ALTER SYSTEM SET audit_sys_operations = true scope = spfile;
AUDIT CONNECT;

AUDIT DELETE ANY TABLE BY ACCESS WHENEVER NOT SUCCESSFUL;
AUDIT DELETE ANY TABLE BY ACCESS;
AUDIT SELECT TABLE, INSERT TABLE, DELETE TABLE, EXECUTE PROCEDURE BY ACCESS WHENEVER NOT SUCCESSFUL;




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



-- watch all role column priv records
SELECT * FROM VIEW_COLUMN_SELECT_ROLE;

-- get all vaitro in system
SELECT DISTINCT NV.VAITRO  FROM DUCCAO_ADMIN.NHANVIEN NV;

-- all chamcong records
SELECT * FROM DUCCAO_ADMIN.CHAMCONG;

-- View salary calculation infor - for ketoan
SELECT * FROM DUCCAO_ADMIN.VIEW_CAL_SALARY;

-- CAL salary for nhanvien
conn USER_KETOAN_01/USER_KETOAN_01;
set role ROLE_DEP_KETOAN identified by ROLE_DEP_KETOAN;
UPDATE DUCCAO_ADMIN.VIEW_CAL_SALARY SET LUONG ='1231233123' 
WHERE DUCCAO_ADMIN.VIEW_CAL_SALARY.MANV='BS01' 
AND THANG = '12-JAN-60';


-- USER_KETOAN_01
-- LUONG = (LUONGCB+PHUCAP)*SONGAYCONG/30;
SELECT * FROM CHAMCONG;




-- 

select * from empno_ctx ('','');

------------------


SELECT *   FROM DUCCAO_ADMIN.NHANVIEN NV;
SELECT NV.MANV,NV.HOTEN,NV.VAITRO   FROM DUCCAO_ADMIN.NHANVIEN NV WHERE NV.VAITRO='NHANVIEN_BACSI';

select FUNC_ENCRYPT_MATKHAU_NHANVIEN('AAAA') as encrpyted_pass from dual;
 SELECT func_decrypt_matkhau_nhanvien('u1') AS DECRYPTED_PASS FROM DUAL;
 
 
SELECT * FROM DUCCAO_ADMIN.DICHVU;
select * from benhnhan;
select * from hosobenhnhan;


SELECT MANV
FROM DUCCAO_ADMIN.NHANVIEN;

SELECT DISTINCT VAITRO
FROM DUCCAO_ADMIN.NHANVIEN;

-- check trace file
SELECT VALUE FROM V$DIAG_INFO WHERE NAME = 'Default Trace File';
-- check policy list
SELECT * FROM ALL_POLICIES ;


CREATE OR REPLACE TRIGGER TRIG_NHANVIEN
AFTER LOGON ON DATABASE
BEGIN
    EMP_ENV_CONTEXT.SET_JOB_POSITION;
END;
/


-- Onboard OLS
--SELECT * FROM DBA_OLS_STATUS;

create pluggable database hospital_pluggable;
ALTER SESSION SET CONTAINER = hospital_pluggable;
ALTER USER LBACSYS  IDENTIFIED BY LBACSYS ;

-- Unlock account

SELECT STATUS FROM DBA_OLS_STATUS WHERE NAME = 'OLS_CONFIGURE_STATUS';
ALTER USER LBACSYS ACCOUNT UNLOCK IDENTIFIED BY 123123;

EXEC LBACSYS.CONFIGURE_OLS;
EXEC LBACSYS.OLS_ENFORCEMENT.ENABLE_OLS;

SELECT VALUE FROM V$OPTION WHERE PARAMETER = 'Oracle Label Security';
-- end unlock

/**/
Begin
LBACSYS.CONFIGURE_OLS;
LBACSYS.OLS_ENFORCEMENT.ENABLE_OLS;
end;
/**/


CONNECT LBACSYS/1;
EXECUTE SA_SYSDBA.CREATE_POLICY('ACCESS_NHANVIEN','OLS_NHANVIEN');

BEGIN
    SA_SYSDBA.CREATE_POLICY(
        policy_name => 'emp_ols_pol1',
        column_name => 'ols_col',
        default_options => 'read_control, update_control'
        );
END;
/

/*********************
*     OLS 
**********************/

-- Policy 1: Manager can view all employees record, Doctor Manager can only view doctor record - OLS_POL_MR
-- Policy 2: DBA in China Cannot View Viet Nam Database Record - OLS_POL_DBA


-- Implementation of Policy 1: Manager can view all employees record - OLS_POL_MR
-- pre drop policy
CONN LBACSYS/1;
exec SA_SYSDBA.DROP_POLICY('OLS_POL_MR',FALSE);
-- + Step 1: Create policy - OLS_POL_MR
CONN LBACSYS/1;
BEGIN
    SA_SYSDBA.CREATE_POLICY(
        policy_name => 'OLS_POL_MR',
        column_name => 'OLS_COL_POL_1'
    );
END;
/
EXEC SA_SYSDBA.ENABLE_POLICY ('OLS_POL_MR');

-- + Step 2: create levels
CONN LBACSYS/1;
BEGIN 
    SA_COMPONENTS.CREATE_LEVEL(
        policy_name => 'OLS_POL_MR',
        level_num =>2100,
        short_name =>'MR',
        long_name =>'Manager'
    );
    SA_COMPONENTS.CREATE_LEVEL(
        policy_name => 'OLS_POL_MR',
        level_num => 2500,
        short_name => 'DM',
        long_name => 'Doctor Manager'
    ); 
END;
/


-- + Step 3: Create compartment
CONN LBACSYS/1;
BEGIN 
    LBACSYS.SA_COMPONENTS.CREATE_COMPARTMENT(
        policy_name      => 'OLS_POL_MR',
        long_name        => 'Doctor',
        short_name       => 'DR',
        comp_num         =>  1100
    );
    LBACSYS.SA_COMPONENTS.CREATE_COMPARTMENT(
        policy_name      => 'OLS_POL_MR',
        long_name        => 'Accounting Department',
        short_name       => 'AD',
        comp_num         =>  1075
    );
END;
/

-- + Step 4: Create label
CONN LBACSYS/1;
BEGIN
    SA_LABEL_ADMIN.CREATE_LABEL(
        policy_name  => 'OLS_POL_MR',
        label_tag    => 1,
        label_value  => 'MR',
        data_label   => TRUE
    );
    
    SA_LABEL_ADMIN.CREATE_LABEL(
        policy_name  => 'OLS_POL_MR',
        label_tag    => 2,
        label_value  => 'DM',
        data_label   => TRUE
    );
END; 
/

-- Label for comparment
-- manger can read all employees records
CONN LBACSYS/1;
BEGIN
  SA_LABEL_ADMIN.CREATE_LABEL(
        policy_name  => 'OLS_POL_MR',
        label_tag    => 10,
        label_value  => 'MR:DR,AD:',
        data_label   => TRUE
    );
END;
/

-- Label for comparment
-- doctor manager only read doctor record

CONN LBACSYS/1;
BEGIN
  SA_LABEL_ADMIN.CREATE_LABEL(
        policy_name  => 'OLS_POL_MR',
        label_tag    => 30,
        label_value  => 'DM:DR:',
        data_label   => TRUE
    );
END;
/

-- 
CONN LBACSYS/1;
BEGIN
  SA_LABEL_ADMIN.CREATE_LABEL(
        policy_name  => 'OLS_POL_MR',
        label_tag    => 40,
        label_value  => 'MR:DR',
        data_label   => TRUE
    );
    SA_LABEL_ADMIN.CREATE_LABEL(
        policy_name  => 'OLS_POL_MR',
        label_tag    => 50,
        label_value  => 'MR:AD',
        data_label   => TRUE
    );
END;
/

-- + Step 5: Apply the OLS policy to BENHVIENMASTER Schema and table nhanvien
-- only use ols in local object
DROP USER BENHVIENMASTER;

CREATE USER BENHVIENMASTER IDENTIFIED BY BENHVIENMASTER;
GRANT CREATE TABLE, UNLIMITED TABLESPACE TO BENHVIENMASTER;
GRANT CREATE SESSION TO BENHVIENMASTER;

CONN BENHVIENMASTER/BENHVIENMASTER;
drop table BENHVIENMASTER.NHANVIEN;

CONN BENHVIENMASTER/BENHVIENMASTER;
CREATE TABLE NHANVIEN(MANV NUMBER,TENNV VARCHAR2(100),CHUCVU VARCHAR2(100));

CONN BENHVIENMASTER/BENHVIENMASTER;
INSERT INTO BENHVIENMASTER.NHANVIEN VALUES (100,'Thu','Doctor Manager');
INSERT INTO BENHVIENMASTER.NHANVIEN VALUES (101,'DUCCAO_ADMIN_VN','Database Administrator Viet Nam');
INSERT INTO BENHVIENMASTER.NHANVIEN VALUES (102,'DUCCAO_ADMIN_CHINA2','Database Administrator China');
INSERT INTO BENHVIENMASTER.NHANVIEN VALUES (103,'Uyen','Manager');
INSERT INTO BENHVIENMASTER.NHANVIEN VALUES (104,'Thao','Doctor');
INSERT INTO BENHVIENMASTER.NHANVIEN VALUES (105,'Hai','Accounting Department');


CONN LBACSYS/1;
BEGIN
  SA_POLICY_ADMIN.APPLY_TABLE_POLICY (
    policy_name    => 'OLS_POL_MR',
    schema_name    => 'BENHVIENMASTER', 
    table_name     => 'NHANVIEN',
    table_options  => 'READ_CONTROL');
END;
/
-- enable policy in table
CONN LBACSYS/1;
BEGIN
   SA_POLICY_ADMIN.ENABLE_TABLE_POLICY (
      policy_name => 'OLS_POL_MR',
      schema_name => 'BENHVIENMASTER',
      table_name  => 'NHANVIEN');
END;
/

-- + Step 6: add  the policy label to table BENHVIENMASTER.NHANVIEN
CONN LBACSYS/1;
BEGIN
   SA_USER_ADMIN.SET_USER_PRIVS (
      policy_name => 'OLS_POL_MR',
      user_name   => 'BENHVIENMASTER',
      privileges  => 'READ');
END;
/


conn BENHVIENMASTER/BENHVIENMASTER;
UPDATE BENHVIENMASTER.NHANVIEN 
SET OLS_COL_POL_1= CHAR_TO_LABEL('OLS_POL_MR','DM:DR')
WHERE MANV =100;

conn BENHVIENMASTER/BENHVIENMASTER;
UPDATE BENHVIENMASTER.NHANVIEN 
SET OLS_COL_POL_1= CHAR_TO_LABEL('OLS_POL_MR','MR:DR,AD')
WHERE MANV =103;

conn BENHVIENMASTER/BENHVIENMASTER;
UPDATE BENHVIENMASTER.NHANVIEN 
SET OLS_COL_POL_1= CHAR_TO_LABEL('OLS_POL_MR','MR:DR')
WHERE MANV =104;

conn BENHVIENMASTER/BENHVIENMASTER;
UPDATE BENHVIENMASTER.NHANVIEN 
SET OLS_COL_POL_1= CHAR_TO_LABEL('OLS_POL_MR','MR:AD')
WHERE MANV =105;



SELECT * FROM BENHVIENMASTER.NHANVIEN ;

-- 
-- + Step 7: SET LEVEL TO USER
DROP USER THU;
DROP USER DUCCAO_ADMIN_VN;
DROP USER DUCCAO_ADMIN_CHINA2;
DROP USER Uyen;
DROP USER Thao;
DROP USER Hai;

CREATE USER THU IDENTIFIED BY THU;
CREATE USER DUCCAO_ADMIN_VN IDENTIFIED BY DUCCAO_ADMIN_VN;
CREATE USER DUCCAO_ADMIN_CHINA2 IDENTIFIED BY DUCCAO_ADMIN_CHINA2;
CREATE USER Uyen IDENTIFIED BY Uyen;
CREATE USER Thao IDENTIFIED BY Thao;
CREATE USER Hai IDENTIFIED BY Hai;

GRANT CREATE SESSION TO THU,DUCCAO_ADMIN_VN,DUCCAO_ADMIN_CHINA2,Uyen,Thao,Hai;
GRANT SELECT ON BENHVIENMASTER.NHANVIEN  TO THU,DUCCAO_ADMIN_VN,DUCCAO_ADMIN_CHINA2,Uyen,Thao,Hai;
--  SET LABEL CHO MANAGER VA DOCTOR MANAGER
CONN LBACSYS/1;
BEGIN 
    SA_USER_ADMIN.SET_USER_LABELS (
        policy_name    => 'OLS_POL_MR',
      user_name      => 'Uyen', 
      max_read_label => 'MR:DR,AD'
      );

    SA_USER_ADMIN.SET_USER_LABELS (
        policy_name    => 'OLS_POL_MR',
      user_name      => 'THU', 
      max_read_label => 'DM:DR'
      );
END;
/

-- SET LABEL CHO BAC SI VA KE TOAN
CONN LBACSYS/1;
BEGIN 
    SA_USER_ADMIN.SET_USER_LABELS (
        policy_name    => 'OLS_POL_MR',
      user_name      => 'Thao', 
      max_read_label => 'MR:DR'
      );
      
    SA_USER_ADMIN.SET_USER_LABELS (
        policy_name    => 'OLS_POL_MR',
      user_name      => 'Hai', 
      max_read_label => 'MR:AD'
      );

END;
/



-- + Step 8: testing
-- UYEN LA MANAGER NEN XEM DUOC RECORD CUA NHAN VIEN TRONG HE THONG
CONN Uyen/Uyen;
SELECT * FROM BENHVIENMASTER.NHANVIEN ;

-- THU LA QUAN LY BAC SI CHI XEM DUOC RECORD CUA BAC SI
CONN THU/THU;
SELECT * FROM BENHVIENMASTER.NHANVIEN ;


-- End policy 1




-- Implementation of Policy 2: DBA in China Cannot View Viet Nam Database Record - OLS_POL_DBA


-- PRE DROP
CONN LBACSYS/1;
 BEGIN
  SA_SYSDBA.DROP_POLICY ( 
    policy_name  => 'OLS_POL_DBA',
    drop_column  => TRUE);
END;
/

-- + Step 1: Create policy
CONN LBACSYS/1;
BEGIN
 SA_SYSDBA.CREATE_POLICY (
  policy_name      => 'OLS_POL_DBA',
  column_name      => 'OLS_COL_POL_2');
END;
/
EXEC SA_SYSDBA.ENABLE_POLICY ('OLS_POL_DBA');

-- + Step 2: Create level
CONN LBACSYS/1;
BEGIN
   SA_COMPONENTS.CREATE_LEVEL (
      policy_name => 'OLS_POL_DBA',
      level_num   => 2500,
      short_name  => 'DBA',
      long_name   => 'Database Aministrator');   
END;
/

-- + Step 3: Create compartment
CONN LBACSYS/1;
BEGIN 
    LBACSYS.SA_COMPONENTS.CREATE_COMPARTMENT(
        policy_name      => 'OLS_POL_DBA',
        long_name        => 'Doctor',
        short_name       => 'DR',
        comp_num         =>  1100
    );
    LBACSYS.SA_COMPONENTS.CREATE_COMPARTMENT(
        policy_name      => 'OLS_POL_DBA',
        long_name        => 'Accounting Department',
        short_name       => 'AD',
        comp_num         =>  1075
    );
END;
/


-- + Step 4: Create  group 
-- parent group
CONN LBACSYS/1;
BEGIN
  SA_COMPONENTS.CREATE_GROUP (
   policy_name     => 'OLS_POL_DBA',
   group_num       => 9999,
   short_name      => 'CORP',
   long_name       => 'Corporate');
END;
/

-- child group
CONN LBACSYS/1;
BEGIN
  SA_COMPONENTS.CREATE_GROUP (
   policy_name     => 'OLS_POL_DBA',
   group_num       => 8400,
   short_name      => 'VI',
   long_name       => 'Viet Nam'
   --   parent_name     => 'CORP'
  );
   
  SA_COMPONENTS.CREATE_GROUP (
   policy_name     => 'OLS_POL_DBA',
   group_num       => 8600,
   short_name      => 'CNI',
   long_name       => 'CHINA'
--   parent_name     => 'CORP'
   );
END;
/


-- + STEP :  Create label tag
CONN LBACSYS/1;
BEGIN
  SA_LABEL_ADMIN.CREATE_LABEL(
        policy_name  => 'OLS_POL_DBA',
        label_tag    => 300,
        label_value  => 'DBA:DR,AD:VI',
        data_label   => TRUE
    );
    
      SA_LABEL_ADMIN.CREATE_LABEL(
        policy_name  => 'OLS_POL_DBA',
        label_tag    => 310,
        label_value  => 'DBA:DR,AD:CNI',
        data_label   => TRUE
    );
END;
/



-- + Step 5: SET  LEVEL to user
CONN LBACSYS/1;
BEGIN
   SA_USER_ADMIN.SET_LEVELS (
      policy_name  => 'OLS_POL_DBA',
      user_name    => 'DUCCAO_ADMIN_VN', 
      max_level    => 'DBA');
      
         SA_USER_ADMIN.SET_LEVELS (
      policy_name  => 'OLS_POL_DBA',
      user_name    => 'DUCCAO_ADMIN_CHINA2', 
      max_level    => 'DBA');
END;
/

-- + Step 6: SET  group to user
CONN LBACSYS/1;
BEGIN 
 SA_USER_ADMIN.SET_GROUPS (
  policy_name    => 'OLS_POL_DBA',
  user_name      => 'DUCCAO_ADMIN_VN', 
  read_groups    => 'VI');
  
   SA_USER_ADMIN.SET_GROUPS (
  policy_name    => 'OLS_POL_DBA',
  user_name      => 'DUCCAO_ADMIN_CHINA2', 
  read_groups    => 'CNI');
END;
/

-- DO WE NEED THIS ?
--  SET USER LABEL
CONN LBACSYS/1;
BEGIN
   SA_USER_ADMIN.SET_USER_LABELS (
      policy_name    => 'OLS_POL_DBA',
      user_name      => 'DUCCAO_ADMIN_VN', 
      max_read_label => 'DBA:DR,AD:VI');
      
         SA_USER_ADMIN.SET_USER_LABELS (
      policy_name    => 'OLS_POL_DBA',
      user_name      => 'DUCCAO_ADMIN_CHINA2', 
      max_read_label => 'DBA:DR,AD:CNI');
   END;
/
   

-- + STEP 7: APPLY TABLE POLICY
CONN LBACSYS/1;
BEGIN
  SA_POLICY_ADMIN.APPLY_TABLE_POLICY (
    policy_name    => 'OLS_POL_DBA',
    schema_name    => 'BENHVIENMASTER', 
    table_name     => 'NhanVien',
    table_options  => 'READ_CONTROL');
END;
/

-- enable pol
CONN LBACSYS/1;
BEGIN
   SA_POLICY_ADMIN.ENABLE_TABLE_POLICY (
      policy_name => 'OLS_POL_DBA',
      schema_name => 'BENHVIENMASTER',
      table_name  => 'NhanVien');
END;

-- set priv to update policy column
CONN LBACSYS/1;
BEGIN
   SA_USER_ADMIN.SET_USER_PRIVS (
      policy_name => 'OLS_POL_DBA',
      user_name   => 'BENHVIENMASTER',
      privileges  => 'READ');
END;
/

-- + STEP 9: add label to column policy
CONN BENHVIENMASTER/BENHVIENMASTER;
UPDATE BENHVIENMASTER.NHANVIEN
SET    OLS_COL_POL_2 = CHAR_TO_LABEL('OLS_POL_DBA','DBA:DR,AD:VI')
WHERE  UPPER(MANV) IN (100,101,103);

CONN BENHVIENMASTER/BENHVIENMASTER;
UPDATE BENHVIENMASTER.NHANVIEN
SET    OLS_COL_POL_2 = CHAR_TO_LABEL('OLS_POL_DBA','DBA:DR,AD:CNI')
WHERE  UPPER(MANV) NOT IN (100,101,103);

select * from BENHVIENMASTER.NhanVien;

-- + step 10; testing
-- DUCCAO_ADMIN_VN LA DBA O VIET NAM NEN CHI TRUY CAP DUOC RECORD O VN
CONN DUCCAO_ADMIN_VN/DUCCAO_ADMIN_VN;
SELECT * FROM BENHVIENMASTER.NhanVien;

SELECT MANV, TENNV, CHUCVU, LABEL_TO_CHAR(OLS_COL_POL_2)
FROM BENHVIENMASTER.NhanVien;


-- DUCCAO_ADMIN_CHINA2 LA DBA O TRUNG QUOC NEN CHI TRUY CAP DUOC RECORD O TRUNG QUOC
CONN DUCCAO_ADMIN_CHINA2/DUCCAO_ADMIN_CHINA2;
SELECT * FROM BENHVIENMASTER.NhanVien;

/*********************
*     END OLS
**********************/











