const oracledb = require("oracledb");

oracledb.outFormat = oracledb.OUT_FORMAT_OBJECT;

async function run(sql) {
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

    const result = await connection.execute(sql);
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

module.exports = {
  load: (sql) => {
    return run(sql);
  },
};
