const path = require("path")

const root = path.resolve(__dirname, "..", "..")

module.exports = {
  ROOT_PATH: root,
  APPS_PATH: path.resolve(root, "apps")
}
