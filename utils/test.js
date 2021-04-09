function load(sql) {
  return function (user, pass) {
    console.log(user, pass, sql);
  };
}

load("abc")("a,", "ssd");
