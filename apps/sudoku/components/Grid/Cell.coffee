{ strong, input } = React.DOM

module.exports = Component.create
  displayName: 'Grid:Cell'

  setNumberOrCandidate: (e) ->
    { index, cell } = @props

    if e.key == "Backspace"
      @props.setNumber(index, null)
      return

    return if e.metaKey || e.ctrlKey

    e.preventDefault()

    key = String.fromCharCode(e.keyCode)
    if key.match /[123456789]/gi
      if e.shiftKey && cell.number == null
        console.debug '[STUB] add candidate', key
        e.preventDefault()

      else
        @props.setNumber(index, parseInt(key))

  render: ->
    { index, cell, hasProblem } = @props

    if cell.isLocked
      strong {}, cell.number

    else
      input
        value: cell.number
        onKeyDown: @setNumberOrCandidate
        onFocus: @focusCell,

        style:
          width: '32px'
          height: '32px'
          textAlign: 'center'
          backgroundColor: 'transparent'

