/*****************************
--- A. Admin Test
/*****************************/




---------------------------------------------
--- 1. Test Select grant with column level
------------------------------------------------
CONN U1/U1;
SELECT * FROM DUCCAO_ADMIN.VW_USER_SELECT_COLUMN_LEVEL_U1_NGAYKB_HOSOBENHNHAN;

CONN U1/U1;
GRANT SELECT ON DUCCAO_ADMIN.VW_USER_SELECT_COLUMN_LEVEL_U1_NGAYKB_HOSOBENHNHAN TO U2;

CONN U2/U2;
SELECT * FROM DUCCAO_ADMIN.VW_USER_SELECT_COLUMN_LEVEL_U1_NGAYKB_HOSOBENHNHAN;

---------------------------------------------
--- 2. Test Select grant with role level
------------------------------------------------
GRANT R2 TO U2;

CONN U2/U2;
SET ROLE R2 IDENTIFIED BY R2;
SELECT * FROM DUCCAO_ADMIN.VW_ROLE_SELECT_COLUMN_LEVEL_R2_MANV_HOSOBENHNHAN;




---------------------------------------------
--- 3. TEST FUNCTION ENCRYPT VARCHAR2 
------------------------------------------------

SET SERVEROUTPUT ON SIZE 30000;
DECLARE
RET RAW(128);
BEGIN
    RET:=func_encrypt_varchar2('US01','US01');
    DBMS_OUTPUT.PUT_LINE(RET);
END;
/

---------------------------------------------
--- 4.  TEST FUNCTION DECRYPT VARCHAR2
------------------------------------------------
SET SERVEROUTPUT ON SIZE 30000;
DECLARE 
encrypted_raw RAW(2048);
DECRYPTED_STRING VARCHAR2(2048);  
  KEY_STRING VARCHAR2(200) := 'KEY-USING-TO-Encrypt-&-Decrypt';

BEGIN
    encrypted_raw:=func_encrypt_varchar2('US01',key_string);
   
 DECRYPTED_STRING:= func_decrypt_varchar2(encrypted_raw,key_string);
  dbms_output.put_line(DECRYPTED_STRING);
END;
/


---------------------------------------------
--- 5.  TEST FUNCTION MAT KHAU NHANVIEN
------------------------------------------------

declare 
ret varchar2(200);
begin
ret:= func_decrypt_matkhau_nhanvien('bfc4f3fb2297026b');
dbms_output.put_line('>ret = '||ret);
end;
/


---------------------------------------------
--- 6.  TEST proc_insertViewUserSelectColumnLevel
------------------------------------------------
execute proc_CreateViewUserSelectColumnLevel('U1','MADONVI','DONVI','false');
execute proc_insertViewUserSelectColumnLevel('U1','SELECT','MADONVI','DONVI','false','VW_USER_SELECT_COLUMN_LEVEL_U1_MADONVI_DONVI');
---------------------------------------------
--- 7.  TEST user grant select column level with grant option 
------------------------------------------------
conn u1/u1;
select * from duccao_admin.VW_USER_SELECT_COLUMN_LEVEL_U1_TENDONVI_DONVI;
grant select on duccao_admin.VW_USER_SELECT_COLUMN_LEVEL_U1_TENDONVI_DONVI to u2;


conn u2/u2;
select * from duccao_admin.VW_USER_SELECT_COLUMN_LEVEL_U1_TENDONVI_DONVI;

---------------------------------------------
--- 8.  TEST user grant UPDATE column level with grant option  - not working
------------------------------------------------
conn u1/u1;
grant update(manv) on DUCCAO_ADMIN.HOSOBENHNHAN to u2;

conn u1/u1;
UPDATE DUCCAO_ADMIN.HOSOBENHNHAN SET MANV ='BS02' WHERE MANV='BS01';


---------------------------------------------
--- 9.  TEST user delete privilege - granted is successfully but not working 
------------------------------------------------
conn u1/u1;
delete from DUCCAO_ADMIN.HOADON where sohd=1;



SELECT * FROM DUCCAO_ADMIN.HOADON;
SELECT * FROM DBA_USER_PRIVS;

select * from DUCCAO_ADMIN.nhanvien;



/*****************************
--- B. Users In System Test
/*****************************/



--------------------------------
--- 1. TEST RECEPTION ROLE 
--------------------------------

-- 1.1 Cannot view the 'donGia' field in table Dichvu
CONN USER_TEPTAN_01/USER_TEPTAN_01;
SET ROLE ROLE_DEP_LETAN IDENTIFIED  BY ROLE_DEP_LETAN;
SELECT * FROM DUCCAO_ADMIN.VW_DEP_LETAN_DICHVU;


