DECLARE 
    CHAMCONG_c number;BENHNHAN_c number;HOSOBENHNHAN_c number;HOSODICHVU_c number;HOADON_c number;NHANVIEN_c number;DONVI_c number;DONTHUOC_c number;DICHVU_c number;CTHOADON_c number;CTDONTHUOC_c number;THUOC_c number;
begin
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
    maNV int,
    thang date,
    soNgayCong int,
    PRIMARY KEY(maNV,thang)
);

CREATE TABLE BENHNHAN (
    maBN int,
    hoTen nchar(200),
    ngaySinh date,
    diaChi nchar(200),
    sdt nchar(200),
    PRIMARY KEY(maBN)
);

CREATE TABLE HOSOBENHNHAN (
    maKB int,
    ngayKB date,
    maNV int,
    maBN int,
    tinhTrangBanDau nchar(200),
    ketLuanCuaBacSi nchar(200),
    PRIMARY KEY(maKB)
);

CREATE TABLE HOSODICHVU (
    maKB int,
    maDV int,
    nguoiThucHien nchar(200),
    ngayGio date,
    ketLuan nchar(200),
    PRIMARY KEY(maKB,maDV)
);

CREATE TABLE HOADON (
    soHD int,
    maKB int,
    ngayGio date,
    nguoiPhuTrach nchar(200),
    tongTien nchar(200),
    PRIMARY KEY(soHD)
);

CREATE TABLE NHANVIEN (
    maNV int,
    hoTen nchar(200),
    luong nchar(200),
    ngaySinh date,
    diaChi nchar(200),
    vaiTro nchar(200),
    maDonVi int,
    PRIMARY KEY(maNV)
);

CREATE TABLE DONVI (
     maDonVi int,
     tenDonVi nchar(200),
    PRIMARY KEY(maDonVi)
);

CREATE TABLE DONTHUOC (
     maKB int,
     nhanVienPhuTrach nchar(200),
    PRIMARY KEY(maKB)
);

CREATE TABLE DICHVU (
     maDV int,
     tenDV nchar(200),
     donGia nchar(200),
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
    soLuong nchar(200),
    lieuDung nchar(200),
    moTa nchar(200),
    PRIMARY KEY(maKB,maThuoc)
);

CREATE TABLE THUOC (
    maThuoc int,
    tenThuoc nchar(200),
    donViThuoc nchar(200),
    donGia nchar(200),
    luuY nchar(200),
    PRIMARY KEY(maThuoc)
);


--
-- FOREIGN KEY
--

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
--trung
--ALTER TABLE HOSOBENHNHAN
--ADD CONSTRAINT FK_HOSOBENHNHAN_NHANVIEN
--FOREIGN KEY (maNV)
--REFERENCES NHANVIEN(maNV);

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

--
-- Records
--

