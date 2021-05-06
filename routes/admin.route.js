const express = require("express");
const adminModel = require("../models/admin.model");
const router = express.Router();
const userModel = require("../models/admin.model");
const oracleModel = require("./../models/oracle.model.js");
const { authUser } = require("./../middlewares/user.mdw");
const { oracle } = require("../config/config");

router.get("/dashboard", authUser, function (req, res) {
  res.render("vwAdmin/dashboard", {
    layout: "admin",
    authUser: req.session.authUser,
  });
});

router.get("/test", function (req, res) {
  res.render("vwAdmin/test", {
    layout: "admin",
  });
});

router.get("/sign-in", function (req, res) {
  res.render("vwAdmin/SignIn", {
    layout: false,
  });
});

router.post("/sign-in", async function (req, res) {
  const data = req.body;
  console.log("data user login: ", data);
  let listUsers = await adminModel.getListUsers(data.username, data.password);

  listUsers = listUsers.map((u) => {
    return {
      username: u.HOTEN.trim(),
      password: u.MATKHAU.trim(),
      role: u.VAITRO.trim(),
    };
  });

  for (let u of listUsers) {
    if (u.username === data.username) {
      console.log(u.username, data.username);
      const password = u.password;
      const decrypted_pass = await userModel.decryptUserPassword(password);
      console.log(decrypted_pass);
      if (u.password !== data.password) {
        return res.status(401).json({ error_message: "Unauthorize!" });
      } else {
        console.log(u);
        if (u.role === "NHANVIEN_ADMIN") {
          req.session.authUser = {
            username: data.username,
            password: data.password,
            role: u.role,
          };
          return res.json({ href: "/dashboard" });
        } else {
          req.session.authUser = {
            username: data.username,
            password: data.password,
            role: u.role,
          };
          return res.json({ href: "/home" });
        }
      }
    }
  }
  return res.status(401).json({ error_message: "Unauthorize!" });
});

