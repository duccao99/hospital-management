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
  const data = {
    username: req.body.username,
    identify: req.body.identify,
  };
  console.log(data);
  const status = await userModel.createUser(data.username, data.identify);

  res.status(200).json({ message: "Create user success!" });
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

//revoke user permission
router.get("/revoke-user-permission", authUser, async function (req, res) {
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

  res.render("vwUser/revokeUser", {
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

router.patch("/revoke-user-permission", authUser, async function (req, res) {
  try {
    const data = {
      username: req.body.username,
      privilege: req.body.privilege,
      tableName: req.body.tableName,
      columnValue: req.body.columnValue,
    };
    console.log(data);

    const status = await userModel.revokeUserPermission(
      data.username,
      data.privilege,
      data.tableName,
      data.columnValue
    );

    res.json({ message: "success!" });
  } catch (e) {
    console.error(e);
    return res.status(500).json({ message: e });
  }
});

module.exports = router;
