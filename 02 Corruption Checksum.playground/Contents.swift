
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

// -------

func divideIfEvenDivisor(x:Int, y:Int) -> Int {
    let a = Float(max(x, y)) / Float(min(x, y))
    return (floor(a) == a) ? Int(a) : 0
}

func findEvenDivision(_ numbers:[Int]) -> Int {
    if (numbers.count < 2) {
        return 0
    }
    let x = numbers[0]
    let rest = numbers[1..<numbers.count]
    var result = 0
    rest.forEach {y in
        let divisor = divideIfEvenDivisor(x: x, y: y)
        if (divisor > 0) {
            result = divisor
        }
    }
    return (result > 0) ? result : findEvenDivision(Array(rest))
}

// -------

var sumOfDifferences = 0
var sumOfEvenDivisors = 0

lines.forEach {row in
    let numbers = row.split(separator: " ").map {Int($0)!}
    var minimum = 99999
    var maximum = 0
    numbers.forEach{ number in
        minimum = min(minimum, number as Int)
        maximum = max(maximum, number)
    }
    sumOfDifferences += maximum - minimum
    sumOfEvenDivisors += findEvenDivision(numbers)
}
print("\nPart 1: \(sumOfDifferences)")
print("\nPart 2: \(sumOfEvenDivisors)")
