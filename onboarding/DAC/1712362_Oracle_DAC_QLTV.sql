/*****************************
THÔNG TIN SINH VIÊN 
MSSV: 1712362
HỌ TÊN: TRỊNH CAO VĂN ĐỨC
*****************************/

-------------------------------------------
-- Script Re-Create Table 
-------------------------------------------
DECLARE LOAI_SACH_C NUMBER;SACH_C NUMBER; DOC_GIA_C NUMBER; THU_VIEN_C NUMBER; LOAI_NHAN_VIEN_C NUMBER;
PHIEU_MUON_SACH_C NUMBER; CT_PHIEU_MUON_C NUMBER; NHAN_VIEN_C NUMBER;
BEGIN 
    SELECT COUNT(*) INTO LOAI_SACH_C FROM ALL_OBJECTS
    WHERE OBJECT_TYPE IN ('TABLE','VIEW')
    AND OBJECT_NAME ='LOAI_SACH';
    
    SELECT COUNT(*) INTO SACH_C FROM ALL_OBJECTS
    WHERE OBJECT_TYPE IN ('TABLE','VIEW')
    AND OBJECT_NAME ='SACH';
    
      SELECT COUNT(*) INTO DOC_GIA_C FROM ALL_OBJECTS
    WHERE OBJECT_TYPE IN ('TABLE','VIEW')
    AND OBJECT_NAME ='DOC_GIA';
    
    SELECT COUNT(*) INTO THU_VIEN_C FROM ALL_OBJECTS
    WHERE OBJECT_TYPE IN ('TABLE','VIEW')
    AND OBJECT_NAME ='THU_VIEN';
    
    SELECT COUNT(*) INTO LOAI_NHAN_VIEN_C FROM ALL_OBJECTS
    WHERE OBJECT_TYPE IN ('TABLE','VIEW')
    AND OBJECT_NAME ='LOAI_NHAN_VIEN';
    
    SELECT COUNT(*) INTO PHIEU_MUON_SACH_C FROM ALL_OBJECTS
    WHERE OBJECT_TYPE IN ('TABLE','VIEW')
    AND OBJECT_NAME ='PHIEU_MUON_SACH';
    
    SELECT COUNT(*) INTO CT_PHIEU_MUON_C FROM ALL_OBJECTS
    WHERE OBJECT_TYPE IN ('TABLE','VIEW')
    AND OBJECT_NAME ='CT_PHIEU_MUON';
    
    SELECT COUNT(*) INTO NHAN_VIEN_C FROM ALL_OBJECTS
    WHERE OBJECT_TYPE IN ('TABLE','VIEW')
    AND OBJECT_NAME ='NHAN_VIEN';
    
    IF LOAI_SACH_C !=0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE ' || ' LOAI_SACH ' || ' CASCADE CONSTRAINTS ';
    END IF;
    IF SACH_C !=0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE ' || ' SACH ' || ' CASCADE CONSTRAINTS ';
    END IF;
    IF DOC_GIA_C !=0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE ' || ' DOC_GIA ' || ' CASCADE CONSTRAINTS ';
    END IF;
    IF THU_VIEN_C !=0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE ' || ' THU_VIEN ' || ' CASCADE CONSTRAINTS ';
    END IF;
    IF LOAI_NHAN_VIEN_C !=0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE ' || ' LOAI_NHAN_VIEN ' || ' CASCADE CONSTRAINTS ';
    END IF;
      IF PHIEU_MUON_SACH_C !=0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE ' || ' PHIEU_MUON_SACH ' || ' CASCADE CONSTRAINTS ';
    END IF;
     IF CT_PHIEU_MUON_C !=0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE ' || ' CT_PHIEU_MUON ' || ' CASCADE CONSTRAINTS ';
    END IF;
      IF NHAN_VIEN_C !=0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE ' || ' NHAN_VIEN ' || ' CASCADE CONSTRAINTS ';
    END IF;
END;
/


/**************************************
    a. Script create CSDL
**************************************/



-------------------------------------------
-- Create Table
-------------------------------------------
CREATE TABLE LOAI_SACH(
    MA_LOAI_SACH NVARCHAR2(200),
    TEN_LOAI_SACH NVARCHAR2(200),
    PRIMARY KEY(MA_LOAI_SACH) 
);


CREATE TABLE SACH(
    MA_SACH NVARCHAR2(200),
    MA_THU_VIEN NVARCHAR2(200),
    TEN_SACH NVARCHAR2(200),
    MA_LOAI_SACH NVARCHAR2(200),
    PRIMARY KEY(MA_SACH) 
);

CREATE TABLE DOC_GIA(
    MA_DOC_GIA NVARCHAR2(200),
    HO_TEN NVARCHAR2(200),
    CMND NVARCHAR2(200),
    SDT NVARCHAR2(200),
    NGAY_SINH DATE,
    PRIMARY KEY(MA_DOC_GIA) 
);

CREATE TABLE THU_VIEN(
    MA_THU_VIEN NVARCHAR2(200),
    TEN_THU_VIEN NVARCHAR2(200),
    PRIMARY KEY(MA_THU_VIEN) 
);


CREATE TABLE LOAI_NHAN_VIEN(
    MA_LOAI_NHAN_VIEN NVARCHAR2(200),
    TEN_LOAI_NHAN_VIEN NVARCHAR2(200),
    PRIMARY KEY(MA_LOAI_NHAN_VIEN) 
);

CREATE TABLE PHIEU_MUON_SACH(
    MA_PHIEU_MUON_SACH NVARCHAR2(200),
    MA_THU_VIEN NVARCHAR2(200),
    MA_DOC_GIA NVARCHAR2(200),
    THOI_GIAN DATE,
    SO_LUONG INTEGER ,
    MA_NHAN_VIEN NVARCHAR2(200),
    PRIMARY KEY(MA_PHIEU_MUON_SACH) 
);

CREATE TABLE CT_PHIEU_MUON(
    MA_PHIEU_MUON_SACH NVARCHAR2(200),
    MA_SACH NVARCHAR2(200),
    SO_LUONG INTEGER ,
    PRIMARY KEY(MA_PHIEU_MUON_SACH,MA_SACH) 
);


