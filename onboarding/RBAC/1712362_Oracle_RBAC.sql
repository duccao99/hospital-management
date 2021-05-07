/******************************
THÔNG TIN SINH VIÊN
MSSV: 1712362
HỌ TÊN: TRỊNH CAO VĂN ĐỨC
******************************/


/*------------------------------------------------------------------------
1. Tạo các users sau: John, Joe, Fred, Lynn, Amy, Beth. Với mỗi user:
a) Mật khẩu lần lượt là tên username nhưng viết hoa (VD: Joe có mật khẩu là Joe)
b) Đảm bảo các user này có thể tạo bất kỳ bảng nào trong tablespace với quota
10M.
------------------------------------------------------------------------*/


-- 1. a) Tạo user
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER John IDENTIFIED BY JOHN;
CREATE USER Joe IDENTIFIED BY JOE;
CREATE USER Fred IDENTIFIED BY FRED;
CREATE USER Lynn IDENTIFIED BY LYNN;
CREATE USER Amy IDENTIFIED BY AMY;
CREATE USER Beth IDENTIFIED BY BETH;

GRANT CREATE SESSION TO John;
GRANT CREATE SESSION TO Joe;
GRANT CREATE SESSION TO Fred;
GRANT CREATE SESSION TO Lynn;
GRANT CREATE SESSION TO Amy;
GRANT CREATE SESSION TO Beth;





-- 1.b)
CREATE  TABLESPACE  TBS_HW32USERS
DATAFILE 'TBS_HW32USERS.TXT'
SIZE 70M REUSE
AUTOEXTEND ON;

-- Add default tablespace to user
ALTER USER John DEFAULT TABLESPACE TBS_HW32USERS
QUOTA 10M ON TBS_HW32USERS;

ALTER USER Joe DEFAULT TABLESPACE  TBS_HW32USERS
QUOTA 10M ON TBS_HW32USERS;

ALTER USER Fred DEFAULT TABLESPACE  TBS_HW32USERS
QUOTA 10M ON TBS_HW32USERS;

ALTER USER Lynn DEFAULT TABLESPACE  TBS_HW32USERS
QUOTA 10M ON TBS_HW32USERS;

ALTER USER Amy DEFAULT TABLESPACE  TBS_HW32USERS
QUOTA 10M ON TBS_HW32USERS;

ALTER USER Beth DEFAULT TABLESPACE  TBS_HW32USERS
QUOTA 10M ON TBS_HW32USERS;

GRANT CREATE TABLE TO John;
GRANT CREATE TABLE TO Joe;
GRANT CREATE TABLE TO Fred;
GRANT CREATE TABLE TO Lynn;
GRANT CREATE TABLE TO Amy;
GRANT CREATE TABLE TO Beth;


/* 2. Tạo bảng Attendance*/
CREATE TABLE Attendance(
    ID INT PRIMARY KEY,
    NAME NVARCHAR2(200)
);
INSERT INTO Attendance(ID,NAME)VALUES (1,'DUCCAO01');
INSERT INTO Attendance(ID,NAME)VALUES (2,'DUCCAO02');


/* 2.a) Create role DataEntry, Supervisor, Management */
CREATE ROLE DataEntry;
CREATE ROLE Supervisor;
CREATE ROLE Management;

GRANT CREATE SESSION TO DataEntry;
GRANT CREATE SESSION TO Supervisor;
GRANT CREATE SESSION TO Management;



/* 2.b) Create role DataEntry, Supervisor, Management
        Gán (John, Joe, Lynn) vào role DataEntry
        Gán Fred vào role Supervisor
        Gán (Amy và Beth) vào role Management.*/
        
GRANT DataEntry TO John;
GRANT DataEntry TO Joe;
GRANT DataEntry TO Lynn;

GRANT Supervisor TO Fred;

GRANT Management TO Amy;
GRANT Management TO Beth;


/* 2.c) Gán quyền cho các role sau đây trên bảng Attendance: 
        role DataEntry các quyền SELECT, INSERT và UPDATE
        role Supervisor các quyền SELECT và DELETE.
        role Management quyền SELECT.. */


