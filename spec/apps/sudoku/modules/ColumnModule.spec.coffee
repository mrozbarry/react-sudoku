ColumnModule = require('../../../../apps/sudoku/modules/ColumnModule')
expect = require('expect.js')

describe 'ColumnModule', ->
  context 'getColumnNumberFromIndex', ->
    it 'returns a number', ->
      expect(ColumnModule.getColumnNumberFromIndex(0)).to.be.a('number')

    [0...9].forEach (rowNumber) ->
      [0...9].forEach (columnNumber) ->
        index = (rowNumber * 9) + columnNumber
        it "returns the correct column number for index #{index}", ->
          expect(ColumnModule.getColumnNumberFromIndex(index)).to.equal(columnNumber)

    it 'returns -1 for any number not in 0...81', ->
      [81, -1].forEach (outsideNumber) ->
        expect(ColumnModule.getColumnNumberFromIndex(outsideNumber)).to.equal(-1)

  context 'getIndexesFromIndex', ->
    it 'returns an array', ->
      expect(ColumnModule.getIndexesFromIndex(0)).to.be.an('array')

    it 'returns exactly 9 items for every index', ->
      [0...81].forEach (index) ->
        expect(ColumnModule.getIndexesFromIndex(index)).to.have.length(9)

    it 'returns falsey for every index outside 0...81', ->
      [-1, 81].forEach (index) ->
        expect(ColumnModule.getIndexesFromIndex(index)).not.to.be.ok()

    [0...9].forEach (rowNumber) ->
      [0...9].forEach (columnNumber) ->
        index = (rowNumber * 9) + columnNumber
        indexes = [0...9].map (columnRow) -> columnNumber + (columnRow * 9)
        it "returns the correct column indexes for index #{index}", ->
          columnIndexes = ColumnModule.getIndexesFromIndex(index)
          allSame = true
          columnIndexes.forEach (index, idx) ->
            allSame &&= (index == indexes[idx])

          expect(allSame).to.be.ok()


  context 'getIndexesFromColumnNumber', ->
    it 'returns an array', ->
      expect(ColumnModule.getIndexesFromColumnNumber(0)).to.be.an('array')

    it 'returns exactly 9 items for every index', ->
      [0...9].forEach (columnNumber) ->
        expect(ColumnModule.getIndexesFromColumnNumber(columnNumber)).to.have.length(9)

    it 'returns falsey for every index outside 0...9', ->
      [-1, 9].forEach (columnNumber) ->
        expect(ColumnModule.getIndexesFromColumnNumber(columnNumber)).not.to.be.ok()

    [0...9].forEach (columnNumber) ->
      indexes = [0...9].map (columnRow) -> columnNumber + (columnRow * 9)
      it "returns the correct column indexes for column number #{columnNumber}", ->
        columnIndexes = ColumnModule.getIndexesFromColumnNumber(columnNumber)
        allSame = true
        columnIndexes.forEach (index, idx) ->
          allSame &&= (index == indexes[idx])

        expect(allSame).to.be.ok()


