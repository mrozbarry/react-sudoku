import { createZoneExport } from './ZoneModule'

import _ from 'lodash'

const columnIndexes = [
  [0, 9,18,27,36,45,54,63,72]
  [1,10,19,28,37,46,55,64,73]
  [2,11,20,29,38,47,56,65,74]
  [3,12,21,30,39,48,57,66,75]
  [4,13,22,31,40,49,58,67,76]
  [5,14,23,32,41,50,59,68,77]
  [6,15,24,33,42,51,60,69,78]
  [7,16,25,34,43,52,61,70,79]
  [8,17,26,35,44,53,62,71,80]
]

export const zone = createZoneExport(columnIndexes)
