import { APPS_PATH } from './_paths'

export default {
  loaders: [
    {
      test: /\.js$/,
      include: APPS_PATH,
      loader: 'babel'
    },
    {
      test: /\.sass$/,
      include: APPS_PATH,
      loader: 'style-loader!css-loader!sass?indentedSyntax'
    }
  ]
}
