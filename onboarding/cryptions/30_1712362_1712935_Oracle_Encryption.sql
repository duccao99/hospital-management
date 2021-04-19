-- MON: An Toan & Bao Mat Du Lieu Trong He Thong Thong Tin
-------------------------------------------------------

    -- NHOM: 30
    -- Thanh vien:
    --  1712935 - PHOMMALA Sisouvanh
    --  1712362 - Trinh Cao Van Duc
    

-------------------------------------------------------


-- Cau 1: Cai dat CSDL va nhap du lieu mau
-- Xoa cac bang neu truoc do da ton tai

DECLARE 
    SINHVIEN_count number;
    MONHOC_count number;
    DANGKY_count number;
begin
    SELECT count(*) into SINHVIEN_count from all_objects
    where object_type in ('TABLE','VIEW')
    and object_name = 'SINHVIEN';
    
    SELECT count(*) into MONHOC_count from all_objects
    where object_type in ('TABLE','VIEW')
    and object_name = 'MONHOC';
    
    SELECT count(*) into DANGKY_count from all_objects
    where object_type in ('TABLE','VIEW')
    and object_name = 'DANGKY';
    
    IF DANGKY_count != 0 then
       EXECUTE IMMEDIATE 'DROP TABLE ' || 'DANGKY';
    end if;
    IF SINHVIEN_count != 0 then
       EXECUTE IMMEDIATE 'DROP TABLE ' || 'SINHVIEN';
    end if;
    IF MONHOC_count != 0 then
       EXECUTE IMMEDIATE 'DROP TABLE ' || 'MONHOC';
    end if;
end;
/

-- Tao bang SINHVIEN
create table SINHVIEN (
     MSSV varchar2(10) not null,
     HoTenSV varchar2(60) not null,
     DTB number,
     primary key (MSSV)
);

-- Tao bang MONHOC
create table MONHOC (
     MaMH varchar2(8) not null,
     TenMH varchar2(80) not null,
     GVPhuTrach varchar2(5) not null,
     primary key (MaMH)
);

-- Tao bang DANGKY
create table DANGKY (
     MSSV varchar2(10) not null,
     MaMH varchar2(8) not null,
     HocKy number(1) not null,
     DiemThi number,
     primary key (MSSV, MaMH, HocKy)
);


------------------------
-- Add Foreign Key
------------------------
alter table DANGKY 
add constraint DANGKY_SINHVIEN_FK 
foreign key (MSSV) 
references SINHVIEN;

-- Tao khoa ngoai toi bang MONHOC
alter table DANGKY 
add constraint DANGKY_MONHOC_FK 
foreign key (MaMH) 
references MONHOC;

--------------------------
---- Add records
--------------------------
-- Nhap du lieu cho bang SINHVIEN
insert into SINHVIEN (MSSV, HoTenSV, DTB) values ('1712362', 'Duccao', 9);
insert into SINHVIEN (MSSV, HoTenSV, DTB) values ('1712102', 'Hua Mi Nghi', 8.5);
insert into SINHVIEN (MSSV, HoTenSV, DTB) values ('1712935', 'Nguyen Van Ni', 6.75);
insert into SINHVIEN (MSSV, HoTenSV, DTB) values ('1715008', 'Nguyen Thi Ngan', 7);
insert into SINHVIEN (MSSV, HoTenSV, DTB) values ('1712482', 'Tran Van Khanh', 5.5);

-- Nhap du lieu cho bang MONHOC
insert into MONHOC (MaMH, TenMH, GVPhuTrach) values ('CSC12001', 'An toan va bao mat du lieu trong he thong thong tin', 'GV01');
insert into MONHOC (MaMH, TenMH, GVPhuTrach) values ('CSC12004', 'Phan tich thiet ke he thong thong tin', 'GV02');
insert into MONHOC (MaMH, TenMH, GVPhuTrach) values ('CSC12105', 'Thuong mai dien tu', 'GV03');