CREATE TABLE NHAN_VIEN(
    MA_NHAN_VIEN NVARCHAR2(200),
    MA_THU_VIEN NVARCHAR2(200),
    MA_LOAI_NHAN_VIEN NVARCHAR2(200),
    HO_TEN NVARCHAR2(200),
    NGAY_SINH DATE,
    SDT NVARCHAR2(200),
    EMAIL NVARCHAR2(200),
    LUONG NVARCHAR2(200),
    PRIMARY KEY(MA_NHAN_VIEN) 
);



-------------------------------------------
-- Create Foreign Key
-------------------------------------------
ALTER TABLE SACH
ADD CONSTRAINT FK_SACH_VS_LOAI_SACH
FOREIGN KEY (MA_LOAI_SACH)
REFERENCES LOAI_SACH(MA_LOAI_SACH);

ALTER TABLE SACH
ADD CONSTRAINT FK_SACH_VS_THU_VIEN
FOREIGN KEY (MA_THU_VIEN)
REFERENCES THU_VIEN(MA_THU_VIEN);

ALTER TABLE PHIEU_MUON_SACH
ADD CONSTRAINT FK_PHIEU_MUON_SACH_VS_DOC_GIA
FOREIGN KEY (MA_DOC_GIA)
REFERENCES DOC_GIA(MA_DOC_GIA);

ALTER TABLE PHIEU_MUON_SACH
ADD CONSTRAINT FK_PHIEU_MUON_SACH_VS_NHAN_VIEN
FOREIGN KEY (MA_NHAN_VIEN)
REFERENCES NHAN_VIEN(MA_NHAN_VIEN);

ALTER TABLE PHIEU_MUON_SACH
ADD CONSTRAINT FK_PHIEU_MUON_SACH_VS_THU_VIEN
FOREIGN KEY (MA_THU_VIEN)
REFERENCES THU_VIEN(MA_THU_VIEN);


ALTER TABLE CT_PHIEU_MUON
ADD CONSTRAINT FK_CT_PHIEU_MUON_VS_CT_PHIEU_MUON
FOREIGN KEY (MA_SACH,MA_PHIEU_MUON_SACH)
REFERENCES CT_PHIEU_MUON(MA_SACH,MA_PHIEU_MUON_SACH);

ALTER TABLE NHAN_VIEN
ADD CONSTRAINT FK_NHAN_VIEN_VS_LOAI_NHAN_VIEN
FOREIGN KEY (MA_LOAI_NHAN_VIEN)
REFERENCES LOAI_NHAN_VIEN(MA_LOAI_NHAN_VIEN);

ALTER TABLE NHAN_VIEN
ADD CONSTRAINT FK_NHAN_VIEN_VS_THU_VIEN
FOREIGN KEY (MA_THU_VIEN)
REFERENCES THU_VIEN(MA_THU_VIEN);


/**************************************
-- b.  Script Insert Records
**************************************/


-----------------------------------------
-- Thêm d? li?u trên b?ng: THU_VIEN
-----------------------------------------

INSERT INTO THU_VIEN(MA_THU_VIEN , TEN_THU_VIEN )
VALUES ('MTV01','THU_VIEN_CS_LINH_TRUNG');
INSERT INTO THU_VIEN(MA_THU_VIEN , TEN_THU_VIEN )
VALUES ('MTV02','THU_VIEN_CS_VAN_CU');
INSERT INTO THU_VIEN(MA_THU_VIEN , TEN_THU_VIEN )
VALUES ('MTV03','THU_VIEN_CS_SU_PHAM');

-----------------------------------------
-- Records LOAI_SACH
-----------------------------------------

INSERT INTO LOAI_SACH( MA_LOAI_SACH, TEN_LOAI_SACH)
VALUES ('MLS01','TEN_LOAI_SACH_01');
INSERT INTO LOAI_SACH( MA_LOAI_SACH, TEN_LOAI_SACH)
VALUES ('MLS02','TEN_LOAI_SACH_02');
INSERT INTO LOAI_SACH( MA_LOAI_SACH, TEN_LOAI_SACH)
VALUES ('MLS03','TEN_LOAI_SACH_03');
INSERT INTO LOAI_SACH( MA_LOAI_SACH, TEN_LOAI_SACH)
VALUES ('MLS04','TEN_LOAI_SACH_04');
INSERT INTO LOAI_SACH( MA_LOAI_SACH, TEN_LOAI_SACH)
VALUES ('MLS05','TEN_LOAI_SACH_05');

-----------------------------------------
-- Records SACH
-----------------------------------------

INSERT INTO SACH(MA_SACH, MA_THU_VIEN, TEN_SACH, MA_LOAI_SACH)
VALUES ('MS01','MTV01','TEN_SACH_01','MLS01');
INSERT INTO SACH(MA_SACH, MA_THU_VIEN, TEN_SACH, MA_LOAI_SACH)
VALUES ('MS02','MTV01','TEN_SACH_02','MLS01');
INSERT INTO SACH(MA_SACH, MA_THU_VIEN, TEN_SACH, MA_LOAI_SACH)
VALUES ('MS03','MTV01','TEN_SACH_03','MLS02');
INSERT INTO SACH(MA_SACH, MA_THU_VIEN, TEN_SACH, MA_LOAI_SACH)
VALUES ('MS04','MTV02','TEN_SACH_04','MLS03');
INSERT INTO SACH(MA_SACH, MA_THU_VIEN, TEN_SACH, MA_LOAI_SACH)
VALUES ('MS05','MTV02','TEN_SACH_05','MLS03');

-----------------------------------------
-- Records DOC_GIA
-----------------------------------------

INSERT INTO DOC_GIA(MA_DOC_GIA,HO_TEN ,CMND,SDT , NGAY_SINH  )
VALUES ('MDG01','DUCCAO_01','CMND01','0901435802',TO_DATE('03/27/1999','MM/DD/YYYY'));
INSERT INTO DOC_GIA(MA_DOC_GIA,HO_TEN ,CMND,SDT , NGAY_SINH  )
VALUES ('MDG02','DUCCAO_02','CMND02','0901435802',TO_DATE('03/27/1999','MM/DD/YYYY'));
INSERT INTO DOC_GIA(MA_DOC_GIA,HO_TEN ,CMND,SDT , NGAY_SINH  )
VALUES ('MDG03','DUCCAO_03','CMND03','0901435802',TO_DATE('03/27/1999','MM/DD/YYYY'));

