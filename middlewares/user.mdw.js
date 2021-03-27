function authUser(req, res, next) {
  console.log(req.session.authUser);
  if (req.session.authUser === undefined) {
    return res.redirect("/");
  }
  next();
}

module.exports = {
  authUser,
};
