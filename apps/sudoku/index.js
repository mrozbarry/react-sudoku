import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import Container from './container.js'
import store from './stores/SudokuStore.js'

// { DevTools, DebugPanel, LogMonitor } = require('redux-devtools/lib/react')

require("./styles/index.sass")
require("./components/Grid/styles/index.sass")
require("./components/Grid/styles/row.sass")
require("./components/Grid/styles/cell.sass")

render(
  <div>
    <Provider store={store}>
      <Container />
    </Provider>
  </div>,
  document.getElementById('app')
)
