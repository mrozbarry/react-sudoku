CellModule = require('../../../../apps/sudoku/modules/CellModule')
expect = require('expect.js')

describe 'CellModule', ->
  context 'empty', ->
    it 'returns an object with a candidates member being an empty array', ->
      cell = CellModule.empty()
      expect(cell.candidates).to.be.an('array')

    it 'returns an object with isLocked being a false', ->
      cell = CellModule.empty()
      expect(cell.isLocked).to.be.a('boolean')

    it 'returns an object with number being null', ->
      cell = CellModule.empty()
      expect(cell.number).to.be(null)

    it 'returns an object with only the valid members', ->
      cell = CellModule.empty()
      expect(cell).to.only.have.keys('candidates', 'isLocked', 'number')

  context 'addCandidate', ->
    it 'returns a copy of the cell', ->
      cell = CellModule.empty()
      nextCell = CellModule.addCandidate(cell, 1)
      expect(cell).not.to.equal(nextCell)

    it 'returns a copy of cell with the right attributes', ->
      cell = CellModule.empty()
      nextCell = CellModule.addCandidate(cell, 1)
      expect(nextCell).to.only.have.keys('candidates', 'isLocked', 'number')

    it 'adds a 1 to the candidates array', ->
      cell = CellModule.empty()
      nextCell = CellModule.addCandidate(cell, 1)
      expect(nextCell.candidates.length).to.equal(1)

    it 'does not change the candidates array if the number is already in the candidates array', ->
      cell = CellModule.empty()
      cell.candidates = [1]
      nextCell = CellModule.addCandidate(cell, 1)
      expect(cell.candidates.length).to.equal(nextCell.candidates.length)

    it 'throws an error when cell does not have a candidates array member', ->
      notACell = new Object()
      expect(CellModule.addCandidate).withArgs(notACell, 1).to.throwException()

    ['', null, undefined, true, 0, 10, false, new Object(), new Array()].forEach (invalidInput) ->
      it "throws an error when candidateNumber is a #{typeof(invalidInput)} (#{invalidInput})", ->
        cell = CellModule.empty()
        expect(CellModule.addCandidate).withArgs(cell, invalidInput).to.throwException()

    [1..9].forEach (validInput) ->
      it "does not throw when candidateNumber is #{validInput}", ->
        cell = CellModule.empty()
        expect(CellModule.addCandidate).withArgs(cell, validInput).not.to.throwException()

  context 'lock', ->
    it 'returns a copy of the cell', ->
      cell = CellModule.empty()
      cell.number = 1
      nextCell = CellModule.lock(cell)
      expect(cell).not.to.equal(nextCell)

    it 'returns a cell object', ->
      cell = CellModule.empty()
      cell.number = 1
      nextCell = CellModule.lock(cell)
      expect(nextCell).to.only.have.keys('candidates', 'isLocked', 'number')

    it 'does not set isLocked to true and returns cell if the number of the cell is null', ->
      cell = CellModule.empty()
      nextCell = CellModule.lock(cell)

      expect(nextCell.isLocked).not.to.be.ok()
      expect(cell).to.equal(nextCell)

  context 'setNumber', ->
    it 'returns a copy of the cell', ->
      cell = CellModule.empty()
      nextCell = CellModule.setNumber(cell, 1)
      expect(cell).not.to.equal(nextCell)

    it 'returns a cell object', ->
      cell = CellModule.empty()
      nextCell = CellModule.setNumber(cell, 1)
      expect(nextCell).to.only.have.keys('candidates', 'isLocked', 'number')

    it 'sets the number attribute', ->
      cell = CellModule.empty()
      nextCell = CellModule.setNumber(cell, 1)
      expect(nextCell.number).to.equal(1)

    it 'returns original cell when cell is locked', ->
      cell = CellModule.empty()
      cell.isLocked = true
      nextCell = CellModule.setNumber(cell, 2)
      expect(cell).to.equal(nextCell)


