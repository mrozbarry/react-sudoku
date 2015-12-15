_ = require('lodash')

CellModule = require('./CellModule')
RowModule = require('./RowModule')
ColumnModule = require('./ColumnModule')
BoxModule = require('./BoxModule')

GridModule =
  empty: ->
    _.map [0...81], (cell) ->
      CellModule.empty()

  debug: (grid) ->
    _.map [0...9], (indexStart) ->
      _.map [0...9], (index) ->
        grid[(indexStart * 9) + index].number

  setNumber: (grid, index, number) ->
    _.map grid, (cell, idx) ->
      if idx == index
        CellModule.setNumber(cell, number)

      else
        cell

module.exports = GridModule
