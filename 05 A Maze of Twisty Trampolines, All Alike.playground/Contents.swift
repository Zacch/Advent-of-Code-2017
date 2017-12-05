
import UIKit

// Read input file into the lines array
var input = ""
let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
do {
    input = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
} catch let error1 as NSError  {
    print("fail: \(error1)")
}
let lines = input.split(separator: "\n")

var instructions: [Int] = []
// -------
for line in lines {
    instructions.append(Int(line)!)
}
let end = instructions.count
var steps = 0
var index = 0

repeat {
    let nextIndex = index + instructions[index]
    instructions[index] += 1
    index = nextIndex
    steps += 1
} while (index >= 0) && (index < end)

print("Part 1: \(steps)")

// -------
instructions = []
for line in lines {
    instructions.append(Int(line)!)
}
steps = 0
index = 0

repeat {
    let nextIndex = index + instructions[index]
    if (instructions[index] >= 3) {
        instructions[index] -= 1
    } else {
        instructions[index] += 1
    }
    index = nextIndex
    steps += 1
} while (index >= 0) && (index < end)

print("Part 2: \(steps)")
