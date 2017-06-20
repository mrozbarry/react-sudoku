import { setGridNumber } from "../modules/GridModule.js"

function getConflicts (conflicts, action, grid) {
  const gridWithNumber = setGridNumber(grid, action.index, action.number)
  return [] // TODO
}

export default function (conflicts, action, grid) {
  switch (action.type) {
  case "SET_NUMBER":
    return getConflicts(conflicts, action, grid)

  default:
    return conflicts
  }
}