--insert benh nhan
insert into BENHNHAN (maBN, hoTen, ngaySinh, diaChi, sdt) 
values (1, 'Nguy?n B?nh An', TO_DATE('12/01/1984', 'DD/MM/YYYY'),'4186 Ph? Qu?, X? ??n, Qu?n Kh?ng Thanh Thoa,H?i Ph?ng','0755586591');
insert into BENHNHAN (maBN, hoTen, ngaySinh, diaChi, sdt)
values (2, 'Trang Quang T?i', TO_DATE('12/01/1975', 'DD/MM/YYYY'),'093 Ph? ?ng Khuy?n Gi?c, Th?n B?nh ?an, Huy?n Tr?ng Sang Ph?ng,C?n Th?','0755586592');
insert into BENHNHAN (maBN, hoTen, ngaySinh, diaChi, sdt) 
values (3, 'Nguy?n An Ninh', TO_DATE('12/01/1988', 'DD/MM/YYYY'),'115 Ph? B?i Sang H?o, ?p Tu? Dung, Qu?n L?m C??ng,S?n La','0755586593');
insert into BENHNHAN (maBN, hoTen, ngaySinh, diaChi, sdt) 
values (4, 'Nguy?n Th?nh Trung', TO_DATE('12/01/1983', 'DD/MM/YYYY'),'116 Ph? D? K? Khi?u, X? Ch? Kim T?m, Huy?n Hu?nh,T?y Ninh','0755586594');
insert into BENHNHAN (maBN, hoTen, ngaySinh, diaChi, sdt) 
values (5, 'Tr?n Minh Ki?t', TO_DATE('12/01/1972', 'DD/MM/YYYY'),'3376 Ph? Ti?p Tr?m Ng?n, Ph??ng ?i?p Ph??ng, Qu?n Hu? H?u,C?n Th?','0755586595');
insert into BENHNHAN (maBN, hoTen, ngaySinh, diaChi, sdt) 
values (6, '?? Ch?nh H?u', TO_DATE('12/01/1973', 'DD/MM/YYYY'),'48 Ph? M?, Ph??ng Tr?c, Huy?n Ho?n Mai,?? N?ng','0755586596');
insert into BENHNHAN (maBN, hoTen, ngaySinh, diaChi, sdt) 
values (7, 'Tr?m C?ng L?', TO_DATE('12/01/1974', 'DD/MM/YYYY'),'2923, ?p Qu?nh, Ph??ng ??u Ki?n L?, Huy?n Kh?i,Ninh Thu?n','0755586597');
insert into BENHNHAN (maBN, hoTen, ngaySinh, diaChi, sdt)
values (8, 'Tr?n Tu?n Ch?u', TO_DATE('12/01/1981', 'DD/MM/YYYY'),'8387 Ph? T?n C?ng Ki?n, Ph??ng Ph??c, Huy?n Xa Ho?n,B?n Tre','0755586598');
insert into BENHNHAN (maBN, hoTen, ngaySinh, diaChi, sdt) 
values (9, 'V? Trung Nh?n', TO_DATE('12/01/1969', 'DD/MM/YYYY'),'6545 Ph? Xu?n, Ph??ng Th?o B?, Qu?n Nghi?p C?t,B? R?a - V?ng T?u','0755586599');
insert into BENHNHAN (maBN, hoTen, ngaySinh, diaChi, sdt) 
values (10, 'Nguy?n Tr?ng Vinh', TO_DATE('12/01/1960', 'DD/MM/YYYY'),'8, Th?n Th?nh, X? Chinh, Qu?n Trang,B?nh ??nh','0755586511');

--insert Don vi
insert into DONVI (maDonVi, tenDonVi) 
values (1,'B? ph?n qu?n l?');
insert into DONVI (maDonVi, tenDonVi) 
values (2,'B? ph?n ti?p t?n v? ?i?u ph?i b?nh');
insert into DONVI (maDonVi, tenDonVi) 
values (3,'B?c s?');
insert into DONVI (maDonVi, tenDonVi) 
values (4,'Ph?ng t?i v?');
insert into DONVI (maDonVi, tenDonVi) 
values (5,'Ph?ng b?n thu?c');
insert into DONVI (maDonVi, tenDonVi) 
values (6,'B? ph?n k? to?n');

--insert NHANVIEN
insert into NHANVIEN (maNV, hoTen, luong, ngaySinh, diaChi, vaiTro, maDonVi) 
values (1,'??ng Ng?c Ph?ng',6912000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'3102 Ph? Y?n, X? H?a, Huy?n 38, B?nh Thu?n','vaitro',1);
insert into NHANVIEN (maNV, hoTen, luong, ngaySinh, diaChi, vaiTro, maDonVi) 
values (2,'T?ng H??ng Ly',6912000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'905 Ph? Anh, X? Tri?t ??m, Huy?n Khu?t Xu?n, H? Ch? Minh','vaitro',1);
insert into NHANVIEN (maNV, hoTen, luong, ngaySinh, diaChi, vaiTro, maDonVi) 
values (3,'D??ng V?n Kh?nh',6912000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'0018, ?p B?nh Dinh, Ph??ng ??nh Mang, Qu?n Tr?, Long An','vaitro',2);
insert into NHANVIEN (maNV, hoTen, luong, ngaySinh, diaChi, vaiTro, maDonVi) 
values (4,'Ch? H?o Nhi',6912000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'316 Ph? Xa Khang Nhi?n, X? 27, Qu?n ???ng ??i, T?y Ninh','vaitro',3);
insert into NHANVIEN (maNV, hoTen, luong, ngaySinh, diaChi, vaiTro, maDonVi) 
values (5,'Ng? H?nh Dung',6912000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'5, Th?n 3, Th?n Ki?u T?, Qu?n B?ch, V?nh Ph?c','vaitro',2);
insert into NHANVIEN (maNV, hoTen, luong, ngaySinh, diaChi, vaiTro, maDonVi) 
values (6,'U?t Kh?nh Minh',12800000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'683, ?p Dao C?, X? 1, Qu?n Ninh ,Kh?nh H?a','vaitro',3);
insert into NHANVIEN (maNV, hoTen, luong, ngaySinh, diaChi, vaiTro, maDonVi) 
values (7,'V?n ??c Duy',6912000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'01, Th?n H?n, Ph??ng Kh??ng, Huy?n T?ng ,Kon Tum','vaitro',4);
insert into NHANVIEN (maNV, hoTen, luong, ngaySinh, diaChi, vaiTro, maDonVi) 
values (8,'Ho?ng L?m Vi?n',6912000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'8, ?p Khanh Ng?n, Ph??ng Nhi?n, Huy?n 95 ,Ninh Thu?n','vaitro',5);
insert into NHANVIEN (maNV, hoTen, luong, ngaySinh, diaChi, vaiTro, maDonVi) 
values (9,'Chung Uy V?',6912000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'148 Ph? Khu?t Khoa M?n, X? Th?c, Huy?n Trinh Danh ,C? Mau','vaitro',6);
insert into NHANVIEN (maNV, hoTen, luong, ngaySinh, diaChi, vaiTro, maDonVi)
values (10,'Tr??ng Quang Th?ng',6912000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'45 Ph? Tr?, X? T??ng ??i, Qu?n Oanh H?c, C?n Th?','vaitro',6);

