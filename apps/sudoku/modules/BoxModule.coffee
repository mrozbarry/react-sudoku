_ = require('lodash')

offsetsOfBox = [
  0, 3, 6,
  27, 30, 33,
  54, 57, 60
]

boxIndexes = (boxNumber) ->
  topLeft = offsetsOfBox[boxNumber]
  _.reduce [0...3], ((cellIndexes, row) ->
    internalRow = _.map [0...3], (column) ->
      topLeft + (row * 9) + column
    cellIndexes.concat internalRow
  ), new Array()

boxCells = (boxNumber, grid) ->
  indexes = boxIndexes(boxNumber)
  _.map indexes, (index) ->
    grid[index]

boxFromIndex = (index) ->
  for boxNumber in [0...9]
    indexes = boxIndexes(boxNumber)
    return boxNumber if _.contains indexes, index

  return 0

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
