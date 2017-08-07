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
    previous: null,
    problem: null
  }
}

function nextSolver (solver, grid, problem) {
  return {
    grid: grid,
    isSolved: solver.isSolved,
    previous: solver,
    problem: problem
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
  if (solver.isSolved) {
    return true
  }

  return mappable(9).every((n) => {
    return isGridNumberSolved(solver.grid, n + 1)
  })
}

function markAsSolved (solver) {
  return Object.assign({}, solver, { isSolved: true })
}

function solveStepFromCandidates (solver) {
  // const nextPossibleCells =
  //   determineNextBestCandidates(solver)
  //
  // const index =
  //   nextPossibleCells
  //   .cellIndexes[Math.floor(
  //     nextPossibleCells.cellIndexes.length *
  //     Math.random()
  //   )]
  const index = solver.grid.reduce((memo, cell, idx) => {
    if (!memo && cell.number == null) {
      return idx
    } else {
      return memo
    }
  }, null)


  // console.log(
  //   "SolverModule.solveStep",
  //   nextPossibleCells,
  //   { unsolved: solver.grid.filter((cell) => cell.number == null) }
  // )

  const cell = solver.grid[index]
  const candidate =
    cell.candidates[Math.floor(
      cell.candidates.length *
      Math.random()
    )]

  const nextGrid =
    setGridNumber(
      solver.grid,
      index,
      candidate
    )

  const canContinueSolving =
    nextGrid.every((cell) => {
      return cell.number > 0 || cell.candidates.length > 0
    })

  console.log("can continue solving", canContinueSolving)

  if (canContinueSolving) {
    return {
      grid: nextGrid,
      isSolved: solver.isSolved,
      previous: solver
    }

  } else {
    const previousSolver =
      determinePreviousBestSolver(solver, { index: index, candidate: candidate })
    return solveStepFromCandidates(previousSolver)

  }
}

function determineNextBestCandidates (solver) {
  return solver.grid.reduce((memo, cell, idx) => {
    if (cell.candidates.length == memo.candidateCount) {
      return {
        candidateCount: memo.candidateCount,
        cellIndexes: memo.cellIndexes.concat(idx)
      }

    } else if (cell.candidates.length == 0) {
      return memo

    } else if (cell.candidates.length < memo.candidateCount) {
      return {
        candidateCount: cell.candidates.length,
        cellIndexes: [idx]
      }

    } else {
      return memo

    }
  }, { candidateCount: 9, cellIndexes: [] })
}


function determinePreviousBestSolver (solver) {
  const possibleCells =
    determineNextBestCandidates(solver)

  if (possibleCells.candidateCount > 1) {
    return solver
  } else {
    return determinePreviousBestSolver(solver.previous)
  }
}