-----------------------------------------
-- Records LOAI_NHAN_VIEN
-----------------------------------------

INSERT INTO LOAI_NHAN_VIEN( MA_LOAI_NHAN_VIEN ,TEN_LOAI_NHAN_VIEN  )
VALUES ('MLNV01','NHAN_VIEN_THU_THU');
INSERT INTO LOAI_NHAN_VIEN( MA_LOAI_NHAN_VIEN ,TEN_LOAI_NHAN_VIEN  )
VALUES ('MLNV02','NHAN_VIEN_QUAN_LY');

-----------------------------------------
-- Records NHAN_VIEN
-----------------------------------------

INSERT INTO NHAN_VIEN(  MA_NHAN_VIEN , MA_THU_VIEN , MA_LOAI_NHAN_VIEN, HO_TEN , NGAY_SINH , SDT , EMAIL , LUONG )
VALUES ('MNV01','MTV01','MLNV01','USER_NHANVIEN_THUTHU_TV01_01',TO_DATE('01/28/1999','MM/DD/YYYY'),
'0901435802','CAOVANDUCS@GMAIL.COM','20.000.000');
INSERT INTO NHAN_VIEN(  MA_NHAN_VIEN , MA_THU_VIEN , MA_LOAI_NHAN_VIEN, HO_TEN , NGAY_SINH , SDT , EMAIL , LUONG )
VALUES ('MNV02','MTV01','MLNV01','USER_NHANVIEN_THUTHU_TV01_02',TO_DATE('01/28/1999','MM/DD/YYYY'),
'0901435802','CAOVANDUCS@GMAIL.COM','20.000.000');
INSERT INTO NHAN_VIEN(  MA_NHAN_VIEN , MA_THU_VIEN , MA_LOAI_NHAN_VIEN, HO_TEN , NGAY_SINH , SDT , EMAIL , LUONG )
VALUES ('MNV03','MTV01','MLNV02','USER_NHANVIEN_QUANLY_TV01',TO_DATE('01/28/1999','MM/DD/YYYY'),
'0901435802','CAOVANDUCS@GMAIL.COM','20.000.000');

INSERT INTO NHAN_VIEN(  MA_NHAN_VIEN , MA_THU_VIEN , MA_LOAI_NHAN_VIEN, HO_TEN , NGAY_SINH , SDT , EMAIL , LUONG )
VALUES ('MNV04','MTV02','MLNV01','USER_NHANVIEN_THUTHU_TV02_01',TO_DATE('01/28/1999','MM/DD/YYYY'),
'0901435802','CAOVANDUCS@GMAIL.COM','20.000.000');
INSERT INTO NHAN_VIEN(  MA_NHAN_VIEN , MA_THU_VIEN , MA_LOAI_NHAN_VIEN, HO_TEN , NGAY_SINH , SDT , EMAIL , LUONG )
VALUES ('MNV05','MTV02','MLNV01','USER_NHANVIEN_THUTHU_TV02_02',TO_DATE('01/28/1999','MM/DD/YYYY'),
'0901435802','CAOVANDUCS@GMAIL.COM','20.000.000');
INSERT INTO NHAN_VIEN(  MA_NHAN_VIEN , MA_THU_VIEN , MA_LOAI_NHAN_VIEN, HO_TEN , NGAY_SINH , SDT , EMAIL , LUONG )
VALUES ('MNV06','MTV02','MLNV02','USER_NHANVIEN_QUANLY_TV02',TO_DATE('01/28/1999','MM/DD/YYYY'),
'0901435802','CAOVANDUCS@GMAIL.COM','20.000.000');

INSERT INTO NHAN_VIEN(  MA_NHAN_VIEN , MA_THU_VIEN , MA_LOAI_NHAN_VIEN, HO_TEN , NGAY_SINH , SDT , EMAIL , LUONG )
VALUES ('MNV07','MTV03','MLNV01','USER_NHANVIEN_THUTHU_TV03_01',TO_DATE('01/28/1999','MM/DD/YYYY'),
'0901435802','CAOVANDUCS@GMAIL.COM','20.000.000');
INSERT INTO NHAN_VIEN(  MA_NHAN_VIEN , MA_THU_VIEN , MA_LOAI_NHAN_VIEN, HO_TEN , NGAY_SINH , SDT , EMAIL , LUONG )
VALUES ('MNV08','MTV03','MLNV01','USER_NHANVIEN_THUTHU_TV03_02',TO_DATE('01/28/1999','MM/DD/YYYY'),
'0901435802','CAOVANDUCS@GMAIL.COM','20.000.000');
INSERT INTO NHAN_VIEN(  MA_NHAN_VIEN , MA_THU_VIEN , MA_LOAI_NHAN_VIEN, HO_TEN , NGAY_SINH , SDT , EMAIL , LUONG )
VALUES ('MNV09','MTV03','MLNV02','USER_NHANVIEN_QUANLY_TV03',TO_DATE('01/28/1999','MM/DD/YYYY'),
'0901435802','CAOVANDUCS@GMAIL.COM','20.000.000');




-----------------------------------------
-- Records PHIEU_MUON_SACH
-----------------------------------------

INSERT INTO PHIEU_MUON_SACH(  MA_PHIEU_MUON_SACH ,MA_THU_VIEN ,MA_DOC_GIA,THOI_GIAN ,SO_LUONG  ,MA_NHAN_VIEN  )
VALUES ('MPM01','MTV01','MDG01',TO_DATE('04/10/2021','MM/DD/YYYY'),1,'MNV01');
INSERT INTO PHIEU_MUON_SACH(  MA_PHIEU_MUON_SACH ,MA_THU_VIEN ,MA_DOC_GIA,THOI_GIAN ,SO_LUONG  ,MA_NHAN_VIEN  )
VALUES ('MPM02','MTV01','MDG02',TO_DATE('04/10/2021','MM/DD/YYYY'),2,'MNV01');
INSERT INTO PHIEU_MUON_SACH(  MA_PHIEU_MUON_SACH ,MA_THU_VIEN ,MA_DOC_GIA,THOI_GIAN ,SO_LUONG  ,MA_NHAN_VIEN  )
VALUES ('MPM03','MTV01','MDG03',TO_DATE('04/10/2021','MM/DD/YYYY'),3,'MNV01');

