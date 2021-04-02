const db = require("../utils/db");
const config = require("../config/config");
const allUser = require("../config/config.js").oracle.system.all_users;
const roleAffectDataObject = require("./../config/config.js").oracle.system
    .roleAffectDataObject;
const userAndTheirRole = require("./../config/config.js").oracle.system
    .userAndTheirRole;
const allRoles = config.oracle.system.all_roles;
const userColPrivs = config.oracle.system.User_col_privs;
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

    grantUserPrivilege(
        username,
        privilege,
        tableName,
        withGrantOption,
        columnValue
    ) {
        let sql = ``;
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
        console.log(sql);

        return db.load(sql);
    },
    grantRolePrivilege(
        rolename,
        privilege,
        tableName,
        withGrantOption,
        columnValue
    ) {
        let sql = ``;
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
        console.log(sql);

        return db.load(sql);
    },
    grantRoleToUser(rolename, username) {
        const sql = `GRANT ${rolename} to ${username}`;
        return db.load(sql);
    },
    getAllUserName() {
        const sql = `SELECT USERNAME FROM ${allUser}`;
        return db.load(sql);
    },

    getAllRoleName() {
        const sql = `SELECT ROLE FROM ${allRoles}`;
        return db.load(sql);
    },
};