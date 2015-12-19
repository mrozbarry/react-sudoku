_ = require('lodash')

VALID_CANDIDATES = [1..9]

# Privates

validateNumber = (number, numberName) ->
  return if number == null
  num = parseInt(number)
  unless num && _.contains(VALID_CANDIDATES, num)
    throw new Error("#{numberName} must be a number between 1 and 9 (#{number} given)")

ascNumSort = (arr) ->
  arr.sort (a, b) -> a > b

addCandidate = (candidates, number) ->
  validateNumber(number, "Candidate")

  ascNumSort _.uniq(candidates.concat(number))

removeCandidate = (candidates, number) ->
  _.reject candidates, (candidate) ->
    candidate == number

# Public code

module.exports =
  empty: ->
    candidates: new Array()
    isLocked: false
    number: null

  addCandidate: (cell, candidateNumber) ->
    return cell if cell.isLocked

    _.assign {}, cell,
      candidates: addCandidate(
        cell.candidates
        candidateNumber
      )

  removeCandidate: (cell, candidateNumber) ->
    return cell if cell.isLocked

    _.assign {}, cell,
      candidates: removeCandidate(
        cell.candidates
        candidateNumber
      )

  removeAllCandidates: (cell) ->
    return cell if cell.isLocked

    _.assign {}, cell,
      candidates: new Array()

  lock: (cell) ->
    return cell unless cell.number?
    _.assign {}, cell,
      isLocked: true

  setNumber: (cell, number) ->
    return cell if cell.isLocked

    validateNumber(number, "Cell number")
    _.assign {}, cell,
      number: number
      candidates: new Array()

