import { APPS_PATH } from './_paths'
import path from 'path'

export default {
  extensions: ['', '.js', '.sass'],
  root: [
    path.resolve(APPS_PATH, 'sudoku')
  ]
}
