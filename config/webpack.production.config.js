var base = require('./webpack.base.config.js');

base.output = {
  path: "./dist",
  publicPath: '/',
  filename: "bundle.js"
};

module.exports = base;

