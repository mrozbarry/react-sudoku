_ = require('lodash')

offsetsOfBox = _.reduce [0, 3, 6], ((offsets, columnOffset) ->
  columnOffsets = _.map [0, 3, 6], (rowOffset) ->
    row: rowOffset
    column: columnOffset
  offsets.concat columnOffsets
), new Array()

cellIndexesOfBox = (offsets = {row: 0, column: 0}) ->
  rowOffset = offsets.row || 0
  columnOffset = offsets.column || 0
  _.reduce [0, 9, 18], ((cellIndexes, rowIndexStart) ->
    internalCells = _.map [0...3], (column) ->
      rowIndexStart + rowOffset + column + columnOffset
    cellIndexes.concat internalCells
  ), new Array()

boxIndexes = (boxNumber) ->
  cellIndexesOfBox(offsetsOfBox[boxNumber])

boxCells = (boxNumber, grid) ->
  indexes = boxIndexes(boxNumber)
  _.map indexes, (index) ->
    grid[index]

boxFromIndex = (index) ->
  for boxNumber in [0...9]
    indexes = boxIndexes(boxNumber)
    return boxNumber if _.contains indexes, index

  return false

BoxModule =
  fromIndex:
    boxIndexes: (index) ->
      boxNumber = boxFromIndex(index)
      boxIndexes(boxNumber)

    boxCells: (index, grid) ->
      boxNumber = boxFromIndex(index)
      boxCells(boxNumber, grid)

  fromBox: ->
    boxIndexes: (box) ->
      boxIndexes(box)

    boxCells: (box, grid) ->
      boxCells(box, grid)

module.exports = BoxModule
