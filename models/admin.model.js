const db = require("../utils/db");
const config = require("../config/config");
const allUser = require("../config/config.js").oracle.system.all_users;
const userPriv = require("./../config/config.js").oracle.system.userPriv;
const userAndTheirRole = require("./../config/config.js").oracle.system
  .userAndTheirRole;
const allRoles = config.oracle.system.all_roles;
const userColPrivs = config.oracle.system.User_col_privs;
const rolePriv = require("./../config/config.js").oracle.system.rolePriv;
const usermodel = require("./user.model");
const roleModel = require("./role.model");

module.exports = {
  allUser() {
    const sql = `select * from ${allUser}`;
    return db.load(sql);
  },
  allRoleNames() {
    const sql = `select ROLE from ${allRoles}`;
    return db.load(sql);
  },
  allRoles() {
    const sql = `select * from ${allRoles}`;
    return db.load(sql);
  },
  getUserAndTheirPrivilegesInColumn() {
    const sql = `select * from ${userColPrivs}`;
    return db.load(sql);
  },
  getUserPriv() {
    const sql = `SELECT * FROM  ${userPriv} WHERE TABLE_NAME = 'CHAMCONG' OR  TABLE_NAME = 'BENHNHAN'
    OR  TABLE_NAME = 'HOSOBENHNHAN' OR  TABLE_NAME = 'HOSODICHVU' OR  TABLE_NAME = 'HOADON'
    OR  TABLE_NAME = 'NHANVIEN' OR  TABLE_NAME = 'DONVI' OR  TABLE_NAME = 'DONTHUOC'
    OR  TABLE_NAME = 'DICHVU' OR  TABLE_NAME = 'CTHOADON' OR  TABLE_NAME = 'CTDONTHUOC'
    OR  TABLE_NAME = 'THUOC'
     `;
    return db.load(sql);
  },
  getUserAndTheirRole() {
    const sql = `SELECT * FROM  ${userAndTheirRole}`;
    console.log(sql);

    return db.load(sql);
  },

  async grantUserPrivilege(
    username,
    privilege,
    tableName,
    withGrantOption,
    columnValue
  ) {
    let sql = ``;

    if (privilege === "select") {
      if (withGrantOption === "false") {
        if (columnValue === "" || columnValue === undefined) {
          sql = `GRANT ${privilege} ON ${tableName} TO ${username}`;
        } else {
          // 1. INSERT TO VIEW FIRST
          const check = await usermodel.insertUserSelectColumnPriv(
            username,
            columnValue,
            tableName,
            withGrantOption
          );

          sql = `
          BEGIN
          proc_CreateViewUserSelectColumnLevel('${username}','${columnValue}','${tableName}','${withGrantOption}');
          END;
          `;
        }
      } else {
        if (columnValue === "" || columnValue === undefined) {
          sql = `GRANT ${privilege} ON ${tableName} TO ${username}  WITH GRANT OPTION`;
        } else {
          const check = await usermodel.insertUserSelectColumnPriv(
            username,
            columnValue,
            tableName,
            withGrantOption
          );

          sql = `
          BEGIN
          proc_CreateViewUserSelectColumnLevel('${username}','${columnValue}','${tableName}','${withGrantOption}');
          END;
          `;
        }
      }
    } else {
      if (withGrantOption === "false") {
        if (columnValue === "" || columnValue === undefined) {
          sql = `GRANT ${privilege} ON ${tableName} TO ${username}`;
        } else {
          sql = `GRANT ${privilege}(${columnValue}) ON ${tableName} TO ${username}`;
        }
      } else {
        if (columnValue === "" || columnValue === undefined) {
          sql = `GRANT ${privilege} ON ${tableName} TO ${username}  WITH GRANT OPTION`;
        } else {
          sql = `GRANT ${privilege}(${columnValue}) ON ${tableName} TO ${username}  WITH GRANT OPTION`;
        }
      }
    }

    console.log(sql);

    return db.load(sql);
  },
  async grantRolePrivilege(
    rolename,
    privilege,
    tableName,
    withGrantOption,
    columnValue
  ) {
    let sql = ``;
    if (privilege === "select") {
      if (withGrantOption === "false") {
        if (columnValue === "" || columnValue === undefined) {
          sql = `GRANT ${privilege} ON ${tableName} TO ${rolename}`;
        } else {
          // 1. INSERT TO VIEW FIRST
          const check = await roleModel.insertRoleSelectColumnPriv(
            rolename,
            columnValue,
            tableName,
            withGrantOption
          );

          sql = `
              BEGIN
              proc_CreateViewRoleSelectColumnLevel('${rolename}','${columnValue}','${tableName}','${withGrantOption}');
              END;
              `;
          console.log("alo");
        }
      } else {
        // cannot grant to a role with grant option
        if (columnValue === "" || columnValue === undefined) {
          sql = `GRANT ${privilege} ON ${tableName} TO ${rolename} `;
        } else {
          sql = `GRANT ${privilege}(${columnValue}) ON ${tableName} TO ${rolename} `;
        }
      }
    } else {
      if (withGrantOption === "false") {
        if (columnValue === "" || columnValue === undefined) {
          sql = `GRANT ${privilege} ON ${tableName} TO ${rolename}`;
        } else {
          sql = `GRANT ${privilege}(${columnValue}) ON ${tableName} TO ${rolename}`;
        }
      } else {
        // cannot grant to a role with grant option
        if (columnValue === "" || columnValue === undefined) {
          sql = `GRANT ${privilege} ON ${tableName} TO ${rolename} `;
        } else {
          sql = `GRANT ${privilege}(${columnValue}) ON ${tableName} TO ${rolename} `;
        }
      }
    }
    console.log(sql);

    return db.load(sql);
  },
  grantRoleToUser(rolename, username) {
    const sql = `GRANT ${rolename} to ${username}`;
    console.log(sql);

    return db.load(sql);
  },
  getAllUserName() {
    const sql = `SELECT USERNAME FROM ${allUser}`;
    console.log(sql);

    return db.load(sql);
  },

  getAllRoleName() {
    const sql = `SELECT ROLE FROM ${allRoles}`;
    console.log(sql);

    return db.load(sql);
  },
  revokeUserPriv(priv, tableName, grantee) {
    const sql = `REVOKE ${priv} ON ${tableName} FROM ${grantee}`;

    console.log(sql);
    return db.load(sql);
  },
  reGrantUserPriv(priv, tblName, grantee, grantAble) {
    let sql = "";
    console.log(grantAble);
    if (grantAble === "false") {
      sql = `GRANT ${priv} ON ${tblName} TO ${grantee}`;
    } else {
      sql = `GRANT ${priv} ON ${tblName} TO ${grantee} WITH GRANT OPTION`;
    }

    console.log(sql);

    return db.load(sql);
  },

  getRolePrivs() {
    const sql = `SELECT * FROM ${rolePriv}  WHERE TABLE_NAME = 'CHAMCONG' OR  TABLE_NAME = 'BENHNHAN'
    OR  TABLE_NAME = 'HOSOBENHNHAN' OR  TABLE_NAME = 'HOSODICHVU' OR  TABLE_NAME = 'HOADON'
    OR  TABLE_NAME = 'NHANVIEN' OR  TABLE_NAME = 'DONVI' OR  TABLE_NAME = 'DONTHUOC'
    OR  TABLE_NAME = 'DICHVU' OR  TABLE_NAME = 'CTHOADON' OR  TABLE_NAME = 'CTDONTHUOC'
    OR  TABLE_NAME = 'THUOC'`;

    return db.load(sql);
  },
  reVokeRolePriv(priv, tblName, roleName) {
    const sql = `REVOKE ${priv} ON ${tblName} FROM ${roleName}`;
    console.log(sql);
    return db.load(sql);
  },
  reGrantRolePriv(priv, tblName, roleName) {
    const sql = `GRANT ${priv} ON ${tblName} TO ${roleName}`;
    console.log(sql);
    return db.load(sql);
  },

  getListUsers(username, pass) {
    const sql = `select hoten, matkhau,vaitro from duccao_admin.nhanvien`;
    return db.load(sql);
  },

  getViewUserSelectColumnLevel() {
    const sql = `SELECT * FROM VIEW_COLUMN_SELECT_USER`;
    return db.load(sql);
  },
  getViewRoleSelectColumnLevel() {
    const sql = `SELECT * FROM VIEW_COLUMN_SELECT_ROLE`;
    return db.load(sql);
  },
};