INSERT INTO PHIEU_MUON_SACH(  MA_PHIEU_MUON_SACH ,MA_THU_VIEN ,MA_DOC_GIA,THOI_GIAN ,SO_LUONG  ,MA_NHAN_VIEN  )
VALUES ('MPM04','MTV02','MDG01',TO_DATE('04/10/2021','MM/DD/YYYY'),4,'MNV04');
INSERT INTO PHIEU_MUON_SACH(  MA_PHIEU_MUON_SACH ,MA_THU_VIEN ,MA_DOC_GIA,THOI_GIAN ,SO_LUONG  ,MA_NHAN_VIEN  )
VALUES ('MPM05','MTV02','MDG02',TO_DATE('04/10/2021','MM/DD/YYYY'),5,'MNV04');
INSERT INTO PHIEU_MUON_SACH(  MA_PHIEU_MUON_SACH ,MA_THU_VIEN ,MA_DOC_GIA,THOI_GIAN ,SO_LUONG  ,MA_NHAN_VIEN  )
VALUES ('MPM06','MTV02','MDG03',TO_DATE('04/10/2021','MM/DD/YYYY'),6,'MNV04');


INSERT INTO PHIEU_MUON_SACH(  MA_PHIEU_MUON_SACH ,MA_THU_VIEN ,MA_DOC_GIA,THOI_GIAN ,SO_LUONG  ,MA_NHAN_VIEN  )
VALUES ('MPM07','MTV03','MDG01',TO_DATE('04/10/2021','MM/DD/YYYY'),7,'MNV07');
INSERT INTO PHIEU_MUON_SACH(  MA_PHIEU_MUON_SACH ,MA_THU_VIEN ,MA_DOC_GIA,THOI_GIAN ,SO_LUONG  ,MA_NHAN_VIEN  )
VALUES ('MPM08','MTV03','MDG02',TO_DATE('04/10/2021','MM/DD/YYYY'),8,'MNV07');
INSERT INTO PHIEU_MUON_SACH(  MA_PHIEU_MUON_SACH ,MA_THU_VIEN ,MA_DOC_GIA,THOI_GIAN ,SO_LUONG  ,MA_NHAN_VIEN  )
VALUES ('MPM09','MTV03','MDG03',TO_DATE('04/10/2021','MM/DD/YYYY'),9,'MNV07');

-----------------------------------------
-- Records CT_PHIEU_MUON
-----------------------------------------

INSERT INTO CT_PHIEU_MUON(  MA_PHIEU_MUON_SACH ,MA_SACH, SO_LUONG  )
VALUES ('MPM01','MS01',3);
INSERT INTO CT_PHIEU_MUON(  MA_PHIEU_MUON_SACH ,MA_SACH , SO_LUONG  )
VALUES ('MPM01','MS02',1);
INSERT INTO CT_PHIEU_MUON(  MA_PHIEU_MUON_SACH ,MA_SACH, SO_LUONG   )
VALUES ('MPM01','MS03',2);
INSERT INTO CT_PHIEU_MUON(  MA_PHIEU_MUON_SACH ,MA_SACH , SO_LUONG  )
VALUES ('MPM02','MS02',2);
INSERT INTO CT_PHIEU_MUON(  MA_PHIEU_MUON_SACH ,MA_SACH , SO_LUONG  )
VALUES ('MPM02','MS03',3);
INSERT INTO CT_PHIEU_MUON(  MA_PHIEU_MUON_SACH ,MA_SACH , SO_LUONG  )
VALUES ('MPM04','MS05',1);
INSERT INTO CT_PHIEU_MUON(  MA_PHIEU_MUON_SACH ,MA_SACH , SO_LUONG  )
VALUES ('MPM05','MS04',1);
INSERT INTO CT_PHIEU_MUON(  MA_PHIEU_MUON_SACH ,MA_SACH , SO_LUONG  )
VALUES ('MPM06','MS05',1);
INSERT INTO CT_PHIEU_MUON(  MA_PHIEU_MUON_SACH ,MA_SACH , SO_LUONG  )
VALUES ('MPM07','MS04',2);
INSERT INTO CT_PHIEU_MUON(  MA_PHIEU_MUON_SACH ,MA_SACH, SO_LUONG   )
VALUES ('MPM08','MS02',5);
INSERT INTO CT_PHIEU_MUON(  MA_PHIEU_MUON_SACH ,MA_SACH , SO_LUONG  )
VALUES ('MPM09','MS01',1);



/*****************************************************************************************
     c.  Script create User, Group Of User
*****************************************************************************************/


----------------------
-- Create User: Doc gia
----------------------
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

--DROP USER DUCCAO_01 ;
--DROP USER DUCCAO_02 ;
--DROP USER DUCCAO_03 ;

CREATE USER DUCCAO_01 IDENTIFIED BY DUCCAO_01;
CREATE USER DUCCAO_02 IDENTIFIED BY DUCCAO_02;
CREATE USER DUCCAO_03 IDENTIFIED BY DUCCAO_03;

GRANT CREATE SESSION TO DUCCAO_01;
GRANT CREATE SESSION TO DUCCAO_02;
GRANT CREATE SESSION TO DUCCAO_03;



----------------------
-- Create User: Thu thu
----------------------


--
--DROP USER USER_NHANVIEN_THUTHU_TV01_01;
--DROP USER USER_NHANVIEN_THUTHU_TV01_02;
--DROP USER USER_NHANVIEN_THUTHU_TV02_01;
--DROP USER USER_NHANVIEN_THUTHU_TV02_02 ;
--DROP USER USER_NHANVIEN_THUTHU_TV03_01 ;
--DROP USER USER_NHANVIEN_THUTHU_TV03_02 ;

