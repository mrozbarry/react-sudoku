import { zone } from '../../../../../apps/sudoku/modules/BoxModule'
import _ from 'lodash'

const expect = require('expect.js')

describe('BoxModule', () => {
  context('zone.zoneToCellIndexes', () => {
    it('returns an array', () => {
      expect(zone.zoneToCellIndexes(0)).to.be.an('array')
    })


    it('returns exactly 9 items for every index', () => {
      expect(zone.zoneToCellIndexes(0)).to.have.length(9)
      expect(zone.zoneToCellIndexes(1)).to.have.length(9)
      expect(zone.zoneToCellIndexes(2)).to.have.length(9)
      expect(zone.zoneToCellIndexes(3)).to.have.length(9)
      expect(zone.zoneToCellIndexes(4)).to.have.length(9)
      expect(zone.zoneToCellIndexes(5)).to.have.length(9)
      expect(zone.zoneToCellIndexes(6)).to.have.length(9)
      expect(zone.zoneToCellIndexes(7)).to.have.length(9)
      expect(zone.zoneToCellIndexes(8)).to.have.length(9)
    })


    it('returns falsey for every index outside 0...9', () => {
      expect(zone.zoneToCellIndexes(-1)).not.to.be.ok()
      expect(zone.zoneToCellIndexes(9)).not.to.be.ok()
    })


    const testCorrectIndexes = (boxNumber) => {
      const simpleRow = Math.floor(boxNumber / 3)
      const simpleColumn = boxNumber % 3
      const topLeft = (simpleRow * 27) + (simpleColumn * 3)

      const indexes = [0, 1, 2].reduce((boxIndexes, row) => {
        return boxIndexes.concat([0, 1, 2].map((col) => {
          return topLeft + col + (row * 9)
        }))
      }, []).sort((a, b) => a > b)

      it(`returns the correct box indexes for box number ${boxNumber}`, () => {
        const boxIndexes = zone.zoneToCellIndexes(boxNumber)
        const allSame = _.every(boxIndexes, function (index, idx) {
          return index === indexes[idx]
        })

        expect(allSame).to.be.ok()
      })
    }

    testCorrectIndexes(0)
    testCorrectIndexes(3)
    testCorrectIndexes(6)
  })
})
