------------------------
-- Auto re-run 
------------------------
DECLARE 
    VIEW_COLUMN_SELECT_USER_c NUMBER; CHAMCONG_c number;BENHNHAN_c number;
    HOSOBENHNHAN_c number;HOSODICHVU_c number;HOADON_c number;
    NHANVIEN_c number;DONVI_c number;DONTHUOC_c number;VIEW_COLUMN_SELECT_ROLE_C NUMBER;
    DICHVU_c number;CTHOADON_c number;CTDONTHUOC_c number;THUOC_c number;
begin

    SELECT COUNT(*) INTO VIEW_COLUMN_SELECT_ROLE_C FROM ALL_OBJECTS
    WHERE OBJECT_TYPE IN ('TABLE','VIEW')
    AND OBJECT_NAME ='VIEW_COLUMN_SELECT_ROLE';


    SELECT COUNT(*) INTO VIEW_COLUMN_SELECT_USER_c FROM ALL_OBJECTS
    WHERE OBJECT_TYPE IN ('TABLE','VIEW')
    AND OBJECT_NAME ='VIEW_COLUMN_SELECT_USER';

    SELECT count(*) into CHAMCONG_c from all_objects
    where object_type in ('TABLE','VIEW')
    and object_name = 'CHAMCONG';
    
    SELECT count(*) into BENHNHAN_c from all_objects
    where object_type in ('TABLE','VIEW')
    and object_name = 'BENHNHAN';
    
    SELECT count(*) into HOSOBENHNHAN_c from all_objects
    where object_type in ('TABLE','VIEW')
    and object_name = 'HOSOBENHNHAN';
    
    SELECT count(*) into HOSODICHVU_c from all_objects
    where object_type in ('TABLE','VIEW')
    and object_name = 'HOSODICHVU';
    
    SELECT count(*) into HOADON_c from all_objects
    where object_type in ('TABLE','VIEW')
    and object_name = 'HOADON';
    
    SELECT count(*) into NHANVIEN_c from all_objects
    where object_type in ('TABLE','VIEW')
    and object_name = 'NHANVIEN';
    
    SELECT count(*) into DONVI_c from all_objects
    where object_type in ('TABLE','VIEW')
    and object_name = 'DONVI';
    
    SELECT count(*) into DONTHUOC_c from all_objects
    where object_type in ('TABLE','VIEW')
    and object_name = 'DONTHUOC';
    
    SELECT count(*) into DICHVU_c from all_objects
    where object_type in ('TABLE','VIEW')
    and object_name = 'DICHVU';
    
    SELECT count(*) into CTHOADON_c from all_objects
    where object_type in ('TABLE','VIEW')
    and object_name = 'CTHOADON';
    
    SELECT count(*) into CTDONTHUOC_c from all_objects
    where object_type in ('TABLE','VIEW')
    and object_name = 'CTDONTHUOC';
    
    SELECT count(*) into THUOC_c from all_objects
    where object_type in ('TABLE','VIEW')
    and object_name = 'THUOC';
    
     IF VIEW_COLUMN_SELECT_ROLE_C !=0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE '|| 'VIEW_COLUMN_SELECT_ROLE ' || ' CASCADE CONSTRAINTS' ;
    END IF;
    
    IF VIEW_COLUMN_SELECT_USER_c !=0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE '|| 'VIEW_COLUMN_SELECT_USER ' || ' CASCADE CONSTRAINTS' ;
    END IF;
    IF CHAMCONG_c != 0 then
       EXECUTE IMMEDIATE 'DROP TABLE ' || 'CHAMCONG ' || 'CASCADE CONSTRAINTS';
    end if;
    IF BENHNHAN_c != 0 then
       EXECUTE IMMEDIATE 'DROP TABLE ' || 'BENHNHAN ' || 'CASCADE CONSTRAINTS';
    end if;
    IF HOSOBENHNHAN_c != 0 then
       EXECUTE IMMEDIATE 'DROP TABLE ' || 'HOSOBENHNHAN ' || 'CASCADE CONSTRAINTS';
    end if;
    IF HOSODICHVU_c != 0 then
       EXECUTE IMMEDIATE 'DROP TABLE ' || 'HOSODICHVU ' || 'CASCADE CONSTRAINTS';
    end if;
    IF HOADON_c != 0 then
       EXECUTE IMMEDIATE 'DROP TABLE ' || 'HOADON ' || 'CASCADE CONSTRAINTS';
    end if;
    IF NHANVIEN_c != 0 then
       EXECUTE IMMEDIATE 'DROP TABLE ' || 'NHANVIEN ' || 'CASCADE CONSTRAINTS';
    end if;
    IF DONVI_c != 0 then
       EXECUTE IMMEDIATE 'DROP TABLE ' || 'DONVI ' || 'CASCADE CONSTRAINTS';
    end if;
    IF DONTHUOC_c != 0 then
       EXECUTE IMMEDIATE 'DROP TABLE ' || 'DONTHUOC ' || 'CASCADE CONSTRAINTS';
    end if;
    IF DICHVU_c != 0 then
       EXECUTE IMMEDIATE 'DROP TABLE ' || 'DICHVU ' || 'CASCADE CONSTRAINTS';
    end if;
    IF CTHOADON_c != 0 then
       EXECUTE IMMEDIATE 'DROP TABLE ' || 'CTHOADON ' || 'CASCADE CONSTRAINTS';
    end if;
    IF CTDONTHUOC_c != 0 then
       EXECUTE IMMEDIATE 'DROP TABLE ' || 'CTDONTHUOC ' || 'CASCADE CONSTRAINTS';
    end if;
    IF THUOC_c != 0 then
       EXECUTE IMMEDIATE 'DROP TABLE ' || 'THUOC ' || 'CASCADE CONSTRAINTS';
    end if;
end;
/


--
-- Table
--
CREATE TABLE CHAMCONG (
    maNV  VARCHAR2(200),
    thang date,
    soNgayCong int,
    phuCap VARCHAR2(2000),
    luong  VARCHAR2(2000),
    PRIMARY KEY(maNV,thang)
);

CREATE TABLE BENHNHAN (
    maBN int,
    hoTen VARCHAR2(200),
    ngaySinh date,
    diaChi VARCHAR2(200),
    sdt VARCHAR2(200),
    PRIMARY KEY(maBN)
);

CREATE TABLE HOSOBENHNHAN (
    maKB int,
    ngayKB date,
     maNV  VARCHAR2(200),
    TENBACSI VARCHAR2(200),
    maBN int,
    tinhTrangBanDau VARCHAR2(200),
    ketLuanCuaBacSi VARCHAR2(200),
    PRIMARY KEY(maKB)
);

