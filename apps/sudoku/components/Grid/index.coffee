{ div, h1, table, tbody } = React.DOM

Row = require('./Row')

require('./styles/index.sass')

module.exports = Component.create
  displayName: 'Grid'

  render: ->
    { grid, conflicts } = @props

    bem = new Bemmer(block: 'grid')

    div
      className: bem.classes(),

      h1
        className: bem.with(element: 'header'),
        'React Sudoku'

      table
        className: bem.with(element: 'table'),

        tbody
          className: bem.with(element: 'table-tbody'),
          _.map [0...9], (row) =>

            Row
              key: row
              row: row
              grid: grid
              conflicts: conflicts
              setNumber: @props.setNumber

