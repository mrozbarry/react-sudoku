const { APPS_PATH } = require("./_paths")

module.exports = {
  loaders: [
    {
      test: /\.js$/,
      include: APPS_PATH,
      loader: "babel-loader"
    },
    {
      test: /\.sass$/,
      include: APPS_PATH,
      loader: "style-loader!css-loader!sass-loader?indentedSyntax"
    }
  ]
}
