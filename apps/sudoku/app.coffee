{ div } = React.DOM

Grid = require('./components/Grid/index.coffee')

App = Component.create
  displayName: 'Sudoku:App'

  render: ->
    div {},
      Grid {}

module.exports = App

