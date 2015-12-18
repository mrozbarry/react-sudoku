{ devTools, persistState } = require('redux-devtools')

reducer = require('../reducers/index')

GridModule = require('../modules/GridModule')

initialState =
  grid: GridModule.empty()
  conflicts: new Array()

logger = (store) => (next) => (action) =>
  console.groupCollapsed(action.type)
  console.info('dispatching', action)
  result = next(action)
  console.log('next state', store.getState())
  console.groupEnd(action.type)

  result

compoundStore = Redux.compose(
  Redux.applyMiddleware(logger),
  devTools(),
  persistState(window.location.href.match(/[?&]debug_session=([^&]+)\b/))
)(Redux.createStore)

module.exports = compoundStore(reducer, initialState)
