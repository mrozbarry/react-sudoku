import { connect } from "react-redux"
import { setNumber, addCandidate, removeCandidate, getConflicts, generatePuzzle } from "./actions/GridActions.js"
import App from "./app.js"

const mapDispatchToProps = function (dispatch) {
  return {
    setNumber (index, number) {
      dispatch(setNumber(index, number))
    },

    addCandidate (index, number) {
      dispatch(addCandidate(index, number))
    },

    removeCandidate (index, number) {
      dispatch(removeCandidate(index, number))
    },

    generatePuzzle () {
      dispatch(generatePuzzle())
    }
  }
}

const connector = connect(((state) => state), mapDispatchToProps)

export default connector(App)
