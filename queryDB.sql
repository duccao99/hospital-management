-- A3. View the list of users in the system
SELECT * FROM Dba_users;

-- A4. Information about the privileges of each user / role on data objects
SELECT * FROM  USER_TAB_PRIVS WHERE TABLE_NAME = 'CHAMCONG' OR  TABLE_NAME = 'BENHNHAN'
OR  TABLE_NAME = 'HOSOBENHNHAN' OR  TABLE_NAME = 'HOSODICHVU' OR  TABLE_NAME = 'HOADON'
OR  TABLE_NAME = 'NHANVIEN' OR  TABLE_NAME = 'DONVI' OR  TABLE_NAME = 'DONTHUOC'
OR  TABLE_NAME = 'DICHVU' OR  TABLE_NAME = 'CTHOADON' OR  TABLE_NAME = 'CTDONTHUOC'
OR  TABLE_NAME = 'THUOC';


SELECT * FROM  DBA_TAB_PRIVS WHERE TABLE_NAME = 'CHAMCONG' OR  TABLE_NAME = 'BENHNHAN'
OR  TABLE_NAME = 'HOSOBENHNHAN' OR  TABLE_NAME = 'HOSODICHVU' OR  TABLE_NAME = 'HOADON'
OR  TABLE_NAME = 'NHANVIEN' OR  TABLE_NAME = 'DONVI' OR  TABLE_NAME = 'DONTHUOC'
OR  TABLE_NAME = 'DICHVU' OR  TABLE_NAME = 'CTHOADON' OR  TABLE_NAME = 'CTDONTHUOC'
OR  TABLE_NAME = 'THUOC';

-- CANNOT GRANT TO A ROLE WITH GRANT OPTION
-- GRANT SELECT ON CHAMCONG TO ROLE_TEMP_01 WITH GRANT OPTION;


-- A6. Grant user permission
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER DUCCAO IDENTIFIED BY DUCCAO;
CREATE USER USER_TEMP_01 IDENTIFIED BY USER_TEMP_01;
CREATE USER USER_TEMP_02 IDENTIFIED BY USER_TEMP_02;
CREATE USER USER_TEMP_03 IDENTIFIED BY USER_TEMP_03;

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


-- A7. Grant Role Permission
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE ROLE ROLE_TEMP_01 IDENTIFIED BY ROLE_TEMP_01;
CREATE ROLE ROLE_TEMP_02 IDENTIFIED BY ROLE_TEMP_02;
CREATE ROLE ROLE_TEMP_03 IDENTIFIED BY ROLE_TEMP_03;
GRANT SELECT ON CHAMCONG TO ROLE_TEMP_01;

-- A8. Grant Role To User
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
GRANT ROLE_NAME TO USER_NAME;
SELECT USERNAME FROM Dba_users;
SELECT ROLE FROM Dba_roles;





-- A33. Admin has the privileges to enable / disable system-wide logging
alter session set "_ORACLE_SCRIPT"=true;  
CREATE USER ADMIN01 IDENTIFIED BY ADMIN01;

ALTER SYSTEM SET AUDIT_SYS_OPERATIONS=TRUE SCOPE=SPFILE;
EXEC SHOW_AUD;



-- A36. View All role
SELECT * FROM Dba_roles;


-- A44. Allows to edit role permissions - DOWN KNOW HOW TO ? ASK INSTRUUCTOR !!
SELECT * FROM Dba_roles where role='ROLE_TEMP_01';
SELECT * FROM USER_TAB_PRIVS where grantee='ROLE_TEMP_01'  and table_name = 'C';

ALTER ROLE ROLE_TEMP_01
ALTER USER_TAB_PRIVS 








--
-- USER IN SYSTEM
-- 

-- Bo phan tai nguyen & nhan su
alter session set "_ORACLE_SCRIPT"=true;  
CREATE USER user_tainguyen_nhansu_01 IDENTIFIED BY user_tainguyen_nhansu_01;
CREATE USER user_tainguyen_nhansu_02 IDENTIFIED BY user_tainguyen_nhansu_02;
CREATE USER user_tainguyen_nhansu_03 IDENTIFIED BY user_tainguyen_nhansu_03;



-- Quan ly tai vu
CREATE USER user_quanly_taivu_01 IDENTIFIED BY user_quanly_taivu_01;
CREATE USER user_quanly_taivu_02 IDENTIFIED BY user_quanly_taivu_02;
CREATE USER user_quanly_taivu_03 IDENTIFIED BY user_quanly_taivu_03;




