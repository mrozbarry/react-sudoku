BoxModule = require('../../../../apps/sudoku/modules/BoxModule')
expect = require('expect.js')
_ = require('lodash')


describe 'BoxModule', ->
  context 'zoneToCellIndexes', ->
    it 'returns an array', ->
      expect(BoxModule.zoneToCellIndexes(0)).to.be.an('array')


    it 'returns exactly 9 items for every index', ->
      [0...9].forEach (boxNumber) ->
        expect(BoxModule.zoneToCellIndexes(boxNumber)).to.have.length(9)


    it 'returns falsey for every index outside 0...9', ->
      [-1, 9].forEach (boxNumber) ->
        expect(BoxModule.zoneToCellIndexes(boxNumber)).not.to.be.ok()


    [0...9].forEach (boxNumber) ->
      simpleRow = Math.floor(boxNumber / 3)
      simpleColumn = boxNumber % 3

      topLeft = (simpleRow * 27) + (simpleColumn * 3)
      indexes = _.reduce([0...3], ((boxIndexes, row) ->
        boxIndexes.concat _.map [0...3], (col) ->
          topLeft + col + (row * 9)
      ), new Array()).sort (a, b) -> a > b

      it "returns the correct box indexes for box number #{boxNumber}", ->
        boxIndexes = BoxModule.zoneToCellIndexes(boxNumber)
        allSame = true
        boxIndexes.forEach (index, idx) ->
          allSame &&= (index == indexes[idx])

        expect(allSame).to.be.ok()


  context 'compact', ->
    it 'throws an error when nothing is passed', ->
      expect(BoxModule.compact).to.throwException()


    it 'returns an array', ->
      result = BoxModule.compact([])
      expect(result).to.be.an('array')


    it 'returns 0...9 when indexes is 0...81', ->
      result = BoxModule.compact([0...81])
      [0...9].forEach (boxNumber) ->
        expect(result).to.contain(boxNumber)


    it 'returns only 9 box numbers when indexes is 0...81', ->
      result = BoxModule.compact([0...81])
      expect(result).to.have.length(9)