CREATE USER USER_NHANVIEN_THUTHU_TV01_01 IDENTIFIED BY USER_NHANVIEN_THUTHU_TV01_01;
CREATE USER USER_NHANVIEN_THUTHU_TV01_02 IDENTIFIED BY USER_NHANVIEN_THUTHU_TV01_02;
CREATE USER USER_NHANVIEN_THUTHU_TV02_01 IDENTIFIED BY USER_NHANVIEN_THUTHU_TV02_01;
CREATE USER USER_NHANVIEN_THUTHU_TV02_02 IDENTIFIED BY USER_NHANVIEN_THUTHU_TV02_02;
CREATE USER USER_NHANVIEN_THUTHU_TV03_01 IDENTIFIED BY USER_NHANVIEN_THUTHU_TV03_01;
CREATE USER USER_NHANVIEN_THUTHU_TV03_02 IDENTIFIED BY USER_NHANVIEN_THUTHU_TV03_02;


GRANT CREATE SESSION TO USER_NHANVIEN_THUTHU_TV01_01;
GRANT CREATE SESSION TO USER_NHANVIEN_THUTHU_TV01_02;
GRANT CREATE SESSION TO USER_NHANVIEN_THUTHU_TV02_01;
GRANT CREATE SESSION TO USER_NHANVIEN_THUTHU_TV02_02;
GRANT CREATE SESSION TO USER_NHANVIEN_THUTHU_TV03_01;
GRANT CREATE SESSION TO USER_NHANVIEN_THUTHU_TV03_02;


-------------------------------
-- Create User: Nhan vien quan ly
-------------------------------

--DROP USER USER_NHANVIEN_QUANLY_TV01 ;
--DROP USER USER_NHANVIEN_QUANLY_TV02 ;
--DROP USER USER_NHANVIEN_QUANLY_TV03 ;

CREATE USER USER_NHANVIEN_QUANLY_TV01 IDENTIFIED BY USER_NHANVIEN_QUANLY_TV01;
CREATE USER USER_NHANVIEN_QUANLY_TV02 IDENTIFIED BY USER_NHANVIEN_QUANLY_TV02;
CREATE USER USER_NHANVIEN_QUANLY_TV03 IDENTIFIED BY USER_NHANVIEN_QUANLY_TV03;




GRANT CREATE SESSION TO USER_NHANVIEN_QUANLY_TV01;
GRANT CREATE SESSION TO USER_NHANVIEN_QUANLY_TV02;
GRANT CREATE SESSION TO USER_NHANVIEN_QUANLY_TV03;


-------------------------------
-- Create Group: Group doc gia
-------------------------------
CREATE OR REPLACE VIEW GROUP_DOC_GIA 
AS
SELECT  DOC_GIA.MA_DOC_GIA, DOC_GIA.HO_TEN, DOC_GIA.SDT, DOC_GIA.NGAY_SINH
FROM DOC_GIA;

--------------- Test Group doc gia -----------------
 -- SELECT * FROM GROUP_DOC_GIA;
 ------------------------------------------------------------------
 
 

-------------------------------
-- Create Group: Group thu thu
-------------------------------
CREATE OR REPLACE VIEW GROUP_THU_THU
AS 
SELECT * FROM NHAN_VIEN WHERE MA_LOAI_NHAN_VIEN='MLNV01';


--------------- Test Group thu thu  -----------------
-- SELECT * FROM GROUP_THU_THU;
 ------------------------------------------------------------------
 
----------------------------------
-- Create Group: Group nhan vien quan ly
-----------------------------------
CREATE OR REPLACE VIEW GROUP_NHANVIEN_QUANLY
AS 
SELECT * FROM NHAN_VIEN WHERE MA_LOAI_NHAN_VIEN='MLNV02';


--------------- Test Group nhan vien quan ly  -----------------
-- SELECT * FROM GROUP_NHANVIEN_QUANLY;
------------------------------------------------------------------




/***********************************************************************************************
-- d. Script grant privileges in row level: script manipulating on view, grant privilege on view
************************************************************************************************/

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
-- doc gia
/* Policy 1: Xem lại các phiếu mượn sách đã mượn: Mã phiếu mượn sách, mã đọc giả, số lượng,
mã sách, tên sách đã mượn cùng số lượng. Không được phép xem những phiếu
mượn sách của đọc giả khác. */
 --------------------------------------------------------------------------------------
 --------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW VIEW_DOCGIA_P1 
AS
SELECT PHIEU_MUON_SACH.MA_PHIEU_MUON_SACH, PHIEU_MUON_SACH.MA_DOC_GIA, PHIEU_MUON_SACH.SO_LUONG , 
CT_PHIEU_MUON.MA_SACH,SACH.TEN_SACH, CT_PHIEU_MUON.SO_LUONG AS SO_LUONG_SACH
FROM PHIEU_MUON_SACH
INNER JOIN CT_PHIEU_MUON
ON CT_PHIEU_MUON.MA_PHIEU_MUON_SACH = PHIEU_MUON_SACH.MA_PHIEU_MUON_SACH
LEFT JOIN SACH
ON SACH.MA_SACH = CT_PHIEU_MUON.MA_SACH 
WHERE PHIEU_MUON_SACH.MA_DOC_GIA 
IN (SELECT MA_DOC_GIA FROM DOC_GIA WHERE  HO_TEN = SYS_CONTEXT('USERENV','SESSION_USER'));

GRANT SELECT ON VIEW_DOCGIA_P1 TO DUCCAO_01;
GRANT SELECT ON VIEW_DOCGIA_P1 TO DUCCAO_02;
GRANT SELECT ON VIEW_DOCGIA_P1 TO DUCCAO_03;





------------------- TEST doc gia Policy 1 ---------------------------------
--CONNECT DUCCAO_01/DUCCAO_01;
--SELECT * FROM SYS.VIEW_DOCGIA_P1;
--
--CONNECT DUCCAO_02/DUCCAO_02;
--SELECT * FROM SYS.VIEW_DOCGIA_P1;
--------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
-- doc gia
/* Policy 2: Xem thông tin tài khoản: không được phép xem thông tin tài khoản của đọc giả
khác */
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW VIEW_DOCGIA_P2
AS
SELECT DOC_GIA.MA_DOC_GIA, DOC_GIA.HO_TEN, DOC_GIA.CMND, DOC_GIA.SDT, DOC_GIA.NGAY_SINH
FROM DOC_GIA
WHERE DOC_GIA.HO_TEN = SYS_CONTEXT('USERENV','SESSION_USER');

