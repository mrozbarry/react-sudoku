import gridReducer from './gridReducer'
import conflictsReducer from './conflictsReducer'

export default function (state, action) {
  return {
    grid: gridReducer(state.grid, action),
    conflicts: conflictsReducer(state.conflicts, action, state.grid)
  }
}

