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

  context 'addCandidate', ->
    it 'returns a new grid', ->
      grid = GridModule.addCandidate(GridModule.empty(), 0, 1)
      expect(grid).to.be.an('array')
      expect(grid).to.have.length(81)

    it 'adds a candidate to correct index', ->
      grid = GridModule.addCandidate(GridModule.empty(), 5, 1)
      expect(grid[5].candidates).to.contain(1)
      [0...5].forEach (index) ->
        expect(grid[index].candidates).not.to.contain(1)
      [6...81].forEach (index) ->
        expect(grid[index].candidates).not.to.contain(1)

  context 'removeCandidate', ->
    it 'returns a new grid', ->
      grid = GridModule.removeCandidate(GridModule.empty(), 0, 1)
      expect(grid).to.be.an('array')
      expect(grid).to.have.length(81)

    it 'removes a candidate from the correct index', ->
      gridWithCandidates = GridModule.empty().map (cell) ->
        cell.candidates = [1]
        cell

      grid = GridModule.removeCandidate(gridWithCandidates, 5, 1)

      expect(grid[5].candidates).not.to.contain(1)

      [0...5].forEach (index) ->
        expect(grid[index].candidates).to.contain(1)
      [6...81].forEach (index) ->
        expect(grid[index].candidates).to.contain(1)

  context 'getConflicts', ->
    it 'returns an array', ->
      conflicts = GridModule.getConflicts(GridModule.empty())
      expect(conflicts).to.be.an('array')

    it 'returns an empty array on an empty grid', ->
      conflicts = GridModule.getConflicts(GridModule.empty())
      expect(conflicts).to.be.empty()

    it 'returns an empty array when there are non-conflicting numbers on a grid', ->
      grid = GridModule.empty()
      grid[0].number = 1
      grid[1].number = 2
      conflicts = GridModule.getConflicts(grid)
      expect(conflicts).to.be.empty()

    it 'returns an array of [0, 1, 2] when those indexes contain the same number', ->
      grid = GridModule.empty()
      grid[0].number = 1
      grid[1].number = 1
      grid[2].number = 1
      conflicts = GridModule.getConflicts(grid)
      expect(conflicts).to.have.length(3)
      [0...3].forEach (conflictIndex) ->
        expect(conflicts).to.contain(conflictIndex)