CREATE TABLE HOSODICHVU (
    maKB int,
    maDV int,
    nguoiThucHien VARCHAR2(200),
    ngayGio date,
    ketLuan VARCHAR2(200),
    PRIMARY KEY(maKB,maDV)
);

CREATE TABLE HOADON (
    soHD int,
    maKB int,
    ngayGio date,
    nguoiPhuTrach VARCHAR2(200),
    tongTien VARCHAR2(200),
    PRIMARY KEY(soHD)
);

CREATE TABLE NHANVIEN (
    maNV  VARCHAR2(200),
    hoTen VARCHAR2(200),
    matKhau varchar2(200),
    luong VARCHAR2(200),
    ngaySinh date,
    diaChi VARCHAR2(200),
    vaiTro VARCHAR2(200),
    maDonVi int,
    PRIMARY KEY(maNV)
);

CREATE TABLE DONVI (
     maDonVi int,
     tenDonVi VARCHAR2(200),
    PRIMARY KEY(maDonVi)
);

CREATE TABLE DONTHUOC (
     maKB int,
     nhanVienPhuTrach VARCHAR2(200),
    PRIMARY KEY(maKB)
);

CREATE TABLE DICHVU (
     maDV int,
     tenDV VARCHAR2(200),
     donGia VARCHAR2(200),
    PRIMARY KEY(maDV)
);

CREATE TABLE CTHOADON (
     soHD int,
    maDV int,
    PRIMARY KEY(soHD,maDV)
);

CREATE TABLE CTDONTHUOC (
    maKB int,
    maThuoc int,
    soLuong VARCHAR2(200),
    lieuDung VARCHAR2(200),
    moTa VARCHAR2(200),
    PRIMARY KEY(maKB,maThuoc)
);

CREATE TABLE THUOC (
    maThuoc int,
    tenThuoc VARCHAR2(200),
    donViThuoc VARCHAR2(200),
    donGia VARCHAR2(200),
    luuY VARCHAR2(200),
    PRIMARY KEY(maThuoc)
);


CREATE TABLE VIEW_COLUMN_SELECT_USER(
    USERNAME NVARCHAR2(200),
    PRIV NVARCHAR2(200),
    COLUMN_NAME NVARCHAR2(200),
    TABLE_NAME NVARCHAR2(200),
    GRANTABLE NVARCHAR2(200),
    VIEW_NAME NVARCHAR2(200)
);

CREATE TABLE VIEW_COLUMN_SELECT_ROLE(
    ROLENAME NVARCHAR2(200),
    PRIV NVARCHAR2(200),
    COLUMN_NAME NVARCHAR2(200),
    TABLE_NAME NVARCHAR2(200),
    GRANTABLE NVARCHAR2(200),
    VIEW_NAME NVARCHAR2(200)
);

------------------------
-- Add Foreign Key
------------------------

ALTER TABLE CHAMCONG
ADD CONSTRAINT FK_CHAMCONG_NHANVIEN
FOREIGN KEY (maNV)
REFERENCES NHANVIEN(maNV);

ALTER TABLE HOSOBENHNHAN
ADD CONSTRAINT FK_HOSOBENHNHAN_NHANVIEN
FOREIGN KEY (maNV)
REFERENCES NHANVIEN(maNV);

ALTER TABLE HOSOBENHNHAN
ADD CONSTRAINT FK_HOSOBENHNHAN_BENHNHAN
FOREIGN KEY (maBN)
REFERENCES BENHNHAN(maBN);


ALTER TABLE HOSODICHVU
ADD CONSTRAINT FK_HOSODICHVU_HOSOBENHNHAN
FOREIGN KEY (maKB)
REFERENCES HOSOBENHNHAN(maKB);

ALTER TABLE HOSODICHVU
ADD CONSTRAINT FK_HOSODICHVU_DICHVU
FOREIGN KEY (maDV)
REFERENCES DICHVU(maDV);


ALTER TABLE HOADON
ADD CONSTRAINT FK_HOADON_HOSOBENHNHAN
FOREIGN KEY (maKB)
REFERENCES HOSOBENHNHAN(maKB);


ALTER TABLE NHANVIEN
ADD CONSTRAINT FK_NHANVIEN_DONVI
FOREIGN KEY (maDonVi)
REFERENCES DONVI(maDonVi);

ALTER TABLE DONTHUOC
ADD CONSTRAINT FK_DONTHUOC_HOSOBENHNHAN
FOREIGN KEY (maKB)
REFERENCES HOSOBENHNHAN(maKB);



ALTER TABLE CTHOADON
ADD CONSTRAINT FK_CTHOADON_DICHVU
FOREIGN KEY (maDV)
REFERENCES DICHVU(maDV);


ALTER TABLE CTHOADON
ADD CONSTRAINT FK_CTHOADON_HOADON
FOREIGN KEY (soHD)
REFERENCES HOADON(soHD);

ALTER TABLE CTDONTHUOC
ADD CONSTRAINT FK_CTDONTHUOC_HOSOBENHNHAN
FOREIGN KEY (maKB)
REFERENCES HOSOBENHNHAN(maKB);

ALTER TABLE CTDONTHUOC
ADD CONSTRAINT FK_CTDONTHUOC_THUOC
FOREIGN KEY (maThuoc)
REFERENCES THUOC(maThuoc);

------------------------
-- Add records
------------------------

