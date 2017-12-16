//
//  Day16.swift
//  Advent Of Code 2017
//
//  Created by Rolf Staflin on 2017-12-16.
//  Copyright © 2017 Piro AB. All rights reserved.
//

import Foundation

var positions:[String] = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p"]
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
        var newPositions = positions[splitIndex...]
        newPositions.append(contentsOf: positions[0 ..< splitIndex])
        positions = Array(newPositions)
    }
}
class Exchange: Move {
    let p1: Int
    let p2: Int
    init(_ s: String) {
        let args = s.split(separator: "/").map {Int($0)!}
        p1 = args[0]
        p2 = args[1]
    }
    
    override func doIt() {
        positions.swapAt(p1, p2)
    }
}
class SwitchPlaces: Move {
    let p1: String
    let p2: String
    init(_ s: String) {
        let args = s.split(separator: "/").map {String($0)}
        p1 = args[0]
        p2 = args[1]
    }
    
    override func doIt() {
        positions.swapAt(positions.index(of: p1)!, positions.index(of: p2)!)
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
        let startTime = getCurrentMillis()
        dance()
        print("Part 1: \(positions.joined())")
        for i in 1 ..< 1000000000 {
            if i % 100 == 0 {
                print("\(i) iterations. Average \((getCurrentMillis() - startTime)  / Int64(i) ) milliseconds")
            }
            dance()
        }
        print("Part 2: \(positions.joined())")
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
