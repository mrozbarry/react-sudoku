import { zone as boxZone } from '../../../../../apps/sudoku/modules/BoxModule'
import { zone as rowZone } from '../../../../../apps/sudoku/modules/RowModule'
import { zone as columnZone } from '../../../../../apps/sudoku/modules/ColumnModule'
import _ from 'lodash'

const expect = require('expect.js')

const zones = [
  { name: 'box', zone: boxZone, cellIndexToZoneTests: [[0, 0], [41, 4], [80, 8]] },
  { name: 'row', zone: rowZone, cellIndexToZoneTests: [[0, 0], [30, 3], [70, 7]] },
  { name: 'column', zone: columnZone, cellIndexToZoneTests: [[0, 0], [41, 5], [67, 4]] }
]

describe('ZoneModule', () => {
  for(let i=0; i < zones.length; i++) {
    const zoneTest = zones[i]
    const { zone } = zoneTest
    context('zone.cellIndexToZone', () => {
      it('returns a number', () => {
        expect(zone.cellIndexToZone(0)).to.be.a('number')
      })

      for(let t=0; t < zoneTest.cellIndexToZoneTests.length; t++) {
        const [test, result] = zoneTest.cellIndexToZoneTests[t]

        it(`returns the correct zone number (${result}) for index ${test}`, () => {
          expect(zone.cellIndexToZone(test)).to.equal(result)
        })
      }

      const testForNegativeOnes = (outsideNumber) => {
        it("returns -1 for any number not in 0...81 (ie #{outsideNumber})", () => {
          expect(zone.cellIndexToZone(outsideNumber)).to.equal(-1)
        })
      }

      testForNegativeOnes(-1)
      testForNegativeOnes(81)
    })
  }
})
