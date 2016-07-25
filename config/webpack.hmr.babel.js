import Webpack from 'webpack'
import path from 'path'

import { ROOT_PATH } from './webpack-config/_paths.js'
import entries from './webpack-config/entries.js'
import module from './webpack-config/module.js'
import resolve from './webpack-config/resolve.js'
import plugins from './webpack-config/plugins.js'

export default {
  devtool: 'cheap-module-eval-source-map',
  entry: entries,
  output: {
    path: path.resolve(ROOT_PATH, 'public'),
    publicPath: '/',
    filename: 'bundle.js'
  },
  module: module,
  resolve: resolve,
  plugins: plugins.concat([
    new Webpack.HotModuleReplacementPlugin(),
    new Webpack.NoErrorsPlugin(),
    new Webpack.DefinePlugin({
      NODE_ENV: 'development'
    })
  ]),
  devServer: {
    inline: true,
    publicPath: '/',
    contentBase: path.resolve(ROOT_PATH, 'public')
  }
}
