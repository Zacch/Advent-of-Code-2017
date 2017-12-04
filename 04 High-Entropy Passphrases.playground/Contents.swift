
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

var numberofValidLines = 0

lines.forEach { line in
    let words = line.split(separator: " ")
    var wordSet: Set<String> = []
    var lineOK = true
    for word in words {
        if wordSet.contains(String(word)) {
            lineOK = false
            break
        } else {
            wordSet.insert(String(word))
        }
    }
    if lineOK {
        numberofValidLines += 1
    }
}
print("Part 1: \(numberofValidLines)")

// ----------

var numberofValidLines2 = 0

lines.forEach { line in
    let words = line.split(separator: " ")
    var wordSet: Set<String> = []
    var lineOK = true
    for word in words {
        var chars: [Character] = []
        for char in word {
            chars.append(char)
        }
        let sorted = String(chars.sorted())
        if wordSet.contains(String(sorted)) {
            lineOK = false
            break
        } else {
            wordSet.insert(String(sorted))
        }
    }
    if lineOK {
        numberofValidLines2 += 1
    }
}
print("Part 1: \(numberofValidLines2)")

