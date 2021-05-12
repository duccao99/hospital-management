const oracledb = require("oracledb");

const dichvuModel = {
  async getDichVuData(curr_user) {
    const conn = await oracledb.getConnection({
      host: "localhost",
      port: 1521,
      user: `${curr_user.username.toUpperCase()}`,
      password: `${curr_user.password.toUpperCase()}`,
      database: "HospitalManagement",
      privilege: oracledb.DEFAULT,
    });

    const role_query = "SET ROLE NHANVIEN_TAIVU IDENTIFIED BY NHANVIEN_TAIVU ";

    await conn.execute(role_query);

    const sql = "SELECT * FROM DUCCAO_ADMIN.DICHVU ";
    console.log(sql);
    const ret = await conn.execute(sql);

    return ret.rows;
  },
};
module.exports = dichvuModel;
