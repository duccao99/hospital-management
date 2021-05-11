const express = require("express");
const adminModel = require("../models/admin.model");
const router = express.Router();
const userModel = require("../models/user.model");
const oracleModel = require("./../models/oracle.model.js");
const { authUser } = require("./../middlewares/user.mdw");
const ccModel = require("./../models/chamcong.model.js");
const ketoanModel = require("./../models/ketoan.model");
const moment = require("moment");
const receptionModel = require("../models/reception.model");
const benhnhanModel = require("./../models/benhnhan.model");
const hosobenhnhanModel = require("../models/hosobenhnhan.model");
const oracle = require("./../models/oracle.model.js");

const validator = require("validator").default;

//create user
router.get("/create-user", authUser, async function (req, res) {
  const allVaiTros = await userModel.getAllVaiTroInSystem();

  res.render("vwUser/create", {
    layout: "admin",
    authUser: req.session.authUser,
    allVaiTros,
  });
});

router.post("/create-user", async function (req, res) {
  const data = {
    username: req.body.username,
    identify: req.body.identify,
    type: req.body.type,
  };

  const status = await userModel.createUser(
    data.username,
    data.identify,
    data.type
  );

  res.status(200).json({ message: "Create user success!" });
});

//update
router.get("/update-user", authUser, async function (req, res) {
  const usernames = await adminModel.getAllUserName();
  res.render("vwUser/updateUser", {
    layout: "admin",
    authUser: req.session.authUser,
    usernames: usernames.sort((a, b) => {
      if (a.USERNAME < b.USERNAME) {
        return -1;
      }
      if (a.USERNAME > b.USERNAME) {
        return 1;
      }
      return 0;
    }),
  });
});

router.patch("/update-user", authUser, async function (req, res) {
  const data = {
    username: req.body.username,
    newPassword: req.body.newPassword,
  };

  console.log(data);
  // const status = await userModel.updateUser(data.username, data.newPassword);
  const status = await userModel.updateUserUsingProc(
    data.username,
    data.newPassword
  );

  res.json({ message: "success!" });
});

//delete user
router.get("/delete-user", authUser, async function (req, res) {
  const usernames = await adminModel.getAllUserName();
  res.render("vwUser/deleteUser", {
    layout: "admin",
    authUser: req.session.authUser,
    usernames: usernames.sort((a, b) => {
      if (a.USERNAME < b.USERNAME) {
        return -1;
      }
      if (a.USERNAME > b.USERNAME) {
        return 1;
      }
      return 0;
    }),
  });
});

router.delete("/delete-user", authUser, async function (req, res) {
  const data = {
    username: req.body.username,
  };

  console.log(data);
  const status = await userModel.deleteUser(data.username);

  res.json({ message: "Deleted User!" });
});

//revoke user permission
router.get("/revoke-user-permission", authUser, async function (req, res) {
  const usernames = await adminModel.getAllUserName();

  // get all column name of all table
  const chamCongColumns = await oracleModel.getAllChamCongColumns();
  const benhnhanColumns = await oracleModel.getAllBenhNhanColumns();
  const hsbnColumns = await oracleModel.getAllHSBNColumns();
  const hsdvColumns = await oracleModel.getAllHSDVColumns();
  const hoadonColumns = await oracleModel.getAllHoaDonColumns();
  const nhanvienColumns = await oracleModel.getAllNhanVienColumns();
  const donviColumns = await oracleModel.getAllDonViColumns();
  const dichvuColumns = await oracleModel.getAllDichVuColumns();
  const ctHoaDonColumns = await oracleModel.getAllCTHOADONColumns();
  const ctDonThuocColumns = await oracleModel.getAllCTDONTHUOCColumns();
  const thuocColumns = await oracleModel.getAllTHUOCColumns();

  const arrayColumns = [
    {
      tableName: "CHAMCONG",
      columns: chamCongColumns,
    },
    {
      tableName: "BENHNHAN",
      columns: benhnhanColumns,
    },
    {
      tableName: "HOSOBENHNHAN",
      columns: hsbnColumns,
    },
    {
      tableName: "HOSODICHVU",
      columns: hsdvColumns,
    },

    {
      tableName: "HOADON",
      columns: hoadonColumns,
    },
    {
      tableName: "NHANVIEN",
      columns: nhanvienColumns,
    },
    {
      tableName: "DONVI",
      columns: donviColumns,
    },
    {
      tableName: "DICHVU",
      columns: dichvuColumns,
    },
    {
      tableName: "CTHOADON",
      columns: ctHoaDonColumns,
    },
    {
      tableName: "CTDONTHUOC",
      columns: ctDonThuocColumns,
    },
    {
      tableName: "THUOC",
      columns: thuocColumns,
    },
  ];

  res.render("vwUser/revokeUser", {
    layout: "admin",
    authUser: req.session.authUser,
    arrayColumns,
    usernames: usernames.sort((a, b) => {
      if (a.USERNAME < b.USERNAME) {
        return -1;
      }
      if (a.USERNAME > b.USERNAME) {
        return 1;
      }
      return 0;
    }),
  });
});

router.patch("/revoke-user-permission", authUser, async function (req, res) {
  try {
    const data = {
      username: req.body.username,
      privilege: req.body.privilege,
      tableName: req.body.tableName,
      columnValue: req.body.columnValue,
    };
    console.log(data);

    const status = await userModel.revokeUserPermission(
      data.username,
      data.privilege,
      data.tableName,
      data.columnValue
    );

    res.json({ message: "success!" });
  } catch (e) {
    console.error(e);
    return res.status(500).json({ message: e });
  }
});

