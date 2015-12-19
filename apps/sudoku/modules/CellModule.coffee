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

addCandidateNumber = (candidates, number) ->
  validateNumber(number, "Candidate")

  ascNumSort _.uniq(candidates.concat(number))

removeCandidateNumber = (candidates, number) ->
  _.reject candidates, (candidate) ->
    candidate == number

# Public code

module.exports =
  empty: ->
    candidates: new Array()
    isLocked: false
    number: null

  addCandidate: (cell, candidateNumber) ->
    _.assign {}, cell,
      candidates: addCandidateNumber(
        cell.candidates
        candidateNumber
      )

  removeCandidate: (cell, candidateNumber) ->
    _.assign {}, cell,
      candidates: removeCandidateNumber(
        cell.candidates
        candidateNumber
      )

  lock: (cell) ->
    return cell unless cell.number?
    _.assign {}, cell,
      isLocked: true

  setNumber: (cell, number) ->
    return cell if cell.isLocked == true

    validateNumber(number, "Cell number")
    _.assign {}, cell,
      number: number
      candidates: new Array()

