import { emptyGrid, addGridCandidate } from '../../../../../apps/sudoku/modules/GridModule'

const expect = require('expect.js')

describe('GridModule', () => {
  context('addGridCandidate', () => {
    it('returns a new grid', () => {
      const grid = addGridCandidate(emptyGrid(), 0, 1)
      expect(grid).to.be.an('array')
      expect(grid).to.have.length(81)
    })

    it('adds a candidate to correct index', () => {
      const grid = addGridCandidate(emptyGrid(), 5, 1)

      expect(grid[4].candidates).not.to.contain(1)
      expect(grid[5].candidates).to.contain(1)
      expect(grid[6].candidates).not.to.contain(1)
    })
  })
})
