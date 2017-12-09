//
//  Day09.swift
//  Advent Of Code 2017
//
//  Created by Rolf Staflin on 2017-12-09.
//  Copyright © 2017 Piro AB. All rights reserved.
//

import Cocoa

class Group {
    var start: String.Index
    var end: String.Index = "foo".endIndex
    var subgroups: [Group] = []
    var supergroup: Group? = nil
    var score: Int
    init(_ start: String.Index, score: Int) {
        self.start = start
        self.score = score
    }
}

class Day09: NSObject {


    func solve() {
        var input = ""
        let fileURL = URL(fileURLWithPath: "Day09.txt")
        do {
            input = try String(contentsOf: fileURL, encoding: String.Encoding.utf8)
        } catch let error as NSError  {
            print("fail: \(error)")
        }
        var totalScore = 0
        let topGroup = Group(input.startIndex, score:0)
        var currentGroup = topGroup
        var parsingGarbage = false
        var garbageCharacters = 0
        var index = input.startIndex
        repeat {
            switch input[index] {
            case "{":
                if parsingGarbage {
                    garbageCharacters += 1
                } else {
                    let newGroup = Group(index, score:currentGroup.score + 1)
                    totalScore += newGroup.score
                    newGroup.supergroup = currentGroup
                    currentGroup.subgroups.append(newGroup)
                    currentGroup = newGroup
                }
            case "}":
                if parsingGarbage {
                    garbageCharacters += 1
                } else {
                    currentGroup.end = index
                    currentGroup = currentGroup.supergroup!
                }
            case ",":
                if parsingGarbage {
                    garbageCharacters += 1
                }
            case "<":
                if parsingGarbage {
                    garbageCharacters += 1
                } else {
                    parsingGarbage = true
                }
            case ">":
                parsingGarbage = false
            case "!":
                index = input.index(after: index)
            default:
                if parsingGarbage {
                    garbageCharacters += 1
                }
            }
            
            index = input.index(after: index)
        } while index < input.endIndex
        print("Part 1: \(totalScore)")
        print("Part 2: \(garbageCharacters)")
    }
}