insert into NHANVIEN (maNV, hoTen, luong, ngaySinh, diaChi, vaiTro, maDonVi)
values (11,'USER_TEMP_01',6912000,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'HO CHI MINH','NHANVIEN',6);
insert into NHANVIEN (maNV, hoTen, luong, ngaySinh, diaChi, vaiTro, maDonVi)
values (12,'USER_TEMP_02',69120020,TO_DATE('12/01/1960', 'DD/MM/YYYY'),'HO CHI MINH','NHANVIEN',6);


--insert cham cong
insert into CHAMCONG (maNV, thang, soNgayCong)
values (1,TO_DATE('12/01/1960', 'DD/MM/YYYY'),5);
insert into CHAMCONG (maNV, thang, soNgayCong)
values (2,TO_DATE('12/01/1960', 'DD/MM/YYYY'),5);
insert into CHAMCONG (maNV, thang, soNgayCong)
values (3,TO_DATE('12/01/1960', 'DD/MM/YYYY'),5);
insert into CHAMCONG (maNV, thang, soNgayCong)
values (4,TO_DATE('12/01/1960', 'DD/MM/YYYY'),5);
insert into CHAMCONG (maNV, thang, soNgayCong)
values (5,TO_DATE('12/01/1960', 'DD/MM/YYYY'),5);
insert into CHAMCONG (maNV, thang, soNgayCong)
values (6,TO_DATE('12/01/1960', 'DD/MM/YYYY'),5);
insert into CHAMCONG (maNV, thang, soNgayCong)
values (7,TO_DATE('12/01/1960', 'DD/MM/YYYY'),5);
insert into CHAMCONG (maNV, thang, soNgayCong)
values (8,TO_DATE('12/01/1960', 'DD/MM/YYYY'),5);
insert into CHAMCONG (maNV, thang, soNgayCong)
values (9,TO_DATE('12/01/1960', 'DD/MM/YYYY'),5);
insert into CHAMCONG (maNV, thang, soNgayCong)
values (10,TO_DATE('12/01/1960', 'DD/MM/YYYY'),5);

