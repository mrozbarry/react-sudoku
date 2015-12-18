_ = require('lodash')

CellModule = require('./CellModule')
RowModule = require('./RowModule')
ColumnModule = require('./ColumnModule')
BoxModule = require('./BoxModule')

indexesOfCellsWithNumber = (grid, number, indexes, excludeIndexes = new Array()) ->
  _.select indexes, (idx) ->
    return false if _.includes excludeIndexes, idx
    grid[idx].number == number

GridModule =
  empty: ->
    _.map [0...81], (cell) ->
      CellModule.empty()

  debug: (grid) ->
    _.map [0...9], (indexStart) ->
      _.map [0...9], (index) ->
        grid[(indexStart * 9) + index].number

  setNumber: (grid, index, number) ->
    _.map grid, (cell, idx) ->
      if idx == index
        CellModule.setNumber(cell, number)

      else
        cell

  getConflicts: (grid) ->
    _.reduce grid, ((conflicts, cell, index) ->
      return conflicts if cell.number == null

      testableIndexes = _.uniq BoxModule.fromIndex.boxIndexes(index).concat(
        RowModule.fromIndex.rowIndexes(index)
      ).concat(
        ColumnModule.fromIndex.columnIndexes(index)
      )

      cellConflicts = indexesOfCellsWithNumber(grid, cell.number, testableIndexes, [index])

      _.uniq conflicts.concat(cellConflicts)
    ), new Array()

module.exports = GridModule
