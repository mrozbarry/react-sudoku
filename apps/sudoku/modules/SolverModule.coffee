_ = require('lodash')
MersenneTwister = require('mersennetwister')

RowModule = require('./RowModule')
ColumnModule = require('./ColumnModule')
BoxModule = require('./BoxModule')
GridModule = require('./GridModule')


SolverModule =
  context: (seed, grid) ->
    mt = new MersenneTwister(seed)

    randomNumber: (-> (mt.int() % 9) + 1)
    randomCell: (-> (mt.int() % 81))
    grid: grid
    isSolved: false
    solving: null


  solveStep: (context) ->
    if GridModule.isSolved(context.grid)
      return _.extend {}, context, isSolved: true

    if context.solving == null
      available = _.reduce context.solved, ((numbers, count, numberMinusOne) ->
        return numbers.concat(numberMinusOne + 1) if count < 9

      ), new Array()
      available = _.map context.solved, (count, numberMinusOne) ->

      number = context.randomNumber()



module.exports = SolverModule
