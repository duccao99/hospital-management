const db = require("../utils/db");
const config = require("./../config/config");
const oracledb = require("oracledb");

const userModel = {
  updateUser(username, newPassword) {
    const sql = `ALTER USER ${username} IDENTIFIED BY ${newPassword}`;

    return db.load(sql);
  },
  deleteUser(username) {
    console.log(username);
    const sql = `DROP USER ${username} CASCADE`;

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
};

// oracledb.outFormat = oracledb.OUT_FORMAT_OBJECT;

// async function proc_CreateUser(pi_username, pi_password) {
//   let connection;

//   try {
//     connection = await oracledb.getConnection({
//       host: "localhost",
//       port: 1521,
//       user: "sys",
//       password: "1",
//       database: "NodeOra",
//       privilege: require("oracledb").SYSDBA,
//     });

//     connection.execute({})

//     const result = await connection.execute(
//       `BEGIN
//            createUser(:pi_username, :pi_password);
//          END;`,
//       {
//         // bind variables
//         pi_username,
//         pi_password,
//       }
//     );
//     console.log(result);
//     return result.rows;
//   } catch (err) {
//     console.error(err);
//   } finally {
//     if (connection) {
//       try {
//         await connection.close();
//       } catch (err) {
//         console.error(err);
//       }
//     }
//   }
// }

// const userModel = {
//   loadBeforeCreateUser() {
//     const sql = `ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE`;
//     return db.load(sql);
//   },

//   async createUser(username, identify) {
//     const status = await proc_CreateUser(username, identify);

//     return -1;
//   },
// };

module.exports = userModel;