--insert cham cong
insert into THUOC (maThuoc,tenThuoc, donViThuoc, donGia, luuY)
values (1,'TITANIUM DIOXIDE','Vi?n','16.200','Kh?ng t? ? ng?ng ho?c t?ng li?u');
insert into THUOC (maThuoc,tenThuoc, donViThuoc, donGia, luuY)
values (2,'Clotrimazole 1%','Vi?n','5.200','Kh?ng t? ? ng?ng ho?c t?ng li?u');
insert into THUOC (maThuoc,tenThuoc, donViThuoc, donGia, luuY)
values (3,'Levofloxacin','Vi?n','5.260','Kh?ng t? ? ng?ng ho?c t?ng li?u');
insert into THUOC (maThuoc,tenThuoc, donViThuoc, donGia, luuY)
values (4,'Povidone Iodine','Vi?n','134.400','Kh?ng t? ? ng?ng ho?c t?ng li?u');
insert into THUOC (maThuoc,tenThuoc, donViThuoc, donGia, luuY)
values (5,'DEXTROSE','Chai','16.200','Kh?ng t? ? ng?ng ho?c t?ng li?u');
insert into THUOC (maThuoc,tenThuoc, donViThuoc, donGia, luuY)
values (6,'ENALAPRIL MALEATE','Vi?n','8.000','Kh?ng t? ? ng?ng ho?c t?ng li?u');
insert into THUOC (maThuoc,tenThuoc, donViThuoc, donGia, luuY)
values (7,'Hydroxychloroquine Sulfate','Chai','6.700','Kh?ng t? ? ng?ng ho?c t?ng li?u');
insert into THUOC (maThuoc,tenThuoc, donViThuoc, donGia, luuY)
values (8,'Imipramine Hydrochloride','Chai','26.500','Kh?ng t? ? ng?ng ho?c t?ng li?u');
insert into THUOC (maThuoc,tenThuoc, donViThuoc, donGia, luuY)
values (9,'Benzalkonium Chloride, Lidocaine Hydrochloride','Vi?n','39.000','Kh?ng t? ? ng?ng ho?c t?ng li?u');
insert into THUOC (maThuoc,tenThuoc, donViThuoc, donGia, luuY)
values (10,'Hydroxyzine Pamoate','Vi?n','3.000','Kh?ng t? ? ng?ng ho?c t?ng li?u');

--insert Ho so benh nhan
insert into HOSOBENHNHAN (maKB,ngayKB, maNV, maBN, tinhTrangBanDau, ketLuanCuaBacSi)
values (1,TO_DATE('12/01/2020', 'DD/MM/YYYY'),4,1,'Ho n?ng','Ung th? ph?i');
insert into HOSOBENHNHAN (maKB,ngayKB, maNV, maBN, tinhTrangBanDau, ketLuanCuaBacSi)
values (2,TO_DATE('12/01/2020', 'DD/MM/YYYY'),4,3,'?au b?ng','ketLuanCuaBacSi');
insert into HOSOBENHNHAN (maKB,ngayKB, maNV, maBN, tinhTrangBanDau, ketLuanCuaBacSi)
values (3,TO_DATE('12/01/2020', 'DD/MM/YYYY'),4,4,'?au n?a ??u','ketLuanCuaBacSi');
insert into HOSOBENHNHAN (maKB,ngayKB, maNV, maBN, tinhTrangBanDau, ketLuanCuaBacSi)
values (4,TO_DATE('12/01/2020', 'DD/MM/YYYY'),6,5,'?au b?ng b?n ph?i','ketLuanCuaBacSi');
insert into HOSOBENHNHAN (maKB,ngayKB, maNV, maBN, tinhTrangBanDau, ketLuanCuaBacSi)
values (5,TO_DATE('12/01/2020', 'DD/MM/YYYY'),6,6,'?au c? ch?n','ketLuanCuaBacSi');
insert into HOSOBENHNHAN (maKB,ngayKB, maNV, maBN, tinhTrangBanDau, ketLuanCuaBacSi)
values (6,TO_DATE('12/01/2020', 'DD/MM/YYYY'),6,7,'S?t cao','ketLuanCuaBacSi');
insert into HOSOBENHNHAN (maKB,ngayKB, maNV, maBN, tinhTrangBanDau, ketLuanCuaBacSi)
values (7,TO_DATE('12/01/2020', 'DD/MM/YYYY'),4,8,'S?t cao v? ho','ketLuanCuaBacSi');
insert into HOSOBENHNHAN (maKB,ngayKB, maNV, maBN, tinhTrangBanDau, ketLuanCuaBacSi)
values (8,TO_DATE('12/01/2020', 'DD/MM/YYYY'),6,9,'S?t cao','ketLuanCuaBacSi');
insert into HOSOBENHNHAN (maKB,ngayKB, maNV, maBN, tinhTrangBanDau, ketLuanCuaBacSi)
values (9,TO_DATE('12/01/2020', 'DD/MM/YYYY'),4,10,'B? c?m','ketLuanCuaBacSi');
insert into HOSOBENHNHAN (maKB,ngayKB, maNV, maBN, tinhTrangBanDau, ketLuanCuaBacSi)
values (10,TO_DATE('12/01/2020', 'DD/MM/YYYY'),6,2,'S?t cao','ketLuanCuaBacSi');


