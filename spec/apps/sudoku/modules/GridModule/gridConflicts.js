import { emptyGrid, gridConflicts } from '../../../../../apps/sudoku/modules/GridModule'

const expect = require('expect.js')

describe('GridModule', () => {
  context('gridConflicts', () => {
    it('returns an array', () => {
      const conflicts = gridConflicts(emptyGrid())
      expect(conflicts).to.be.an('array')
    })

    it('returns an empty array on an empty grid', () => {
      const conflicts = gridConflicts(emptyGrid())
      expect(conflicts).to.be.empty()
    })

    it('returns an empty array when there are non-conflicting numbers on a grid', () => {
      const grid = emptyGrid()
      grid[0].number = 1
      grid[1].number = 2
      const conflicts = gridConflicts(grid)
      expect(conflicts).to.be.empty()
    })

    it('returns an array of [0, 1, 2] when those indexes contain the same number', () => {
      const grid = emptyGrid()
      grid[0].number = 1
      grid[1].number = 1
      grid[2].number = 1
      const conflicts = gridConflicts(grid)
      expect(conflicts).to.have.length(3)
      [0, 1, 2].forEach((conflictIndex) => expect(conflicts).to.contain(conflictIndex))
    })
  })
})
