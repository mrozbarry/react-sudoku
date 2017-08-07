import _ from "lodash"

import mappable from "../lib/mappable.js"
import {
  emptyCell,
  addCellCandidate,
  removeCellCandidate,
  setCellNumber,
  isCellSame
} from "./CellModule.js"

import { zone as boxZone } from "./BoxModule.js"
import { zone as rowZone } from "./RowModule.js"
import { zone as columnZone } from "./ColumnModule.js"

export function relatedCellIndexes (index) {
  const boxIndexes = boxZone.cellIndexToZoneCellIndexes(index)
  if (!boxIndexes) {
    throw new Error(`relatedCellIndexes: index=${index}`)
    return []
  }

  const rowIndexes = rowZone.cellIndexToZoneCellIndexes(index)
  const colIndexes = columnZone.cellIndexToZoneCellIndexes(index)

  const relatedIndexes = _.uniq(
    boxIndexes
      .concat(rowIndexes)
      .concat(colIndexes)
  )

  return _.reject(relatedIndexes, function (idx) { return idx == index })
}

export function relatedCells (grid, index) {
  return relatedCellIndexes(index).map(function (cellIndex) {
    return grid[cellIndex]
  })
}

export function emptyGrid () {
  return mappable(81).map(function (cell) {
    return emptyCell()
  })
}

export function isGridSame (grid, otherGrid) {
  return grid.every((cell, idx) => {
    return isCellSame(cell, otherGrid[idx])
  })
}

export function isGridSolved (grid) {
  return grid.every((cell) => cell.number > 0)
}

export function isGridNumberSolved (grid, number) {
  const cellIndexes = grid.reduce(function (indexes, cell, idx) {
    if (cell.number == number) {
      return indexes.concat(idx)
    }
    return indexes
  }, [])

  if (cellIndexes.length != 9) {
    return false
  }

  // Check that no indexes are in conflict with the source index
  // return _.all(cellIndexes, function (cellIndex) {
  //   return _.all(relatedCellIndexes(cellIndex), function (subIndex) {
  //     return !cellIndexes.indexOf(subIndex)
  //   })
  // })
  return true
}

function zoneBoxesAlongRow (boxIndex) {
  switch (boxIndex) {
    case 0:
      return [1, 2]
    case 1:
      return [0, 2]
    case 2:
      return [0, 1]
    case 3:
      return [4, 5]
    case 4:
      return [3, 5]
    case 5:
      return [3, 4]
    case 6:
      return [7, 8]
    case 7:
      return [6, 8]
    case 8:
      return [6, 7]
  }
}

function zoneBoxesAlongColumn (boxIndex) {
  switch (boxIndex) {
    case 0:
      return [3, 6]
    case 1:
      return [4, 7]
    case 2:
      return [5, 8]
    case 3:
      return [0, 6]
    case 4:
      return [1, 7]
    case 5:
      return [2, 8]
    case 6:
      return [0, 3]
    case 7:
      return [1, 4]
    case 8:
      return [2, 5]
  }
}

export function gridCleanupCandidates (grid) {
  return _.reduce(mappable(9), function (nextGrid, boxIndex) {
    return gridCleanupBoxCandidates(nextGrid, boxIndex)
  }, grid)
}

  function gridCleanupBoxCandidates (grid, boxIndex) {
    const boxIndexes = boxZone.zoneToCellIndexes(boxIndex)

    return _.reduce(boxIndexes, function (nextGrid, cellIndex) {
      if (nextGrid[cellIndex].candidates.length) {
        return gridCleanupCandidatesFromCellIndex(nextGrid, boxIndex, cellIndex)
      } else {
        return nextGrid
      }
    }, grid)
  }

  function gridCleanupCandidatesFromCellIndex (grid, boxIndex, cellIndex) {
    const candidates = grid[cellIndex].candidates
    return _.reduce(candidates, function (nextGrid, candidate) {
      return gridCleanupCandidateAtCell(nextGrid, candidate, boxIndex, cellIndex)
    }, grid)
  }

  function gridCleanupCandidateAtCell (grid, candidate, boxIndex, cellIndex) {
    // const otherIndexes = _.reject(boxZone.zoneToCellIndexes(boxIndex), function (index) {
    //   const isSet = grid[index].number > 0
    //   const noCandidate = !_.includes(grid[index].candidates, candidate)
    //   return isSet || noCandidate
    // })
    //
    // if (allCellIndexesInSameZone(rowZone, otherIndexes)) {
    //   const rowIdx = rowZone.cellIndexToZone(otherIndexes[0])
    //   return gridCleanupRemoveCandidates(grid, candidate, rowZone, rowIdx, otherIndexes)
    //
    // } else if (allCellIndexesInSameZone(columnZone, otherIndexes)) {
    //   const columnIdx = columnZone.cellIndexToZone(otherIndexes[0])
    //   return gridCleanupRemoveCandidates(grid, candidate, columnZone, columnIdx, otherIndexes)
    //
    // } else {
    //   return grid
    // }
    return grid
  }

  function allCellIndexesInSameZone (zone, cellIndexes) {
    return cellIndexes.every((cellIndex) => {
      return rowZone.cellIndexToZone(cellIndex)
    })
  }

  function gridCleanupRemoveCandidates (grid, candidate, zone, zoneIndex, rejectIndexes) {
    const cellIndexes = zone.zoneToCellIndexes(zoneIndex)

    return _.reduce(cellIndexes, function (nextGrid, cellIndex) {
      if (_.includes(rejectIndexes, cellIndex)) {
        return nextGrid
      } else {
        return removeGridCandidate(nextGrid, cellIndex, candidate)
      }
    }, grid)
  }


export function gridGetCellIndexesWithCandidate (grid, candidate) {
  return grid.reduce(function (matchingIndexes, cell, index) {
    if (cell.candidates.indexOf(candidate) >= 0) {
      return matchingIndexes.concat(index)
    }
    return matchingIndexes
  }, [])
}

export function gridIndexesWithNumber (grid, number, indexes) {
  const localIndexes = indexes || mappable(81)

  return indexes.filter(function (gridIdx) {
    return grid[gridIdx].number === number
  })
}

export function setGridNumber (grid, index, number) {
  const related = relatedCellIndexes(index)
  return grid.map(function (cell, idx) {
    if (idx === index) {
      return setCellNumber(cell, number)
    } else {
      if (_.includes(related, idx)) {
        return removeCellCandidate(cell, number)
      } else {
        return cell
      }
    }
  })
}

export function addGridCandidate (grid, index, candidate) {
  return grid.map(function (cell, idx) {
    if (idx === index) {
      return addCellCandidate(cell, candidate)
    }

    return cell
  })
}


export function addGridCandidates (grid, index, candidates) {
  return grid.map(function (cell, idx) {
    if (idx === index) {
      return Object.assign({}, cell, {
        candidates: candidates
      })
    }

    return cell
  })
}

export function removeGridCandidate (grid, index, candidate) {
  return grid.map(function (cell, idx) {
    if (idx === index) {
      return removeCellCandidate(cell, candidate)
    }

    return cell
  })
}

export function gridConflicts (grid) {
  return []
}
