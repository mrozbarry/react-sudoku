import gridReducer from "./gridReducer.js"
import conflictsReducer from "./conflictsReducer.js"

export default function (state, action) {
  return {
    grid: gridReducer(state.grid, action),
    conflicts: conflictsReducer(state.conflicts, action, state.grid)
  }
}

