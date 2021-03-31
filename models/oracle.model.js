const db = require("../utils/db");
const config = require("../config/config");
const allUser = require("../config/config.js").oracle.system.all_users;
const roleAffectDataObject = require("./../config/config.js").oracle.system
  .roleAffectDataObject;
const userAndTheirRole = require("./../config/config.js").oracle.system
  .userAndTheirRole;
const allRoles = config.oracle.system.all_roles;

module.exports = {
  getAllChamCongColumns() {
    const sql = `SELECT  column_name FROM USER_TAB_COLUMNS WHERE table_name = 'CHAMCONG'`;
    return db.load(sql);
  },
  getAllBenhNhanColumns() {
    const sql = `SELECT  column_name FROM USER_TAB_COLUMNS WHERE table_name = 'BENHNHAN'`;
    return db.load(sql);
  },
  getAllHSBNColumns() {
    const sql = `SELECT  column_name FROM USER_TAB_COLUMNS WHERE table_name = 'HOSOBENHNHAN'`;
    return db.load(sql);
  },
  getAllHSDVColumns() {
    const sql = `SELECT  column_name FROM USER_TAB_COLUMNS WHERE table_name = 'HOSODICHVU'`;
    return db.load(sql);
  },
  getAllHoaDonColumns() {
    const sql = `SELECT  column_name FROM USER_TAB_COLUMNS WHERE table_name = 'HOADON'`;
    return db.load(sql);
  },
  getAllNhanVienColumns() {
    const sql = `SELECT  column_name FROM USER_TAB_COLUMNS WHERE table_name = 'NHANVIEN'`;
    return db.load(sql);
  },
  getAllDonViColumns() {
    const sql = `SELECT  column_name FROM USER_TAB_COLUMNS WHERE table_name = 'DONVI'`;
    return db.load(sql);
  },

  getAllDichVuColumns() {
    const sql = `SELECT  column_name FROM USER_TAB_COLUMNS WHERE table_name = 'DICHVU'`;
    return db.load(sql);
  },
  getAllCTHOADONColumns() {
    const sql = `SELECT  column_name FROM USER_TAB_COLUMNS WHERE table_name = 'CTHOADON'`;
    return db.load(sql);
  },
  getAllCTDONTHUOCColumns() {
    const sql = `SELECT  column_name FROM USER_TAB_COLUMNS WHERE table_name = 'CTDONTHUOC'`;
    return db.load(sql);
  },
  getAllTHUOCColumns() {
    const sql = `SELECT  column_name FROM USER_TAB_COLUMNS WHERE table_name = 'THUOC'`;
    return db.load(sql);
  },
};
