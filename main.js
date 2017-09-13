const electron = require('electron');
const {app, BrowserWindow, globalShortcut} = electron;

app.on('ready', () => {
  let win = new BrowserWindow({
    width: 800,
    height: 600,
    resizable: false
  });
  win.loadURL(`file://${__dirname}/html/index.html`);
  win.setMenu(null);
  win.webContents.openDevTools();
})
