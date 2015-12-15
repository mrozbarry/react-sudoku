GridModule = require('../apps/sudoku/modules/GridModule.coffee')
SolverModule = require('../apps/sudoku/modules/SolverModule.coffee')

grid = GridModule.empty()

solver = SolverModule.init(1)
console.log GridModule.debug SolverModule.solve(solver, grid, 0)
