{ div } = React.DOM

Grid = require('./components/Grid/index.coffee')

App = Component.create
  displayName: 'Sudoku:App'

  render: ->
    { grid, conflicts } = @props

    div {},
      Grid
        grid: grid
        conflicts: conflicts
        setNumber: @props.setNumber

module.exports = App

