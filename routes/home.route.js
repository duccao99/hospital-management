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

module.exports = router;
