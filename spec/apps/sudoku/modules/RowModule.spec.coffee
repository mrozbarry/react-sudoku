RowModule = require('../../../../apps/sudoku/modules/RowModule')
expect = require('expect.js')

describe 'RowModule', ->
  context 'getRowNumberFromIndex', ->
    it 'returns a number', ->
      expect(RowModule.getRowNumberFromIndex(0)).to.be.a('number')

    [0...9].forEach (rowNumber) ->
      [0...9].forEach (columnNumber) ->
        index = (rowNumber * 9) + columnNumber
        it "returns the correct row number for index #{index}", ->
          expect(RowModule.getRowNumberFromIndex(index)).to.equal(rowNumber)

    it 'returns -1 for any number not in 0...81', ->
      [81, -1].forEach (outsideNumber) ->
        expect(RowModule.getRowNumberFromIndex(outsideNumber)).to.equal(-1)

  context 'getIndexesFromIndex', ->
    it 'returns an array', ->
      expect(RowModule.getIndexesFromIndex(0)).to.be.an('array')

    it 'returns exactly 9 items for every index', ->
      [0...81].forEach (index) ->
        expect(RowModule.getIndexesFromIndex(index)).to.have.length(9)

    it 'returns falsey for every index outside 0...81', ->
      [-1, 81].forEach (index) ->
        expect(RowModule.getIndexesFromIndex(index)).not.to.be.ok()

    [0...9].forEach (rowNumber) ->
      [0...9].forEach (columnNumber) ->
        index = (rowNumber * 9) + columnNumber
        indexes = [(rowNumber * 9)...((rowNumber * 9) + 9)]
        it "returns the correct row indexes for index #{index}", ->
          rowIndexes = RowModule.getIndexesFromIndex(index)
          allSame = true
          rowIndexes.forEach (index, idx) ->
            allSame &&= (index == indexes[idx])

          expect(allSame).to.be.ok()


  context 'getIndexesFromRowNumber', ->
    it 'returns an array', ->
      expect(RowModule.getIndexesFromRowNumber(0)).to.be.an('array')

    it 'returns exactly 9 items for every index', ->
      [0...9].forEach (rowNumber) ->
        expect(RowModule.getIndexesFromRowNumber(rowNumber)).to.have.length(9)

    it 'returns falsey for every index outside 0...9', ->
      [-1, 9].forEach (rowNumber) ->
        expect(RowModule.getIndexesFromRowNumber(rowNumber)).not.to.be.ok()

    [0...9].forEach (rowNumber) ->
      indexes = [(rowNumber * 9)...((rowNumber * 9) + 9)]
      it "returns the correct row indexes for row number #{rowNumber}", ->
        rowIndexes = RowModule.getIndexesFromRowNumber(rowNumber)
        allSame = true
        rowIndexes.forEach (index, idx) ->
          allSame &&= (index == indexes[idx])

        expect(allSame).to.be.ok()


