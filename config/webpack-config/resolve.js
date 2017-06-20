const { APPS_PATH, ROOT_PATH } = require("./_paths")
const path = require("path")

module.exports = {
  extensions: [".js", ".sass"],
  modules: [
    path.resolve(APPS_PATH, "sudoku"),
    path.resolve(ROOT_PATH, "node_modules")
  ]
}
