_ = require('lodash')

columnNumberFromIndex = (index) ->
  return -1 if index < 0 || index >= 81
  index % 9

columnIndexes = (column) ->
  _.map [0...9], (rowNumber) ->
    column + (rowNumber * 9)

columnCells = (column, grid) ->
  indexes = ColumnModule.fromColumn.columnIndexes(column)
  _.map indexes, (columnIndex) ->
    grid[columnIndex]

ColumnModule =
  fromIndex:
    columnIndexes: (index) ->
      columnNumber = columnNumberFromIndex(index)
      columnIndexes(columnNumber)

    columnCells: (index, grid) ->
      columnNumber = columnNumberFromIndex(index)
      columnCells(columnNumber, grid)

  fromColumn: ->
    columnIndexes: (column) ->
      columnIndexes(column)

    columnCells: (column, grid) ->
      columnCells(column, grid)

module.exports = ColumnModule
