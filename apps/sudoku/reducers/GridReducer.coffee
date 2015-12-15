highlightCells: (cells, action) ->
  # TODO
  _.map cells, (cell) ->
    cell

addCandidate: (cells, action) ->
  # TODO
  cells

setNumber: (cells, action) ->
  # TODO
  cells

module.exports = (cells, action) ->
  switch action.type
    when 'HIGHLIGHT_CELLS'
      highlightCells(cells, action)

    when 'ADD_CANDIDATE'
      addCandidate(cells, action)

    when 'SET_NUMBER'
      setNumber(cells, action)

    else
      cells
