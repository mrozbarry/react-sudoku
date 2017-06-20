import { emptyGrid, isGridSolved, setGridNumber, isGridNumberSolved, gridGetCellIndexesWithCandidate, removeGridCandidate, gridCleanupCandidates } from './GridModule.js'
import { VALID_CANDIDATES, addCellCandidate } from './CellModule.js'
import { zone as boxZone } from './BoxModule.js'
import mappable from '../lib/mappable.js'
import _ from 'lodash'

export function solver () {
  return {
    grid: emptyGrid().map(function (cell, idx) {
      return _.reduce(VALID_CANDIDATES, function (nextCell, candidate) {
        return addCellCandidate(nextCell, candidate)
      }, cell)
    }),
    isSolved: false,
    previous: null
  }
}

function nextSolver (solver, nextGrid) {
  return {
    grid: nextGrid,
    isSolved: solver.isSolved,
    previous: solver
  }
}

export function hasSolveConflict (grid) {
  return grid.some((cell) => {
    return !cell.number && cell.candidates.length == 0
  })
}

export function createPuzzle () {
  const fillGrid = function (s) {
    if (s.isSolved) return s.grid

    if (s.grid.some((cell) => !cell.number && (cell.candidates.length == 0))) {
      throw new Error("Unable to solve in-memory puzzle")
    }

    return fillGrid(solveStep(s))
  }

  return fillGrid(solver())
}

export function solveStep (solver) {
  if (isSolved(solver)) {
    return markAsSolved(solver)
  }

  return solveStepFromCandidates(solver)
}

  function isSolved (solver) {
    return mappable(9).every((n) => {
      return isGridNumberSolved(solver.grid, n + 1)
    })
  }

  function markAsSolved (solver) {
    return Object.assign({}, solver, { isSolved: true })
  }

  function solveStepFromCandidates (solver) {
    //const boxOrder = [0, 4, 8, 1, 2, 3, 5, 6, 7]
    const boxOrder = mappable(9)
    const boxToSolve = boxOrder.reduce(function (firstUnsolvedBoxIdx, boxIdx) {
      if (firstUnsolvedBoxIdx >= 0) {
        return firstUnsolvedBoxIdx
      }

      const boxCellIdxs = boxZone.zoneToCellIndexes(boxIdx)
      const isBoxSolved = boxCellIdxs.every((cellIdx) => {
        return solver.grid[cellIdx].number > 0
      })

      if (isBoxSolved) {
        return firstUnsolvedBoxIdx
      } else {
        return boxIdx
      }
    }, undefined)

    return solveStepBox(solver, boxToSolve)
  }

  function solveStepBox (solver, boxIdx) {
    //console.log("solveStepBox", boxIdx)

    const emptyCellIndexes = boxZone.zoneToCellIndexes(boxIdx).filter(function (index) {
      return !solver.grid[index].number
    })

    const cellIdxs = _.sortBy(emptyCellIndexes, function (index) {
      return solver.grid[index].candidates.length
    })

    const cellIdx = cellIdxs[0]

    const number = _.shuffle(solver.grid[cellIdx].candidates)[0]

    //console.log(`solveStepBox: boxIdx=${boxIdx}, cellIdx=${cellIdx}, number=${number}`, solver.grid[cellIdx].candidates.join(","))

    return nextSolver(solver, setGridNumber(solver.grid, cellIdx, number)) //solver.grid[cellIdx].candidates[0]))
  }
