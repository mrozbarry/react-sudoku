module.exports =
  setNumber: (index, number) ->
    type: 'SET_NUMBER'
    index: index
    number: number

  getConflicts: (index) ->
    type: 'GET_CONFLICTS'
    index: index