GRANT SELECT ON VIEW_DOCGIA_P2 TO DUCCAO_01;
GRANT SELECT ON VIEW_DOCGIA_P2 TO DUCCAO_02;
GRANT SELECT ON VIEW_DOCGIA_P2 TO DUCCAO_03;


-------------------- TEST doc gia policy 2 --------------------------------------
--CONN DUCCAO_01/DUCCAO_01;
--SELECT * FROM SYS.VIEW_DOCGIA_P2;
--
--CONN DUCCAO_03/DUCCAO_03;
--SELECT * FROM SYS.VIEW_DOCGIA_P2;
--------------------------------------------------------------------------------------



------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Thu thu
/* Policy 1: Xem thông tin cá nhân: 
          o Không được phép xem thông tin tài khoản của nhân viên khác.*/
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW  VIEW_THUTHU_P1
AS
SELECT NHAN_VIEN.MA_NHAN_VIEN, NHAN_VIEN.MA_THU_VIEN, NHAN_VIEN.HO_TEN, NHAN_VIEN.NGAY_SINH,
NHAN_VIEN.SDT, NHAN_VIEN.EMAIL, NHAN_VIEN.LUONG
FROM NHAN_VIEN
WHERE NHAN_VIEN.MA_LOAI_NHAN_VIEN = 'MLNV01'
AND NHAN_VIEN.HO_TEN = SYS_CONTEXT('USERENV','SESSION_USER');


GRANT SELECT ON VIEW_THUTHU_P1 TO USER_NHANVIEN_THUTHU_TV01_01;
GRANT SELECT ON VIEW_THUTHU_P1 TO USER_NHANVIEN_THUTHU_TV01_02;
GRANT SELECT ON VIEW_THUTHU_P1 TO USER_NHANVIEN_THUTHU_TV02_01;
GRANT SELECT ON VIEW_THUTHU_P1 TO USER_NHANVIEN_THUTHU_TV02_02;
GRANT SELECT ON VIEW_THUTHU_P1 TO USER_NHANVIEN_THUTHU_TV03_01;
GRANT SELECT ON VIEW_THUTHU_P1 TO USER_NHANVIEN_THUTHU_TV03_02;

-------------------- TEST thu thu policy 1 --------------------------------------
--CONN USER_NHANVIEN_THUTHU_TV01_01/USER_NHANVIEN_THUTHU_TV01_01;
--SELECT * FROM SYS.VIEW_THUTHU_P1;
--
--CONN USER_NHANVIEN_THUTHU_TV03_02/USER_NHANVIEN_THUTHU_TV03_02;
--SELECT * FROM SYS.VIEW_THUTHU_P1;
--------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Thu thu
/* Chính sách 2: Xem danh sách các phiếu mượn:
        o Chỉ được phép xem các phiếu mượn ở thư viên của mình.
        o Chỉ được phép xem thông tin phiếu mượn do chính thủ thư đó đã ký.*/
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW VIEW_THUTHU_P2
AS
SELECT PHIEU_MUON_SACH.MA_PHIEU_MUON_SACH, PHIEU_MUON_SACH.MA_THU_VIEN, PHIEU_MUON_SACH.MA_DOC_GIA,
PHIEU_MUON_SACH.THOI_GIAN,PHIEU_MUON_SACH.SO_LUONG,PHIEU_MUON_SACH.MA_NHAN_VIEN
FROM PHIEU_MUON_SACH 
LEFT JOIN THU_VIEN 
ON THU_VIEN.MA_THU_VIEN = PHIEU_MUON_SACH.MA_THU_VIEN
LEFT JOIN NHAN_VIEN
ON NHAN_VIEN.MA_NHAN_VIEN = PHIEU_MUON_SACH.MA_NHAN_VIEN
AND NHAN_VIEN.MA_THU_VIEN = THU_VIEN.MA_THU_VIEN
WHERE NHAN_VIEN.MA_LOAI_NHAN_VIEN='MLNV01'
AND NHAN_VIEN.HO_TEN=SYS_CONTEXT('USERENV','SESSION_USER')
ORDER BY PHIEU_MUON_SACH.MA_PHIEU_MUON_SACH;

GRANT SELECT ON VIEW_THUTHU_P2 TO USER_NHANVIEN_THUTHU_TV01_01;
GRANT SELECT ON VIEW_THUTHU_P2 TO USER_NHANVIEN_THUTHU_TV01_02;
GRANT SELECT ON VIEW_THUTHU_P2 TO USER_NHANVIEN_THUTHU_TV02_01;
GRANT SELECT ON VIEW_THUTHU_P2 TO USER_NHANVIEN_THUTHU_TV02_02;
GRANT SELECT ON VIEW_THUTHU_P2 TO USER_NHANVIEN_THUTHU_TV03_01;
GRANT SELECT ON VIEW_THUTHU_P2 TO USER_NHANVIEN_THUTHU_TV03_02;

-------------------- TEST thu thu policy 2 --------------------------------------
--CONN USER_NHANVIEN_THUTHU_TV01_01/USER_NHANVIEN_THUTHU_TV01_01;
--SELECT * FROM SYS.VIEW_THUTHU_P2;
--
--CONN USER_NHANVIEN_THUTHU_TV02_01/USER_NHANVIEN_THUTHU_TV02_01;
--SELECT * FROM SYS.VIEW_THUTHU_P2;
--
--CONN USER_NHANVIEN_QUANLY_TV01/USER_NHANVIEN_QUANLY_TV01;
--SELECT * FROM SYS.VIEW_THUTHU_P2;
--------------------------------------------------------------------------------------



------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Nhân viên quản lý
/* Chính sách 1:- Xem thông tin cá nhân:
    o Không được phép xem thông tin tài khoản của nhân viên khác.*/
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW VIEW_NHANVIEN_QUANLY_P1
AS
SELECT *
FROM  NHAN_VIEN
WHERE NHAN_VIEN.MA_LOAI_NHAN_VIEN='MLNV02'
AND NHAN_VIEN.HO_TEN = SYS_CONTEXT('USERENV','SESSION_USER');

