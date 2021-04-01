const express = require("express");
const adminModel = require("../models/admin.model");
const router = express.Router();
const userModel = require("../models/user.model");
const oracleModel = require("./../models/oracle.model.js");
const { authUser } = require("./../middlewares/user.mdw");
const { oracle } = require("../config/config");
const { route } = require("./admin.route");

//create user
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
  const status = await userModel.updateUser(data.username, data.newPassword);

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

  res.json({ message: "success!" });
});



module.exports = router;
