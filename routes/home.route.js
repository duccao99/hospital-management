const router = require("express").Router();

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

router.get("/home/user/role/accounting-department", function (req, res) {
  console.log("Home ????");

  res.render("vwHome/AccountingDepartment", {
    layout: false,
  });
});

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