--insert benh nhan
insert into BENHNHAN (maBN, hoTen, ngaySinh, diaChi, sdt) 
values (1, 'Tiep Thi Lan', TO_DATE('12/01/1984', 'DD/MM/YYYY'),'5/9 Ap Tay Vinh Phu Thuan An Binh Duong, Ho Chi Minh','0755586591');
insert into BENHNHAN (maBN, hoTen, ngaySinh, diaChi, sdt)
values (2, 'Trang Quang Tri', TO_DATE('12/01/1975', 'DD/MM/YYYY'),'485 Huynh Van Banh, Ho Chi Minh','0755586592');
insert into BENHNHAN (maBN, hoTen, ngaySinh, diaChi, sdt) 
values (3, 'Nguyen An Ninh', TO_DATE('12/01/1988', 'DD/MM/YYYY'),'173/44/15 Duong Quang Ham St Go Vap Dist Ho Chi Minh City, ho chi minh','0755586593');
insert into BENHNHAN (maBN, hoTen, ngaySinh, diaChi, sdt) 
values (4, 'Nguyen Thanh Trung', TO_DATE('12/01/1983', 'DD/MM/YYYY'),'164/22 Le Dinh Tham Str., Ho Chi Minh','0755586594');
insert into BENHNHAN (maBN, hoTen, ngaySinh, diaChi, sdt) 
values (5, 'Tran Minh Kiet', TO_DATE('12/01/1972', 'DD/MM/YYYY'),'102 Le Thi Rieng Street, Ho Chi Minh','0755586595');
insert into BENHNHAN (maBN, hoTen, ngaySinh, diaChi, sdt) 
values (6, 'Nguyen Van Ni', TO_DATE('12/01/1973', 'DD/MM/YYYY'),'176 / 38 Tran Huy Lieu. Phu Nhuan District, Ho Chi Minh','0755586596');
insert into BENHNHAN (maBN, hoTen, ngaySinh, diaChi, sdt) 
values (7, 'Le Trong Thang', TO_DATE('12/01/1974', 'DD/MM/YYYY'),'67 / 140 Bui Dinh Tuy Street-Ward12-Binh Thanh, Ho Chi Minh','0755586597');
insert into BENHNHAN (maBN, hoTen, ngaySinh, diaChi, sdt)
values (8, 'Ho Ngoc Thanh', TO_DATE('12/01/1981', 'DD/MM/YYYY'),'376 / 24 Nguyen Dinh Chieu Street. District 3, Ho Chi Minh','0755586598');
insert into BENHNHAN (maBN, hoTen, ngaySinh, diaChi, sdt) 
values (9, 'Lo Trong Lanh', TO_DATE('12/01/1969', 'DD/MM/YYYY'),'2nd Floor 54 Phung Van Cung Street, Ho Chi Minh','0755586599');
insert into BENHNHAN (maBN, hoTen, ngaySinh, diaChi, sdt) 
values (10, 'Phu Van Huu', TO_DATE('12/01/1960', 'DD/MM/YYYY'),'72 Vo Thi Sau, Dist.1, TP HCM','0755586511');

--insert Don vi
insert into DONVI (maDonVi, tenDonVi) 
values (1,'BO PHAN QUAN LY');
insert into DONVI (maDonVi, tenDonVi) 
values (2,'BO PHAN TIEP TAN VA DIEU PHOI');
insert into DONVI (maDonVi, tenDonVi) 
values (3,'BAC SI');
insert into DONVI (maDonVi, tenDonVi) 
values (4,'PHONG TAI VU');
insert into DONVI (maDonVi, tenDonVi) 
values (5,'PHONG BAN THUOC');
insert into DONVI (maDonVi, tenDonVi) 
values (6,'BO PHAN KE TOAN');
insert into DONVI (maDonVi, tenDonVi) 
values (7,'ADMIN');

--insert NHANVIEN
insert into NHANVIEN (maNV, hoTen,matKhau, luong, ngaySinh, diaChi, vaiTro, maDonVi) 
values ('NVQL01','user_nvquanli_01','user_nvquanli_01',6912000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'174 Tran Quang Khai, Thu Duc Ward, Dist.1,TP HCM','NHANVIEN_QUANLY_TAINGUYEN_NHANSU',1);

insert into NHANVIEN (maNV, hoTen,matKhau, luong, ngaySinh, diaChi, vaiTro, maDonVi) 
values ('NVQL02','user_nvquanli_02','user_nvquanli_02',6912000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'49 Dong Khoi Street,  Ben Nghe Ward, District 1, Tp HCM','NHANVIEN_QUANLY_TAIVU',1);
insert into NHANVIEN (maNV, hoTen,matKhau, luong, ngaySinh, diaChi, vaiTro, maDonVi) 
values ('NVQL03','user_nvquanli_03','user_nvquanli_03',6912000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'15 Hau Giang Street, Ward 4, Tan Binh','NHANVIEN_QUANLY_CHUYENMON',2);
insert into NHANVIEN (maNV, hoTen,matKhau, luong, ngaySinh, diaChi, vaiTro, maDonVi) 
values ('NVLT01','user_nvletan_01','user_nvletan_01',6912000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'24/2 Tran Khac Tran Strees, Tan Dinh Ward, District 1, TP HCM','NHANVIEN_LETAN',3);
insert into NHANVIEN (maNV, hoTen,matKhau, luong, ngaySinh, diaChi, vaiTro, maDonVi) 
values ('NVLT02','user_nvletan_02','user_nvletan_02',6912000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'196/18 To Hieu St., Hiep Tan Ward, Tan Phu','NHANVIEN_LETAN',2);
insert into NHANVIEN (maNV, hoTen,matKhau, luong, ngaySinh, diaChi, vaiTro, maDonVi) 
values ('BS01','USER_BACSI_01','USER_BACSI_01',12800000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'107 Hoa Hung St., Ward 12, Dist. 10, TP HCM','NHANVIEN_BACSI',3);
insert into NHANVIEN (maNV, hoTen,matKhau, luong, ngaySinh, diaChi, vaiTro, maDonVi) 
values ('BS02','USER_BACSI_02','USER_BACSI_02',6912000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'180-182 Ly Chinh Thang Street, Ward 9, District 3, TP HCM','NHANVIEN_BACSI',4);
insert into NHANVIEN (maNV, hoTen,matKhau, luong, ngaySinh, diaChi, vaiTro, maDonVi) 
values ('NVTV01','USER_TAIVU_01','USER_TAIVU_01',6912000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'288R No Trang Long Street, Ward 12, Binh Thanh','NHANVIEN_TAIVU',5);
insert into NHANVIEN (maNV, hoTen,matKhau, luong, ngaySinh, diaChi, vaiTro, maDonVi) 
values ('NVBT01','USER_BANTHUOC_01','USER_BANTHUOC_01',6912000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'148 Ph? Khu?t Khoa M?n, X? Th?c, Huy?n Trinh Danh ,C? Mau','NHANVIEN_KETOAN',6);
insert into NHANVIEN (maNV, hoTen,matKhau, luong, ngaySinh, diaChi, vaiTro, maDonVi)
values ('NVKT01','USER_KETOAN_01','USER_KETOAN_01',6912000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'297/5F Nguyen Xi, Ward 13, Binh Thanh','NHANVIEN_KETOAN',6);

-- NHAN VIEN TEMP
insert into NHANVIEN (maNV, hoTen,matKhau, luong, ngaySinh, diaChi, vaiTro, maDonVi)
values ('NVTEMP01','USER_TEMP_01','USER_TEMP_01',6912000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'HO CHI MINH','NHANVIEN_TEMP',2);
insert into NHANVIEN (maNV, hoTen,matKhau, luong, ngaySinh, diaChi, vaiTro, maDonVi)
values ('NVTEMP02','USER_TEMP_02','USER_TEMP_02',69120020,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'HO CHI MINH','NHANVIEN_TEMP',2);

