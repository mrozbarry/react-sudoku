import _ from 'lodash'
import { solver, solveStep } from '../apps/sudoku/modules/SolverModule.js'
import { emptyGrid, isGridSame } from '../apps/sudoku/modules/GridModule.js'
import { emptyCell, setCellNumber } from '../apps/sudoku/modules/CellModule.js'
import { zone as rowZone } from '../apps/sudoku/modules/RowModule.js'
import mappable from '../apps/sudoku/lib/mappable.js'

console.log("solving...")
outputGrid(solveNextStep(solver()))

function solveNextStep (solver) {
  outputGrid(solver.grid)
  console.log("")
  outputCandidates(solver.grid)

  if (solver.isSolved) {
    return solver.grid
  }

  if (solver.grid.some((cell) => !cell.number && (cell.candidates.length == 0))) {
    throw new Error("Found a cell with no number and no candidates!")
  }

  return solveNextStep(solveStep(solver))
}

function outputGrid (g) {
  const rows = mappable(9).map(function (rowNumber) {
    const indexes = rowZone.zoneToCellIndexes(rowNumber)

    return _.chunk(indexes, 3).map(function (numberGroup) {
      return numberGroup.map(function (index) {
        const cell = g[index]
        return cell && cell.number ? cell.number : "x"
      }).join(" ")
    }).join(" | ")
  })

  const chunkedRows = _.chunk(rows, 3).map(function (rowGroup) {
    return rowGroup.join("\n")
  }).join("\n------+-------+------\n")

  console.log(chunkedRows)

  console.log("\n")

  return g
}

function outputCandidates (g) {
  const rows = mappable(9).map(function (rowNumber) {
    const indexes = rowZone.zoneToCellIndexes(rowNumber)

    return _.chunk(indexes, 3).map(function (numberGroup) {
      return numberGroup.map(function (index) {
        const cell = g[index]
        return cell && cell.number ? `        ${cell.number}` : (mappable(9 - cell.candidates.length).map((n) => " ")).concat(cell.candidates).join("")
      }).join(" ")
    }).join(" | ")
  })

  const chunkedRows = _.chunk(rows, 3).map(function (rowGroup) {
    return rowGroup.join("\n")
  }).join("\n------------------------------+-------------------------------+------------------------------\n")

  console.log(chunkedRows)

  console.log("\n")

  return g
}
