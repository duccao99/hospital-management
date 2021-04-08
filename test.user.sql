

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

