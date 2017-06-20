//require('./styles/index.sass')

import React from 'react'
import Row from './Row.js'
import mappable from '../../lib/mappable.js'

const { array, func } = React.PropTypes

export default class Grid extends React.Component {
  render () {
    return (
      <div className='grid'>
        <h1 className='grid__header'>
          React Sudoku
        </h1>
        <table className='grid__table'>
          <tbody className='grid__table-tbody'>
            {this.renderRows()}
          </tbody>
        </table>
      </div>
    )
  }

  renderRows () {
    const {
      grid,
      conflicts,
      setNumber,
      addCandidate,
      removeCandidate
    } = this.props

    return mappable(9).map((row) => {
      return (
        <Row
          key={row}
          row={row}
          grid={grid}
          conflicts={conflicts}
          setNumber={setNumber}
          addCandidate={addCandidate}
          removeCandidate={removeCandidate}
          />
      )
    })
  }
}

Grid.propTypes = {
  grid: array.isRequired,
  conflicts: array.isRequired,
  setNumber: func.isRequired,
  addCandidate: func.isRequired,
  removeCandidate: func.isRequired
}
