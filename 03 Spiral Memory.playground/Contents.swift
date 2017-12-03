
import UIKit

/*
            34         31
    17  16  15  14  13
    18   5   4   3  12
    19   6   1   2  11 28
    20   7   8   9  10
    21  22  23  24  25 26

 eastAxis = highestInRingBefore + ring
 northAxis = highestInRingBefore + ring * 3
 westAxis = highestInRingBefore + ring * 5
 southAxis = highestInRingBefore + ring * 7

 */
func manhattanDistance(_ i: Int) -> Int {
    let ring = ringOf(i)
    let positionInRing = i - lowestNumberIn(ring: ring)
    let segment = positionInRing / (ring * 2)
    let segmentCenter = (lowestNumberIn(ring: ring) - 1) + (segment * 2 + 1) * ring
    let radialDistance = abs(segmentCenter - i)
    return ring + radialDistance
}

func ringOf(_ i: Int) -> Int {
    let j = sqrt(Double(i))
    return Int(ceil((j - 1) / 2))
}

func lowestNumberIn(ring: Int) -> Int {
    let i = ((ring - 1) * 2 + 1)
    return i * i + 1
}

print("Part 1: \(manhattanDistance(368078))")

//--------------------
class Point {
    let x: Int
    let y: Int
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    func turnLeft() -> Point {
        return Point(x:-y, y:x)
    }
}

func +=(left: inout Point, right: Point) {
    left = Point(x: left.x + right.x, y: left.y + right.y)
}

//----------
let origoIndex = 5
let arraySize = 2 * origoIndex + 1
var memory: [[Int]] = Array(repeating: Array(repeating: 0, count: arraySize), count: arraySize)

func get(_ p: Point) -> Int {
    return memory[p.x + origoIndex][p.y + origoIndex]
}

func put(_ p: Point, value: Int) {
    memory[p.x + origoIndex][p.y + origoIndex] = value
}

func getValue(_ p: Point) -> Int {
    let x = p.x + origoIndex
    let y = p.y + origoIndex
    return  memory[x-1][y-1] +
            memory[x  ][y-1] +
            memory[x+1][y-1] +
            memory[x-1][y] +
            memory[x+1][y] +
            memory[x-1][y+1] +
            memory[x  ][y+1] +
            memory[x+1][y+1]
}

//-----

var location = Point(x: 0, y: 0)
var value = 1
put(location, value: value)

var exit = false
for radius in 1...origoIndex-1 {
    location += Point(x: 1, y: -1)
    var direction = Point(x: 0, y: 1)
    for _ in 0...3 {
        for _ in 0..<(radius * 2) {
            location += direction
            value = getValue(location)
            put(location, value: value)
            if(value > 368078) {
                print("Part 2: \(value), at [\(location.x),\(location.y)]")
                exit = true
            }
            if (exit) {break}
        }
       direction = direction.turnLeft()
       if (exit) {break}
    }
    if (exit) {break}
}

//-------------

let formatter = NumberFormatter()
formatter.formatWidth = 7

for minusY in -origoIndex...origoIndex {
    var s = ""
    for x in -origoIndex...origoIndex {
        s += "\(formatter.string(from:get(Point(x:x, y:-minusY)) as NSNumber)!)"
    }
    print(s)
}
