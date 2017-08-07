import React from 'react'

const { func } = React.PropTypes

export default function Actions (props) {
  const onGeneratePuzzle = (e) => {
    e.preventDefault()
    props.generatePuzzle()
  }

  const onClearPuzzle = (e) => {
    e.preventDefault()
    props.clearPuzzle()
  }

  return (
    <div className='actions'>
      <button onClick={onGeneratePuzzle}>Generate Puzzle</button>
      <button onClick={onClearPuzzle}>Clear Puzzle</button>
    </div>
  )
}

Actions.propTypes = {
  generatePuzzle: func.isRequired,
  clearPuzzle: func.isRequired
}