--insert don thuoc
insert into DONTHUOC (maKB,nhanVienPhuTrach)
values (1,'Nguy?n V?n Ni');
insert into DONTHUOC (maKB,nhanVienPhuTrach)
values (2,'Nguy?n ??c Tr?nh');
insert into DONTHUOC (maKB,nhanVienPhuTrach)
values (3,'Nguy?n V?n L?m');
insert into DONTHUOC (maKB,nhanVienPhuTrach)
values (4,'Nguy?n V?n Ni');
insert into DONTHUOC (maKB,nhanVienPhuTrach)
values (5,'Nguy?n V?n Ni');
insert into DONTHUOC (maKB,nhanVienPhuTrach)
values (6,'Nguy?n V?n Ni');
insert into DONTHUOC (maKB,nhanVienPhuTrach)
values (7,'Nguy?n V?n Ni');
insert into DONTHUOC (maKB,nhanVienPhuTrach)
values (8,'Nguy?n V?n Ni');
insert into DONTHUOC (maKB,nhanVienPhuTrach)
values (9,'Nguy?n V?n Ni');
insert into DONTHUOC (maKB,nhanVienPhuTrach)
values (10,'Nguy?n V?n Ni');


--insert don thuoc
insert into CTDONTHUOC (maKB,maThuoc, soLuong, lieuDung, moTa)
values (1,1,'4', 'lieudung', 'mota');
insert into CTDONTHUOC (maKB,maThuoc, soLuong, lieuDung, moTa)
values (1,2,'12', 'lieudung', 'mota');
insert into CTDONTHUOC (maKB,maThuoc, soLuong, lieuDung, moTa)
values (2,3,'5', 'lieudung', 'mota');
insert into CTDONTHUOC (maKB,maThuoc, soLuong, lieuDung, moTa)
values (3,4,'6', 'lieudung', 'mota');
insert into CTDONTHUOC (maKB,maThuoc, soLuong, lieuDung, moTa)
values (3,5,'6', 'lieudung', 'mota');
insert into CTDONTHUOC (maKB,maThuoc, soLuong, lieuDung, moTa)
values (4,6,'4', 'lieudung', 'mota');
insert into CTDONTHUOC (maKB,maThuoc, soLuong, lieuDung, moTa)
values (2,7,'3', 'lieudung', 'mota');
insert into CTDONTHUOC (maKB,maThuoc, soLuong, lieuDung, moTa)
values (5,8,'7', 'lieudung', 'mota');
insert into CTDONTHUOC (maKB,maThuoc, soLuong, lieuDung, moTa)
values (6,9,'8', 'lieudung', 'mota');
insert into CTDONTHUOC (maKB,maThuoc, soLuong, lieuDung, moTa)
values (8,10,'9', 'lieudung', 'mota');

--insert dich vu
insert into DICHVU (maDV, tenDV, donGia)
values (1,'Si?u ?m 2D','150.000');
insert into DICHVU (maDV, tenDV, donGia)
values (2,'Si?u ?m 3D','250.000');
insert into DICHVU (maDV, tenDV, donGia)
values (3,'Kh?m, n?i soi Tai, M?i, H?ng','230.000');
insert into DICHVU (maDV, tenDV, donGia)
values (4,'Kh?m s? sinh','150.000');
insert into DICHVU (maDV, tenDV, donGia)
values (5,'Chi?u b?ng m?y plasmamend h? tr? ?i?u tr? v?t th??ng','240.000');
insert into DICHVU (maDV, tenDV, donGia)
values (6,'S?ng l?c th?nh l? s? sinh','200.000');
insert into DICHVU (maDV, tenDV, donGia)
values (7,'T?m kh?','300.000');
insert into DICHVU (maDV, tenDV, donGia)
values (8,'D?ch v? massage s? sinh','150.000');
insert into DICHVU (maDV, tenDV, donGia)
values (9,'Gi?m ?au th? thu?t','1.000.000');
insert into DICHVU (maDV, tenDV, donGia)
values (10,'Theo d?i chuy?n d? v? ?? ??','1.000.000');