-- Nhap du lieu cho bang DANGKY
insert into DANGKY (MSSV, MaMH, HocKy, DiemThi) values ('1712362', 'CSC12004', 2, 10);
insert into DANGKY (MSSV, MaMH, HocKy, DiemThi) values ('1712362', 'CSC12105', 2,8.5);
insert into DANGKY (MSSV, MaMH, HocKy, DiemThi) values ('1712362', 'CSC12001', 2, 9);
insert into DANGKY (MSSV, MaMH, HocKy, DiemThi) values ('1715008', 'CSC12105', 2, 5.5);
insert into DANGKY (MSSV, MaMH, HocKy, DiemThi) values ('1715008', 'CSC12004', 2, 6.75);
insert into DANGKY (MSSV, MaMH, HocKy, DiemThi) values ('1712482', 'CSC12001', 2, 4);
insert into DANGKY (MSSV, MaMH, HocKy, DiemThi) values ('1712482', 'CSC12004', 2, 6.75);
insert into DANGKY (MSSV, MaMH, HocKy, DiemThi) values ('1712102', 'CSC12001', 2, 7.25);
insert into DANGKY (MSSV, MaMH, HocKy, DiemThi) values ('1712102', 'CSC12105', 2, 6);
insert into DANGKY (MSSV, MaMH, HocKy, DiemThi) values ('1712935', 'CSC12004', 2, 8.5);
insert into DANGKY (MSSV, MaMH, HocKy, DiemThi) values ('1712935', 'CSC12001', 2, 7.5);



-- Cau 2: Tao tai khoan nguoi dung

 -- Tai khoan hoc sinh
ALTER SESSION SET "_ORACLE_SCRIPT"= TRUE;
CREATE USER a1712362 IDENTIFIED BY a1712362;
CREATE USER a1712102 IDENTIFIED BY a1712102;
CREATE USER a1712935 IDENTIFIED BY a1712935;
CREATE USER a1715008 IDENTIFIED BY a1715008;
CREATE USER a1712482 IDENTIFIED BY a1712482;

GRANT CREATE SESSION TO a1712362;
GRANT CREATE SESSION TO a1712102;
GRANT CREATE SESSION TO a1712935;
GRANT CREATE SESSION TO a1715008;
GRANT CREATE SESSION TO a1712482;



-- Tai khoan giao vien

CREATE USER GV01 IDENTIFIED BY GV01;
CREATE USER GV02 IDENTIFIED BY GV02;

GRANT CREATE SESSION TO GV01;
GRANT CREATE SESSION TO GV02;


-- Tai khoan giao vu
CREATE USER GIAOVU IDENTIFIED BY GIAOVU;

GRANT CREATE SESSION TO GIAOVU;



-----------------------------------------------------------------------
-- Cau 3a: Chi co sinh vien duoc xem diem thi & diem trung binh cua minh
--------------------------------------------------------------------------


-- Ma hoa dtb,diemthi cua sinh vien su dung thuat toan DES_CBC_PKCS5 
-- Solution:
-- 0. Create Function Encrypt - (input Diem thi/dtb INT, key_string) , output: Diem thi/dtb encrypted
-- 1. Create Procedure Decrypt - (input Diem thi/dtb encrypted, key_string) , output: Diemthi/dtb INT
-- 2. Create Procedure using loop to encrypt all dtb fields 
-- 3. Create Procedure using loop to encrypt all diem thi fields 
-- 4. Handle User login decrypt dtb   field
-- 4. Handle User login decrypt diem thi field




-- 0. Function Encrypt
-- Input: Data to encrypt Type INT, key string Type Varchar2
-- Output: encrypted data Type Raw
CREATE OR REPLACE FUNCTION  FUNC_ENCRYPT(input_data IN INT,input_key_string VARCHAR2 )
RETURN RAW
IS
input_int INT :=input_data;
raw_input RAW(128):=UTL_RAW.CAST_TO_RAW(CONVERT(input_int,'AL32UTF8','US7ASCII'));

key_string VARCHAR2(200):=input_key_string;
raw_key RAW(128):=UTL_RAW.CAST_TO_RAW(CONVERT(key_string,'AL32UTF8','US7ASCII'));

 encrypted_raw RAW(2048);
 encrypted_string VARCHAR2(2048);
 decrypted_raw RAW(2048);
 decrypted_string VARCHAR2(2048);


