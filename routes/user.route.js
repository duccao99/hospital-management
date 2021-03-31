const express = require("express");
const router = express.Router();
const userModel = require("./../models/user.model");

router.get("/create-user", function (req, res) {
  res.render("vwUser/create", {
    layout: "admin",
  });
});

router.post("/create-user", async function (req, res) {
  try {
    const data = {
      username: req.body.username,
      identify: req.body.identify,
    };
    console.log(data);
    const trigger = await userModel.loadBeforeCreateUser();
    const status = await userModel.createUser(data.username, data.identify);

    res.status(200);
  } catch (e) {
    return res.status(500).json({ e });
  }
});

module.exports = router;
