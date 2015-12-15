{ div, h1, table, tbody, tr, td, input } = React.DOM

module.exports = Component.create
  displayName: 'Grid'

  rejectInvalidKeys: (e) ->
    if e.keyCode >= 32
      key = String.fromCharCode(e.keyCode)
      unless key.match /[123456789]/gi
        e.preventDefault()

  render: ->
    div {},
      h1 {}, 'React Sudoku'

      table
        cellSpacing: 0
        cellPadding: 2,

        tbody {},
          _.map [0...9], (row) =>
            borderTop = 'none'
            borderBottom = 'none'

            if row % 3 == 0
              borderTop = '1px black solid'

            if row == 8
              borderBottom = '1px black solid'

            tr
              key: row,

              _.map [0...9], (column) =>
                borderLeft = 'none'
                borderRight = 'none'

                if column % 3 == 0
                  borderLeft = '1px black solid'

                if column == 8
                  borderRight = '1px black solid'

                td
                  key: column
                  style: {
                    borderTop: borderTop
                    borderBottom: borderBottom
                    borderLeft: borderLeft
                    borderRight: borderRight
                  },

                  input
                    defaultValue: ''
                    onKeyDown: @rejectInvalidKeys
                    style:
                      width: '32px'
                      height: '32px'
                      textAlign: 'center'