GRANT SELECT ON VIEW_NHANVIEN_QUANLY_P1 TO USER_NHANVIEN_QUANLY_TV01;
GRANT SELECT ON VIEW_NHANVIEN_QUANLY_P1 TO USER_NHANVIEN_QUANLY_TV02;
GRANT SELECT ON VIEW_NHANVIEN_QUANLY_P1 TO USER_NHANVIEN_QUANLY_TV03;

-------------------- TEST Nhân viên quản lý chính sách 1 --------------------------------------
--CONN USER_NHANVIEN_QUANLY_TV01/USER_NHANVIEN_QUANLY_TV01;
--SELECT * FROM SYS.VIEW_NHANVIEN_QUANLY_P1;
--
--CONN USER_NHANVIEN_QUANLY_TV03/USER_NHANVIEN_QUANLY_TV03;
--SELECT * FROM SYS.VIEW_NHANVIEN_QUANLY_P1;
-----------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Nhân viên quản lý
/* Chính sách 2: - Xem thông tin tất cả thủ thư:
        o Không được xem thuộc tính lương.
        o Chỉ được xem những thủ thư làm việc tại thư viện của mình.*/
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW VIEW_NHANVIEN_QUANLY_P2
AS
SELECT NHAN_VIEN.MA_NHAN_VIEN, NHAN_VIEN.MA_THU_VIEN, NHAN_VIEN.MA_LOAI_NHAN_VIEN, NHAN_VIEN.HO_TEN
, NHAN_VIEN.NGAY_SINH, NHAN_VIEN.SDT, NHAN_VIEN.EMAIL,
DECODE(NHAN_VIEN.HO_TEN,USER,NHAN_VIEN.LUONG,NULL) LUONG
FROM NHAN_VIEN
WHERE NHAN_VIEN.MA_LOAI_NHAN_VIEN='MLNV01'
AND NHAN_VIEN.MA_THU_VIEN =
(SELECT MA_THU_VIEN FROM NHAN_VIEN WHERE HO_TEN = SYS_CONTEXT('USERENV','SESSION_USER') );


GRANT SELECT ON VIEW_NHANVIEN_QUANLY_P2 TO USER_NHANVIEN_QUANLY_TV01;
GRANT SELECT ON VIEW_NHANVIEN_QUANLY_P2 TO USER_NHANVIEN_QUANLY_TV02;
GRANT SELECT ON VIEW_NHANVIEN_QUANLY_P2 TO USER_NHANVIEN_QUANLY_TV03;

-------------------- TEST Nhân viên quản lý chính sách 2 --------------------------------------
--CONN USER_NHANVIEN_QUANLY_TV01/USER_NHANVIEN_QUANLY_TV01;
--SELECT * FROM SYS.VIEW_NHANVIEN_QUANLY_P2;
--
--CONN USER_NHANVIEN_QUANLY_TV03/USER_NHANVIEN_QUANLY_TV03;
--SELECT * FROM SYS.VIEW_NHANVIEN_QUANLY_P2;
-----------------------------------------------------------------------------------------------




/*****************************************************************************************
    e. Viết script để phân quyền trên cột: script phân quyền trên cột trong bảng hay
        trên view.
*****************************************************************************************/



------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Độc giả
/* Chính sách 1 (column level):-  Xem thông tin cá nhân: ho_ten, cmnd, sdt, ngay_sinh
*/
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW VIEW_DOCGIA_COLUMN_LEVEL_P1
AS
SELECT DOC_GIA.HO_TEN, DOC_GIA.CMND, DOC_GIA.SDT, DOC_GIA.NGAY_SINH
FROM DOC_GIA
WHERE DOC_GIA.HO_TEN = SYS_CONTEXT('USERENV','SESSION_USER');

GRANT SELECT ON VIEW_DOCGIA_COLUMN_LEVEL_P1 TO DUCCAO_01;
GRANT SELECT ON VIEW_DOCGIA_COLUMN_LEVEL_P1 TO DUCCAO_02;
GRANT SELECT ON VIEW_DOCGIA_COLUMN_LEVEL_P1 TO DUCCAO_03;


-------------------- TEST đọc giả Chính sách 1(Column level) -----
--CONN DUCCAO_01/DUCCAO_01;
--SELECT * FROM SYS.VIEW_DOCGIA_COLUMN_LEVEL_P1;
-----------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Độc giả
/* Chính sách 2 (column level):- Cập nhật thông tin cá nhân: cmnd, sdt, ngay_sinh
*/
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
GRANT UPDATE(CMND,SDT,NGAY_SINH) ON SYS.VIEW_DOCGIA_COLUMN_LEVEL_P1 TO DUCCAO_01;
GRANT UPDATE(CMND,SDT,NGAY_SINH) ON SYS.VIEW_DOCGIA_COLUMN_LEVEL_P1 TO DUCCAO_02;
GRANT UPDATE(CMND,SDT,NGAY_SINH) ON SYS.VIEW_DOCGIA_COLUMN_LEVEL_P1 TO DUCCAO_03;



-------------------- TEST đọc giả Chính sách 2(Column level) --------------------------------------
--CONN DUCCAO_01/DUCCAO_01;
--UPDATE SYS.VIEW_DOCGIA_COLUMN_LEVEL_P1
--SET CMND='CMND_UPDATED', SDT='SDT_UPDATED'
--WHERE HO_TEN = SYS_CONTEXT('USERENV','SESSION_USER');
--
--CONN DUCCAO_01/DUCCAO_01;
--SELECT * FROM SYS.VIEW_DOCGIA_COLUMN_LEVEL_P1;
-----------------------------------------------------------------------------------------------





------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Thủ thư
/* Chính sách 1 (column level):-  Xem thông tin cá nhân: ho_ten, cmnd, sdt, ngay_sinh
*/
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW VIEW_THUTHU_COLUMN_LEVEL_P1
AS
SELECT * FROM NHAN_VIEN 
WHERE NHAN_VIEN.MA_LOAI_NHAN_VIEN ='MLNV01'
AND NHAN_VIEN.HO_TEN = SYS_CONTEXT('USERENV','SESSION_USER');

