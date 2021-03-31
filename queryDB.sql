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

-- A6. Grant user permission
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER DUCCAO IDENTIFIED BY DUCCAO;
CREATE USER USER_TEMP_01 IDENTIFIED BY USER_TEMP_01;
CREATE USER USER_TEMP_02 IDENTIFIED BY USER_TEMP_02;
CREATE USER USER_TEMP_03 IDENTIFIED BY USER_TEMP_03;
GRANT ALL PRIVILEGES TO DUCCAO;
GRANT select, insert ON Employee TO duccao WITH GRANT OPTION;

-- A7. Grant Role Permission
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE ROLE ROLE_TEMP_01 IDENTIFIED BY ROLE_TEMP_01;
CREATE ROLE ROLE_TEMP_02 IDENTIFIED BY ROLE_TEMP_02;
CREATE ROLE ROLE_TEMP_03 IDENTIFIED BY ROLE_TEMP_03;
GRANT SELECT ON CHAMCONG TO ROLE_TEMP_01;










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
SELECT * FROM ALL_COL_PRIVS;
SELECT * FROM  DBA_ROLE_PRIVS;

SELECT * FROM  USER_ROLE_PRIVS;
SELECT * FROM  DBA_TAB_PRIVS;


CREATE ROLE TELLER IDENTIFIED BY TELLER;
GRANT  TELLER TO SCOTT;
GRANT SELECT ON CHAMCONG TO TELLER;



