//require('./styles/row')

import React from 'react'

import Cell from './Cell.js'

import mappable from '../../lib/mappable.js'

const { number, array, func } = React.PropTypes

export default class Row extends React.Component {
  // borderStyleIf (truthy) {
  //   return truthy
  //     ? '1px black solid'
  //     : undefined
  // },
  //
  // applyStyleIf (toggle, key, style) {
  //   return toggle
  //     ? Object.assign({}, style, { [key]: '1px black solid' })
  //     : style
  // },
  //
  // rowStyles (row, column) {
  //   // Sorry future @mrozbarry
  //   return this.applyStyleIf(
  //     row % 3 === 0,
  //     'borderTop',
  //     this.applyStyleIf(
  //       row === 8,
  //       'borderBottom',
  //       this.applyStyleIf(
  //         column % 3 === 0,
  //         'borderLeft',
  //         {}
  //         // this.applyStyleIf(
  //         //   column === 8,
  //         //   'borderRight',
  //         //   {}
  //         // )
  //       )
  //     )
  //   )
  // },

  render () {

    return (
      <tr>{this.renderCells()}</tr>
    )
  }

  renderCells () {
    const {
      row,
      grid,
      conflicts,
      setNumber,
      addCandidate,
      removeCandidate
    } = this.props

    return mappable(9).map((column) => {
      const index = (row * 9) + column

      return (
        <td key={column} className='row__cell'>
          <Cell
            index={index}
            cell={grid[index]}
            setNumber={setNumber}
            addCandidate={addCandidate}
            removeCandidate={removeCandidate}
            />
        </td>
      )
    })
  }
}

Row.propTypes = {
  row: number.isRequired,
  grid: array.isRequired,
  conflicts: array.isRequired,
  setNumber: func.isRequired,
  addCandidate: func.isRequired,
  removeCandidate: func.isRequired
}