-- 1.2 Can Select on table BENHNHAN
CONN USER_TEPTAN_01/USER_TEPTAN_01;
SET ROLE ROLE_DEP_LETAN IDENTIFIED  BY ROLE_DEP_LETAN;
SELECT * FROM DUCCAO_ADMIN.BENHNHAN;

-- 1.3 Can Insert on table BENHNHAN
CONN USER_TEPTAN_01/USER_TEPTAN_01;
SET ROLE ROLE_DEP_LETAN IDENTIFIED  BY ROLE_DEP_LETAN;
INSERT INTO DUCCAO_ADMIN.BENHNHAN (MABN,HOTEN,NGAYSINH,DIACHI,SDT)
VALUES (15,'BN10',TO_DATE('12/12/1999','MM/DD/YYYY'),'HCM','123123123');


-- 1.4 Can Update on table BENHNHAN
CONN USER_TEPTAN_01/USER_TEPTAN_01;
SET ROLE ROLE_DEP_LETAN IDENTIFIED  BY ROLE_DEP_LETAN;
UPDATE DUCCAO_ADMIN.BENHNHAN SET DIACHI = 'HCM UPDATED' WHERE MABN=15;


-- 1.5 Can Select on table HOSOBENHNHAN
CONN USER_TEPTAN_01/USER_TEPTAN_01;
SET ROLE ROLE_DEP_LETAN IDENTIFIED  BY ROLE_DEP_LETAN;
SELECT * FROM DUCCAO_ADMIN.HOSOBENHNHAN;

-- 1.6 Can Insert on table HOSOBENHNHAN
CONN USER_TEPTAN_01/USER_TEPTAN_01;
SET ROLE ROLE_DEP_LETAN IDENTIFIED  BY ROLE_DEP_LETAN;
INSERT INTO DUCCAO_ADMIN.HOSOBENHNHAN (MAKB, NGAYKB, TENBACSI, MABN, TINHTRANGBANDAU)   
VALUES (15,TO_DATE('12/12/1999','MM/DD/YYYY'),'USER_BACSI_01',1,'HO');


-- 1.7 Can Update on table HOSOBENHNHAN
CONN USER_TEPTAN_01/USER_TEPTAN_01;
SET ROLE ROLE_DEP_LETAN IDENTIFIED  BY ROLE_DEP_LETAN;
UPDATE DUCCAO_ADMIN.HOSOBENHNHAN SET TINHTRANGBANDAU = 'HO UPDATED' WHERE MAKB=15;


-- Check Role Priv
CONN USER_TEPTAN_01/USER_TEPTAN_01;
SELECT * FROM DUCCAO_ADMIN.VW_DEP_LETAN_DICHVU;


-------------------------------------
--- 2. TEST ACCOUNTING DEPARMENT ROLE
------------------------------------

-- 2.1 User in Ketoan can Select on CHAMCONG
CONN USER_KETOAN_01/USER_KETOAN_01;
SET ROLE ROLE_DEP_KETOAN IDENTIFIED BY ROLE_DEP_KETOAN;
SELECT * FROM DUCCAO_ADMIN.CHAMCONG;

-- 2.2 User in Ketoan ca UPDATE 'LUONG' field on tbl NHANVIEN
CONN USER_KETOAN_01/USER_KETOAN_01;
SET ROLE ROLE_DEP_KETOAN IDENTIFIED BY ROLE_DEP_KETOAN;
UPDATE DUCCAO_ADMIN.NHANVIEN SET LUONG ='20.000.000' WHERE MANV = 'BS01';




-------------------------------
--- 3. TEST DOCTOR ROLE
----------------------------
-- USER_BACSI_01

-- p1. Only SELECT patient information for their responsibility
SELECT * FROM DUCCAO_ADMIN.HOSOBENHNHAN;

CONN USER_BACSI_01/USER_BACSI_01;
SET ROLE ROLE_DOCTOR IDENTIFIED  BY ROLE_DOCTOR;
SELECT * FROM DUCCAO_ADMIN.HOSOBENHNHAN;



-- p1. Only UPDATE patient information for their responsibility
CONN USER_BACSI_01/USER_BACSI_01;
SET ROLE ROLE_DOCTOR IDENTIFIED  BY ROLE_DOCTOR;
UPDATE DUCCAO_ADMIN.HOSOBENHNHAN SET KETLUANCUABACSI ='KHOE MANH!' WHERE MAKB = 1 ;