--insert dich vu
insert into HOSODICHVU (maKB, maDV, nguoiThucHien, ngayGio,ketLuan)
values (1,2,'nguoi thuc hien', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 'ketLuan');
insert into HOSODICHVU (maKB, maDV, nguoiThucHien, ngayGio,ketLuan)
values (2,1,'nguoi thuc hien', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 'ketLuan');
insert into HOSODICHVU (maKB, maDV, nguoiThucHien, ngayGio,ketLuan)
values (3,3,'nguoi thuc hien', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 'ketLuan');
insert into HOSODICHVU (maKB, maDV, nguoiThucHien, ngayGio,ketLuan)
values (4,3,'nguoi thuc hien', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 'ketLuan');
insert into HOSODICHVU (maKB, maDV, nguoiThucHien, ngayGio,ketLuan)
values (5,4,'nguoi thuc hien', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 'ketLuan');
insert into HOSODICHVU (maKB, maDV, nguoiThucHien, ngayGio,ketLuan)
values (6,1,'nguoi thuc hien', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 'ketLuan');
insert into HOSODICHVU (maKB, maDV, nguoiThucHien, ngayGio,ketLuan)
values (7,2,'nguoi thuc hien', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 'ketLuan');
insert into HOSODICHVU (maKB, maDV, nguoiThucHien, ngayGio,ketLuan)
values (8,3,'nguoi thuc hien', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 'ketLuan');
insert into HOSODICHVU (maKB, maDV, nguoiThucHien, ngayGio,ketLuan)
values (9,2,'nguoi thuc hien', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 'ketLuan');
insert into HOSODICHVU (maKB, maDV, nguoiThucHien, ngayGio,ketLuan)
values (10,7,'nguoi thuc hien', TO_DATE('12/01/2020', 'DD/MM/YYYY'), 'ketLuan');


--insert Hoa Don
insert into HOADON (soHD, maKB, ngayGio, nguoiPhuTrach,tongTien)
values (1, 1, TO_DATE('12/01/2020', 'DD/MM/YYYY'),'nguoiphutrach',0);
insert into HOADON (soHD, maKB, ngayGio, nguoiPhuTrach,tongTien)
values (2, 2, TO_DATE('12/01/2020', 'DD/MM/YYYY'),'nguoiphutrach',0);
insert into HOADON (soHD, maKB, ngayGio, nguoiPhuTrach,tongTien)
values (3, 3, TO_DATE('12/01/2020', 'DD/MM/YYYY'),'nguoiphutrach',0);
insert into HOADON (soHD, maKB, ngayGio, nguoiPhuTrach,tongTien)
values (4, 4, TO_DATE('12/01/2020', 'DD/MM/YYYY'),'nguoiphutrach',0);
insert into HOADON (soHD, maKB, ngayGio, nguoiPhuTrach,tongTien)
values (5, 5, TO_DATE('12/01/2020', 'DD/MM/YYYY'),'nguoiphutrach',0);
insert into HOADON (soHD, maKB, ngayGio, nguoiPhuTrach,tongTien)
values (6, 5, TO_DATE('12/01/2020', 'DD/MM/YYYY'),'nguoiphutrach',0);
insert into HOADON (soHD, maKB, ngayGio, nguoiPhuTrach,tongTien)
values (7, 6, TO_DATE('12/01/2020', 'DD/MM/YYYY'),'nguoiphutrach',0);
insert into HOADON (soHD, maKB, ngayGio, nguoiPhuTrach,tongTien)
values (8, 7, TO_DATE('12/01/2020', 'DD/MM/YYYY'),'nguoiphutrach',0);
insert into HOADON (soHD, maKB, ngayGio, nguoiPhuTrach,tongTien)
values (9, 7, TO_DATE('12/01/2020', 'DD/MM/YYYY'),'nguoiphutrach',0);
insert into HOADON (soHD, maKB, ngayGio, nguoiPhuTrach,tongTien)
values (10, 2, TO_DATE('12/01/2020', 'DD/MM/YYYY'),'nguoiphutrach',0);


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
insert into CTHOADON (soHD, maDV)
values (6, 9);
insert into CTHOADON (soHD, maDV)
values (1, 5);
insert into CTHOADON (soHD, maDV)
values (3, 6);
insert into CTHOADON (soHD, maDV)
values (10, 1);
insert into CTHOADON (soHD, maDV)
values (10, 3);








