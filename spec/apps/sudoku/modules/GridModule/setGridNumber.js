import { emptyGrid, setGridNumber } from '../../../../../apps/sudoku/modules/GridModule'

const expect = require('expect.js')

describe('GridModule', () => {
  context('setGridNumber', () => {
    it('returns a new grid', () => {
      const grid = emptyGrid()
      const numberedGrid = setGridNumber(grid, 0, 1)
      expect(numberedGrid).to.be.an('array')
      expect(numberedGrid).to.have.length(81)
    })

    it('sets the grid cell .number to the correct number', () => {
      const grid = emptyGrid()
      const numberedGrid = setGridNumber(grid, 0, 1)
      expect(numberedGrid[0].number).to.equal(1)
    })

    it('removes the set number of a cell from candidates in the same box, row, and column', () => {
      const grid = emptyGrid()
      grid[1].candidates = [1]
      grid[8].candidates = [1]
      grid[72].candidates = [1]

      const numberedGrid = setGridNumber(grid, 0, 1)

      expect(numberedGrid[1].candidates).to.be.empty()
      expect(numberedGrid[8].candidates).to.be.empty()
      expect(numberedGrid[72].candidates).to.be.empty()
    })
  })
})

