{ div, h1, table, tbody } = React.DOM

Row = require('./Row')

module.exports = Component.create
  displayName: 'Grid'

  render: ->
    { grid, conflicts } = @props

    div {},
      h1 {}, 'React Sudoku'

      table
        cellSpacing: 0
        cellPadding: 2
        style: {
          margin: 'auto auto'
        },

        tbody {},
          _.map [0...9], (row) =>

            Row
              key: row
              row: row
              grid: grid
              conflicts: conflicts
              setNumber: @props.setNumber

