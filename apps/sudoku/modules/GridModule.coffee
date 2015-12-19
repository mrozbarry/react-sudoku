_ = require('lodash')

CellModule = require('./CellModule')
RowModule = require('./RowModule')
ColumnModule = require('./ColumnModule')
BoxModule = require('./BoxModule')

relatedIndexes = (index) ->
  _.reject _.uniq(BoxModule.getIndexesFromIndex(index)
    .concat(RowModule.getIndexesFromIndex(index))
    .concat(ColumnModule.getIndexesFromIndex(index))
  ), (idx) -> idx == index

indexesOfCellsWithNumber = (grid, number, indexes) ->
  _.select indexes, (idx) ->
    grid[idx].number == number

mapGridToRows = (callback) ->
  _.map [0...9], (row) ->
    _.map [0...9], (column) ->
      index = (row * 9) + column

      callback(index, row, column)


GridModule =
  empty: ->
    _.map [0...81], (cell) ->
      CellModule.empty()

  debug: (grid) ->
    mapGridToRows (index, row, column) ->
      grid[index].number

  debugAll: (grid) ->
    mapGridToRows (index, row, column) ->
      _.extend {index: index}, grid[index]

  debugCandidates: (grid) ->
    mapGridToRows (index, row, column) ->
      grid[index].candidates.join('.')

  setNumber: (grid, index, number) ->
    revokableIndexes = relatedIndexes(index)
    _.map grid, (cell, idx) ->
      if idx == index
        return CellModule.setNumber(cell, number)

      else if _.includes(revokableIndexes, idx) && cell.candidates.length > 0
        return CellModule.removeCandidate(cell, number)

      cell

  addCandidate: (grid, index, candidate) ->
    _.map grid, (cell, idx) ->
      if idx == index
        return CellModule.addCandidate(cell, candidate)

      cell

  removeCandidate: (grid, index, candidate) ->
    _.map grid, (cell, idx) ->
      if idx == index
        return CellModule.removeCandidate(cell, candidate)

      cell

  resetAllCandidates: (grid) ->
    _.map grid, (cell, index) ->
      return cell if cell.isLocked

      nextCell = cell

      _.each cell.candidates, (candidate) ->
        nextCell = nextCell.removeCandidate(grid, index, candidate)

      nextCell

  resetAllNumbers: (grid) ->
    _.map grid, (cell) ->
      return cell if cell.isLocked
      CellModule.setNumber(cell, null)

  reset: (grid) ->
    _.map grid, (cell, index) ->
      return cell if cell.isLocked

  getConflicts: (grid) ->
    _.reduce grid, ((conflicts, cell, index) ->
      return conflicts if cell.number == null

      testableIndexes = relatedIndexes(index)

      cellConflicts = indexesOfCellsWithNumber(grid, cell.number, testableIndexes)

      _.uniq conflicts.concat(cellConflicts)
    ), new Array()

module.exports = GridModule
