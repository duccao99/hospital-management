const db = require("../utils/db");
const config = require("./../config/config");
const oracledb = require("oracledb");

const roleModel = {
  createRole(rolename, identify) {
    const sql = `
    BEGIN
    proc_createRole('${rolename}','${identify}');
    END;
    `;
    console.log(sql);
    return db.load(sql);
  },
  updateRole(rolename, newPassword) {
    const sql = `ALTER ROLE ${rolename} IDENTIFIED BY ${newPassword}`;
    console.log(sql);
    return db.load(sql);
  },
  updateRoleUsingProc(rolename, newPassword) {
    const sql = `
    BEGIN
    proc_AlterRole('${rolename}','${newPassword}');
    END;
    `;
    console.log(sql);
    return db.load(sql);
  },
  deleteRole(rolename) {
    const sql = `
    BEGIN
    proc_deleteRole('${rolename}');
    END;
    `;
    return db.load(sql);
  },
  revokeRolePermission(
    rolename,
    privilege,
    tableName,
    // withGrantOption,
    columnValue
  ) {
    let sql = ``;

    if (columnValue === "" || columnValue === undefined) {
      sql = `REVOKE ${privilege} ON ${tableName} FROM ${rolename}`;
    } else {
      sql = `REVOKE ${privilege}(${columnValue}) ON ${tableName} FROM ${rolename}`;
    }

    console.log(sql);

    return db.load(sql);
  },
  insertRoleSelectColumnPriv(rolename, column, tbl, grantable) {
    let viewName = `VW_ROLE_SELECT_COLUMN_LEVEL_${rolename}_${column}_${tbl}`;
    viewName = viewName.toUpperCase();
    const sql = `
    BEGIN 
    proc_insertViewRoleSelectColumnLevel('${rolename}','SELECT','${column}','${tbl}','${grantable}','${viewName}');
    END;
    `;
    console.log(sql);
    return db.load(sql);
  },
};

module.exports = roleModel;