-- NHAN VIEN LE TAN & DIEU PHOI
insert into NHANVIEN (maNV, hoTen,matKhau, luong, ngaySinh, diaChi, vaiTro, maDonVi)
values ('NVTIEPTAN01','user_tieptan_01','user_tieptan_01',6912000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'HO CHI MINH','NHANVIEN_TIEPTAN',1);
insert into NHANVIEN (maNV, hoTen,matKhau, luong, ngaySinh, diaChi, vaiTro, maDonVi)
values ('NVTIEPTAN02','user_tieptan_02','user_tieptan_02',6912000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'HO CHI MINH','NHANVIEN_TIEPTAN',1);

-- NHAN VIEN ADMIN
insert into NHANVIEN (maNV, hoTen,matKhau, luong, ngaySinh, diaChi, vaiTro, maDonVi)
values ('NVADMIN','DUCCAO_ADMIN','DUCCAO_ADMIN',6912000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'HO CHI MINH','NHANVIEN_ADMIN',1);


--insert cham cong
insert into CHAMCONG (maNV, thang, soNgayCong,phuCap,luong)
values ('BS01',TO_DATE('12/01/1960', 'DD/MM/YYYY'),25,'1000000','');
insert into CHAMCONG (maNV, thang, soNgayCong,phuCap,luong)
values ('BS01',TO_DATE('12/01/2019', 'DD/MM/YYYY'),30,'1000000','');
insert into CHAMCONG (maNV, thang, soNgayCong,phuCap,luong)
values ('BS01',TO_DATE('12/01/2020', 'DD/MM/YYYY'),30,'1000000','');
insert into CHAMCONG (maNV, thang, soNgayCong,phuCap,luong)
values ('BS02',TO_DATE('12/01/1960', 'DD/MM/YYYY'),30,'1000000','');
insert into CHAMCONG (maNV, thang, soNgayCong,phuCap,luong)
values ('NVTIEPTAN01',TO_DATE('12/01/1960', 'DD/MM/YYYY'),30,'1000000','');
insert into CHAMCONG (maNV, thang, soNgayCong,phuCap,luong)
values ('NVTIEPTAN02',TO_DATE('12/01/1960', 'DD/MM/YYYY'),25,'1000000','');

--insert THUOC
insert into THUOC (maThuoc,tenThuoc, donViThuoc, donGia, luuY)
values (1,'TITANIUM DIOXIDE','Vien','16.200','Khong tu y ngung hoac tang lieu thuoc uong');
insert into THUOC (maThuoc,tenThuoc, donViThuoc, donGia, luuY)
values (2,'Clotrimazole 1%','Vien','5.200','Khong tu y ngung hoac tang lieu thuoc uong');
insert into THUOC (maThuoc,tenThuoc, donViThuoc, donGia, luuY)
values (3,'Levofloxacin','Vien','5.260','Khong tu y ngung hoac tang lieu thuoc uong');
insert into THUOC (maThuoc,tenThuoc, donViThuoc, donGia, luuY)
values (4,'Povidone Iodine','Vien','134.400','Khong tu y ngung hoac tang lieu thuoc uong');
insert into THUOC (maThuoc,tenThuoc, donViThuoc, donGia, luuY)
values (5,'DEXTROSE','Chai','16.200','Khong tu y ngung hoac tang lieu thuoc uong');
insert into THUOC (maThuoc,tenThuoc, donViThuoc, donGia, luuY)
values (6,'ENALAPRIL MALEATE','Vien','8.000','Khong tu y ngung hoac tang lieu thuoc uong');
insert into THUOC (maThuoc,tenThuoc, donViThuoc, donGia, luuY)
values (7,'Hydroxychloroquine Sulfate','Chai','6.700','Khong tu y ngung hoac tang lieu thuoc uong');
insert into THUOC (maThuoc,tenThuoc, donViThuoc, donGia, luuY)
values (8,'Imipramine Hydrochloride','Chai','26.500','Khong tu y ngung hoac tang lieu thuoc uong');
insert into THUOC (maThuoc,tenThuoc, donViThuoc, donGia, luuY)
values (9,'Benzalkonium Chloride, Lidocaine Hydrochloride','Vien','39.000','Khong tu y ngung hoac tang lieu thuoc uong');
insert into THUOC (maThuoc,tenThuoc, donViThuoc, donGia, luuY)
values (10,'Hydroxyzine Pamoate','Vien','3.000','Khong tu y ngung hoac tang lieu thuoc uong');

--insert Ho so benh nhan
insert into HOSOBENHNHAN (maKB,ngayKB, maNV, tenBacSi, maBN, tinhTrangBanDau, ketLuanCuaBacSi)
values (1,TO_DATE('12/01/2020', 'DD/MM/YYYY'),'BS01','USER_BACSI_01',1,'Ho 1','Viem phoi 1');
insert into HOSOBENHNHAN (maKB,ngayKB, maNV, tenBacSi, maBN, tinhTrangBanDau, ketLuanCuaBacSi)
values (2,TO_DATE('12/01/2020', 'DD/MM/YYYY'),'BS01','USER_BACSI_01',2,'Ho 1','Viem phoi 1');
insert into HOSOBENHNHAN (maKB,ngayKB, maNV, tenBacSi, maBN, tinhTrangBanDau, ketLuanCuaBacSi)
values (3,TO_DATE('12/01/2020', 'DD/MM/YYYY'),'BS01','USER_BACSI_01',3,'Ho 1','Viem phoi 1');
insert into HOSOBENHNHAN (maKB,ngayKB, maNV, tenBacSi, maBN, tinhTrangBanDau, ketLuanCuaBacSi)
values (4,TO_DATE('12/01/2020', 'DD/MM/YYYY'),'BS02','USER_BACSI_02',4,'Ho 2','Viem phoi 2');
insert into HOSOBENHNHAN (maKB,ngayKB, maNV, tenBacSi, maBN, tinhTrangBanDau, ketLuanCuaBacSi)
values (5,TO_DATE('12/01/2020', 'DD/MM/YYYY'),'BS02','USER_BACSI_02',5,'Ho 2','Viem phoi 2');
--insert don thuoc
insert into DONTHUOC (maKB,nhanVienPhuTrach)
values (1,'Nguyen Van Ni');
insert into DONTHUOC (maKB,nhanVienPhuTrach)
values (2,'Nguyen Duc Trinh');
insert into DONTHUOC (maKB,nhanVienPhuTrach)
values (3,'Vo Quoc Thai');
insert into DONTHUOC (maKB,nhanVienPhuTrach)
values (4,'Truong Hoang Phuc');
insert into DONTHUOC (maKB,nhanVienPhuTrach)
values (5,'Nguyen Hoang Viet');


