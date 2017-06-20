// require('./styles/cell.sass')

import React from 'react'

const { number, object, func } = React.PropTypes

export default React.createClass({
  propTypes: {
    index: number.isRequired,
    cell: object.isRequired,
    setNumber: func.isRequired,
    addCandidate: func.isRequired,
    removeCandidate: func.isRequired
  },

  handleKeyDown (e) {
    const {
      index,
      cell,
      setNumber,
      addCandidate,
      removeCandidate
    } = this.props

    if (e.key == "Backspace") {
      setNumber(index, null)
      return
    }

    if (e.metaKey || e.ctrlKey || (e.key === 'Tab')) {
      return
    }

    e.preventDefault()

    const key = String.fromCharCode(e.keyCode)

    if (key.match(/[123456789]/gi)) {
      const number = parseInt(key, 10)

      if (e.shiftKey) {
        if (cell.number === null) {
          if (_.includes(cell.candidates, number)) {
            removeCandidate(index, number)
          } else {
            addCandidate(index, number)
          }
        }

      } else {
        setNumber(index, number)
      }
    }
  },

  render () {
    const { index, cell } = this.props

    if (cell.isLocked) {
      return (
        <strong className='cell-locked'>{cell.number}</strong>
      )
    } else {
      return (
        <input
          className='cell-unlocked'
          value={cell.number || ''}
          onKeyDown={this.handleKeyDown}
          placeholder={cell.candidates.join('')}
          />
      )
    }
  }
})
