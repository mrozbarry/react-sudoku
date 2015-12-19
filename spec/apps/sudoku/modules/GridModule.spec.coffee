GridModule = require('../../../../apps/sudoku/modules/GridModule')
expect = require('expect.js')

describe 'GridModule', ->
  context 'empty', ->
    it 'returns an array', ->
      grid = GridModule.empty()
      expect(grid).to.be.an('array')

    it 'returns an array with 81 elements', ->
      grid = GridModule.empty()
      expect(grid.length).to.equal(81)

  context 'debug', ->
    it 'returns an array', ->
      grid = GridModule.empty()
      expect(GridModule.debug(grid)).to.be.an('array')

    it 'returns an array with 9 elements', ->
      grid = GridModule.empty()
      expect(GridModule.debug(grid)).to.have.length(9)

    it 'returns an array with 9 elements, having 9 sub-elements', ->
      grid = GridModule.empty()
      debugGrid = GridModule.debug(grid)
      debugGrid.forEach (row) ->
        expect(row).to.have.length(9)

  context 'setNumber', ->
    it 'returns a new grid', ->
      grid = GridModule.empty()
      numberedGrid = GridModule.setNumber(grid, 0, 1)
      expect(numberedGrid).to.be.an('array')
      expect(numberedGrid).to.have.length(81)

    it 'sets the grid cell .number to the correct number', ->
      grid = GridModule.empty()
      numberedGrid = GridModule.setNumber(grid, 0, 1)
      expect(numberedGrid[0].number).to.equal(1)

    it 'removes the set number of a cell from candidates in the same box, row, and column', ->
      grid = GridModule.empty()
      grid[1].candidates = [1]
      grid[8].candidates = [1]
      grid[72].candidates = [1]

      numberedGrid = GridModule.setNumber(grid, 0, 1)

      [1, 8, 72].forEach (gridIdx) ->
        expect(numberedGrid[gridIdx].candidates).to.be.empty()

