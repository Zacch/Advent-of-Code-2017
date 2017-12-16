//
//  Day16.swift
//  Advent Of Code 2017
//
//  Created by Rolf Staflin on 2017-12-16.
//  Copyright © 2017 Piro AB. All rights reserved.
//

import Foundation

var positions: [Character] = Array("abcdefghijklmnop")
let numberOfLetters = positions.count
var savedPositions: [String] = []

// Base class for the dance moves
class Move {
    func doIt() {}
}

class Swap: Move {
    let splitIndex: Int
    init(_ s: String) {
        splitIndex = numberOfLetters - Int(s)!
    }
    
    override func doIt() {
        positions = Array(positions.suffix(numberOfLetters - splitIndex) +
                          positions.prefix(splitIndex))
    }
}
class Exchange: Move {
    let p1: Int
    let p2: Int
    init(_ s: String) {
        let args = s.split(separator: "/").map {Int($0)!}
        p1 = min(args[0], args[01])
        p2 = max(args[0], args[01])
    }
    
    override func doIt() {
        positions.swapAt(p1, p2)
    }
}
class SwitchPlaces: Move {
    let c1: Character
    let c2: Character
    init(_ s: String) {
        let args = s.split(separator: "/").map {String($0)}
        c1 = args[0].first!
        c2 = args[1].first!
    }
    
    override func doIt() {
        let i1 = positions.index(of: c1)!
        let i2 = positions.index(of: c2)!
        positions.swapAt(i1, i2)
    }
}

class Day16 {
    var moves: [Move] = []
    
    func solve() {
        let input = Utils.readFile("Day16.txt")
        let moveStrings = input.split(separator: ",")
        for s in moveStrings {
            switch s.first! {
            case "s":
                moves.append(Swap(String(s.dropFirst())))
            case "x":
                moves.append(Exchange(String(s.dropFirst())))
            case "p":
                moves.append(SwitchPlaces(String(s.dropFirst())))
            default:
                print("Error")
            }
        }

        savedPositions.append(String(positions))
        dance()
        savedPositions.append(String(positions))
        print("Part 1: \(String(positions))")

        for i in 2... {
            dance()
            let s = String(positions)
            if (savedPositions.contains(s)) {
                print("Part 2: \(savedPositions[1000000000 % i])")
                exit(0)
            }
            savedPositions.append(s)
        }
    }

    func dance() {
        for move in moves {
            move.doIt()
        }
    }
}
