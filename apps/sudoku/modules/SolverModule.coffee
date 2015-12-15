_ = require('lodash')
MersenneTwister = require('mersennetwister')

RowModule = require('./RowModule')
ColumnModule = require('./ColumnModule')
BoxModule = require('./BoxModule')
GridModule = require('./GridModule')

possibleNumbersForIndex = (index, grid) ->
  return new Array() if index >= 81
  rowIndexes = RowModule.fromIndex.rowIndexes(index)
  columnIndexes = ColumnModule.fromIndex.columnIndexes(index)
  boxIndexes = BoxModule.fromIndex.boxIndexes(index)

  relatedIndexes = _.uniq(
    rowIndexes
      .concat(columnIndexes)
      .concat(boxIndexes)
  )

  relatedNumbers = _.reduce relatedIndexes, ((numbers, index) ->
    return numbers if grid[index].number == null
    numbers.concat(grid[index].number)
  ), new Array()

  _.reject [1..9], (number) -> _.includes relatedNumbers, number

seedShuffle = (input, solver) ->
  result = JSON.parse(JSON.stringify(input))
  _.each [0...(input.length * 2)], (iter) ->
    indexes = [
      solver() % result.length
      solver() % result.length
    ]
    storage = result[indexes[0]]
    result[indexes[0]] = result[indexes[1]]
    result[indexes[1]] = storage

  result

numberEmpty = (grid) ->
  _.sum grid, (cell) -> if cell.number == null then 1 else 0

SolverModule =
  init: (seed) ->
    mt = new MersenneTwister(seed)
    (-> mt.int())

  solve: (solver, grid, index = 0) ->
    return grid if index >= 81

    possibleNumbers = seedShuffle(
      possibleNumbersForIndex(index, grid)
      solver
    )

    if possibleNumbers.length == 9 && index == 0
      nextGrid = grid
      _.each possibleNumbers, (number, idx) ->
        nextGrid = GridModule.setNumber(nextGrid, idx, number)
      return SolverModule.solve(solver, nextGrid, 9)

    for number in possibleNumbers
      nextGrid = GridModule.setNumber(grid, index, number)
      console.log GridModule.debug nextGrid
      nextPossibiles = possibleNumbersForIndex(index + 1, grid)
      if nextPossibiles.length > 0
        result = SolverModule.solve(solver, nextGrid, index + 1)
        return result unless result == false
      else
        result = SolverModule.solve(solver, grid, index - 2)
        return result unless result == false

    return false

  allPossibilities: (grid) ->
    possibilities = _.compact _.map grid, (cell, idx) ->
      return null if cell.number > 0
      index: idx
      numbers: possibleNumbersForIndex(idx, grid)

    _.sortBy possibilities, (possibility) -> possibility.numbers.length

  resolve: (solver, grid, index) ->
    console.log GridModule.debug grid
    emptyCells = numberEmpty(grid)
    if emptyCells == 81
      number = _.first seedShuffle([1..9], solver)
      nextGrid = GridModule.setNumber(grid, index, number)
      possibilities = SolverModule.allPossibilities(grid)
      return SolverModule.resolve(solver, nextGrid, possibilities[0].index)

    else if emptyCells > 0
      numbers = possibleNumbersForIndex(index, grid)
      console.log numbers
      number = _.first seedShuffle(numbers, solver)
      nextGrid = GridModule.setNumber(grid, index, number)
      possibilities = SolverModule.allPossibilities(grid)
      if possibilities.length > 0
        return SolverModule.resolve(solver, nextGrid, possibilities[0].index)
      else
        return grid

    else
      return grid


module.exports = SolverModule
