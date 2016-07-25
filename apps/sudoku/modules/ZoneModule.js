import _ from 'lodash'

export function createZoneExport (zoneIndexes) {
  const cellIndexToZone = function (cellIndex) {
    return _.findIndex(zoneIndexes, (indexList) => {
      return _.includes(indexList, cellIndex)
    })
  }

  const zoneToCellIndexes = function (zone) {
    return zoneIndexes[zone]
  }

  const cellIndexToZoneCellIndexes = function (cellIndex) {
    const index = cellIndexToZone(cellIndex)
    return zoneIndexes[index]
  }

  return {
    cellIndexToZone,
    zoneToCellIndexes,
    cellIndexToZoneCellIndexes
  }
}
