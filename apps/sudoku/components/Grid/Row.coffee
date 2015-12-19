{ tr, td } = React.DOM

Cell = require('./Cell')

module.exports = Component.create
  displayName: 'Grid:Row'

  getBorderStyleIf: (truthy) ->
    if truthy
      '1px black solid'
    else
      'none'

  render: ->
    { row, grid, conflicts } = @props

    rowStyles =
      borderTop: @getBorderStyleIf(row % 3 == 0)
      borderBottom: @getBorderStyleIf(row == 8)
      backgroundColor: 'white'
      textAlign: 'center'
      verticalAlign: 'middle'

    tr {},
      _.map [0...9], (column) =>
        index = (row * 9) + column

        tableDataStyle = _.extend {}, rowStyles,
          borderLeft: @getBorderStyleIf(column % 3 == 0)
          borderRight: @getBorderStyleIf(column == 8)

        if _.includes conflicts, index
          tableDataStyle.backgroundColor = 'red'

        td
          key: column
          style: tableDataStyle,

          Cell
            index: index
            cell: grid[index]
            setNumber: @props.setNumber

