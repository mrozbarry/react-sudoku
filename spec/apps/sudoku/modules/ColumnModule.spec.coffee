ColumnModule = require('../../../../apps/sudoku/modules/ColumnModule')
expect = require('expect.js')

describe 'ColumnModule', ->
  context 'cellIndexToZone', ->
    it 'returns a number', ->
      expect(ColumnModule.cellIndexToZone(0)).to.be.a('number')


    [0...9].forEach (rowNumber) ->
      [0...9].forEach (columnNumber) ->
        index = (rowNumber * 9) + columnNumber
        it "returns the correct column number for index #{index}", ->
          expect(ColumnModule.cellIndexToZone(index)).to.equal(columnNumber)


    it 'returns -1 for any number not in 0...81', ->
      [81, -1].forEach (outsideNumber) ->
        expect(ColumnModule.cellIndexToZone(outsideNumber)).to.equal(-1)


  context 'cellIndexToZoneCellIndexes', ->
    it 'returns an array', ->
      expect(ColumnModule.cellIndexToZoneCellIndexes(0)).to.be.an('array')


    it 'returns exactly 9 items for every index', ->
      [0...81].forEach (index) ->
        expect(ColumnModule.cellIndexToZoneCellIndexes(index)).to.have.length(9)


    it 'returns falsey for every index outside 0...81', ->
      [-1, 81].forEach (index) ->
        expect(ColumnModule.cellIndexToZoneCellIndexes(index)).not.to.be.ok()


    [0...9].forEach (rowNumber) ->
      [0...9].forEach (columnNumber) ->
        index = (rowNumber * 9) + columnNumber
        indexes = [0...9].map (columnRow) -> columnNumber + (columnRow * 9)
        it "returns the correct column indexes for index #{index}", ->
          columnIndexes = ColumnModule.cellIndexToZoneCellIndexes(index)
          allSame = true
          columnIndexes.forEach (index, idx) ->
            allSame &&= (index == indexes[idx])

          expect(allSame).to.be.ok()


  context 'zoneToCellIndexes', ->
    it 'returns an array', ->
      expect(ColumnModule.zoneToCellIndexes(0)).to.be.an('array')


    it 'returns exactly 9 items for every index', ->
      [0...9].forEach (columnNumber) ->
        expect(ColumnModule.zoneToCellIndexes(columnNumber)).to.have.length(9)


    it 'returns falsey for every index outside 0...9', ->
      [-1, 9].forEach (columnNumber) ->
        expect(ColumnModule.zoneToCellIndexes(columnNumber)).not.to.be.ok()


    [0...9].forEach (columnNumber) ->
      indexes = [0...9].map (columnRow) -> columnNumber + (columnRow * 9)
      it "returns the correct column indexes for column number #{columnNumber}", ->
        columnIndexes = ColumnModule.zoneToCellIndexes(columnNumber)
        allSame = true
        columnIndexes.forEach (index, idx) ->
          allSame &&= (index == indexes[idx])

        expect(allSame).to.be.ok()
