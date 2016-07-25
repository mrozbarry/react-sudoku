import React from 'react'
import Grid from './components/Grid/index'

const { array, func } = React.PropTypes

export default React.createClass({
  propTypes: {
    grid: array.isRequired,
    conflicts: array.isRequired,
    setNumber: func.isRequired,
    addCandidate: func.isRequired,
    removeCandidate: func.isRequired
  },

  render () {
    const {
      grid,
      conflicts,
      setNumber,
      addCandidate,
      removeCandidate
    } = this.props

    return (
      <div>
        <Grid
          grid={grid}
          conflicts={conflicts}
          setNumber={setNumber}
          addCandidate={addCandidate}
          removeCandidate={removeCandidate}
          />
      </div>
    )
  }
})
