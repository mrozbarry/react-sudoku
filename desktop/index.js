const electron = require('electron')
const { crashReporter, app, BrowserWindow } = electron
const path = require('path')

crashReporter.start()

var mainWindow = null

app.on('window-all-closed', function () {
  app.quit() unless process.platform == 'darwin'
})

app.on('ready', function () {
  var mainWindow = new BrowserWindow({
    width: 398
    height: 600
  })

  mainWindow.loadURL('file://' + path.resolve(__dirname, '..', 'public', 'index.html'))

  mainWindow.on('close', function () {
    mainWindow = null
  })
})
