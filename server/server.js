const express = require("express");
const server = express();

const PORT = 1212;

server.listen(PORT, () => {
  console.log(`Server is listening at ${PORT}`);
});
