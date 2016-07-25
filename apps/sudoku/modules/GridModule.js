import _ from 'lodash'

import mappable from 'lib/mappable'
import {
  emptyCell,
  addCellCandidate,
  removeCellCandidate,
  setCellNumber
} from './CellModule'

// function relatedCellIndexes (index) {
//   return _.reject(_.uniq(BoxModule.cellIndexToZoneCellIndexes(index)
//     .concat(rowCellIndexToZoneCellIndexes(index))
//     .concat(columnCellIndexToZoneCellIndexes(index))
//   ), (idx) => idx == index)
// }


export function emptyGrid () {
  return mappable(81).map(function (cell) {
    return emptyCell()
  })
}

export function isGridSolved (grid) {
  return _.all(grid, (cell) => cell.number > 0)
}

export function gridIndexesWithNumber (grid, number, indexes) {
  const localIndexes = indexes || mappable(81)

  return indexes.filter(function (gridIdx) {
    return grid[gridIdx].number === number
  })
}

export function setGridNumber (grid, index, number) {
  return grid.map(function (cell, idx) {
    if (idx === index) {
      return setCellNumber(cell, number)
    } else {
      // TODO: remove candidates
      return cell
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
