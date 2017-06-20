function quickGridAction (type) {
  return function (index, number) {
    return {
      type: type,
      index: index,
      number: number
    }
  }
}

export const setNumber = quickGridAction('SET_NUMBER')

export const addCandidate = quickGridAction('ADD_CANDIDATE')

export const removeCandidate = quickGridAction('REMOVE_CANDIDATE')

export function getConflicts (index) {
  return {
    type: 'GET_CONFLICTS',
    index: index
  }
}

export function generatePuzzle () {
  return {
    type: 'GENERATE_PUZZLE'
  }
}
