rowNumberFromIndex = (index) ->
  return -1 if index < 0 || index >= 81
  Math.floor(index / 9)

rowIndexes = (row) ->
  firstCellIndex = row * 9
  [firstCellIndex...(firstCellIndex + 9)]

rowCells = (row, grid) ->
  rowIndexes = rowIndexes(row)
  _.map rowIndexes, (rowIndex) ->
    grid[rowIndex]

RowModule =
  fromIndex:
    rowIndexes: (index) ->
      rowNumber = rowNumberFromIndex(index)
      rowIndexes(rowNumber)

    rowCells: (index, grid) ->
      rowNumber = rowNumberFromIndex(index)
      rowCells(rowNumber)

  fromRow: ->
    rowIndexes: (row) ->
      rowIndexes(row)

    rowCells: (row, grid) ->
      rowCells(row, grid)

module.exports = RowModule
