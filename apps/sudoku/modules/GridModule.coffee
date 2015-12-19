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

GridModule =
  empty: ->
    _.map [0...81], (cell) ->
      CellModule.empty()

  debug: (grid) ->
    _.map [0...9], (indexStart) ->
      _.map [0...9], (index) ->
        grid[(indexStart * 9) + index].number

  debugAll: (grid) ->
    _.map [0...9], (indexStart) ->
      _.map [0...9], (index) ->
        idx = (indexStart * 9) + index
        _.extend {index: idx}, grid[idx]

  setNumber: (grid, index, number) ->
    revokableIndexes = relatedIndexes(index)
    _.map grid, (cell, idx) ->
      if idx == index
        return CellModule.setNumber(cell, number)

      else if _.includes(revokableIndexes, idx) && cell.candidates.length > 0
        return CellModule.removeCandidate(cell, number)

      cell

  getConflicts: (grid) ->
    _.reduce grid, ((conflicts, cell, index) ->
      return conflicts if cell.number == null

      testableIndexes = relatedIndexes(index)

      cellConflicts = indexesOfCellsWithNumber(grid, cell.number, testableIndexes)

      _.uniq conflicts.concat(cellConflicts)
    ), new Array()

module.exports = GridModule