BEGIN
   -- dbms_output.put_line('> Input int : ' || input_int);
    dbms_output.put_line('> ========= BEGIN Encrypt =========');
    
    encrypted_raw := dbms_crypto.Encrypt(
        src => raw_input,
        typ => dbms_crypto.DES_CBC_PKCS5,
        key => raw_key      
    );
    
    ---dbms_output.put_line('> Encrypted ret: '||encrypted_raw);
    dbms_output.put_line('> ========= END Encrypt =========');

    RETURN encrypted_raw;

END FUNC_ENCRYPT;
/

-- Test function encrypt
--SET SERVEROUTPUT ON SIZE 30000;
--declare 
--ret raw(128);
--begin
--ret:=FUNC_ENCRYPT(10,'a1712362');
--dbms_output.put_line(ret);
--end;
--/


-- 1. Function Decrypt - Input encrypted_raw, key_string - Output value Number
-- Input: encrypted data Type Raw, key string Type Varchar2
-- Output: Decrypted Data Type Number
CREATE OR REPLACE FUNCTION FUNC_DECRYPT(input_raw_data IN RAW, input_key_string_data VARCHAR2)
RETURN NUMBER
IS
input_raw RAW(128):=input_raw_data;
input_key_string VARCHAR2(200) := input_key_string_data;
input_key_raw RAW(128):= UTL_RAW.CAST_TO_RAW(CONVERT(input_key_string,'AL32UTF8','US7ASCII'));

decrypted_raw RAW(128);
decrypted_nvarchar2 VARCHAR2(200);
decrypted_ret NUMBER;
BEGIN
    decrypted_raw:=dbms_crypto.Decrypt(
        src => input_raw,
        typ => dbms_crypto.DES_CBC_PKCS5,
        key =>input_key_raw
    );
    
    decrypted_nvarchar2:= CONVERT(UTL_RAW.CAST_TO_VARCHAR2(decrypted_raw),'US7ASCII','AL32UTF8');
    decrypted_ret:=TO_NUMBER(decrypted_nvarchar2,'999');
  RETURN decrypted_ret;
END  FUNC_DECRYPT;
/



-- Test function decrypt
--SET SERVEROUTPUT ON SIZE 30000;
--declare
--ret NUMBER;
--encrypted_raw raw(128);
--
--begin
--  encrypted_raw:='6593049A6B04B439';
--  ret:=  FUNC_DECRYPT(encrypted_raw,'a1712362'); 
--  dbms_output.put_line(ret);
--end;
--/



-- 2. Procedure Encrypt All DTB Fields
CREATE OR REPLACE PROCEDURE Encrypt_SINHVIEN_DTB
IS
len_tbl_sinhvien INT;
executer NVARCHAR2(1000);
ii INT;
c1 NVARCHAR2(100);

CURSOR c_mssv IS SELECT MSSV FROM SYS.SINHVIEN;
CURSOR c_dtb IS SELECT DTB FROM SYS.SINHVIEN;

TYPE arr_mssv IS VARRAY(100)OF SYS.SINHVIEN.MSSV%TYPE;
TYPE arr_dtb IS VARRAY(100)OF SYS.SINHVIEN.DTB%TYPE;

mssvs arr_mssv:=arr_mssv();
dtbs arr_dtb:=arr_dtb();

counter INTEGER:=0;

input_data NUMBER;
key_string VARCHAR2(200);

encrypted_raw RAW(128);

BEGIN
    --MSSV
   FOR ms IN c_mssv LOOP
    counter:=counter+1;
    mssvs.extend;
    mssvs(counter):=ms.mssv;
   END LOOP;
   
   counter:=0;
   -- DTB
   FOR dd IN c_dtb LOOP
   counter:=counter+1;
   dtbs.extend;
   dtbs(counter):=dd.dtb;
   END LOOP;
   
   
   -- Encrypt
   executer:='SELECT COUNT(*) FROM SYS.SINHVIEN ';
   EXECUTE IMMEDIATE (executer) INTO len_tbl_sinhvien;
   FOR ii IN 1..len_tbl_sinhvien LOOP
   input_data:=  dtbs(ii);
   key_string:='a'|| mssvs(ii);
   
   encrypted_raw := Func_encrypt(input_data,key_string);
   
    executer:='UPDATE SINHVIEN SET DTB = '
     ||rawtohex(UTL_RAW.CAST_TO_RAW(encrypted_raw))
    || 'WHERE MSSV = ' ||mssvs(ii);
    
    EXECUTE IMMEDIATE(executer);
     
   -- debug
   dbms_output.put_line('Ma hoa thu: '|| ii || ' la : '|| encrypted_raw);  
   -- debug
   -- dbms_output.put_line('diem thu: '|| ii || ' la : '|| dtbs(ii));
   -- dbms_output.put_line('mssv thu: '|| ii|| 'la: '|| mssvs(ii)); 
   END LOOP;
