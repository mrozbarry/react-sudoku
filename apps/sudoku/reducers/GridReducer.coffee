GridModule = require('../modules/GridModule')

setNumber = (grid, action) ->
  GridModule.setNumber(grid, action.index, action.number)

module.exports = (grid, action) ->
  switch action.type
    when 'SET_NUMBER'
      setNumber(grid, action)

    else
      grid
