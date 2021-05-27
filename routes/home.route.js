const router = require("express").Router();
const { authUser } = require("../middlewares/user.mdw");
const ketoanModel = require("../models/ketoan.model");
const receptionModel = require("../models/reception.model");
const moment = require("moment");
const e = require("express");
const dichvuModel = require("../models/dichvu.model");
const hoadonModel = require("../models/hoadon.model");
const cthoadonModel = require("../models/cthoadon.model");

router.get("/", function (req, res) {
  res.redirect("/sign-in");
});

router.get("/home", function (req, res) {
  res.render("vwHome/HomePage", {
    layout: false,
  });
});

router.get("/home/user/role/human-resource-management", function (req, res) {
  res.render("vwHome/HumanResourceManagement", {
    layout: false,
  });
});

router.get("/home/user/role/reception", authUser, async function (req, res) {
  const curr_user_info = req.session.authUser;

  //user_tieptan_01
  let reception_data = await receptionModel.get_view_reception(curr_user_info);

  reception_data = reception_data.map((e) => {
    return {
      ...e,
      NGAYKB: moment(e.NGAYKB).format("DD-MM-YYYY , hh:mm:ss").toUpperCase(),
    };
  });

  let patient_info_data = await receptionModel.getPatientData(curr_user_info);

  patient_info_data = patient_info_data.map((e) => {
    return {
      ...e,
      NGAYSINH: moment(e.NGAYSINH).format("DD-MM-YYYY, HH:MM:SS"),
    };
  });

  const doctor_data = await receptionModel.getDoctorData(curr_user_info);

  res.render("vwHome/Reception", {
    layout: "home.hbs",
    home_title: "Reception Department",
    curr_user_info: curr_user_info,
    reception_data: reception_data,
    patient_info_data,
    doctor_data,
  });
});

router.get("/home/user/role/professional-management", function (req, res) {
  res.render("vwHome/ProfessionalManagement", {
    layout: false,
  });
});

router.get("/home/user/role/accounting-room", async function (req, res) {
  const curr_user = req.session.authUser;
  console.log(curr_user);

  const dichvu_data = await dichvuModel.getDichVuData(curr_user);
  const hoadon_data = await hoadonModel.getHoaDonData(curr_user);
  const cthoadon_data = await cthoadonModel.getCtHoaDonData(curr_user);


  res.render("vwHome/AccountingRoom", {
    layout: "home.hbs",
    home_title: "Accounting Room",
    curr_user_info: curr_user,
    dichvu_data,
    hoadon_data,
    cthoadon_data,
  });
});


router.get(
  "/home/user/role/accounting-department",
  authUser,
  async function (req, res) {
    const accounting_department_info = req.session.authUser;
    const chamcong_data = await ketoanModel.all(accounting_department_info);
    const curr_user_info = req.session.authUser;

    console.log("Current user role accounting info: ", curr_user_info);
    res.render("vwHome/AccountingDepartment", {
      layout: "home.hbs",
      home_title: "Accounting Deparment",
      curr_user_info: curr_user_info,
      chamcong_data,
    });
  }
);

router.get("/home/user/role/accounting-management", function (req, res) {
  res.render("vwHome/AccountingManagement", {
    layout: false,
  });
});

router.get("/home/user/role/doctor", function (req, res) {
  res.render("vwHome/Doctor", {
    layout: false,
  });
});
module.exports = router;