END Encrypt_SINHVIEN_DTB;
/


-- Thuc thi ma hoa truong dtb cua bang SINHVIEN
SET SERVEROUTPUT ON SIZE 30000;
EXEC Encrypt_SINHVIEN_DTB;

-- 3. Procedure Encrypt ALL diem thi Fields
CREATE OR REPLACE PROCEDURE Encrypt_DANGKY_DIEMTHI
IS
len_tbl_dangky INT;
exe NVARCHAR2(1000);
ii INT;

c1 NVARCHAR2(100);

CURSOR c_mssv IS SELECT MSSV FROM SYS.DANGKY;
CURSOR c_diemthi IS SELECT DIEMTHI FROM SYS.DANGKY;

TYPE arr_mssv IS VARRAY(100) OF SYS.DANGKY.MSSV%TYPE;
TYPE arr_diemthi IS VARRAY(100) OF SYS.DANGKY.DIEMTHI%TYPE;

mssvs arr_mssv:=arr_mssv();
diemthis arr_diemthi:=arr_diemthi();


counter INTEGER :=0;

input_data NUMBER;
key_string VARCHAR2(200);

encrypted_raw  RAW(128);
BEGIN
    -- Get array mssv
    FOR ms IN c_mssv LOOP
        counter:=counter+1;
        mssvs.extend;
        mssvs(counter):=ms.mssv;
    END LOOP;
    
    counter:=0;
    -- get array diem
    FOR dd IN c_diemthi LOOP
        counter:=counter+1;
        diemthis.extend;
        diemthis(counter):=dd.diemthi;
    END LOOP;
    
    -- Encrypt
    exe:='SELECT COUNT(*) FROM SYS.DANGKY';
    EXECUTE IMMEDIATE (exe) INTO len_tbl_dangky;
    
    FOR II IN 1..len_tbl_dangky LOOP
        input_data :=diemthis(ii);
        key_string :='a'||mssvs(ii);
        
        encrypted_raw:= func_encrypt(input_data,key_string);
        
        exe:='UPDATE DANGKY SET DIEMTHI = '
        || RAWTOHEX(utl_raw.cast_to_raw(encrypted_raw))
        || 'WHERE MSSV = '|| mssvs(ii);
        
        EXECUTE IMMEDIATE(exe);
    
    --debug
    dbms_output.put_line(encrypted_raw);
    END LOOP;
END Encrypt_DANGKY_DIEMTHI;
/

-- Thuc thi ma hoa truong diemthi cua bang dangky -  khong the thuc thi vi 5. chua lam duoc
-- SET SERVEROUTPUT ON SIZE 30000;
-- EXEC Encrypt_DANGKY_DIEM;


-- 4. Handle Login Decrypt DTB Sinhvien
CREATE OR REPLACE  FUNCTION  FUNC_SINHVIEN_LOGIN_DECRYPT_DIEM
(curr_user in varchar2)
RETURN VARCHAR2
IS
exe VARCHAR2(1000);
RET NUMBER:=0;

curr VARCHAR2(200);
curr_mssv VARCHAR2(200);
curr_dtb_hex_number NUMBER;
curr_dtb_varchar2 VARCHAR2(200);


BEGIN 
    curr:=lower(curr_user);
    curr_mssv:=substr(curr,2,LENGTH(curr));
    
    exe := 'SELECT DTB FROM SYS.SINHVIEN WHERE MSSV = '||curr_mssv;
    EXECUTE IMMEDIATE (exe) INTO curr_dtb_hex_number;
    
  curr_dtb_varchar2:=UTL_RAW.CAST_TO_VARCHAR2(HEXTORAW(curr_dtb_hex_number));
    
   RET:=func_decrypt(curr_dtb_varchar2,curr);

