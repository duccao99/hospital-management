const db = require("../utils/db");
const config = require("./../config/config");
const oracledb = require("oracledb");

const userModel = {
  updateUser(username, newPassword) {
    const sql = `ALTER USER ${username} IDENTIFIED BY ${newPassword}`;

    return db.load(sql);
  },

  revokeUserPermission(
    username,
    privilege,
    tableName,
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
};

module.exports = userModel;
