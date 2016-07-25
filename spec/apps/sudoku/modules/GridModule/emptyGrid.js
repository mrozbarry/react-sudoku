import { emptyGrid } from '../../../../../apps/sudoku/modules/GridModule'

const expect = require('expect.js')

describe('GridModule', () => {
  context('emptyGrid', () => {
    it('returns an array', () => {
      const grid = emptyGrid()
      expect(grid).to.be.an('array')
    })

    it('returns an array with 81 elements', () => {
      const grid = emptyGrid()
      expect(grid.length).to.equal(81)
    })
  })
})
