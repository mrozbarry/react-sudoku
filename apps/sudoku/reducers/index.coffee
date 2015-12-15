
module.exports = (state, action) ->
  grid: require('./GridReducer')(state.grid, action)
  cursor: require('./CursorReducer')(state.cursor, action)

