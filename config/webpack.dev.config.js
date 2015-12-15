var base = require('./webpack.base.config.js');

base.output = {
  path: "./dist",
  publicPath: '/',
  filename: "bundle.js"
};

base.devServer = {
  port: process.env.PORT || 8080
};

module.exports = base;