GRANT SELECT,INSERT, UPDATE ON ATTENDANCE TO DataEntry;
GRANT SELECT, DELETE ON ATTENDANCE TO Supervisor;
GRANT SELECT ON ATTENDANCE TO Management;

/* 2.d) Viết lệnh lần lượt kiểm tra kết quả phân quyền đã cho cấp cho các role.*/
-- Kiểm tra role DataEntry quyền SELECT
SELECT * FROM ROLE_SYS_PRIVS WHERE ROLE = 'DATAENTRY';
SELECT * FROM ROLE_SYS_PRIVS WHERE ROLE = 'SUPERVISOR';
SELECT * FROM ROLE_SYS_PRIVS WHERE ROLE = 'MANAGEMENT';


/* 3. Tạo mới một user với tên NameManager với mật khẩu là pc123. Gán quyền
UPDATE cho user này trên cột Name của bản Attendance. */
CREATE OR REPLACE PROCEDURE CREATE_NameManager (ip_NameManager nvarchar2)
AS
EXECUTER VARCHAR(1000);
BEGIN

EXECUTER:= 'ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE';
EXECUTE IMMEDIATE (EXECUTER);

EXECUTER:=  'CREATE USER NameManager IDENTIFIED BY pc123';
EXECUTE IMMEDIATE (EXECUTER);

EXECUTER:=  'GRANT CREATE SESSION TO NameManager';
EXECUTE IMMEDIATE (EXECUTER);

EXECUTER:=  'GRANT UPDATE(NAME) ON SYS.ATTENDANCE TO NameManager';
EXECUTE IMMEDIATE (EXECUTER);

EXECUTER:= 'ALTER SESSION SET "_ORACLE_SCRIPT"=FALSE';
EXECUTE IMMEDIATE (EXECUTER);

END;
/

EXEC CREATE_NameManager('NameManager');

-- Test câu 3.
--SELECT  * FROM ALL_USERS WHERE USERNAME='NAMEMANAGER';
--SELECT * FROM DBA_COL_PRIVS WHERE GRANTEE='NAMEMANAGER';



/* 4. Thực hiện các yêu cầu sau đối với ác view được liệt kê trong phần Từ điển dữ liệu:
a) Tìm quyền mà trong tên của quyền có chữ CONTEXT
b) Liệt kê tất cả các user có quyền SELECT ANY TABLE */
SELECT DBA_SYS_PRIVS.PRIVILEGE AS PRIV FROM DBA_SYS_PRIVS WHERE PRIVILEGE LIKE '%CONTEXT%';
SELECT DBA_SYS_PRIVS.GRANTEE AS USERNAME FROM DBA_SYS_PRIVS WHERE PRIVILEGE ='SELECT ANY TABLE';


/*5. Thực hiện các bước sau:
a) Gán mật khẩu cho role DataEntry ở câu 1 là "mgt"
b) Cho phép user John quyền cấp quyền cho các user khác.
c) Gán tất cả các quyền mà user John có cho user Beth. Beth có quyền INSERT và
UPDATE trên bảng Attendance không? */

-- 5.a)
 ALTER ROLE DataEntry IDENTIFIED BY mgt;
 
-- Test 5.a)
-- SET ROLE DataEntry IDENTIFIED BY mgt;

-- 5.b) Cho phép John cấp quyền cho user khác
GRANT SELECT,INSERT, UPDATE ON SYS.ATTENDANCE TO John WITH GRANT OPTION;

-- Test 5.b)
--CONN John/JOHN;
--GRANT SELECT ON SYS.ATTENDANCE TO LYNN;

-- 5.c) Beth có quyền INSERT, UPDATE trên bảng Attendance 
-- Tất cả quyền John có là: QSELECT,INSERT, UPDATE ON SYS.ATTENDANCE WITH GRANT OPTION 
GRANT SELECT,INSERT, UPDATE ON SYS.ATTENDANCE TO Beth WITH GRANT OPTION;





