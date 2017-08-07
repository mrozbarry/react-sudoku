import React from 'react'
import Actions from './components/Actions/index.js'
import Grid from './components/Grid/index.js'

const { array, func } = React.PropTypes

var App = (props) => {
  const {
    grid,
    conflicts,
    setNumber,
    addCandidate,
    removeCandidate,
    generatePuzzle,
    clearPuzzle
  } = props

  return (
    <div>
      <Actions
        generatePuzzle={generatePuzzle}
        clearPuzzle={clearPuzzle}
        />
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

App.propTypes = {
  grid: array.isRequired,
  conflicts: array.isRequired,
  setNumber: func.isRequired,
  addCandidate: func.isRequired,
  removeCandidate: func.isRequired,
  generatePuzzle: func.isRequired,
  clearPuzzle: func.isRequired
}

export default App
