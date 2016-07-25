// { devTools, persistState } = require('redux-devtools')
import { compose, applyMiddleware, createStore } from 'redux'

import reducer from 'reducers/index'
import { emptyGrid } from 'modules/GridModule'

const initialState = {
  grid: emptyGrid(),
  conflicts: [],
  highlight: {
    index: null
  }
}

const logger = (store) => (next) => (action) => {
  console.groupCollapsed(action.type)
  console.info('dispatching', action)
  const result = next(action)
  console.log('next state', store.getState())
  console.groupEnd(action.type)

  return result
}

const compoundStore = compose(
  applyMiddleware(logger) //,
  // devTools(),
  // persistState(window.location.href.match(/[?&]debug_session=([^&]+)\b/))
)(createStore)

export default compoundStore(reducer, initialState)
