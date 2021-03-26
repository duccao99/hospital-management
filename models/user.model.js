const db = require("./../utils/db");
const config = require("../config/config");

module.exports = {
  all() {
    const sql = `select * from ${config.oracle.table.hospitalUser}`;
    return db.load(sql);
  },
};
