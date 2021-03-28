const express = require("express");
const router = express.Router();

router.get("/info-privileges-user", function (req, res) {
  console.log("GET privileges user");
  res.render("vwPrivileges/userPrivileges", {
    layout: "admin",
    userPriveleges: [
      { userID: 1, username: "duc", privelege: 1 },
      { userID: 2, username: "tons", privelege: 3 },
      { userID: 3, username: "duc2", privelege: 122 },
    ],
  });
});

module.exports = router;
