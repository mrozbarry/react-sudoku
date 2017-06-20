import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import Container from './container.js'
import store from './stores/SudokuStore.js'

// { DevTools, DebugPanel, LogMonitor } = require('redux-devtools/lib/react')

if (this) {
  render(
    <div>
      <Provider store={store}>
        <Container />
      </Provider>
    </div>,
    document.getElementById('app')
  )
}
