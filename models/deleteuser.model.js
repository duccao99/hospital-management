const db = require("../utils/db");
const config = require("../config/config");
const oracledb = require("oracledb");

oracledb.outFormat = oracledb.OUT_FORMAT_OBJECT;

async function proc_DeleteUser(pi_username) {
  let connection;

  try {
    connection = await oracledb.getConnection({
      host: "localhost",
      port: 1521,
      user: "sys",
      password: "1",
      database: "NodeOra",
      privilege: require("oracledb").SYSDBA,
    });
    const result = await connection.execute(
      
      `BEGIN
           deleteUser(:pi_username);
        END;`,
      {
        pi_username: `${pi_username}`,
      }
    );
    console.log(result);
    return result.rows;
  } catch (err) {
    console.error(err);
  } finally {
    if (connection) {
      try {
        await connection.close();
      } catch (err) {
        console.error(err);
      }
    }
  }
}

const deleteUserModel = {
  async deleteUser(username) {
    const status = await proc_DeleteUser(username);

    return -1;
  },
};

module.exports = deleteUserModel;
