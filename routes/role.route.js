const express = require("express");
const adminModel = require("../models/admin.model");
const router = express.Router();
const roleModel = require("../models/role.model");
const oracleModel = require("./../models/oracle.model.js");
const { authUser } = require("./../middlewares/user.mdw");
const { oracle } = require("../config/config");
const { route } = require("./admin.route");

//create role
router.get("/create-role", function (req, res) {
  res.render("vwRole/createRole", {
    layout: "admin",
  });
});

//update role
router.get("/update-role", async function (req, res) {
  const rolenames = await adminModel.getAllRoleName();
  res.render("vwRole/updateRole", {
    layout: "admin",
    rolenames: rolenames.sort(function (a, b) {
      if (a.ROLE < b.ROLE) {
        return -1;
      }
      if (a.ROLE < b.ROLE) {
        return 1;
      }
      return 0;
    }),
    authUser: req.session.authUser,
  });
});

router.patch("/update-role", authUser, async function (req, res) {
  const data = {
    rolename: req.body.rolename,
    newPassword: req.body.newPassword,
  };

  console.log(data);
  const status = await roleModel.updateRole(data.rolename, data.newPassword);

  res.json({ message: "success!" });
});



//delete role
router.get("/delete-role", async function (req, res) {
    const rolenames = await adminModel.getAllRoleName();
    res.render("vwRole/deleteRole", {
      layout: "admin",
      rolenames: rolenames.sort(function (a, b) {
        if (a.ROLE < b.ROLE) {
          return -1;
        }
        if (a.ROLE < b.ROLE) {
          return 1;
        }
        return 0;
      }),
      authUser: req.session.authUser,
    });
  });
  
  router.delete("/delete-role", authUser, async function (req, res) {
    const data = {
      rolename: req.body.rolename,
    };
  
    console.log(data);
    const status = await roleModel.deleteRole(data.rolename);
  
    res.json({ message: "success!" });
  });
// router.get("/update-role", function (req, res) {
//     const rolenames = await adminModel.getAllRoleName();
//       res.render("vwRole/updateRole", {
//         layout: "admin",
//         authUser: req.session.authUser,
//         rolenames: rolenames.sort((a, b) => {
//           if (a.ROLE < b.ROLE) {
//             return -1;
//           }
//           if (a.ROLE > b.ROLE) {
//             return 1;
//           }
//           return 0;
//         }),
//       });
// });

// router.post("/create-user", async function (req, res) {
//   try {
//     const data = {
//       username: req.body.username,
//       identify: req.body.identify,
//     };
//     console.log(data);
//     const trigger = await userModel.loadBeforeCreateUser();
//     const status = await userModel.createUser(data.username, data.identify);

//     res.status(200);
//   } catch (e) {
//     return res.status(500).json({ e });
//   }
// });

// //update
// router.get("/update-user", authUser, async function (req, res) {
//   const usernames = await adminModel.getAllUserName();
//   res.render("vwUser/updateUser", {
//     layout: "admin",
//     authUser: req.session.authUser,
//     usernames: usernames.sort((a, b) => {
//       if (a.USERNAME < b.USERNAME) {
//         return -1;
//       }
//       if (a.USERNAME > b.USERNAME) {
//         return 1;
//       }
//       return 0;
//     }),
//   });
// });

// router.patch("/update-user", authUser, async function (req, res) {
//   const data = {
//     username: req.body.username,
//     newPassword: req.body.newPassword,
//   };

//   console.log(data);
//   const status = await userModel.updateUser(data.username, data.newPassword);

//   res.json({ message: "success!" });
// });

// //delete user
// router.get("/delete-user", authUser, async function (req, res) {
//   const usernames = await adminModel.getAllUserName();
//   res.render("vwUser/deleteUser", {
//     layout: "admin",
//     authUser: req.session.authUser,
//     usernames: usernames.sort((a, b) => {
//       if (a.USERNAME < b.USERNAME) {
//         return -1;
//       }
//       if (a.USERNAME > b.USERNAME) {
//         return 1;
//       }
//       return 0;
//     }),
//   });
// });

// router.delete("/delete-user", authUser, async function (req, res) {
//   const data = {
//     username: req.body.username,
//   };

//   console.log(data);
//   const status = await userModel.deleteUser(data.username);

//   res.json({ message: "success!" });
// });

module.exports = router;
