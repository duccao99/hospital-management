function authUser(req, res, next) {
  if (req.session.authUser === undefined) {
    return res.redirect("/");
  }

  res.locals.authUser = req.session.authUser;
  console.log(`User ${req.session.authUser.username} signed-in in the system!`);

  next();
}

module.exports = {
  authUser,
};
