-- A3. View the list of users in the system
SELECT * FROM Dba_users;

-- A4. Information about the privileges of each user / role on data objects
SELECT * FROM  USER_TAB_PRIVS WHERE TABLE_NAME = 'CHAMCONG' OR  TABLE_NAME = 'BENHNHAN'
OR  TABLE_NAME = 'HOSOBENHNHAN' OR  TABLE_NAME = 'HOSODICHVU' OR  TABLE_NAME = 'HOADON'
OR  TABLE_NAME = 'NHANVIEN' OR  TABLE_NAME = 'DONVI' OR  TABLE_NAME = 'DONTHUOC'
OR  TABLE_NAME = 'DICHVU' OR  TABLE_NAME = 'CTHOADON' OR  TABLE_NAME = 'CTDONTHUOC'
OR  TABLE_NAME = 'THUOC';

-- A6. Grant user permission











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



--
-- Grant role to user
--

-- Bo phan tiep tan
GRANT dep_letan TO user_tieptan_01;
GRANT dep_letan TO user_tieptan_02;
GRANT dep_letan TO user_tieptan_03;







-- TEST
SELECT * FROM ALL_COL_PRIVS;
SELECT * FROM  DBA_ROLE_PRIVS;

SELECT * FROM  USER_ROLE_PRIVS;
SELECT * FROM  Dba_role_privs;


CREATE ROLE TELLER IDENTIFIED BY TELLER;
GRANT  TELLER TO SCOTT;
GRANT SELECT ON CHAMCONG TO TELLER;