--insert don thuoc
insert into CTDONTHUOC (maKB,maThuoc, soLuong, lieuDung, moTa)
values (1,1,'4', '2 vien', 'Ngay 2 vien sang chieu sau khi an');
insert into CTDONTHUOC (maKB,maThuoc, soLuong, lieuDung, moTa)
values (1,2,'12', '30ml', 'Uong sang-trua-chieu truoc khi an');
insert into CTDONTHUOC (maKB,maThuoc, soLuong, lieuDung, moTa)
values (2,3,'5', '2 vien', 'Uong luc 8 sang - 8 gio toi');
insert into CTDONTHUOC (maKB,maThuoc, soLuong, lieuDung, moTa)
values (3,4,'6', '2 vien', 'Uong sang va chieu sau khi an');
insert into CTDONTHUOC (maKB,maThuoc, soLuong, lieuDung, moTa)
values (3,5,'6', '4 vien', 'Sang chieu sau an');

--insert dich vu
insert into DICHVU (maDV, tenDV, donGia)
values (1,'Sieu am 2D','150.000');
insert into DICHVU (maDV, tenDV, donGia)
values (2,'Sieu am 3D','250.000');
insert into DICHVU (maDV, tenDV, donGia)
values (3,'Kham, noi soi Tai, M?i','230.000');
insert into DICHVU (maDV, tenDV, donGia)
values (4,'Kham so sinh','150.000');
insert into DICHVU (maDV, tenDV, donGia)
values (5,'Chieu bang may plasmamend ho tro dieu tri vet thuong','240.000');

--insert dich vu
insert into HOSODICHVU (maKB, maDV, nguoiThucHien, ngayGio,ketLuan)
values (1,2,'Pham Minh Tuan', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 'Bi sot xuat huyet');
insert into HOSODICHVU (maKB, maDV, nguoiThucHien, ngayGio,ketLuan)
values (2,1,'Nguyen Phuong Vy', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 'Bi viem hong');
insert into HOSODICHVU (maKB, maDV, nguoiThucHien, ngayGio,ketLuan)
values (3,3,'Thong Quang Hao', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 'Bi viem phoi');
insert into HOSODICHVU (maKB, maDV, nguoiThucHien, ngayGio,ketLuan)
values (4,3,'Luong Ngoc Uoc', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 'Bi viem tai');
insert into HOSODICHVU (maKB, maDV, nguoiThucHien, ngayGio,ketLuan)
values (5,4,'Ton Quang Dung', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 'bi gay chan');


--insert Hoa Don
insert into HOADON (soHD, maKB, ngayGio, nguoiPhuTrach,tongTien)
values (1, 1, TO_DATE('12/01/2020', 'DD/MM/YYYY'),'Tran Duc Huy',150000);
insert into HOADON (soHD, maKB, ngayGio, nguoiPhuTrach,tongTien)
values (2, 2, TO_DATE('12/01/2020', 'DD/MM/YYYY'),'Do Duy Manh',150000);
insert into HOADON (soHD, maKB, ngayGio, nguoiPhuTrach,tongTien)
values (3, 3, TO_DATE('12/01/2020', 'DD/MM/YYYY'),'Tran Dinh Trong',150000);
insert into HOADON (soHD, maKB, ngayGio, nguoiPhuTrach,tongTien)
values (4, 4, TO_DATE('12/01/2020', 'DD/MM/YYYY'),'Pham Duc Huy',150000);
insert into HOADON (soHD, maKB, ngayGio, nguoiPhuTrach,tongTien)
values (5, 5, TO_DATE('12/01/2020', 'DD/MM/YYYY'),'Nguyen Quang Hai',0);


--insert chi tiet hoa don
insert into CTHOADON (soHD, maDV)
values (1, 1);
insert into CTHOADON (soHD, maDV)
values (1, 2);
insert into CTHOADON (soHD, maDV)
values (2, 1);
insert into CTHOADON (soHD, maDV)
values (3, 1);
insert into CTHOADON (soHD, maDV)
values (4, 1);








------------------------
-- B. Add policy
------------------------




--• Mandatory Access Control Models (MAC)
--• Definition When a system mechanism controls access to an
--object and an individual user cannot alter that access, the
--control is a mandatory access control (MAC), occasionally
--called a rule-based access control.

-- Discretionary Access Control Models (DAC)
--• Definition If an individual user can set an access control
-- mechanism to allow or deny access to an object, that
-- mechanism is a discretionary access control (DAC),

-- • RBAC (Role-based Access Control)


------------------------
-- B.1. Reception Role 
------------------------
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;  
CREATE ROLE ROLE_DEP_LETAN IDENTIFIED BY ROLE_DEP_LETAN;
GRANT CREATE SESSION TO ROLE_DEP_LETAN;

-- Grant policy to reception department
GRANT CREATE SESSION TO ROLE_DEP_LETAN;
GRANT INSERT, SELECT, UPDATE ON BENHNHAN TO ROLE_DEP_LETAN;
GRANT SELECT ON HOSOBENHNHAN TO ROLE_DEP_LETAN;
GRANT INSERT (MAKB, NGAYKB, TENBACSI, MABN, TINHTRANGBANDAU) ON HOSOBENHNHAN TO ROLE_DEP_LETAN;
GRANT UPDATE (MAKB, NGAYKB, TENBACSI, MABN, TINHTRANGBANDAU) ON HOSOBENHNHAN TO ROLE_DEP_LETAN;

CREATE OR REPLACE VIEW VIEW_RECEPTION_DOCTOR AS
SELECT NV.MANV, NV.HOTEN, NV.VAITRO
FROM NHANVIEN NV
WHERE NV.VAITRO = 'NHANVIEN_BACSI';

GRANT SELECT ON VIEW_RECEPTION_DOCTOR TO ROLE_DEP_LETAN;

SELECT * FROM NHANVIEN;

CREATE USER USER_TIEPTAN_01 IDENTIFIED BY USER_TIEPTAN_01;
CREATE USER USER_TIEPTAN_02 IDENTIFIED BY USER_TIEPTAN_02;
GRANT CREATE SESSION TO USER_TIEPTAN_01;
GRANT CREATE SESSION TO USER_TIEPTAN_02;


