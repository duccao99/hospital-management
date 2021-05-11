const oracledb = require("oracledb");
const { oracle } = require("../config/config");

const receptionModel = {
  async get_view_reception(curr_user) {
    const connection = await oracledb.getConnection({
      host: "localhost",
      port: 1521,
      user: `${curr_user.username.toUpperCase()}`,
      password: `${curr_user.password.toUpperCase()}`,
      database: "HospitalManagement",
      privilege: oracledb.DEFAULT,
    });

    const set_role_query = `SET ROLE ROLE_DEP_LETAN IDENTIFIED BY ROLE_DEP_LETAN `;
    console.log(set_role_query);
    const ret_set_role = await connection.execute(set_role_query);
    console.log(ret_set_role);

    const sql = `SELECT * FROM DUCCAO_ADMIN.VIEW_RECEPTION `;
    console.log(sql);
    const ret = await connection.execute(sql);

    return ret.rows;
  },

  async getPatientData(curr_user) {
    const conn = await oracledb.getConnection({
      host: "localhost",
      port: 1521,
      user: `${curr_user.username.toUpperCase()}`,
      password: `${curr_user.password.toUpperCase()}`,
      database: "HospitalManagement",
      privilege: oracledb.DEFAULT,
    });

    const role_query = "SET ROLE ROLE_DEP_LETAN IDENTIFIED BY ROLE_DEP_LETAN ";

    await conn.execute(role_query);

    const sql = "SELECT * FROM DUCCAO_ADMIN.BENHNHAN ";
    console.log(sql);
    const ret = await conn.execute(sql);

    return ret.rows;
  },

  async getDoctorData(curr_user) {
    const conn = await oracledb.getConnection({
      host: "localhost",
      port: 1521,
      user: `${curr_user.username.toUpperCase()}`,
      password: `${curr_user.password.toUpperCase()}`,
      database: "HospitalManagement",
      privilege: oracledb.DEFAULT,
    });

    const role_query = "SET ROLE ROLE_DEP_LETAN IDENTIFIED BY ROLE_DEP_LETAN ";

    await conn.execute(role_query);

    const sql = "SELECT * FROM DUCCAO_ADMIN.VIEW_RECEPTION_DOCTOR ";
    console.log(sql);
    const ret = await conn.execute(sql);

    return ret.rows;
  },

  async addNewPatientTry1(curr_user, patientFullInfo) {
    const conn = await oracledb.getConnection({
      host: "localhost",
      port: 1521,
      user: `${curr_user.username.toUpperCase()}`,
      password: `${curr_user.password.toUpperCase()}`,
      database: "HospitalManagement",
      privilege: oracledb.DEFAULT,
    });

    oracledb.autoCommit;

    const query_role = "SET  ROLE ROLE_DEP_LETAN IDENTIFIED BY ROLE_DEP_LETAN ";
    await conn.execute(query_role);

    const sql = `
    BEGIN
    DUCCAO_ADMIN.PROC_RECEPTION_ADD_NEW_PATIENT(:IP_MABN,:IP_HOTEN,:IP_NGAYSINH,:IP_DIACHI,:IP_SDT,
      :IP_MAKB,:IP_NGAYKB,:IP_MANV,:IP_TENBACSI,:IP_MABN2,:IP_TINHTRANGBANDAU,:IP_KETLUANCUABACSI);
    END;
    `;

    const ret = await conn.execute(sql, {
      // benhnhan
      IP_MABN: {
        val: patientFullInfo.MABN,
      },
      IP_HOTEN: {
        val: patientFullInfo.HOTEN,
      },
      IP_NGAYSINH: {
        val: `'${patientFullInfo.NGAYSINH}'`,
        type: oracledb.json_sca,
      },
      IP_DIACHI: {
        val: patientFullInfo.DIACHI,
      },
      IP_SDT: {
        val: patientFullInfo.SDT,
      },
      // hosobenhnhan
      IP_MAKB: {
        val: patientFullInfo.MAKB,
      },
      IP_NGAYKB: {
        val: `'${patientFullInfo.NGAYKB}'`,
        type: oracledb.DATE,
      },
      IP_MANV: {
        val: patientFullInfo.MANV,
      },
      IP_TENBACSI: {
        val: patientFullInfo.TENBACSI,
      },
      IP_MABN2: {
        val: patientFullInfo.MABN2,
      },
      IP_TINHTRANGBANDAU: {
        val: patientFullInfo.TINHTRANGBANDAU,
      },
      IP_KETLUANCUABACSI: {
        val: patientFullInfo.KETLUANCUABACSI,
      },
    });

    console.log(ret);
  },
  async addNewPatientTry2(curr_user, patientFullInfo) {
    try {
      const conn = await oracledb.getConnection({
        host: "localhost",
        port: 1521,
        user: `${curr_user.username.toUpperCase()}`,
        password: `${curr_user.password.toUpperCase()}`,
        database: "HospitalManagement",
        privilege: oracledb.DEFAULT,
      });

      oracledb.autoCommit;

      const query_role =
        "SET  ROLE ROLE_DEP_LETAN IDENTIFIED BY ROLE_DEP_LETAN ";
      await conn.execute(query_role);

      const sql = `
    BEGIN
    DUCCAO_ADMIN.PROC_RECEPTION_ADD_NEW_PATIENT (${patientFullInfo.MABN},'${patientFullInfo.HOTEN}',TO_DATE('${patientFullInfo.NGAYSINH}','DD/MM/YYYY'),'${patientFullInfo.DIACHI}','${patientFullInfo.SDT}',${patientFullInfo.MAKB},TO_DATE('${patientFullInfo.NGAYKB}','DD/MM/YYYY'),'${patientFullInfo.MANV}','${patientFullInfo.TENBACSI}',${patientFullInfo.MABN2},'${patientFullInfo.TINHTRANGBANDAU}','');
    END;
    `;

      console.log(sql);
      const ret = await conn.execute(sql);
      return 1;
    } catch (er) {
      return -1;
    }
  },
  async delPatientRecords(curr_user, makb, mabn) {
    const conn = await oracledb.getConnection({
      host: "localhost",
      port: 1521,
      user: `${curr_user.username.toUpperCase()}`,
      password: `${curr_user.password.toUpperCase()}`,
      database: "HospitalManagement",
      privilege: oracledb.DEFAULT,
    });
    oracledb.autoCommit = true;

    const query_role = "SET  ROLE ROLE_DEP_LETAN IDENTIFIED BY ROLE_DEP_LETAN ";
    await conn.execute(query_role);

    const sql = `
    BEGIN
      DUCCAO_ADMIN.PROC_DEL_PATIENT_RECORDS(:makb,:mabn);
    END;
  `;

    const ret = await conn.execute(sql, {
      makb: {
        val: makb,
      },
      mabn: {
        val: mabn,
      },
    });

    console.log(ret);
  },

  async editPatient(curr_user, edit_info) {
    try {
      const conn = await oracledb.getConnection({
        host: "localhost",
        port: 1521,
        user: `${curr_user.username.toUpperCase()}`,
        password: `${curr_user.password.toUpperCase()}`,
        database: "HospitalManagement",
        privilege: oracledb.DEFAULT,
      });

      oracledb.autoCommit = true;
      const query_role =
        "SET  ROLE ROLE_DEP_LETAN IDENTIFIED BY ROLE_DEP_LETAN ";

      await conn.execute(query_role);

      const sql = `BEGIN
    DUCCAO_ADMIN.PROC_EDIT_PATIENT_INFO(${edit_info.MABN},'${edit_info.HOTEN}',TO_DATE('${edit_info.NGAYSINH}','DD/MM/YYYY'),'${edit_info.DIACHI}','${edit_info.SDT}',${edit_info.MAKB},TO_DATE('${edit_info.NGAYKB}','DD/MM/YYYY'),'${edit_info.MANV}','${edit_info.TENBACSI}',${edit_info.MABN},'${edit_info.TINHTRANGBANDAU}','');
    END;`;
      console.log(sql);

      const ret = await conn.execute(sql);

      console.log(ret);
      return 1;
    } catch (er) {
      return -1;
    }
  },
};
module.exports = receptionModel;