-- P2. Only SELECT, INSERT, UPDATE ON CTDONTHUOC for their responsibility
-- SELECT
CONN USER_BACSI_01/USER_BACSI_01;
SET ROLE ROLE_DOCTOR IDENTIFIED  BY ROLE_DOCTOR;
SELECT * FROM DUCCAO_ADMIN.VIEW_VPD_DOCTOR_CTDONTHUOC;

-- feature view patient info
CONN USER_BACSI_01/USER_BACSI_01;
SET ROLE ROLE_DOCTOR IDENTIFIED  BY ROLE_DOCTOR;
SELECT * FROM DUCCAO_ADMIN.VIEW_DOCTOR_SEE_PATIENT_INFO;



----------------------------
-- More policies for Doctor Role
----------------------------

-- mp1. Doctor see their infor only
CONN USER_BACSI_01/USER_BACSI_01;
SET ROLE ROLE_DOCTOR IDENTIFIED  BY ROLE_DOCTOR;
SELECT * FROM DUCCAO_ADMIN.VW_DOCTOR_SEE_THEIR_INFO;

SELECT * FROM DUCCAO_ADMIN.nhanvien;




-----------------------------
-- 3. TEST MANAGEMENT DEPARTMENT ROLE
--------------------------
-- Quan ly tai nguyen & nhan su
-- Can see every column except the others's salary
CONN USER_TAINGUYEN_NHANSU_01/USER_TAINGUYEN_NHANSU_01;
SET ROLE ROLE_DEP_QL_TG_NS IDENTIFIED  BY ROLE_DEP_QL_TG_NS;
SELECT * FROM DUCCAO_ADMIN.VW_DEP_QL_TAINGUYEN_NHANSU;

-- Insert nhan vien into table NHANVIEN except luong column can't be insert
CONN USER_TAINGUYEN_NHANSU_01/USER_TAINGUYEN_NHANSU_01;
SET ROLE ROLE_DEP_QL_TG_NS IDENTIFIED  BY ROLE_DEP_QL_TG_NS;
insert into DUCCAO_ADMIN.NHANVIEN (maNV, hoTen,matKhau, ngaySinh, diaChi, vaiTro, maDonVi) 
values ('testnv01','testnv01','testnv01',TO_DATE('12/01/1960', 'DD/MM/YYYY'),'174 Tran Quang Khai, Thu Duc Ward, Dist.1,TP HCM','NHANVIEN_QUANLY_TAINGUYEN_NHANSU',1);

-- Delete nhan vien recode in table NHANVIEN
Delete from NHANVIEN where manv = 'testnv01';

-- Insert nhan vien into table NHANVIEN except luong column can't be insert
CONN USER_TAINGUYEN_NHANSU_01/USER_TAINGUYEN_NHANSU_01;
SET ROLE ROLE_DEP_QL_TG_NS IDENTIFIED  BY ROLE_DEP_QL_TG_NS;
insert into DUCCAO_ADMIN.NHANVIEN (maNV, hoTen,matKhau, ngaySinh, diaChi, vaiTro, maDonVi) 
values ('testnv01','testnv01','testnv01',TO_DATE('12/01/1960', 'DD/MM/YYYY'),'174 Tran Quang Khai, Thu Duc Ward, Dist.1,TP HCM','NHANVIEN_QUANLY_TAINGUYEN_NHANSU',1);

-- Quan ly tai vu --
--------------------
-- Insert nhan vien quan ly tai vu into table NHANVIEN
insert into NHANVIEN (maNV, hoTen,matKhau,luong, ngaySinh, diaChi, vaiTro, maDonVi) 
values ('testnvqltaivu01','USER_QUANLY_TAIVU_01','USER_QUANLY_TAIVU_01',10000000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'174 Tran Quang Khai, Thu Duc Ward, Dist.1,TP HCM','USER_QUANLY_TAIVU_01',4);

