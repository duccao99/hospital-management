const oracledb = require('oracledb');
const { oracle } = require('../config/config');

const receptionModel = {
  async getViewDoctorSeePatientInfo(curr_user) {
    const connection = await oracledb.getConnection({
      host: 'localhost',
      port: 1521,
      user: `${curr_user.username.toUpperCase()}`,
      password: `${curr_user.password.toUpperCase()}`,
      database: 'HospitalManagement',
      privilege: oracledb.DEFAULT
    });

    const set_role_query = `SET ROLE ROLE_DOCTOR IDENTIFIED BY ROLE_DOCTOR `;
    console.log(set_role_query);
    const ret_set_role = await connection.execute(set_role_query);
    console.log(ret_set_role);

    const sql = `SELECT * FROM DUCCAO_ADMIN.VIEW_DOCTOR_SEE_PATIENT_INFO `;
    console.log(sql);
    const ret = await connection.execute(sql);

    return ret.rows;
  }
};
module.exports = receptionModel;