--dbms_output.put_line(ret);
    
     RETURN RET;
END FUNC_SINHVIEN_LOGIN_DECRYPT_DIEM;
/

-- 5. Handle Login Decrypt diemthi DANGKY - still not done!
CREATE OR REPLACE FUNCTION FUNC_SINHVIEN_LOGIN_DECRYPT_DIEMTHI
(curr_user IN VARCHAR2) 
RETURN VARCHAR2
IS
executer VARCHAR2(1000);
RET NUMBER:=0;



LEN_Diemthi_dangky INT;
II INT;

CURSOR c_mssv IS SELECT MSSV FROM SYS.DANGKY;
CURSOR c_diemthi IS SELECT DIEMTHI FROM SYS.DANGKY ;

TYPE arr_mssv IS VARRAY(100) OF SYS.DANGKY.MSSV%TYPE;
TYPE arr_diemthi IS VARRAY(100) OF SYS.DANGKY.DIEMTHI%TYPE;

mssvs arr_mssv:=arr_mssv();
diemthis arr_diemthi:=arr_diemthi();

curr_diemthi_hex_number NUMBER;
curr_diemthi_varchar2 VARCHAR2(200);

counter INTEGER:=0;

curr VARCHAR2(200):=lower(curr_user);
curr_mssv VARCHAR2(200):=SUBSTR(curr,2,length(curr));

BEGIN



FOR ms IN c_mssv LOOP
counter:=counter+1;
mssvs.extend;
mssvs(counter):=ms.mssv;
--dbms_output.put_line(mssvs(counter));
END LOOP;

counter:=0; 

FOR diem IN c_diemthi LOOP
counter:=counter+1;
diemthis.extend;
diemthis(counter):=diem.diemthi;
--dbms_output.put_line(diemthis(counter));
END LOOP;

executer:='SELECT COUNT(*) FROM DANGKY ';
EXECUTE IMMEDIATE (executer) INTO LEN_Diemthi_dangky;

-- dbms_output.put_line((LEN_Diemthi_dangky));

FOR ii IN 1..LEN_Diemthi_dangky LOOP
    IF(MSSVS(ii)='1712362')THEN
        -- dbms_output.put_line(diemthis(ii));
    curr_diemthi_varchar2:=UTL_RAW.CAST_TO_VARCHAR2(HEXTORAW(diemthis(ii)));
   RET:=func_decrypt(curr_diemthi_varchar2,'a1712362');
              dbms_output.put_line(RET);
 
    END IF;
END LOOP;
return 0;

--curr_diemthi_varchar2:=UTL_RAW.CAST_TO_VARCHAR2(HEXTORAW(curr_diemthi_varchar2));
--
--RET:= func_decrypt(curr_diemthi_varchar2,curr);

END FUNC_SINHVIEN_LOGIN_DECRYPT_DIEMTHI;
/

-- View Xem DTB da duoc decrypt 
CREATE OR REPLACE VIEW VW_SINHVIEN_XEM_DTB
AS
SELECT  FUNC_SINHVIEN_LOGIN_DECRYPT_DIEM(sys_context('userenv','session_user')) 
AS DTB, DANGKY.diemthi as diemthi, monhoc.tenmh
FROM DUAL, SYS.DANGKY, sys.monhoc
WHERE DANGKY.MSSV=SUBSTR(sys_context('userenv','session_user'),2,
length(sys_context('userenv','session_user')))
AND monhoc.MAMH= DANGKY.MAMH;



GRANT SELECT ON SYS.VW_SINHVIEN_XEM_DTB TO a1712362;
GRANT SELECT ON SYS.VW_SINHVIEN_XEM_DTB TO a1712102;
GRANT SELECT ON SYS.VW_SINHVIEN_XEM_DTB TO a1712935;
GRANT SELECT ON SYS.VW_SINHVIEN_XEM_DTB TO a1715008;
GRANT SELECT ON SYS.VW_SINHVIEN_XEM_DTB TO a1712482;



-- 3a: Result  Chi co sinh vien duoc xem DTB & DIEMTHI cua minh
--conn a1712362/a1712362;
--SHOW USER;
--SELECT * FROM SYS.VW_SINHVIEN_XEM_DTB;



