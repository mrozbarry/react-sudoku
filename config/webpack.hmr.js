const Webpack = require("webpack")
const path = require("path")

const { ROOT_PATH } = require("./webpack-config/_paths.js")
const entries = require("./webpack-config/entries.js")
const modules = require("./webpack-config/module.js")
const resolve = require("./webpack-config/resolve.js")
const plugins = require("./webpack-config/plugins.js")

module.exports = {
  devtool: "cheap-module-eval-source-map",

  entry: entries,

  output: {
    path: path.resolve(ROOT_PATH, "public"),
    publicPath: "/",
    filename: "bundle.js"
  },

  module: modules,

  resolve: resolve,

  plugins: plugins.concat([
    new Webpack.HotModuleReplacementPlugin(),
    new Webpack.NoErrorsPlugin(),
    new Webpack.DefinePlugin({
      NODE_ENV: "development"
    })
  ]),

  devServer: {
    hot: true,
    inline: true,
    publicPath: "/",
    contentBase: path.resolve(ROOT_PATH, "public")
  }
}