-- Quan ly chuyen mon
CREATE USER user_quanly_chuyenmon_01 IDENTIFIED BY user_quanly_chuyenmon_01;
CREATE USER user_quanly_chuyenmon_02 IDENTIFIED BY user_quanly_chuyenmon_02;
CREATE USER user_quanly_chuyenmon_03 IDENTIFIED BY user_quanly_chuyenmon_03;



-- Bo phan tiep tan
CREATE USER user_tieptan_01 IDENTIFIED BY user_tieptan_01;
CREATE USER user_tieptan_02 IDENTIFIED BY user_tieptan_02;
CREATE USER user_tieptan_03 IDENTIFIED BY user_tieptan_03;



-- Bac si
CREATE USER user_bacsi_01 IDENTIFIED BY user_bacsi_01;
CREATE USER user_bacsi_02 IDENTIFIED BY user_bacsi_02;
CREATE USER user_bacsi_03 IDENTIFIED BY user_bacsi_03;


-- Phong tai vu
CREATE USER user_taivu_01 IDENTIFIED BY user_taivu_01;
CREATE USER user_taivu_02 IDENTIFIED BY user_taivu_02;
CREATE USER user_taivu_03 IDENTIFIED BY user_taivu_03;




-- Phong ban thuoc
CREATE USER user_banthuoc_01 IDENTIFIED BY user_banthuoc_01;
CREATE USER user_banthuoc_02 IDENTIFIED BY user_banthuoc_02;
CREATE USER user_banthuoc_03 IDENTIFIED BY user_banthuoc_03;




-- Bo phan ke toan
CREATE USER user_ketoan_01 IDENTIFIED BY user_ketoan_01;
CREATE USER user_ketoan_02 IDENTIFIED BY user_ketoan_02;
CREATE USER user_ketoan_03 IDENTIFIED BY user_ketoan_03;


---
-- Create Role &  Grant policy to it
---

--A42 Grant policy to management deparment
--Quan ly tai nguyen & nhan su
alter session set "_ORACLE_SCRIPT"=true;
CREATE ROLE dep_ql_tainguyen_nhansu IDENTIFIED BY dep_ql_tainguyen_nhansu;
--Grant policy
GRANT INSERT, DELETE, UPDATE, SELECT ON NHANVIEN TO dep_ql_tainguyen_nhansu;
GRANT INSERT, DELETE, UPDATE, SELECT ON DONVI TO dep_ql_tainguyen_nhansu;
GRANT SELECT ON BENHNHAN TO dep_ql_tainguyen_nhansu;
GRANT SELECT ON CHAMCONG TO dep_ql_tainguyen_nhansu;
GRANT SELECT ON CTDONTHUOC TO dep_ql_tainguyen_nhansu;
GRANT SELECT ON CTHOADON TO dep_ql_tainguyen_nhansu;
GRANT SELECT ON DICHVU TO dep_ql_tainguyen_nhansu;
GRANT SELECT ON DONTHUOC TO dep_ql_tainguyen_nhansu;
GRANT SELECT ON HOADON TO dep_ql_tainguyen_nhansu;
GRANT SELECT ON HOSOBENHNHAN TO dep_ql_tainguyen_nhansu;
GRANT SELECT ON HOSODICHVU TO dep_ql_tainguyen_nhansu;
GRANT SELECT ON THUOC TO dep_ql_tainguyen_nhansu;
--Grant role to user
GRANT dep_ql_tainguyen_nhansu TO user_tainguyen_nhansu_01;
GRANT dep_ql_tainguyen_nhansu TO user_tainguyen_nhansu_02;
GRANT dep_ql_tainguyen_nhansu TO user_tainguyen_nhansu_03;

