import React from 'react'

const { func } = React.PropTypes

export default React.createClass({
  propTypes: {
    generatePuzzle: func.isRequired
  },

  onGeneratePuzzle (e) {
    this.props.generatePuzzle()
  },

  render () {
    return (
      <div className='actions'>
        <button onClick={this.onGeneratePuzzle}>Generate Puzzle</button>
      </div>
    )
  }
})
