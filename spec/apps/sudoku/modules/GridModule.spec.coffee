GridModule = require('../../../../apps/sudoku/modules/GridModule')
expect = require('expect.js')

describe 'GridModule', ->
  context 'empty', ->
    it 'returns an array', ->
      grid = GridModule.empty()
      console.log GridModule.debug(grid)
      expect(grid).to.be.an('array')

    it 'returns an array with 81 elements', ->
      grid = GridModule.empty()
      expect(grid.length).to.equal(81)

  # context 'indexesOfRow', ->
  #   it 'returns a list of integers', ->
  #     grid = GridModule.empty()
  #     rowIndexes = GridModule.indexesOfRow(0)
  #     expect(rowIndexes).to.be.an('array')
  #     expect(rowIndexes).to.have.length(9)
  #
  #   [[0...9],[9...18],[18...27],[27...36],[36...45],[45...54],[54...63],[63...72],[72...81]].forEach (knownIndexes, rowNumber) ->
  #     it 'has the correct row indexes', ->
  #       rowIndexes = GridModule.indexesOfRow(rowNumber)
  #       knownIndexes.forEach (rowIndex, idx) ->
  #         expect(rowIndex).to.equal(rowIndexes[idx])
  #
  #   it 'throws an error when the row is out of range', ->
  #     expect(GridModule.indexesOfRow).withArgs(-1).to.throwException()
  #     expect(GridModule.indexesOfRow).withArgs(9).to.throwException()
  #
  # context 'indexesOfColumn', ->
  #   [[0,9,18,27,36,45,54,63,72], [1,10,19,28,37,46,55,64,73]].forEach (knownIndexes, columnNumber) ->
  #     it 'has the correct column indexes', ->
  #       columnIndexes = GridModule.indexesOfColumn(columnNumber)
  #       knownIndexes.forEach (columnIndex, idx) ->
  #         expect(columnIndex).to.equal(columnIndexes[idx])
  #
  #   it 'throws an error when the column is out of range', ->
  #     expect(GridModule.indexesOfColumn).withArgs(-1).to.throwException()
  #     expect(GridModule.indexesOfColumn).withArgs(9).to.throwException()
  #
  # context 'indexesOfBox', ->
  #   [[0,1,2,9,10,11,18,19,20], [3,4,5,12,13,14,21,22,23]].forEach (knownIndexes, boxNumber) ->
  #     it 'has the correct box indexes', ->
  #       boxIndexes = GridModule.indexesOfBox(boxNumber)
  #       knownIndexes.forEach (boxIndex, idx) ->
  #         expect(boxIndex).to.equal(boxIndexes[idx])
  #
  #   it 'throws an error when the box is out of range', ->
  #     expect(GridModule.indexesOfBox).withArgs(-1).to.throwException()
  #     expect(GridModule.indexesOfBox).withArgs(9).to.throwException()
  #
  #
