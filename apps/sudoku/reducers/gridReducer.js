import { setGridNumber, addGridCandidate, removeGridCandidate } from 'modules/GridModule'

function setNumber (grid, action) {
  return setGridNumber(grid, action.index, action.number)
}

function addCandidate (grid, action) {
  return addGridCandidate(grid, action.index, action.number)
}

function removeCandidate (grid, action) {
  return removeGridCandidate(grid, action.index, action.number)
}

export default function (grid, action) {
  switch (action.type) {
  case 'SET_NUMBER':
    return setNumber(grid, action)

  case'ADD_CANDIDATE':
    return addCandidate(grid, action)

  case 'REMOVE_CANDIDATE':
    return removeCandidate(grid, action)

  default:
    return grid
  }
}
