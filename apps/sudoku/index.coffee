Provider = React.createFactory(ReactRedux.Provider)
Container = require('./container')

{ DevTools, DebugPanel, LogMonitor } = require('redux-devtools/lib/react')

store = require('./stores/SudokuStore')

ReactDOM.render(
  React.DOM.div({},
    Provider
      store: store,
      Container {}
  ),
  document.getElementById('app')
)

