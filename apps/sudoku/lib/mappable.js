export default function (count, startAt) {
  const start = startAt || 0

  return Array.from(' '.repeat(count)).map(function (char, idx) {
    return start + idx
  })
}

