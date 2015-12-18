{ input } = React.DOM

module.exports = Component.create
  displayName: 'Grid:Cell'

  rejectInvalidKeys: (e) ->
    if e.keyCode >= 32
      key = String.fromCharCode(e.keyCode)
      unless key.match /[123456789]/gi
        console.debug 'rejecting input'
        e.preventDefault()

  setNumber: (e) ->
    { index, cell } = @props

    value = e.target.value
    if value == ''
      @props.setNumber(index, null)

    else
      number = parseInt(value)
      if _.includes [1..9], number
        @props.setNumber(index, number)

      else
        @props.setNumber(index, cell.number)

  render: ->
    { index, cell, hasProblem } = @props

    input
      value: cell.number
      onKeyDown: @rejectInvalidKeys
      onChange: @setNumber
      onFocus: @focusCell,

      style:
        width: '32px'
        height: '32px'
        textAlign: 'center'

