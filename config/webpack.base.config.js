const Webpack = require("webpack");
const path = require('path');

module.exports = {
  entry: {
    sudoku: "./apps/sudoku/index.coffee"
  },

  module: {
    loaders: [
      { test: /\.sass$/, loader: "style-loader!css-loader!sass?indentedSyntax" }
    ]
  },
  resolve: {
    extensions: [".js", ".sass"]
  },
  plugins: [
    new Webpack.ProvidePlugin({
      "_": "lodash",
      "React": "react",
      "ReactDOM": "react-dom",

      "Redux": "redux",
      "ReactRedux": "react-redux",

      "Bemmer": "bemmer-node/bemmer-class.js",

      "Component": path.resolve(".", "lib", "local_modules", "component.coffee")
    })
  ]
};
