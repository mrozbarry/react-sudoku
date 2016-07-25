import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import Container from './container'
import store from 'stores/SudokuStore'

// { DevTools, DebugPanel, LogMonitor } = require('redux-devtools/lib/react')

render(
  <div>
    <Provider store={store}>
      <Container />
    </Provider>
  </div>,
  document.getElementById('app')
)

