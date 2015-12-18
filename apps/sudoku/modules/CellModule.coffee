_ = require('lodash')

VALID_CANDIDATES = [1..9]

# Privates

validateNumber = (number, numberName) ->
  return if number == null
  num = parseInt(number)
  unless num && _.contains(VALID_CANDIDATES, num)
    throw new Error("#{numberName} must be a number between 1 and 9 (#{number} given)")

addCandidateNumber = (candidates, number) ->
  validateNumber(number, "Candidate")

  _.uniq(candidates.concat(number)).sort()

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

