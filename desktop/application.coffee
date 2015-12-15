electron = require 'electron'
{ crashReporter, app, BrowserWindow } = electron

crashReporter.start()

mainWindow = null

app.on 'window-all-closed', ->
  app.quit() unless process.platform == 'darwin'

app.on 'ready', ->
  mainWindow = new BrowserWindow(
    width: 398
    height: 600
  )

  mainWindow.loadURL(
    "file://#{__dirname}/../public/index.html"
  )

  mainWindow.on 'close', ->
    mainWindow = null
