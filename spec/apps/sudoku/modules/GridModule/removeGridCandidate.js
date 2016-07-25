import { emptyGrid, removeGridCandidate } from '../../../../../apps/sudoku/modules/GridModule'

const expect = require('expect.js')

describe('GridModule', () => {
  context('removeGridCandidate', () => {
    it('returns a new grid', () => {
      const grid = removeGridCandidate(emptyGrid(), 0, 1)
      expect(grid).to.be.an('array')
      expect(grid).to.have.length(81)
    })

    it('removes a candidate from the correct index', () => {
      const gridWithCandidates = emptyGrid().map((cell) => {
        cell.candidates = [1]
        return cell
      })

      const grid = removeGridCandidate(gridWithCandidates, 5, 1)

      expect(grid[4].candidates).to.contain(1)
      expect(grid[5].candidates).not.to.contain(1)
      expect(grid[6].candidates).to.contain(1)
    })
  })
})


