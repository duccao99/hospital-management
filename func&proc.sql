
----
-- 2. Procedure Create A User
------
CREATE OR REPLACE PROCEDURE createUser(
    pi_username IN NVARCHAR2,
    pi_password IN NVARCHAR2)
IS    
    user_name  NVARCHAR2(20):= pi_username;
    pwd NVARCHAR2(20):= pi_password;
    li_count INTEGER :=0;
    lv_stmt VARCHAR(1000);
    BEGIN
    SELECT COUNT (1)
    INTO li_count
    FROM all_users
    WHERE username =UPPER(user_name);
    
    
    IF li_count !=0
    THEN 
        lv_stmt:='DROP USER ' ||user_name ||' CASCADE';
        EXECUTE IMMEDIATE (lv_stmt);      
    END IF;
    
    lv_stmt:='ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE ';
    EXECUTE IMMEDIATE (lv_stmt);
    
   -- lv_stmt:='CREATE USER ' || user_name|| ' IDENTIFIED BY ' || pwd|| ' DEFAULT TABLESPACE SYSTEM ';
    lv_stmt:='CREATE USER ' || user_name|| ' IDENTIFIED BY ' || pwd;

  --  DBMS_OUTPUT.put_line(lv_stmt);
    
    EXECUTE IMMEDIATE (lv_stmt);
    
     -- ****** Object: Roles for user ******
     lv_stmt:='GRANT CONNECT TO ' ||user_name;
         EXECUTE IMMEDIATE (lv_stmt);
      
          lv_stmt:='ALTER SESSION SET "_ORACLE_SCRIPT"=FALSE ';
    EXECUTE IMMEDIATE (lv_stmt);
       COMMIT;
    END createUser;
/

----------------
-- 3. Procedure Delete A User
------------------
CREATE OR REPLACE PROCEDURE deleteUser(
    ip_username IN NVARCHAR2)
IS
user_name NVARCHAR2(20):=ip_username;
exec_commander VARCHAR(1000);
    BEGIN
        exec_commander := 'ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE ';
        EXECUTE IMMEDIATE (exec_commander);
        
       exec_commander :='DROP USER ' || user_name|| ' CASCADE ';
           EXECUTE IMMEDIATE (exec_commander);
          exec_commander := 'ALTER SESSION SET "_ORACLE_SCRIPT"=FALSE ';
        EXECUTE IMMEDIATE (exec_commander);
        COMMIT;    
    END deleteUser;
/


----------------
-- 4. Procedure Create a role
------------------

CREATE OR REPLACE PROCEDURE proc_createRole(
    ip_rolename IN NVARCHAR2,
    ip_identify IN NVARCHAR2)
IS
role_name nvarchar2(20):= ip_rolename;
identify nvarchar2(20):= ip_identify;
exec_commander varchar(1000);
    BEGIN
        exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT"= TRUE';
        EXECUTE IMMEDIATE(exec_commander);
        
        exec_commander:='CREATE ROLE '||role_name ||' IDENTIFIED BY '||identify;
        EXECUTE IMMEDIATE(exec_commander);

     exec_commander:='GRANT CREATE SESSION TO '||role_name;
        EXECUTE IMMEDIATE(exec_commander);
        
          exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT"= FALSE';
        EXECUTE IMMEDIATE(exec_commander);
    COMMIT;
    END proc_createRole;
/


----------------
-- 5. Procedure Delete a role
------------------
CREATE OR REPLACE PROCEDURE proc_deleteRole(
ip_rolename IN NVARCHAR2)
IS 
role_name NVARCHAR2(20):=ip_rolename;
exec_commander varchar(1000);
BEGIN
    exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE';
      EXECUTE IMMEDIATE(exec_commander);

    exec_commander:='DROP ROLE '|| role_name;
    EXECUTE IMMEDIATE (exec_commander);
    
      exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT"=FALSE';
      EXECUTE IMMEDIATE(exec_commander);
COMMIT;
END proc_deleteRole;
/

----------------
-- 6. Procedure Alter a user
------------------
CREATE OR REPLACE PROCEDURE proc_alterUser(
    ip_username nvarchar2,
    ip_identify nvarchar2)
IS
user_name nvarchar2(200):=ip_username;
user_identify nvarchar2(200):=ip_identify;
exec_commander varchar(1000);
BEGIN
 exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE';
EXECUTE IMMEDIATE (exec_commander);

exec_commander:='ALTER USER '||user_name||' IDENTIFIED BY '||user_identify;
EXECUTE IMMEDIATE (exec_commander);

 exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT"=false';
 EXECUTE IMMEDIATE (exec_commander);


END proc_alterUser;
/




----------------
-- 7. Procedure Alter a ROLE
------------------
CREATE OR REPLACE PROCEDURE proc_AlterRole(
    ip_rolename nvarchar2,
    ip_identify nvarchar2)
IS
role_name nvarchar2(200):=ip_rolename;
role_identify nvarchar2(200):=ip_identify;
exec_commander varchar(1000);
BEGIN
 exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE';
EXECUTE IMMEDIATE (exec_commander);

exec_commander:='ALTER ROLE '||role_name||' IDENTIFIED BY '||role_identify;
EXECUTE IMMEDIATE (exec_commander);

 exec_commander:='ALTER SESSION SET "_ORACLE_SCRIPT"=false';
 EXECUTE IMMEDIATE (exec_commander);


END proc_AlterRole;
/