-- Can see every table except the column of others's salary and the password of others's user
-- !! this works only when user connect to database properly without usign conn
--CONN USER_QUANLY_TAIVU_01/USER_QUANLY_TAIVU_01;
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE; 
SET ROLE ROLE_DEP_QL_TAIVU IDENTIFIED  BY ROLE_DEP_QL_TAIVU;
SELECT * FROM DUCCAO_ADMIN.BENHNHAN;
SELECT * FROM DUCCAO_ADMIN.CHAMCONG;
SELECT * FROM DUCCAO_ADMIN.CTDONTHUOC;
SELECT * FROM DUCCAO_ADMIN.CTHOADON;
SELECT * FROM DUCCAO_ADMIN.DICHVU;
SELECT * FROM DUCCAO_ADMIN.DONTHUOC;
SELECT * FROM DUCCAO_ADMIN.DONVI;
SELECT * FROM DUCCAO_ADMIN.HOADON;
SELECT * FROM DUCCAO_ADMIN.HOSOBENHNHAN;
SELECT * FROM DUCCAO_ADMIN.HOSODICHVU;
SELECT * FROM DUCCAO_ADMIN.THUOC;

--view to show only password and salary of current logged in user
show user;
SELECT * FROM DUCCAO_ADMIN.VW_NHANVIEN_DEP_QL_TAIVU;

--Cap nhat cac truong sau
select * from DUCCAO_ADMIN.DICHVU;
update DUCCAO_ADMIN.DICHVU set DONGIA = 151000 where madv = 1;

select * from DUCCAO_ADMIN.HOADON;
update DUCCAO_ADMIN.HOADON set TONGTIEN = 151000 where sohd = 5;

select * from DUCCAO_ADMIN.THUOC;
update DUCCAO_ADMIN.THUOC set DONGIA = 25000 where mathuoc = 1;


-- Quan ly chuyen mon --
------------------------
select * from nhanvien;
-- insert du lieu mau de test
insert into NHANVIEN (maNV, hoTen,matKhau,luong, ngaySinh, diaChi, vaiTro, maDonVi) 
values ('testnvqlcm01','USER_QUANLY_CHUYENMON_01','USER_QUANLY_CHUYENMON_01',28000000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'174 Tran Quang Khai, Thu Duc Ward, Dist.1,TP HCM','NHANVIEN_QUANLY_TAINGUYEN_NHANSU',1);

--Khong xem duoc luong va mat khau dang nhap cua nhan vien khac trong bang nhan vien
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
SET ROLE ROLE_DEP_QL_CHUYENMON IDENTIFIED  BY ROLE_DEP_QL_CHUYENMON;
show user;
select * from DUCCAO_ADMIN.VW_NHANVIEN_DEP_QL_CHUYENMON;

--Khong duoc them xoa sua nhung thong tin khac(Bang khac)
--test
UPDATE DUCCAO_ADMIN.NHANVIEN SET luong = 0;

-----------------------------------------------------------------
-- . TEST ACCOUNTING ROOM - 
--------------------------------------------------------------
CONN USER_TAIVU_01/USER_TAIVU_01;
SET ROLE  NHANVIEN_TAIVU IDENTIFIED BY NHANVIEN_TAIVU;
SELECT * FROM DUCCAO_ADMIN.DICHVU;
SELECT * FROM DUCCAO_ADMIN.HOADON;
SELECT * FROM DUCCAO_ADMIN.CTHOADON;
SELECT * FROM DUCCAO_ADMIN.VW_NHANVIEN_TAIVU_CHITTIETHOADON;
-----------------------------------------------------------------
-- 4. TEST ACCOUNTING DEPARMENT - procedure calculate salary
--------------------------------------------------------------
CONN USER_KETOAN_01/USER_KETOAN_01;
SET ROLE  ROLE_DEP_KETOAN IDENTIFIED BY ROLE_DEP_KETOAN;
EXEC DUCCAO_ADMIN.PROC_CAL_SALARY('BS02','12-JAN-60','1112321322');



CONN USER_KETOAN_01/USER_KETOAN_01;
SET ROLE  ROLE_DEP_KETOAN IDENTIFIED BY ROLE_DEP_KETOAN;
EXEC   DUCCAO_ADMIN.PROC_CAL_SALARY('BS02','12-Jan-60','7912000');

-----------------------------------------------------------------
--  procedure reset salary
--------------------------------------------------------------
exec PROC_SET_SALARY_TO_0('','','');


-----------------------------------------------------------------
-- 5. TEST RECEPTION ROLE 
--------------------------------------------------------------

-- WATCH HSBN RECORDS
CONN USER_TEPTAN_01/USER_TEPTAN_01;
SET  ROLE ROLE_DEP_LETAN IDENTIFIED BY ROLE_DEP_LETAN;
SELECT * FROM DUCCAO_ADMIN.HOSOBENHNHAN;

-- WATCH BN RECORDS
CONN USER_TEPTAN_01/USER_TEPTAN_01;
SET  ROLE ROLE_DEP_LETAN IDENTIFIED BY ROLE_DEP_LETAN;
SELECT * FROM DUCCAO_ADMIN.BENHNHAN;

