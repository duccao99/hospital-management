const usname = "sys";
const sql = "select * from all_users where username = " + `'${usname}'`;

const injection = `
    test' 
    UNION
    SELECT username,password FROM dba_users
    WHERE 'a' ='a
`;

const fullInjection = `
SELECT * FROM ALL_USERS WHERE USERNAME ='
test' UNION SELECT username,password FROM dba_users WHERE 'a'=a'
`;
