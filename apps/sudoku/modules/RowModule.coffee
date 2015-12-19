_ = require('lodash')

rowIndexes = [
  [0...9]
  [9...18]
  [18...27]
  [27...36]
  [36...45]
  [45...54]
  [54...63]
  [63...72]
  [72...81]
]

RowModule =
  getRowNumberFromIndex: (index) ->
    _.findIndex rowIndexes, (rowIndexList) ->
      _.includes rowIndexList, index

  getIndexesFromIndex: (index) ->
    _.find rowIndexes, (rowIndexList) ->
      _.includes rowIndexList, index

  getIndexesFromRowNumber: (rowNumber) ->
    rowIndexes[rowNumber]

module.exports = RowModule