GRANT ROLE_DEP_LETAN TO USER_TIEPTAN_01;
GRANT ROLE_DEP_LETAN TO USER_TIEPTAN_02;

------------------------------
-- B.2. Accounting Department
------------------------------
CREATE ROLE ROLE_DEP_KETOAN IDENTIFIED BY ROLE_DEP_KETOAN;

GRANT CREATE SESSION TO ROLE_DEP_KETOAN;

GRANT SELECT ON CHAMCONG TO ROLE_DEP_KETOAN;
GRANT SELECT, UPDATE(LUONG) ON NHANVIEN TO ROLE_DEP_KETOAN;


CREATE USER USER_KETOAN_01 IDENTIFIED BY USER_KETOAN_01;
CREATE USER USER_KETOAN_02 IDENTIFIED BY USER_KETOAN_02;

GRANT CREATE SESSION TO USER_KETOAN_01;
GRANT CREATE SESSION TO USER_KETOAN_02;


GRANT ROLE_DEP_KETOAN to USER_KETOAN_01;
GRANT ROLE_DEP_KETOAN to USER_KETOAN_02;





------------------------
-- B.3. Doctor Role 
------------------------

-- 1. Only SELECT, UPDATE patient information for their responsibility
-- VPD Function
CREATE OR REPLACE FUNCTION FUNC_VPD_POLICY_DOCTOR_HOSOBENHNHAN(
    v_schema IN VARCHAR2,
    v_object IN VARCHAR2
)
RETURN VARCHAR2 
AS
    predicate VARCHAR2(200);
    cur_user VARCHAR2(200);
