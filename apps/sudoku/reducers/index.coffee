
module.exports = (state, action) ->
  grid: require('./GridReducer')(state.grid, action)
  conflicts: require('./ConflictsReducer')(state.conflicts, action, state.grid)

