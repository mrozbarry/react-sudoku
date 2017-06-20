const { APPS_PATH } = require("./_paths")
const path = require("path")

module.exports = {
  sudoku: [
    "babel-polyfill",
    "react-hot-loader/patch",
    path.resolve(APPS_PATH, "sudoku", "index.js")
  ]
}