-----------------------------------------------------------------------
-- Cau 3b: 
-- P1: Giaovien duoc SELECT, UPDATE DIEMTHI CUA MON DO MINH PHU TRACH
-- P2: Khong duoc SELECT & UPDATE DTB CUA SINHVIEN
--------------------------------------------------------------------------

-- Cau 3b. P1.1 View Giao vien chi SELECT DIEMTHI CUA MON DO MINH PHU TRACH
CREATE OR REPLACE VIEW VW_GIAOVIEN_DIEMTHI
AS
SELECT DANGKY.MSSV, DANGKY.MAMH,DANGKY.HOCKY, DANGKY.DIEMTHI,MONHOC.GVPHUTRACH
FROM SYS.DANGKY
LEFT JOIN SYS.MONHOC
ON MONHOC.MAMH = DANGKY.MAMH
WHERE MONHOC.GVPHUTRACH = SYS_CONTEXT('USERENV','SESSION_USER');



GRANT SELECT ON VW_GIAOVIEN_DIEMTHI TO GV01;
GRANT SELECT ON VW_GIAOVIEN_DIEMTHI TO GV02;
GRANT UPDATE (DIEMTHI) ON VW_GIAOVIEN_DIEMTHI TO GV01;
GRANT UPDATE (DIEMTHI) ON VW_GIAOVIEN_DIEMTHI TO GV02;




-- P1 Result: Giao vien chi SELECT, UPDATE DIEMTHI CUA MON DO MINH PHU TRACH
--CONN GV01/GV01;
--SELECT * FROM SYS.VW_GIAOVIEN_DIEMTHI;
--
--CONN GV01/GV01;
--UPDATE SYS.VW_GIAOVIEN_DIEMTHI SET DIEMTHI = '9' WHERE MSSV = '1712935';


-- P2: Khong duoc SELECT & UPDATE DTB CUA SINHVIEN
--GRANT SELECT ON   SYS.SINHVIEN TO GV01;
--CONN GV01/GV01;
--SELECT * FROM SYS.SINHVIEN;


-----------------------------------------------------------------------
-- Cau 3c: 
-- P1: GIAOVU duoc SELECT, INSERT, UPDATE DANGKY CUA SINHVIEN (ngoai tru DIEMTHI)
-- P2: GIAOVU duoc SELECT, INSERT SINHVIEN, MOHOC (ngoai tru DTB, DIEMTHI)
-- P3: GIAOVU khong duoc SELECT DTB,DIEMTHI
--------------------------------------------------------------------------

-- P1: Tao view cho giaovu
CREATE OR REPLACE VIEW VW_GIAOVU_SELECT_DANGKY
AS
SELECT  SYS.DANGKY.MSSV, SYS.DANGKY.MAMH,SYS.DANGKY.HOCKY
FROM SYS.DANGKY;

GRANT SELECT,INSERT,UPDATE ON VW_GIAOVU_SELECT_DANGKY TO GIAOVU;



---- P1 RESULT: SELECT & INSERT
--CONN GIAOVU/GIAOVU;
--SELECT * FROM SYS.VW_GIAOVU_SELECT_DANGKY;
--INSERT INTO SYS.VW_GIAOVU_SELECT_DANGKY(MSSV,MAMH,HOCKY) VALUES('1712362','CSC12004','1');



-- P2: GIAOVU duoc SELECT, INSERT SINHVIEN, MOHOC (ngoai tru DTB, DIEMTHI)
CREATE OR REPLACE VIEW VW_GIAOVU_SINHVIEN
AS
SELECT SYS.SINHVIEN.MSSV, SYS.SINHVIEN.HOTENSV, SYS.SINHVIEN.DTB
FROM SYS.SINHVIEN;

GRANT SELECT,INSERT(MSSV,HOTENSV) ON VW_GIAOVU_SINHVIEN TO GIAOVU;

-- P2 RESULT
--CONN GIAOVU/GIAOVU;
--SELECT * FROM SYS.VW_GIAOVU_SINHVIEN;
--INSERT INTO SYS.VW_GIAOVU_SINHVIEN (MSSV,HOTENSV) VALUES ('1712364','DUCCAO 34');
--






