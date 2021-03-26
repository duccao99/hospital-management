const express = require("express");
const router = express.Router();
const userModel = require("./../models/user.model");

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

    console.log(data);
    return res.redirect("/dashboard");
  } catch (e) {
    return res.status(500).json(e);
  }
});

router.get("/dashboard", function (req, res) {
  res.locals.authUser = {
    username: "duc",
  };
  res.render("vwAdmin/dashboard", {
    layout: "admin",
    user: {
      username: "duc",
    },
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
    const users = await userModel.all();
    console.log(users);
    res.json(users);
    return;
  } catch (e) {
    console.log(e);
  }
});

router.get("/all-users", async function (req, res) {
  const users = await userModel.all();
  console.log(users);

  res.render("vwAdmin/allUser", {
    layout: "admin",
    users,
  });
});

router.get("/grant-user-permission", function (req, res) {
  res.render("vwAdmin/grantUserPermission", {
    layout: "admin",
  });
});

router.get("/grant-role-permission", function (req, res) {
  res.render("vwAdmin/grantRolePermission", {
    layout: "admin",
  });
});
router.get("/grant-role-to-user", function (req, res) {
  res.render("vwAdmin/grantRoleToUser", {
    layout: "admin",
  });
});
router.get("*", function (req, res) {
  res.render("vwError/404", {
    layout: "admin",
  });
});
module.exports = router;
