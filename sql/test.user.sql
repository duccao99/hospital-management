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










-------------------------
--- 1. TEST RECEPTION ROLE
----------------------
-- user_tieptan_02
SELECT SYS_CONTEXT('USERENV','SESSION_USER') FROM DUAL;
SET ROLE role_dep_letan IDENTIFIED  BY role_dep_letan;
SELECT * FROM DUCCAO_ADMIN.VW_DEP_LETAN;
SELECT * FROM DUCCAO_ADMIN.DICHVU;
SELECT INSTR(SYS_CONTEXT('USERENV','SESSION_USER'),'BACSI') FROM DUAL;



-------------------------
--- 2. TEST DOCTOR ROLE
----------------------
-- USER_BACSI_01
SELECT * FROM ALL_POLICIES ;
SET ROLE ROLE_DOCTOR IDENTIFIED  BY ROLE_DOCTOR;
SELECT * FROM DUCCAO_ADMIN.HOSOBENHNHAN;
SELECT * FROM DUCCAO_ADMIN.CTDONTHUOC;

select * from duccao_admin.hosobenhnhan where tenBacSi = 'USER_BACSI_01';

SELECT * FROM DUCCAO_ADMIN.HOSOBENHNHAN WHERE MAKB IN 
(SELECT MAKB FROM DUCCAO_ADMIN.HOSOBENHNHAN WHERE tenBacSi = upper('user_bacsi_01'));