--Quan ly tai vu
alter session set "_ORACLE_SCRIPT"=true; 
CREATE ROLE dep_ql_taivu IDENTIFIED BY dep_ql_taivu;
--Grant policy
GRANT INSERT,UPDATE ON DICHVU TO dep_ql_taivu;
GRANT INSERT,UPDATE ON HOADON TO dep_ql_taivu;
GRANT INSERT,UPDATE ON CTHOADON TO dep_ql_taivu;
GRANT SELECT ON BENHNHAN TO dep_ql_taivu;
GRANT SELECT ON CTDONTHUOC TO dep_ql_taivu;
GRANT SELECT ON DONTHUOC TO dep_ql_taivu;
GRANT SELECT ON HOSOBENHNHAN TO dep_ql_taivu;
GRANT SELECT ON HOSODICHVU TO dep_ql_taivu;
GRANT SELECT ON THUOC TO dep_ql_taivu;
GRANT SELECT ON NHANVIEN TO dep_ql_taivu;
GRANT SELECT ON CHAMCONG TO dep_ql_taivu;
GRANT SELECT ON DONVI TO dep_ql_taivu;
--Grant role to user
GRANT dep_ql_taivu TO user_quanly_taivu_01;
GRANT dep_ql_taivu TO user_quanly_taivu_02;
GRANT dep_ql_taivu TO user_quanly_taivu_03;


--Quan ly chuyen mon
alter session set "_ORACLE_SCRIPT"=true; 
CREATE ROLE dep_ql_chuyenmon IDENTIFIED BY dep_ql_chuyenmon;
--Grant policy
GRANT SELECT ON BENHNHAN TO dep_ql_chuyenmon;
GRANT SELECT ON CTDONTHUOC TO dep_ql_chuyenmon;
GRANT SELECT ON DONTHUOC TO dep_ql_chuyenmon;
GRANT SELECT ON HOSOBENHNHAN TO dep_ql_chuyenmon;
GRANT SELECT ON HOSODICHVU TO dep_ql_chuyenmon;
GRANT SELECT ON THUOC TO dep_ql_chuyenmon;
GRANT SELECT ON CHAMCONG TO dep_ql_chuyenmon;
--Grant role to user
GRANT dep_ql_chuyenmon TO user_quanly_chuyenmon_01;
GRANT dep_ql_chuyenmon TO user_quanly_chuyenmon_02;
GRANT dep_ql_chuyenmon TO user_quanly_chuyenmon_03;

-- Reception Role
alter session set "_ORACLE_SCRIPT"=true;  
CREATE ROLE dep_letan  IDENTIFIED BY dep_letan;
-- A43. Grant policy to reception department
GRANT INSERT, SELECT, UPDATE ON BENHNHAN TO dep_letan;
GRANT INSERT, SELECT, UPDATE ON HOSOBENHNHAN TO dep_letan;
-- REVOKE SELECT ON THUOC FROM dep_letan;
GRANT dep_letan TO user_tieptan_01;
GRANT dep_letan TO user_tieptan_02;
GRANT dep_letan TO user_tieptan_03;

--  Doctor role
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE ROLE doctor IDENTIFIED BY doctor;
-- A44. Grant policy to doctor
GRANT INSERT, UPDATE (ketLuanCuaBacSi) ON HOSOBENHNHAN TO doctor;
GRANT INSERT, UPDATE (maKB,maDV,ngayGio) ON HOSODICHVU TO doctor;
-- Grant role to user - doctor
GRANT doctor TO user_bacsi_01;
GRANT doctor TO user_bacsi_02;
GRANT doctor TO user_bacsi_03;


--A46 Grant policy to pharmacy
--user_banthuoc_01
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE ROLE dep_banthuoc IDENTIFIED BY dep_banthuoc;
GRANT SELECT ON THUOC TO dep_banthuoc;
-- Grant role to user - doctor
GRANT dep_banthuoc TO user_banthuoc_01;
GRANT dep_banthuoc TO user_banthuoc_02;
GRANT dep_banthuoc TO user_banthuoc_03;

-- Accounting role
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE ROLE dep_ketoan IDENTIFIED BY dep_ketoan;
-- A47. Grant policy to dep ketoan
GRANT INSERT, DELETE, UPDATE, SELECT ON CHAMCONG TO dep_ketoan;
-- Add role to user
GRANT dep_ketoan to user_ketoan_01;
GRANT dep_ketoan to user_ketoan_02;
GRANT dep_ketoan to user_ketoan_03;






-- TEST
-- TEST
-- TEST
SELECT * FROM CHAMCONG;
SELECT * FROM benhnhan;
SELECT * FROM hosobenhnhan;
SELECT * FROM hosodichvu;
SELECT * FROM hoadon;
SELECT * FROM nhanvien;
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


CREATE ROLE TELLER IDENTIFIED BY TELLER;
GRANT  TELLER TO SCOTT;
GRANT SELECT ON CHAMCONG TO TELLER;



