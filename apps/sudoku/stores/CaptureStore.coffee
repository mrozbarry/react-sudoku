{ devTools, persistState } = require('redux-devtools')
thunk = require('redux-thunk')

reducer = require('../reducers/index')

GridModule = require('../modules/GridModule.coffee')

initialState =
  grid: GridModule.empty()
  cursor: new Object()

logger = (store) => (next) => (action) =>
  console.groupCollapsed(action.type)
  console.info('dispatching', action)
  result = next(action)
  console.log('next state', store.getState())
  console.groupEnd(action.type)

  result

compoundStore = Redux.compose(
  Redux.applyMiddleware(logger, thunk),
  devTools(),
  persistState(window.location.href.match(/[?&]debug_session=([^&]+)\b/))
)(Redux.createStore)

# module.exports = Redux.createStore(captureReducer, initialState)
module.exports = compoundStore(reducer, initialState)
