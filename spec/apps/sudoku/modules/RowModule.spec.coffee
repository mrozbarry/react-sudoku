RowModule = require('../../../../apps/sudoku/modules/RowModule')
expect = require('expect.js')

describe 'RowModule', ->
  context 'cellIndexToZone', ->
    it 'returns a number', ->
      expect(RowModule.cellIndexToZone(0)).to.be.a('number')


    [0...9].forEach (rowNumber) ->
      [0...9].forEach (columnNumber) ->
        index = (rowNumber * 9) + columnNumber
        it "returns the correct row number for index #{index}", ->
          expect(RowModule.cellIndexToZone(index)).to.equal(rowNumber)


    it 'returns -1 for any number not in 0...81', ->
      [81, -1].forEach (outsideNumber) ->
        expect(RowModule.cellIndexToZone(outsideNumber)).to.equal(-1)


  context 'cellIndexToZoneCellIndexes', ->
    it 'returns an array', ->
      expect(RowModule.cellIndexToZoneCellIndexes(0)).to.be.an('array')


    it 'returns exactly 9 items for every index', ->
      [0...81].forEach (index) ->
        expect(RowModule.cellIndexToZoneCellIndexes(index)).to.have.length(9)


    it 'returns falsey for every index outside 0...81', ->
      [-1, 81].forEach (index) ->
        expect(RowModule.cellIndexToZoneCellIndexes(index)).not.to.be.ok()


    [0...9].forEach (rowNumber) ->
      [0...9].forEach (columnNumber) ->
        index = (rowNumber * 9) + columnNumber
        indexes = [(rowNumber * 9)...((rowNumber * 9) + 9)]
        it "returns the correct row indexes for index #{index}", ->
          rowIndexes = RowModule.cellIndexToZoneCellIndexes(index)
          allSame = true
          rowIndexes.forEach (index, idx) ->
            allSame &&= (index == indexes[idx])

          expect(allSame).to.be.ok()


  context 'zoneToCellIndexes', ->
    it 'returns an array', ->
      expect(RowModule.zoneToCellIndexes(0)).to.be.an('array')


    it 'returns exactly 9 items for every index', ->
      [0...9].forEach (rowNumber) ->
        expect(RowModule.zoneToCellIndexes(rowNumber)).to.have.length(9)


    it 'returns falsey for every index outside 0...9', ->
      [-1, 9].forEach (rowNumber) ->
        expect(RowModule.zoneToCellIndexes(rowNumber)).not.to.be.ok()


    [0...9].forEach (rowNumber) ->
      indexes = [(rowNumber * 9)...((rowNumber * 9) + 9)]
      it "returns the correct row indexes for row number #{rowNumber}", ->
        rowIndexes = RowModule.zoneToCellIndexes(rowNumber)
        allSame = true
        rowIndexes.forEach (index, idx) ->
          allSame &&= (index == indexes[idx])

        expect(allSame).to.be.ok()
