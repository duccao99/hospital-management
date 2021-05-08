const db = require("./../utils/db");
const oracledb = require("oracledb");
const { oracle } = require("../config/config");

async function base(sql, username, password) {
  let connection;

  try {
    connection = await oracledb.getConnection({
      host: "localhost",
      port: 1521,
      user: username,
      password: password,
      database: "HospitalManagement",
      privilege: require("oracledb").DEFAULT,
    });

    const result = await connection.execute(sql);

    return result.rows;
  } catch (err) {
    console.log("error in oracledb: ", err);
    throw new Error(err);
  } finally {
    if (connection) {
      try {
        await connection.close();
      } catch (err) {
        console.log("connection to oracle error: ", err);
        throw new Error(err);
      }
    }
  }
}

const ketoanModel = {
  async all(accounting_department_info) {
    let connection;

    console.log(accounting_department_info);
    try {
      connection = await oracledb.getConnection({
        host: "localhost",
        port: 1521,
        user: `${accounting_department_info.username}`,
        password: `${accounting_department_info.password}`,
        database: "HospitalManagement",
        privilege: require("oracledb").DEFAULT,
      });

      const sql_set_role = `SET ROLE  ROLE_DEP_KETOAN IDENTIFIED BY ROLE_DEP_KETOAN `;
      console.log(sql_set_role);

      const ret_set_role = await connection.execute(sql_set_role);

      console.log(ret_set_role);

      const sql = `SELECT * FROM DUCCAO_ADMIN.VIEW_CAL_SALARY`;
      console.log(sql);

      const result = await connection.execute(sql);

      return result.rows;
    } catch (err) {
      console.log("error in oracledb: ", err);
      throw new Error(err);
    } finally {
      if (connection) {
        try {
          await connection.close();
        } catch (err) {
          console.log("connection to oracle error: ", err);
          throw new Error(err);
        }
      }
    }
  },

  async updateSalary(manv, thang, luong, accounting_department_info) {
    let connection;

    console.log(accounting_department_info);
    try {
      connection = await oracledb.getConnection({
        host: "localhost",
        port: 1521,
        user: `${accounting_department_info.username}`,
        password: `${accounting_department_info.password}`,
        database: "HospitalManagement",
        privilege: require("oracledb").DEFAULT,
      });
      // set role always!s

      const sql_set_role = `SET ROLE  ROLE_DEP_KETOAN IDENTIFIED BY ROLE_DEP_KETOAN `;
      console.log(sql_set_role);

      const ret_set_role = await connection.execute(sql_set_role);

      console.log(ret_set_role);

      const sql = `
      UPDATE DUCCAO_ADMIN.VIEW_CAL_SALARY SET LUONG ='${luong}'
      WHERE DUCCAO_ADMIN.VIEW_CAL_SALARY.MANV='${manv}' 
      AND THANG = '${thang}'
      
      `;

      console.log(sql);

      const result = await connection.execute(sql);
      console.log(result);

      return result.rows;
    } catch (err) {
      console.log("error in oracledb: ", err);
      throw new Error(err);
    } finally {
      if (connection) {
        try {
          await connection.close();
        } catch (err) {
          console.log("connection to oracle error: ", err);
          throw new Error(err);
        }
      }
    }
  },

  async calSalaryInfo(accounting_department_info) {
    let connection;

    console.log(accounting_department_info);
    try {
      connection = await oracledb.getConnection({
        host: "localhost",
        port: 1521,
        user: `${accounting_department_info.username}`,
        password: `${accounting_department_info.password}`,
        database: "HospitalManagement",
        privilege: require("oracledb").DEFAULT,
      });
      // set role always!s

      const sql_set_role = `SET ROLE  ROLE_DEP_KETOAN IDENTIFIED BY ROLE_DEP_KETOAN `;
      console.log(sql_set_role);

      const ret_set_role = await connection.execute(sql_set_role);

      console.log(ret_set_role);

      const sql = `SELECT * FROM DUCCAO_ADMIN.VIEW_CAL_SALARY `;
      console.log(sql);

      const result = await connection.execute(sql);

      console.log(result);

      return result.rows;
    } catch (err) {
      console.log("error in oracledb: ", err);
      throw new Error(err);
    } finally {
      if (connection) {
        try {
          await connection.close();
        } catch (err) {
          console.log("connection to oracle error: ", err);
          throw new Error(err);
        }
      }
    }
  },
};

module.exports = ketoanModel;