GRANT SELECT ON VIEW_THUTHU_COLUMN_LEVEL_P1 TO USER_NHANVIEN_THUTHU_TV01_01;
GRANT SELECT ON VIEW_THUTHU_COLUMN_LEVEL_P1 TO USER_NHANVIEN_THUTHU_TV01_02;
GRANT SELECT ON VIEW_THUTHU_COLUMN_LEVEL_P1 TO USER_NHANVIEN_THUTHU_TV02_01;
GRANT SELECT ON VIEW_THUTHU_COLUMN_LEVEL_P1 TO USER_NHANVIEN_THUTHU_TV02_02;
GRANT SELECT ON VIEW_THUTHU_COLUMN_LEVEL_P1 TO USER_NHANVIEN_THUTHU_TV03_01;
GRANT SELECT ON VIEW_THUTHU_COLUMN_LEVEL_P1 TO USER_NHANVIEN_THUTHU_TV03_02;

-------------------- TEST Thủ thư Chính sách 1(Column level) --------------------------------------
--CONN USER_NHANVIEN_THUTHU_TV01_01/USER_NHANVIEN_THUTHU_TV01_01;
--SELECT * FROM SYS.VIEW_THUTHU_COLUMN_LEVEL_P1;
-----------------------------------------------------------------------------------------------



------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Thủ thư
/* Chính sách 2 (column level):- Cập nhật thông tin cá nhân: ngay_sinh, sdt, email*/
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
GRANT UPDATE(NGAY_SINH,SDT,EMAIL) ON SYS.VIEW_THUTHU_COLUMN_LEVEL_P1 TO USER_NHANVIEN_THUTHU_TV01_01;
GRANT UPDATE(NGAY_SINH,SDT,EMAIL) ON SYS.VIEW_THUTHU_COLUMN_LEVEL_P1 TO USER_NHANVIEN_THUTHU_TV01_02;
GRANT UPDATE(NGAY_SINH,SDT,EMAIL) ON SYS.VIEW_THUTHU_COLUMN_LEVEL_P1 TO USER_NHANVIEN_THUTHU_TV01_01;
GRANT UPDATE(NGAY_SINH,SDT,EMAIL) ON SYS.VIEW_THUTHU_COLUMN_LEVEL_P1 TO USER_NHANVIEN_THUTHU_TV02_02;
GRANT UPDATE(NGAY_SINH,SDT,EMAIL) ON SYS.VIEW_THUTHU_COLUMN_LEVEL_P1 TO USER_NHANVIEN_THUTHU_TV01_01;
GRANT UPDATE(NGAY_SINH,SDT,EMAIL) ON SYS.VIEW_THUTHU_COLUMN_LEVEL_P1 TO USER_NHANVIEN_THUTHU_TV03_02;

-------------------- TEST Thủ thư Chính sách 2(Column level) --------------------------------------
--CONN USER_NHANVIEN_THUTHU_TV01_01/USER_NHANVIEN_THUTHU_TV01_01;
--UPDATE SYS.VIEW_THUTHU_COLUMN_LEVEL_P1
--SET SDT='SDT_UPDATED', EMAIL='NEW EMAIL!'
--WHERE HO_TEN = SYS_CONTEXT('USERENV','SESSION_USER');
--
--CONN USER_NHANVIEN_THUTHU_TV01_01/USER_NHANVIEN_THUTHU_TV01_01;
--SELECT * FROM SYS.VIEW_THUTHU_COLUMN_LEVEL_P1;
-----------------------------------------------------------------------------------------------









------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Nhân viên quản lý
/* Chính sách 1 (column level):-  Xem thông tin cá nhân: ho_ten, cmnd, sdt, ngay_sinh
*/
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW VIEW_NVQL_COLUMN_LEVEL_P1
AS
SELECT * FROM NHAN_VIEN 
WHERE NHAN_VIEN.MA_LOAI_NHAN_VIEN ='MLNV02'
AND NHAN_VIEN.HO_TEN = SYS_CONTEXT('USERENV','SESSION_USER');

GRANT SELECT ON VIEW_NVQL_COLUMN_LEVEL_P1 TO USER_NHANVIEN_QUANLY_TV01;
GRANT SELECT ON VIEW_NVQL_COLUMN_LEVEL_P1 TO USER_NHANVIEN_QUANLY_TV02;
GRANT SELECT ON VIEW_NVQL_COLUMN_LEVEL_P1 TO USER_NHANVIEN_QUANLY_TV03;

-------------------- TEST Nhân viên quản lý Chính sách 1(Column level) --------------------------------------
--CONN USER_NHANVIEN_QUANLY_TV01/USER_NHANVIEN_QUANLY_TV01;
--SELECT * FROM SYS.VIEW_NVQL_COLUMN_LEVEL_P1;
-----------------------------------------------------------------------------------------------



------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Nhân viên quản lý
/* Chính sách 2 (column level):- Cập nhật thông tin cá nhân: ngay_sinh, sdt, email*/
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
GRANT UPDATE(NGAY_SINH,SDT,EMAIL) ON SYS.VIEW_NVQL_COLUMN_LEVEL_P1 TO USER_NHANVIEN_QUANLY_TV01;
GRANT UPDATE(NGAY_SINH,SDT,EMAIL) ON SYS.VIEW_NVQL_COLUMN_LEVEL_P1 TO USER_NHANVIEN_QUANLY_TV02;
GRANT UPDATE(NGAY_SINH,SDT,EMAIL) ON SYS.VIEW_NVQL_COLUMN_LEVEL_P1 TO USER_NHANVIEN_QUANLY_TV03;


------------------ TEST Nhân viên quản lý Chính sách 2(Column level) --------------------------------------
--CONN USER_NHANVIEN_QUANLY_TV01/USER_NHANVIEN_QUANLY_TV01;
--UPDATE SYS.VIEW_NVQL_COLUMN_LEVEL_P1
--SET SDT='SDT_UPDATED', EMAIL='NEW NVQL EMAIL!'
--WHERE HO_TEN = SYS_CONTEXT('USERENV','SESSION_USER');
--
--CONN USER_NHANVIEN_QUANLY_TV01/USER_NHANVIEN_QUANLY_TV01;
--SELECT * FROM SYS.VIEW_NVQL_COLUMN_LEVEL_P1;
---------------------------------------------------------------------------------------------





-- Hồ Chí Minh 04/11/2021 



















