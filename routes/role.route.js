const express = require("express");
const adminModel = require("../models/admin.model");
const router = express.Router();
const roleModel = require("../models/role.model");
const oracleModel = require("./../models/oracle.model.js");
const { authUser } = require("./../middlewares/user.mdw");
const { oracle } = require("../config/config");

//create role
router.get("/create-role", authUser, function (req, res) {
  res.render("vwRole/createRole", {
    layout: "admin",
    authUser: req.session.authUser,
  });
});

router.post("/create-role", authUser, async function (req, res) {
  const data = {
    rolename: req.body.rolename,
    identify: req.body.identify,
  };
  const status = await roleModel.createRole(data.rolename, data.identify);
  res.json({ message: "Created Role!" });
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
  //const status = await roleModel.updateRole(data.rolename, data.newPassword);
  const status = await roleModel.updateRoleUsingProc(
    data.rolename,
    data.newPassword
  );

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

  const status = await roleModel.deleteRole(data.rolename);

  res.json({ message: "success!" });
});

//revoke role permission
router.get("/revoke-role-permission", authUser, async function (req, res) {
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
  res.render("vwRole/revokeRolePermission", {
    roleNames,
    arrayColumns,
    layout: "admin",
    authUser: req.session.authUser,
  });
});

router.patch("/revoke-role-permission", authUser, async function (req, res) {
  try {
    const data = {
      rolename: req.body.rolename,
      privilege: req.body.privilege,
      tableName: req.body.tableName,
      // withGrantOption: req.body.withGrantOption,
      columnValue: req.body.columnValue,
    };
    console.log(data);
    const status = await roleModel.revokeRolePermission(
      data.rolename,
      data.privilege,
      data.tableName,
      // false,
      data.columnValue
    );

    res.json({ message: "success!" });
  } catch (e) {
    return res.status(500).json({ message: e });
  }
});

router.get("/update-role", authUser, async function (req, res) {
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

  res.render("vwRole/updateRole", {
    layout: "admin",
    roleNames,
    arrayColumns,
    layout: "admin",
    authUser: req.session.authUser,
  });
});
module.exports = router;
