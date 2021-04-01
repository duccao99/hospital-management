const express = require("express");
const path = require("path");
const server = express();
const expressHandleBars = require("express-handlebars");
const expressHandlebarsSections = require("express-handlebars-sections");
const morgan = require("morgan");
const bodyParser = require("body-parser");
const expressSession = require("express-session");
require("express-async-errors");

server.engine(
  "hbs",
  expressHandleBars({
    defaultLayout: "",
    extname: ".hbs",
    layoutsDir: "views/_layouts",
    partialsDir: "views/_partials",
    helpers: {
      section: expressHandlebarsSections(),
    },
  })
);

//server.use(morgan("dev"));
//server.use(express.json());
server.use(bodyParser.urlencoded({ extended: false }));
server.use(bodyParser.json());

server.set("view engine", "hbs");

server.use("/utils", express.static("utils"));
server.use(
  expressSession({
    secret: "sc",
    resave: false,
    saveUninitialized: true,
    authUser: {},
  })
);

server.use(express.static(path.join(__dirname, "./client/html&css")));

server.use(
  "/vendor",
  express.static(path.join(__dirname, "./client/html&css/vendor"))
);
server.use(
  "/css",
  express.static(path.join(__dirname, "./client/html&css/css"))
);
server.use(
  "/assets",
  express.static(path.join(__dirname, "./client/html&css/assets"))
);

server.use(require("./routes/admin.route"));
server.use(require("./routes/privilege.route"));
server.use(require("./routes/user.route"));
server.use(require("./routes/role.route"));

server.get("*", function (req, res) {
  res.render("vwError/404", {
    layout: "admin",
  });
});

server.use(function (er, req, res, next) {
  console.log(er.stack);
  res.join({ error_message: er });
});

const PORT = 1212;
server.listen(PORT, () => {
  console.log(`Server is listening at ${PORT}\nURL: http://localhost:1212/`);
});
