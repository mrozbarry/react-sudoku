import { connect } from 'react-redux'
import { setNumber, addCandidate, removeCandidate, getConflicts } from 'actions/GridActions'
import App from './app'

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
    }
  }
}

const connector = connect(((state) => state), mapDispatchToProps)

export default connector(App)