-- VIEW Of reception
CONN USER_TIEPTAN_01/USER_TIEPTAN_01;
SET  ROLE ROLE_DEP_LETAN IDENTIFIED BY ROLE_DEP_LETAN;
SELECT * FROM DUCCAO_ADMIN.VIEW_RECEPTION;

-- VIEW DOCTOR VIEW_RECEPTION_DOCTOR
CONN USER_TIEPTAN_01/USER_TIEPTAN_01;
SET  ROLE ROLE_DEP_LETAN IDENTIFIED BY ROLE_DEP_LETAN;
SELECT * FROM DUCCAO_ADMIN.VIEW_RECEPTION_DOCTOR;


-- PROC ADD NEW PATIENT RECORDS
CONN USER_TIEPTAN_01/USER_TIEPTAN_01;
SET  ROLE ROLE_DEP_LETAN IDENTIFIED BY ROLE_DEP_LETAN;
EXEC DUCCAO_ADMIN.PROC_RECEPTION_ADD_NEW_PATIENT (17,'DUC CAO 2',TO_DATE('27/03/1999','DD/MM/YYYY'),'HCMUS Q5','123456789',9,TO_DATE('09/05/2021','DD/MM/YYYY'),'BS02','USER_BACSI_02',17,'KHO THO 2','');

--  DELETE PATIENT RECORDS
CONN USER_TIEPTAN_01/USER_TIEPTAN_01;
SET  ROLE ROLE_DEP_LETAN IDENTIFIED BY ROLE_DEP_LETAN;
EXEC PROC_DEL_PATIENT_RECORDS(2,2);

-- UPDATE PATIENT RECORDS
CONN USER_TIEPTAN_01/USER_TIEPTAN_01;
ALTER SESSION SET CURRENT_SCHEMA = USER_TIEPTAN_01;
SET  ROLE ROLE_DEP_LETAN IDENTIFIED BY ROLE_DEP_LETAN;
EXEC DUCCAO_ADMIN.PROC_EDIT_PATIENT_INFO(1,'ASDF',TO_DATE('27/03/1999','DD/MM/YYYY'),'ASDF','00901435802',1,TO_DATE('27/03/1999','DD/MM/YYYY'),'BS01','USER_BACSI_01',1,'ASDF','');


CONN USER_TIEPTAN_01/USER_TIEPTAN_01;
ALTER SESSION SET CURRENT_SCHEMA = USER_TIEPTAN_01;
SET  ROLE ROLE_DEP_LETAN IDENTIFIED BY ROLE_DEP_LETAN;
SELECT * FROM DUCCAO_ADMIN.VIEW_RECEPTION_DOCTOR;

CONN USER_TIEPTAN_01/USER_TIEPTAN_01;
SET  ROLE ROLE_DEP_LETAN IDENTIFIED BY ROLE_DEP_LETAN;
EXEC DUCCAO_ADMIN.PROC_EDIT_PATIENT_INFO(4,'123123',TO_DATE('01/01/2021','DD/MM/YYYY'),'DASD','0901435802',4,TO_DATE('11/05/2021','DD/MM/YYYY'),'BS01','USER_BACSI_01',4,'CASD','');

-- -- -- -- -- -- -- 
-- TEST AUDIT TRIGGER
-- -- -- -- -- -- -- 
SET SERVEROUTPUT ON SIZE 30000;
EXEC SHOW_AUDIT_LUONG_NHANVIEN;
SELECT * FROM AUDIT_LUONG_NHANVIEN;

-- -- -- -- -- -- -- 
-- TEST PURE AUDIT 
-- -- -- -- -- -- -- 
SELECT DBUSERNAME, ACTION_NAME, SQL_TEXT, OBJECT_SCHEMA, OBJECT_NAME, EVENT_TIMESTAMP 
FROM UNIFIED_AUDIT_TRAIL
WHERE DBUSERNAME = 'DUCCAO_ADMIN'
ORDER BY EVENT_TIMESTAMP DESC ;

-- AUDIT NHANVIEN
SELECT DBUSERNAME, ACTION_NAME, SQL_TEXT, OBJECT_SCHEMA, OBJECT_NAME, EVENT_TIMESTAMP 
FROM UNIFIED_AUDIT_TRAIL
WHERE DBUSERNAME = 'USER_TIEPTAN_01'
ORDER BY EVENT_TIMESTAMP DESC ;




