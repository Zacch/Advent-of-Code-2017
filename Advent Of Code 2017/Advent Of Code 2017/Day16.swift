//
//  Day16.swift
//  Advent Of Code 2017
//
//  Created by Rolf Staflin on 2017-12-16.
//  Copyright © 2017 Piro AB. All rights reserved.
//

import Foundation

var positions = "abcdefghijklmnop"
let numberOfLetters = positions.count

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
        positions = String(positions.suffix(numberOfLetters - splitIndex) + positions.prefix(splitIndex))
    }
}
class Exchange: Move {
    let p1: Int
    let p2: Int
    let middleRange: NSRange
    init(_ s: String) {
        let args = s.split(separator: "/").map {Int($0)!}
        p1 = min(args[0], args[01])
        p2 = max(args[0], args[01])
        middleRange = NSMakeRange(p1, p2 - p1)
    }
    
    override func doIt() {
        var chars = Array(positions)
        chars.swapAt(p1, p2)
        positions = String(chars)
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
        var chars = Array(positions)
        let i1 = chars.index(of: c1)!
        let i2 = chars.index(of: c2)!

        chars.swapAt(i1, i2)
        positions = String(chars)
    }
}

class Day16 {
    var moves: [Move] = []
    
    func solve() {
        let input = Utils.readFile("Day16.txt")
        //let input = "s1,x3/4,pe/b"
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
        let startTime = getCurrentMillis()
        dance()
        print("Part 1: \(positions)")
        for i in 1 ..< 1000000000 {
            if i % 100 == 0 {
                print("\(i) iterations. Average \((getCurrentMillis() - startTime)  / Int64(i) ) milliseconds")
            }
            dance()
        }
        print("Part 2: \(positions)")
    }
    
    func dance() {
        for move in moves {
            move.doIt()
        }
    }
    func getCurrentMillis()->Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
}
