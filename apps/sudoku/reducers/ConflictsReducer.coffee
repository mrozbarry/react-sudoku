GridModule = require('../modules/GridModule')

getConflicts = (conflicts, action, grid) ->
  gridWithNumber = GridModule.setNumber(grid, action.index, action.number)
  GridModule.getConflicts(gridWithNumber)

module.exports = (conflicts, action, grid) ->
  switch action.type
    when 'SET_NUMBER'
      getConflicts(conflicts, action, grid)

    else
      conflicts