router.post("/user/cal-salary", async function (req, res) {
  // always declare current user info
  const accounting_department_info = req.session.authUser;
  const salary_infos = await ketoanModel.calSalaryInfo(
    accounting_department_info
  );

  for (let i = 0; i < salary_infos.length; ++i) {
    // calculation
    const salary =
      ((Number(salary_infos[i].PHUCAP) + Number(salary_infos[i].LUONG_COBAN)) *
        Number(salary_infos[i].SONGAYCONG)) /
      30;

    const thang = moment(salary_infos[i].THANG)
      .format("DD-MMM-YY")
      .toUpperCase();

    const update_salary_ret = await ketoanModel.updateSalary(
      salary_infos[i].MANV,
      thang,
      salary.toString(),
      accounting_department_info
    );

    // update salary
    // const update_salary_ret = await ketoanModel.updateSalaryTry3(
    //   salary_infos[i].MANV,
    //   thang,
    //   salary.toString(),
    //   accounting_department_info
    // );

    console.log(update_salary_ret);
  }

  res.json({
    href: "/home/user/role/accounting-department",
  });
});

router.post("/user/ketoan/reset-salary", async function (req, res) {
  const accounting_department_info = req.session.authUser;

  const reset_salary_status = await ketoanModel.resetSalary(
    accounting_department_info
  );

  console.log(reset_salary_status);

  return res.json({ href: "/home/user/role/accounting-department" });
});

router.post("/user/reception/add-patient-records", async function (req, res) {
  try {
    const curr_user = req.session.authUser;

    const len_benhnhan = await benhnhanModel.len();
    const len_HSBN = await hosobenhnhanModel.len();

    const find_mabn = len_benhnhan + 5;

    const fullDoctorData = await oracleModel.getAllDoctorNameAndID();

    let find_MANV = null;

    for (let i = 0; i < fullDoctorData.length; ++i) {
      if (fullDoctorData[i].HOTEN === req.body.TENBACSI) {
        find_MANV = fullDoctorData[i].MANV;
        break;
      }
    }

    console.log(len_benhnhan);
    console.log(len_HSBN);

    if (validator.isMobilePhone(req.body.SDT) === false) {
      return res.status(500).json({ err_message: "Phone invalid!" });
    }

    const patientFullInfo = {
      MABN: find_mabn,
      HOTEN: req.body.HOTEN,
      NGAYSINH: moment(req.body.NGAYSINH, "dd.mm.yyyy").format("DD/MM/YYYY"),
      DIACHI: req.body.DIACHI,
      SDT: req.body.SDT,
      //
      MAKB: len_HSBN + 5,
      NGAYKB: moment(Date.now()).format("DD/MM/YYYY"),
      MANV: find_MANV,
      TENBACSI: req.body.TENBACSI,
      MABN2: find_mabn,
      TINHTRANGBANDAU: req.body.TINHTRANGBANDAU,
      KETLUANCUABACSI: "",
    };

    console.log("Patient full info: ", patientFullInfo);

    const ret = await receptionModel.addNewPatientTry2(
      curr_user,
      patientFullInfo
    );

    console.log(ret);
    if (ret === 1) {
      return res.json({
        href: "/home/user/role/reception",
        message: "Added new patient records!",
      });
    }

    return res.status(500).json({
      href: "/home/user/role/reception",
      message: "error!",
    });
  } catch (er) {
    console.log(er);
    return res.status(500).json({
      href: "/home/user/role/reception",
      message: "error!",
    });
  }
});

router.delete("/user/reception/del", async function (req, res) {
  const curr_user = req.session.authUser;
  console.log(req.body);
  const data = {
    MAKB: +req.body.MAKB,
    MABN: +req.body.MABN,
  };

  const del_status = await receptionModel.delPatientRecords(
    curr_user,
    data.MAKB,
    data.MABN
  );

  return res.json({ href: "/home/user/role/reception" });
});

router.get("/user/reception/edit-patient", async function (req, res) {
  const curr_user_info = req.session.authUser;
  const data = {
    MAKB: req.query.makb,
    MABN: req.query.mabn,
  };

  const doctor_data = await oracleModel.getAllDoctorNameAndID();
  console.log(doctor_data);
  res.render("vwHome/EditPatient", {
    layout: "home.hbs",
    curr_user_info: curr_user_info,
    doctor_data,
  });
});

router.patch("/user/reception/edit-patient", async function (req, res) {
  const curr_user = req.session.authUser;
  let body_data = {
    ...req.body,
  };
  const doctor_data = await oracleModel.getAllDoctorNameAndID();

  let MANV = "";

  for (let i = 0; i < doctor_data.length; ++i) {
    if (doctor_data[i].HOTEN === body_data.TENBACSI) {
      MANV = doctor_data[i].MANV;
      break;
    }
  }

  if (validator.isMobilePhone(body_data.SDT) === false) {
    return res.status(500).json({ err_message: "Invalid phone!" });
  }

  body_data.NGAYSINH = moment(body_data.NGAYSINH, "dd.mm.yyyy").format(
    "DD/MM/YYYY"
  );
  body_data.MANV = MANV;
  body_data.NGAYKB = moment(Date.now()).format("DD/MM/YYYY");

  console.log(body_data);
  const ret_edit = await receptionModel.editPatient(curr_user, body_data);
  console.log(ret_edit);

  return res.json({
    href: "/home/user/role/reception",
  });
});

module.exports = router;