BEGIN
-- ''' ERROR  @@ TROI OI!! CAI ''' NAY LA NGUYEN NHAN 
    cur_user:= SYS_CONTEXT('USERENV','SESSION_USER');
    IF (INSTR(cur_user,'BACSI')<>0) THEN
      predicate:= 'TENBACSI = ''' ||cur_user||'''';
    ELSE
     predicate:= '';
    END IF;
    RETURN predicate;
END FUNC_VPD_POLICY_DOCTOR_HOSOBENHNHAN;
/

BEGIN
    DBMS_RLS.add_policy(
    object_schema    => 'DUCCAO_ADMIN', 
    object_name      => 'HOSOBENHNHAN',
    policy_name      => 'POLICY_VPD_DOCTOR_HOSOBENHNHAN',
    policy_function  => 'FUNC_VPD_POLICY_DOCTOR_HOSOBENHNHAN',
    statement_types => 'SELECT,UPDATE',
    update_check => TRUE);
END;
/


-- 2. Only SELECT, INSERT, UPDATE ON CTDONTHUOC for their responsibility
CREATE OR REPLACE FUNCTION FUNC_VPD_DOCTOR_CTDONTHUOC(
    IPSCHEMA IN VARCHAR2,
    IPOBJ IN VARCHAR2
)
RETURN VARCHAR2
AS
PREDICATE VARCHAR2(200);
CURR VARCHAR2(200);
BEGIN
    CURR:=UPPER(SYS_CONTEXT('USERENV','SESSION_USER'));
    
    IF (INSTR(CURR,'BACSI')<>0) THEN
    PREDICATE :=  'TENBACSI = '''||CURR||''' ';
    ELSE
    PREDICATE :='';
    END IF;
    RETURN PREDICATE;
END FUNC_VPD_DOCTOR_CTDONTHUOC;
/

-- VIEW VIEW_VPD_DOCTOR_CTDONTHUOC
CREATE OR REPLACE VIEW VIEW_VPD_DOCTOR_CTDONTHUOC
AS
SELECT CTDONTHUOC.MAKB, CTDONTHUOC.MATHUOC, CTDONTHUOC.SOLUONG, CTDONTHUOC.LIEUDUNG, CTDONTHUOC.MOTA, 
HOSOBENHNHAN.NGAYKB, HOSOBENHNHAN.MANV, HOSOBENHNHAN.TENBACSI, HOSOBENHNHAN.MABN, HOSOBENHNHAN.TINHTRANGBANDAU
,HOSOBENHNHAN.KETLUANCUABACSI
FROM CTDONTHUOC 
LEFT JOIN HOSOBENHNHAN 
ON HOSOBENHNHAN.MAKB = CTDONTHUOC.MAKB;





CREATE ROLE ROLE_DOCTOR IDENTIFIED BY ROLE_DOCTOR;
GRANT CREATE SESSION TO ROLE_DOCTOR;


GRANT SELECT ON HOSOBENHNHAN TO ROLE_DOCTOR;
GRANT SELECT ON CTDONTHUOC TO ROLE_DOCTOR;
GRANT SELECT ON HOSODICHVU TO ROLE_DOCTOR;
GRANT SELECT ON THUOC TO ROLE_DOCTOR;

GRANT INSERT(ketLuanCuaBacSi), UPDATE(ketLuanCuaBacSi)ON HOSOBENHNHAN TO ROLE_DOCTOR;
GRANT INSERT (maKB,maDV,ngayGio), UPDATE (maKB,maDV,ngayGio) ON HOSODICHVU TO ROLE_DOCTOR;
GRANT INSERT, UPDATE ON DONTHUOC TO ROLE_DOCTOR;
GRANT INSERT, UPDATE ON CTDONTHUOC TO ROLE_DOCTOR;


GRANT INSERT, UPDATE (ketLuanCuaBacSi) ON HOSOBENHNHAN TO ROLE_DOCTOR;
GRANT INSERT, UPDATE (maKB,maDV,ngayGio) ON HOSODICHVU TO ROLE_DOCTOR;
-- Grant role to user - role_doctor


CREATE USER USER_BACSI_01 IDENTIFIED BY USER_BACSI_01;
CREATE USER USER_BACSI_02 IDENTIFIED BY USER_BACSI_02;
GRANT CREATE SESSION TO USER_BACSI_01;
GRANT CREATE SESSION TO USER_BACSI_02;

GRANT ROLE_DOCTOR TO USER_BACSI_01;
GRANT ROLE_DOCTOR TO USER_BACSI_02;


GRANT SELECT ON VIEW_VPD_DOCTOR_CTDONTHUOC TO ROLE_DOCTOR;
-- ADD POLICY
BEGIN
    DBMS_RLS.ADD_POLICY (
        OBJECT_SCHEMA =>'DUCCAO_ADMIN',
        OBJECT_NAME => 'VIEW_VPD_DOCTOR_CTDONTHUOC',
        POLICY_NAME => 'POLICY_VPD_DOCTOR_CTDONTHUOC',
        POLICY_FUNCTION =>'FUNC_VPD_DOCTOR_CTDONTHUOC',
        STATEMENT_TYPES =>'SELECT, INSERT, UPDATE',
        UPDATE_CHECK =>TRUE );
END;
/


----------------------------
-- B.4. Management Department
----- Grant policy to management deparment using DAC || RBAC
----------------------------

-- a. Quan ly tai nguyen va nhan su
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;  
CREATE ROLE ROLE_DEP_QL_TG_NS IDENTIFIED BY ROLE_DEP_QL_TG_NS;
GRANT CREATE SESSION TO ROLE_DEP_QL_TG_NS;

--GRANT INSERT, DELETE, UPDATE ON NHANVIEN TO ROLE_DEP_QL_TG_NS;
GRANT INSERT(MANV, HOTEN, MATKHAU, NGAYSINH, DIACHI, VAITRO, MADONVI) ON NHANVIEN TO ROLE_DEP_QL_TG_NS;
GRANT DELETE ON NHANVIEN TO ROLE_DEP_QL_TG_NS;
GRANT INSERT, DELETE, UPDATE ON DONVI TO ROLE_DEP_QL_TG_NS;
GRANT INSERT, DELETE, UPDATE ON CHAMCONG TO ROLE_DEP_QL_TG_NS;

-- Duoc quyen xem tat ca thong tin cua nhan vien nhung khong duoc xem truong luong cua nhan vien khac
CREATE OR REPLACE VIEW VW_DEP_QL_TAINGUYEN_NHANSU
AS
SELECT nv.MANV,nv.HOTEN,
DECODE(trim(nv.HOTEN),sys_context('USERENV','SESSION_USER'),nv.LUONG,null) as Salary,
nv.NGAYSINH, nv.DIACHI, 
nv.VAITRO, nv.MADONVI, cc.THANG, cc.SONGAYCONG, dv.TENDONVI
FROM NHANVIEN nv 
LEFT JOIN CHAMCONG cc ON nv.MANV = cc.MANV
JOIN DONVI dv ON nv.MADONVI = dv.MADONVI;

GRANT SELECT ON VW_DEP_QL_TAINGUYEN_NHANSU TO ROLE_DEP_QL_TG_NS;

-- tao User Quan ly tai nguyen va nhan su
CREATE USER USER_TAINGUYEN_NHANSU_01 IDENTIFIED BY USER_TAINGUYEN_NHANSU_01;
CREATE USER USER_TAINGUYEN_NHANSU_02 IDENTIFIED BY USER_TAINGUYEN_NHANSU_02;
GRANT CONNECT TO USER_TAINGUYEN_NHANSU_01;
GRANT CONNECT TO USER_TAINGUYEN_NHANSU_02;

GRANT CREATE SESSION TO USER_TAINGUYEN_NHANSU_01;
GRANT CREATE SESSION TO USER_TAINGUYEN_NHANSU_02;


GRANT ROLE_DEP_QL_TG_NS TO USER_TAINGUYEN_NHANSU_01;
GRANT ROLE_DEP_QL_TG_NS TO USER_TAINGUYEN_NHANSU_02;

-- b. Quan ly tai vu
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;  
CREATE ROLE ROLE_DEP_QL_TAIVU IDENTIFIED BY ROLE_DEP_QL_TAIVU;
GRANT CREATE SESSION TO ROLE_DEP_QL_TAIVU;

--Grant policy to nhom quan ly tai vu;
--Duoc xem tat ca thong tin
BEGIN
   FOR R IN (SELECT owner, table_name FROM all_tables WHERE table_name != 'NHANVIEN' AND owner = sys_context('userenv','session_user')) LOOP
      EXECUTE IMMEDIATE 'grant select on '||R.owner||'.'||R.table_name||' to ROLE_DEP_QL_TAIVU';
   END LOOP;
END;
/

--Duoc chinh sua cac truong sau
GRANT UPDATE (DONGIA) ON DICHVU TO ROLE_DEP_QL_TAIVU;
GRANT UPDATE (TONGTIEN) ON HOADON TO ROLE_DEP_QL_TAIVU;
GRANT UPDATE (DONGIA) ON THUOC TO ROLE_DEP_QL_TAIVU;

---- Duoc quyen xem tat ca thong tin tru truong luong va truong mat khau cua nhan vien khac select * from nhanvien;
CREATE OR REPLACE VIEW VW_NHANVIEN_DEP_QL_TAIVU
AS
SELECT nv.MANV,nv.HOTEN,
DECODE(trim(nv.HOTEN),sys_context('USERENV','SESSION_USER'),nv.MATKHAU,null) as Matkhau,
DECODE(trim(nv.HOTEN),sys_context('USERENV','SESSION_USER'),nv.LUONG,null) as Salary,
nv.NGAYSINH, nv.DIACHI, 
nv.VAITRO, nv.MADONVI
FROM NHANVIEN nv;

GRANT SELECT ON VW_NHANVIEN_DEP_QL_TAIVU TO ROLE_DEP_QL_TAIVU;

-- tao User Quan ly tai nguyen va nhan su
CREATE USER USER_QUANLY_TAIVU_01 IDENTIFIED BY USER_QUANLY_TAIVU_01;
CREATE USER USER_QUANLY_TAIVU_02 IDENTIFIED BY USER_QUANLY_TAIVU_02;
GRANT CONNECT TO USER_QUANLY_TAIVU_01;
GRANT CONNECT TO USER_QUANLY_TAIVU_02;

GRANT CREATE SESSION TO USER_QUANLY_TAIVU_01;
GRANT CREATE SESSION TO USER_QUANLY_TAIVU_02;


GRANT ROLE_DEP_QL_TAIVU TO USER_QUANLY_TAIVU_01;
GRANT ROLE_DEP_QL_TAIVU TO USER_QUANLY_TAIVU_02;

-- c. Quan ly chuyen mon
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;  
CREATE ROLE ROLE_DEP_QL_CHUYENMON IDENTIFIED BY ROLE_DEP_QL_CHUYENMON;
GRANT CREATE SESSION TO ROLE_DEP_QL_CHUYENMON;

--Grant policy to nhom quan ly tai vu;
--Duoc xem tat ca thong tin tru di truong luong cua nhan vien khac trong bang nhan vien
BEGIN
   FOR R IN (SELECT owner, table_name FROM all_tables WHERE table_name != 'NHANVIEN' AND owner = sys_context('userenv','session_user')) LOOP
      EXECUTE IMMEDIATE 'grant select on '||R.owner||'.'||R.table_name||' to ROLE_DEP_QL_CHUYENMON';
   END LOOP;
END;
/

---- View de chi nhin thay luong va mat khau cua user dang login
CREATE OR REPLACE VIEW VW_NHANVIEN_DEP_QL_CHUYENMON
AS
SELECT nv.MANV,nv.HOTEN,
DECODE(trim(nv.HOTEN),sys_context('USERENV','SESSION_USER'),nv.MATKHAU,null) as Matkhau,
DECODE(trim(nv.HOTEN),sys_context('USERENV','SESSION_USER'),nv.LUONG,null) as Salary,
nv.NGAYSINH, nv.DIACHI, 
nv.VAITRO, nv.MADONVI
FROM NHANVIEN nv;

GRANT SELECT ON VW_NHANVIEN_DEP_QL_CHUYENMON TO ROLE_DEP_QL_CHUYENMON;

-- tao User Quan ly tai nguyen va nhan su
CREATE USER USER_QUANLY_CHUYENMON_01 IDENTIFIED BY USER_QUANLY_CHUYENMON_01;
CREATE USER USER_QUANLY_CHUYENMON_02 IDENTIFIED BY USER_QUANLY_CHUYENMON_02;
GRANT CONNECT TO USER_QUANLY_CHUYENMON_01;
GRANT CONNECT TO USER_QUANLY_CHUYENMON_02;

GRANT CREATE SESSION TO USER_QUANLY_CHUYENMON_01;
GRANT CREATE SESSION TO USER_QUANLY_CHUYENMON_02;


GRANT ROLE_DEP_QL_CHUYENMON TO USER_QUANLY_CHUYENMON_01;
GRANT ROLE_DEP_QL_CHUYENMON TO USER_QUANLY_CHUYENMON_02;



/*****************
C. Encrypt 
*****************/


-- Thuc thi ma hoa - matkhau - nhanvien
SET SERVEROUTPUT ON SIZE 30000;
EXEC proc_encrypt_matkhau_nhanvien;

-- More policy
-- Doctor see their infor only
CREATE OR REPLACE VIEW VW_DOCTOR_SEE_THEIR_INFO
AS
SELECT DUCCAO_ADMIN.NHANVIEN.MANV, DUCCAO_ADMIN.NHANVIEN.HOTEN, 
func_decrypt_matkhau_nhanvien(DUCCAO_ADMIN.NHANVIEN.MATKHAU) AS MATKHAU ,
DUCCAO_ADMIN.NHANVIEN.LUONG, DUCCAO_ADMIN.NHANVIEN.NGAYSINH, DUCCAO_ADMIN.NHANVIEN.DIACHI,
DUCCAO_ADMIN.NHANVIEN.VAITRO, DUCCAO_ADMIN.NHANVIEN.MADONVI
FROM DUCCAO_ADMIN.NHANVIEN;

-- Function VPD DOCTOR_SEE_THEIR_INFO
CREATE OR REPLACE FUNCTION FUNC_VPD_DOCTOR_SEE_THEIR_INFO_ONLY(
    v_schema IN VARCHAR2,
    v_object IN VARCHAR2
)
RETURN VARCHAR2
IS 
predicate VARCHAR2(2048);
curr VARCHAR2(2048);
BEGIN
    predicate:= 'HOTEN = ''' ||sys_context('USERENV','SESSION_USER') || '''';
    RETURN predicate;
END FUNC_VPD_DOCTOR_SEE_THEIR_INFO_ONLY;
/

-- Add policy VPD
BEGIN
    dbms_rls.add_policy(
    object_schema    => 'DUCCAO_ADMIN', 
    object_name      => 'VW_DOCTOR_SEE_THEIR_INFO',
    policy_name      => 'POLICY_VPD_DOCTOR_SEE_THEIR_INFO_ONLY',
    policy_function  => 'FUNC_VPD_DOCTOR_SEE_THEIR_INFO_ONLY',
    statement_types => 'SELECT',
    update_check => TRUE);    
END;
/


GRANT SELECT ON DUCCAO_ADMIN.VW_DOCTOR_SEE_THEIR_INFO TO ROLE_DOCTOR;

--**********************************************************************
--***********************    MODULE 2    *******************************
--**********************************************************************



---------------------------------------------------------------------------------
--  ketoan feature:  View info_salary using for ketoan calculate & reset salary
---- -----------------------------------------------------------------------------

CREATE OR REPLACE VIEW VIEW_CAL_SALARY AS
SELECT CC.MANV, NV.HOTEN,CC.THANG, CC.SONGAYCONG, CC.PHUCAP, CC.LUONG,  NV.LUONG AS LUONG_COBAN
FROM DUCCAO_ADMIN.CHAMCONG CC 
INNER JOIN DUCCAO_ADMIN.NHANVIEN NV
ON NV.MANV  =CC.MANV;


GRANT SELECT, UPDATE, INSERT ON DUCCAO_ADMIN.VIEW_CAL_SALARY TO ROLE_DEP_KETOAN;
GRANT SELECT, UPDATE, INSERT ON DUCCAO_ADMIN.NHANVIEN TO ROLE_DEP_KETOAN;



-- CALCULATE SALARY
GRANT EXECUTE ON DUCCAO_ADMIN.PROC_CAL_SALARY TO ROLE_DEP_KETOAN;
GRANT EXECUTE ON DUCCAO_ADMIN.PROC_SET_SALARY_TO_0 TO ROLE_DEP_KETOAN;


---------------------------------------------------------------------------------
--  reception feature:  
---- -----------------------------------------------------------------------------
CREATE OR REPLACE VIEW VIEW_RECEPTION AS
SELECT HS.MAKB, HS.NGAYKB, HS.MABN, BN.HOTEN, HS.TINHTRANGBANDAU, NV.HOTEN AS BACSI_PHUTRACH
FROM DUCCAO_ADMIN.HOSOBENHNHAN HS
INNER JOIN DUCCAO_ADMIN.BENHNHAN BN
ON HS.MABN = BN.MABN
INNER JOIN DUCCAO_ADMIN.NHANVIEN  NV
ON HS.MANV= NV.MANV;

GRANT SELECT,UPDATE,DELETE,INSERT ON DUCCAO_ADMIN.VIEW_RECEPTION TO  ROLE_DEP_LETAN;

GRANT EXECUTE ON DUCCAO_ADMIN.PROC_RECEPTION_ADD_NEW_PATIENT TO ROLE_DEP_LETAN;












