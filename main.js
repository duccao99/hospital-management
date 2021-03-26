const { app, BrowserWindow } = require("electron");
const path = require("path");

require("electron-handlebars")({
  // Template bindings go here!
  title: "Hello, World!",
  body: "The quick brown fox jumps over the lazy dog.",
});

function createWindow() {
  const win = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      preload: path.join(__dirname, "preload.js"),
    },
  });

  win.webContents.openDevTools();

  win.loadURL("http://localhost:1212/sign-in");

  //win.loadFile("./src/html&css/pages/examples/sign-in.html");
}

app.whenReady().then(() => {
  createWindow();

  app.on("activate", () => {
    if (BrowserWindow.getAllWindows().length === 0) {
      createWindow();
    }
  });
});

app.on("window-all-closed", () => {
  if (process.platform !== "darwin") {
    app.quit();
  }
});
