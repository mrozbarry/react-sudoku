import { zone } from '../../../../../apps/sudoku/modules/BoxModule'
import _ from 'lodash'

const expect = require('expect.js')

describe('BoxModule', () => {
  context('zone.cellIndexToZone', () => {
    it('returns an array', () => {
      expect(zone.cellIndexToZoneCellIndexes(0)).to.be.an('array')
    })


    it('returns exactly 9 items for any index', () => {
      expect(zone.cellIndexToZoneCellIndexes(0)).to.have.length(9)
      expect(zone.cellIndexToZoneCellIndexes(41)).to.have.length(9)
      expect(zone.cellIndexToZoneCellIndexes(80)).to.have.length(9)
    })


    it('returns falsey for every index outside 0...81', () => {
      expect(zone.cellIndexToZoneCellIndexes(-1)).not.to.be.ok()
      expect(zone.cellIndexToZoneCellIndexes(81)).not.to.be.ok()
    })

    const testBoxIndexes = (index) => {
      const simpleColumn = Math.floor(index / 3) % 3
      const simpleRow = Math.floor(index / 27) % 3

      const topLeft = (simpleRow * 27) + (simpleColumn * 3)
      const indexes = [0, 1, 2].reduce((boxIndexes, row) => {
        return boxIndexes.concat([0, 1, 2].map((col) => {
          return topLeft + col + (row * 9)
        }))
      }, []).sort((a, b) => a > b)

      const boxNumber = simpleColumn + (simpleRow * 3)

      it(`returns the correct box indexes for index ${index}`, () => {
        const boxIndexes = zone.cellIndexToZoneCellIndexes(index)
        const allSame = _.every(boxIndexes, (index, idx) => {
          return index === indexes[idx]
        })

        expect(allSame).to.be.ok()
      })
    }

    testBoxIndexes(0)
    testBoxIndexes(3)
    testBoxIndexes(6)
    testBoxIndexes(27)
    testBoxIndexes(30)
    testBoxIndexes(33)
  })
})