router.post("/sign-out", function (req, res) {
  req.session.authUser = undefined;
  return res.redirect("/");
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

router.get("/user-priv", authUser, async function (req, res) {
  const roleInfo = await adminModel.getUserPriv();

  res.render("vwAdmin/userPriv", {
    layout: "admin",
    roleInfo,
    authUser: req.session.authUser,
  });
});

router.patch("/user-priv", authUser, async function (req, res) {
  const editInfo = {
    edit_info_tableName: req.body.edit_info_tableName,
    edit_info_priv: req.body.edit_info_priv,
    edit_info_grantAble: req.body.edit_info_grantAble,
  };
  const info = {
    info_grantee: req.body.info_grantee,
    info_tableName: req.body.info_tableName,
    info_priv: req.body.info_priv,
    info_grantAble: req.body.info_grantAble,
  };
  // SOLUTION: Revoke first then re-grant
  const revokeStatus = await adminModel.revokeUserPriv(
    info.info_priv,
    info.info_tableName,
    info.info_grantee
  );
  const reGrantStatus = await adminModel.reGrantUserPriv(
    editInfo.edit_info_priv,
    editInfo.edit_info_tableName,
    info.info_grantee,
    editInfo.edit_info_grantAble
  );

  res.json({ message: "success" });
});

router.get("/role-priv", authUser, async function (req, res) {
  const rolePrivs = await adminModel.getRolePrivs();

  res.render("vwAdmin/rolePriv", {
    layout: "admin",
    rolePrivs,
    authUser: req.session.authUser,
  });
});

router.patch("/role-priv", authUser, async function (req, res) {
  const editInfo = {
    tblName: req.body.edit_info_tableName,
    priv: req.body.edit_info_priv,
  };
  const info = {
    roleName: req.body.info_grantee,
    tblName: req.body.info_tableName,
    priv: req.body.info_priv,
  };

  const revokeStatus = await adminModel.reVokeRolePriv(
    info.priv,
    info.tblName,
    info.roleName
  );
  const geGrantStatus = await adminModel.reGrantRolePriv(
    editInfo.priv,
    editInfo.tblName,
    info.roleName
  );
  res.json({ message: "Edit role priv sucess!" });
});

router.get("/user-role", async function (req, res) {
  const userAndTheirRoles = await adminModel.getUserAndTheirRole();

  res.render("vwAdmin/userAndTheirRole", {
    layout: "admin",
    userAndTheirRoles,
    authUser: req.session.authUser,
  });
});

router.get("/user-column-privilege", async function (req, res) {
  const userColPrivs = await adminModel.getUserAndTheirPrivilegesInColumn();

  res.render("vwAdmin/userColPrivileges", {
    layout: "admin",
    userColPrivs,
    authUser: req.session.authUser,
  });
});

router.get("/grant-user-permission", authUser, async function (req, res) {
  const usernames = await adminModel.getAllUserName();

  // get all column name of all table
  const chamCongColumns = await oracleModel.getAllChamCongColumns();
  const benhnhanColumns = await oracleModel.getAllBenhNhanColumns();
  const hsbnColumns = await oracleModel.getAllHSBNColumns();
  const hsdvColumns = await oracleModel.getAllHSDVColumns();
  const hoadonColumns = await oracleModel.getAllHoaDonColumns();
  const nhanvienColumns = await oracleModel.getAllNhanVienColumns();
  const donviColumns = await oracleModel.getAllDonViColumns();
  const dichvuColumns = await oracleModel.getAllDichVuColumns();
  const ctHoaDonColumns = await oracleModel.getAllCTHOADONColumns();
  const ctDonThuocColumns = await oracleModel.getAllCTDONTHUOCColumns();
  const thuocColumns = await oracleModel.getAllTHUOCColumns();

  const arrayColumns = [
    {
      tableName: "CHAMCONG",
      columns: chamCongColumns,
    },
    {
      tableName: "BENHNHAN",
      columns: benhnhanColumns,
    },
    {
      tableName: "HOSOBENHNHAN",
      columns: hsbnColumns,
    },
    {
      tableName: "HOSODICHVU",
      columns: hsdvColumns,
    },

    {
      tableName: "HOADON",
      columns: hoadonColumns,
    },
    {
      tableName: "NHANVIEN",
      columns: nhanvienColumns,
    },
    {
      tableName: "DONVI",
      columns: donviColumns,
    },
    {
      tableName: "DICHVU",
      columns: dichvuColumns,
    },
    {
      tableName: "CTHOADON",
      columns: ctHoaDonColumns,
    },
    {
      tableName: "CTDONTHUOC",
      columns: ctDonThuocColumns,
    },
    {
      tableName: "THUOC",
      columns: thuocColumns,
    },
  ];

  res.render("vwAdmin/grantUserPermission", {
    layout: "admin",
    authUser: req.session.authUser,
    arrayColumns,
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

router.post("/grant-user-permission", authUser, async function (req, res) {
  try {
    const data = {
      username: req.body.username,
      privilege: req.body.privilege,
      tableName: req.body.tableName,
      withGrantOption: req.body.withGrantOption,
      columnValue: req.body.columnValue,
    };
    console.log(data);

    const status = await adminModel.grantUserPrivilege(
      data.username,
      data.privilege,
      data.tableName,
      data.withGrantOption,
      data.columnValue
    );

    res.json({ message: "success!" });
  } catch (e) {
    console.error(e);
    return res.status(500).json({ message: e });
  }
});

router.get("/grant-role-permission", authUser, async function (req, res) {
  const roleNames = await adminModel.allRoleNames();

  // get all column name of all table
  const chamCongColumns = await oracleModel.getAllChamCongColumns();
  const benhnhanColumns = await oracleModel.getAllBenhNhanColumns();
  const hsbnColumns = await oracleModel.getAllHSBNColumns();
  const hsdvColumns = await oracleModel.getAllHSDVColumns();
  const hoadonColumns = await oracleModel.getAllHoaDonColumns();
  const nhanvienColumns = await oracleModel.getAllNhanVienColumns();
  const donviColumns = await oracleModel.getAllDonViColumns();
  const dichvuColumns = await oracleModel.getAllDichVuColumns();
  const ctHoaDonColumns = await oracleModel.getAllCTHOADONColumns();
  const ctDonThuocColumns = await oracleModel.getAllCTDONTHUOCColumns();
  const thuocColumns = await oracleModel.getAllTHUOCColumns();

  const arrayColumns = [
    {
      tableName: "CHAMCONG",
      columns: chamCongColumns,
    },
    {
      tableName: "BENHNHAN",
      columns: benhnhanColumns,
    },
    {
      tableName: "HOSOBENHNHAN",
      columns: hsbnColumns,
    },
    {
      tableName: "HOSODICHVU",
      columns: hsdvColumns,
    },

    {
      tableName: "HOADON",
      columns: hoadonColumns,
    },
    {
      tableName: "NHANVIEN",
      columns: nhanvienColumns,
    },
    {
      tableName: "DONVI",
      columns: donviColumns,
    },
    {
      tableName: "DICHVU",
      columns: dichvuColumns,
    },
    {
      tableName: "CTHOADON",
      columns: ctHoaDonColumns,
    },
    {
      tableName: "CTDONTHUOC",
      columns: ctDonThuocColumns,
    },
    {
      tableName: "THUOC",
      columns: thuocColumns,
    },
  ];
  res.render("vwAdmin/grantRolePermission", {
    roleNames,
    arrayColumns,
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
      withGrantOption: req.body.withGrantOption,
      columnValue: req.body.columnValue,
    };
    console.log(data);

    const status = await adminModel.grantRolePrivilege(
      data.rolename,
      data.privilege,
      data.tableName,
      "false",
      data.columnValue
    );

    res.json({ message: "success!" });
  } catch (e) {
    return res.status(500).json({ message: e });
  }
});

router.get("/grant-role-to-user", authUser, async function (req, res) {
  const usernames = await adminModel.getAllUserName();
  const rolenames = await adminModel.getAllRoleName();

  res.render("vwAdmin/grantRoleToUser", {
    layout: "admin",
    usernames: usernames.sort(function (a, b) {
      if (a.USERNAME < b.USERNAME) {
        return -1;
      }
      if (a.USERNAME < b.USERNAME) {
        return 1;
      }
      return 0;
    }),
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

router.post("/grant-role-to-user", authUser, async function (req, res) {
  const data = {
    rolename: req.body.rolename,
    username: req.body.username,
  };
  const status = await adminModel.grantRoleToUser(data.rolename, data.username);
  res.json({ message: "Granted!" });
});

router.get(
  "/user-select-column-privilege",
  authUser,
  async function (req, res) {
    const userSelectColumnPrivs = await adminModel.getViewUserSelectColumnLevel();
    res.render("vwAdmin/UserSelectColumnPriv", {
      layout: "admin",
      authUser: req.session.authUser,
      userSelectColumnPrivs,
    });
  }
);

router.get(
  "/role-select-column-privilege",
  authUser,
  async function (req, res) {
    const roleSeletColumnPrivs = await adminModel.getViewRoleSelectColumnLevel();
    res.render("vwAdmin/UserSelectColumnPriv", {
      layout: "admin",
      authUser: req.session.authUser,
      roleSeletColumnPrivs,
    });
  }
);

module.exports = router;
