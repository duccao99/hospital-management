const express = require("express");
const adminModel = require("../models/admin.model");
const router = express.Router();
const userModel = require("../models/admin.model");
const { authUser } = require("./../middlewares/user.mdw");

router.get("/", function (req, res) {
  res.redirect("/sign-in");
});

router.get("/test", function (req, res) {
  res.render("vwAdmin/test", {
    layout: "admin",
  });
});

router.get("/sign-in", function (req, res) {
  try {
    return res.render("vwAdmin/SignIn", {
      layout: false,
    });
  } catch (e) {
    return res.status(500).json(e);
  }
});

router.post("/sign-in", function (req, res) {
  try {
    const data = req.body;
    //console.log(data);
    req.session.authUser = {
      username: data.username,
    };

    return res.redirect("/dashboard");
  } catch (e) {
    return res.status(500).json(e);
  }
});

router.post("/sign-out", function (req, res) {
  req.session.authUser = undefined;
  return res.redirect("/");
});

router.get("/dashboard", authUser, function (req, res) {
  res.render("vwAdmin/dashboard", {
    layout: "admin",
    authUser: req.session.authUser,
  });
});

router.get("/sign-up", function (req, res) {
  try {
  } catch (e) {
    return res.status(500).json(e);
  }
});

router.get("/temp", function (req, res) {
  try {
  } catch (e) {
    return res.status(500).json(e);
  }
});

router.get("/api/users", async function (req, res) {
  try {
    const users = await userModel.allUser();
    console.log(users);
    res.json(users);
    return;
  } catch (e) {
    console.log(e);
  }
});

router.get("/all-users", authUser, async function (req, res) {
  const users = await userModel.allUser();
  const sorted = [...users].sort((a, b) => a.USER_ID - b.USER_ID);

  res.render("vwAdmin/allUser", {
    layout: "admin",
    users: sorted,
    authUser: req.session.authUser,
  });
});

router.get("/user-role-privileges", authUser, async function (req, res) {
  const userRolePrivileges = await adminModel.getUserRolePrivileges();
  res.render("vwAdmin/userRolePrivileges", {
    layout: "admin",
    userRolePrivileges,
  });
});

router.get("/grant-user-permission", authUser, function (req, res) {
  res.render("vwAdmin/grantUserPermission", {
    layout: "admin",
    authUser: req.session.authUser,
  });
});

router.get("/grant-role-permission", authUser, function (req, res) {
  res.render("vwAdmin/grantRolePermission", {
    layout: "admin",
    authUser: req.session.authUser,
  });
});
router.get("/grant-role-to-user", authUser, function (req, res) {
  res.render("vwAdmin/grantRoleToUser", {
    layout: "admin",
    authUser: req.session.authUser,
  });
});

module.exports = router;
