const router = require("express").Router();
const { authUser } = require("../middlewares/user.mdw");
const ketoanModel = require("../models/ketoan.model");
const ccModel = require("./../models/chamcong.model");

router.get("/", function (req, res) {
  res.redirect("/sign-in");
});

router.get("/home", function (req, res) {
  console.log("Home ????");

  res.render("vwHome/HomePage", {
    layout: false,
  });
});

router.get("/home/user/role/human-resource-management", function (req, res) {
  console.log("Home ????");

  res.render("vwHome/HumanResourceManagement", {
    layout: false,
  });
});

router.get("/home/user/role/reception", function (req, res) {
  console.log("Home ????");

  res.render("vwHome/Reception", {
    layout: false,
  });
});

router.get("/home/user/role/professional-management", function (req, res) {
  console.log("Home ????");

  res.render("vwHome/ProfessionalManagement", {
    layout: false,
  });
});

router.get("/home/user/role/accounting-room", function (req, res) {
  console.log("Home ????");

  res.render("vwHome/AccountingRoom", {
    layout: false,
  });
});

router.get(
  "/home/user/role/accounting-department",
  authUser,
  async function (req, res) {
    const accounting_department_info = req.session.authUser;
    const chamcong_data = await ketoanModel.all(accounting_department_info);
    const curr_user_info = req.session.authUser;

    console.log(curr_user_info);
    res.render("vwHome/AccountingDepartment", {
      layout: "home.hbs",
      home_title: "Accounting Deparment",
      curr_user_info: curr_user_info,
      chamcong_data,
    });
  }
);

router.get("/home/user/role/accounting-management", function (req, res) {
  console.log("Home ????");

  res.render("vwHome/AccountingManagement", {
    layout: false,
  });
});
router.get("/home/user/role/doctor", function (req, res) {
  console.log("Home ????");

  res.render("vwHome/Doctor", {
    layout: false,
  });
});
module.exports = router;
