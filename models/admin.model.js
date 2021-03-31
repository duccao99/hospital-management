const db = require("../utils/db");
const config = require("../config/config");
const allUser = require("../config/config.js").oracle.system.all_users;
const roleAffectDataObject = require("./../config/config.js").oracle.system
  .roleAffectDataObject;
const userAndTheirRole = require("./../config/config.js").oracle.system
  .userAndTheirRole;

module.exports = {
  allUser() {
    const sql = `select * from ${allUser}`;
    return db.load(sql);
  },
  getRoleAcffectDataOjbect() {
    const sql = `SELECT * FROM  ${roleAffectDataObject} WHERE TABLE_NAME = 'CHAMCONG' OR  TABLE_NAME = 'BENHNHAN'
    OR  TABLE_NAME = 'HOSOBENHNHAN' OR  TABLE_NAME = 'HOSODICHVU' OR  TABLE_NAME = 'HOADON'
    OR  TABLE_NAME = 'NHANVIEN' OR  TABLE_NAME = 'DONVI' OR  TABLE_NAME = 'DONTHUOC'
    OR  TABLE_NAME = 'DICHVU' OR  TABLE_NAME = 'CTHOADON' OR  TABLE_NAME = 'CTDONTHUOC'
    OR  TABLE_NAME = 'THUOC'
     `;
    return db.load(sql);
  },
  getUserAndTheirRole() {
    const sql = `SELECT * FROM  ${userAndTheirRole}`;
    return db.load(sql);
  },
};
