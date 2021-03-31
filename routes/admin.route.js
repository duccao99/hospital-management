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

router.get("/all-roles", authUser, async function (req, res) {
  const roles = await userModel.allRoles();

  const sorted = [...roles].sort((a, b) => a.ROLE_ID - b.ROLE_ID);

  res.render("vwAdmin/allRoles", {
    layout: "admin",
    roles: sorted,
    authUser: req.session.authUser,
  });
});

router.get("/role-info", authUser, async function (req, res) {
  const roleInfo = await adminModel.getRoleAcffectDataOjbect();

  res.render("vwAdmin/roleInfo", {
    layout: "admin",
    roleInfo,
  });
});

router.get("/user-role", async function (req, res) {
  const userAndTheirRoles = await adminModel.getUserAndTheirRole();

  res.render("vwAdmin/userAndTheirRole", {
    layout: "admin",
    userAndTheirRoles,
  });
});

router.get("/grant-user-permission", authUser, function (req, res) {
  res.render("vwAdmin/grantUserPermission", {
    layout: "admin",
    authUser: req.session.authUser,
  });
});

router.post("/grant-user-permission", authUser, async function (req, res) {
  try {
    const data = {
      username: req.body.username,
      privilege: req.body.privilege,
      tableName: req.body.tableName,
    };

    const status = await adminModel.grantUserPrivilege(
      data.username,
      data.privilege,
      data.tableName
    );

    res.json({ message: "success!" });
  } catch (e) {
    return res.status(500).json({ message: e });
  }
});

router.get("/grant-role-permission", authUser, function (req, res) {
  res.render("vwAdmin/grantRolePermission", {
    layout: "admin",
    authUser: req.session.authUser,
  });
});

router.post("/grant-role-permission", authUser, async function (req, res) {
  try {
    const data = {
      rolename: req.body.rolename,
      privilege: req.body.privilege,
      tableName: req.body.tableName,
    };

    const status = await adminModel.grantRolePrivilege(
      data.rolename,
      data.privilege,
      data.tableName
    );

    res.json({ message: "success!" });
  } catch (e) {
    return res.status(500).json({ message: e });
  }
});

router.get("/grant-role-to-user", authUser, function (req, res) {
  res.render("vwAdmin/grantRoleToUser", {
    layout: "admin",
    authUser: req.session.authUser,
  });
});

module.exports = router;
