const db = require("./../utils/db");

const ccModel = {
  all() {
    const sql = `SELECT * FROM DUCCAO_ADMIN.CHAMCONG`;
    console.log(sql);

    return db.load(sql);
  },
};

module.exports = ccModel;
