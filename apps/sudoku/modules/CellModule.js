import _ from 'lodash'

const VALID_CANDIDATES = [1, 2, 3, 4, 5, 6, 7, 8, 9]

function ascNumSort (arr) {
  return arr.sort((a, b) => a > b)
}

function validateNumber (value, description) {
  if (value === null) {
    return
  }

  if (!_.contains(VALID_CANDIDATES, value)) {
    throw new TypeError(`Expected ${description} to be ${VALID_CANDIDATES.join('/')}, got ${value}`)
  }
}

function addCandidate (candidates, number) {
  validateNumber(number, "Candidate")

  return ascNumSort(_.uniq(candidates.concat(number)))
}

function removeCandidate (candidates, number) {
  return _.reject(candidates, (candidate) => candidate === number)
}

export function cellValidateNumber (number, description) {
  const num = parseInt(number, 10)

  if (!_.contains(VALID_CANDIDATES, num)) {
    throw new Error(`${description || 'Number'} must be a number between 1 and 9 (${number} given)`)
  }
}

export function emptyCell () {
  return {
    candidates: [],
    isLocked: false,
    number: null
  }
}

export function isCellEmpty (cell) {
  return cell.number === null
}

export function addCellCandidate (cell, candidateNumber) {
  if ( cell.isLocked) {
    return cell
  }

  return Object.assign({}, cell, {
    candidates: addCandidate(cell.candidates, candidateNumber)
  })
}

export function removeCellCandidate (cell, candidateNumber) {
  if ( cell.isLocked) {
    return cell
  }

  return Object.assign({}, cell, {
    candidates: removeCandidate(cell.candidates, candidateNumber)
  })
}

export function removeAllCellCandidates (cell) {
  if ( cell.isLocked) {
    return cell
  }

  return Object.assign({}, cell, {
    candidates: []
  })
}

export function setCellNumber (cell, number) {
  if ( cell.isLocked) {
    return cell
  }

  return Object.assign({}, cell, {
    candidates: [],
    number: number
  })
}
