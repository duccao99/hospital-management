const db = require("../utils/db");
const config = require("./../config/config");
const oracledb = require("oracledb");
const randomstring = require("randomstring");

const userModel = {
  updateUser(username, newPassword) {
    const sql = `ALTER USER ${username} IDENTIFIED BY ${newPassword}`;
    console.log(sql);

    return db.load(sql);
  },

  insertUserSelectColumnPriv(username, column, tbl, grantable) {
    let viewName = `VW_USER_SELECT_COLUMN_LEVEL_${username}_${column}_${tbl}`;
    viewName = viewName.toUpperCase();
    const sql = `
      BEGIN
      proc_insertViewUserSelectColumnLevel('${username}','SELECT','${column}','${tbl}','${grantable}','${viewName}');
      END;
    `;
    console.log(sql);
    return db.load(sql);
  },

  updateUserUsingProc(username, newPassword) {
    const sql = `
    BEGIN
    proc_alterUser('${username}','${newPassword}');
    END;
    `;
    console.log(sql);

    return db.load(sql);
  },

  deleteUser(username) {
    const sql = `
    BEGIN
    deleteUser('${username}');
    END;
    `;
    console.log(sql);
    return db.load(sql);
  },
  revokeUserPermission(
    username,
    privilege,
    tableName,
    // withGrantOption,
    columnValue
  ) {
    let sql = ``;

    if (columnValue === "" || columnValue === undefined) {
      sql = `REVOKE ${privilege} ON ${tableName} FROM ${username}`;
    } else {
      sql = `REVOKE ${privilege}(${columnValue}) ON ${tableName} FROM ${username}`;
    }

    console.log(sql);

    return db.load(sql);
  },
  async createUser(username, identify, type) {
    const sql = `BEGIN createUser('${username}','${identify}'); END;`;
    const status = await db.load(sql);

    // encrypt pass
    const encrypt_sql = `select func_encrypt_varchar2('${identify}','SECRETKEY_ORACLE_ERROR')
     as encrypted_pass from dual
    `;
    const encrypted_pass = await db.load(encrypt_sql);
    console.log(encrypted_pass);
    console.log(encrypted_pass[0].ENCRYPTED_PASS.toString("hex"));
    const insert_pass = encrypted_pass[0].ENCRYPTED_PASS.toString("hex");

    // insert into nhanvien
    const manv = randomstring.generate(10);
    const sql2 = `
    BEGIN
    proc_insertCreatedUserIntoDB('${manv}','${username}','${insert_pass}','${type}');
    END;
    `;

    const statuInsertDB = await db.load(sql2);

    console.log(status);
    console.log(statuInsertDB);

    return status;
  },

  decryptUserPassword(password) {
    const sql = `
    BEGIN
    func_decrypt_matkhau_nhanvien(${password});
    END;
    `;
    const ret = db.load(sql);
    return ret;
  },
  getAllVaiTroInSystem() {
    const sql = `SELECT DISTINCT NV.VAITRO  FROM DUCCAO_ADMIN.NHANVIEN NV `;
    return db.load(sql);
  },
  encrypAllUserPassword() {
    const sql = `
    begin
    proc_encrypt_matkhau_nhanvien;
   end;
   /
   
    `;
    return db.load(sql);
  },
};

module.exports = userModel;
