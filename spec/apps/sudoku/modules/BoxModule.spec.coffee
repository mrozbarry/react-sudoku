BoxModule = require('../../../../apps/sudoku/modules/BoxModule')
expect = require('expect.js')
_ = require('lodash')

describe 'BoxModule', ->
  context 'getBoxNumberFromIndex', ->
    it 'returns a number', ->
      expect(BoxModule.getBoxNumberFromIndex(0)).to.be.a('number')

    [0...81].forEach (index) ->
      simpleColumn = Math.floor(index / 3) % 3
      simpleRow = Math.floor(index / 27) % 3
      boxNumber = simpleColumn + (simpleRow * 3)
      it "returns the correct box number (#{boxNumber}) for index #{index}", ->
        expect(BoxModule.getBoxNumberFromIndex(index)).to.equal(boxNumber)

    [-1, 81].forEach (outsideNumber) ->
      it "returns -1 for any number not in 0...81 (ie #{outsideNumber})", ->
        expect(BoxModule.getBoxNumberFromIndex(outsideNumber)).to.equal(-1)

  context 'getIndexesFromIndex', ->
    it 'returns an array', ->
      expect(BoxModule.getIndexesFromIndex(0)).to.be.an('array')

    it 'returns exactly 9 items for every index', ->
      [0...81].forEach (index) ->
        expect(BoxModule.getIndexesFromIndex(index)).to.have.length(9)

    it 'returns falsey for every index outside 0...81', ->
      [-1, 81].forEach (index) ->
        expect(BoxModule.getIndexesFromIndex(index)).not.to.be.ok()

    [0...81].forEach (index) ->
      simpleColumn = Math.floor(index / 3) % 3
      simpleRow = Math.floor(index / 27) % 3

      topLeft = (simpleRow * 27) + (simpleColumn * 3)
      indexes = _.reduce([0...3], ((boxIndexes, row) ->
        boxIndexes.concat _.map [0...3], (col) ->
          topLeft + col + (row * 9)
      ), new Array()).sort (a, b) -> a > b

      boxNumber = simpleColumn + (simpleRow * 3)
      it "returns the correct box indexes for index #{index}", ->
        boxIndexes = BoxModule.getIndexesFromIndex(index)
        allSame = true
        boxIndexes.forEach (index, idx) ->
          allSame &&= (index == indexes[idx])

        expect(allSame).to.be.ok()


  context 'getIndexesFromBoxNumber', ->
    it 'returns an array', ->
      expect(BoxModule.getIndexesFromBoxNumber(0)).to.be.an('array')

    it 'returns exactly 9 items for every index', ->
      [0...9].forEach (boxNumber) ->
        expect(BoxModule.getIndexesFromBoxNumber(boxNumber)).to.have.length(9)

    it 'returns falsey for every index outside 0...9', ->
      [-1, 9].forEach (boxNumber) ->
        expect(BoxModule.getIndexesFromBoxNumber(boxNumber)).not.to.be.ok()

    [0...9].forEach (boxNumber) ->
      simpleRow = Math.floor(boxNumber / 3)
      simpleColumn = boxNumber % 3

      topLeft = (simpleRow * 27) + (simpleColumn * 3)
      indexes = _.reduce([0...3], ((boxIndexes, row) ->
        boxIndexes.concat _.map [0...3], (col) ->
          topLeft + col + (row * 9)
      ), new Array()).sort (a, b) -> a > b

      it "returns the correct box indexes for box number #{boxNumber}", ->
        boxIndexes = BoxModule.getIndexesFromBoxNumber(boxNumber)
        allSame = true
        boxIndexes.forEach (index, idx) ->
          allSame &&= (index == indexes[idx])

        expect(allSame).to.be.ok()
