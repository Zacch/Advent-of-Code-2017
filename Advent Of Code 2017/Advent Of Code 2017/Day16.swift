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

class Day16 {
    var moves: [String] = []
    
    func solve() {
        let input = Utils.readFile("Day16.txt")
        moves = input.split(separator: ",").map{String($0)}
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
            switch move.first! {
            case "s":
                let splitIndex = numberOfLetters - Int(move.dropFirst())!
                var newPositions = positions[splitIndex...]
                newPositions.append(contentsOf: positions[0 ..< splitIndex])
                positions = Array(newPositions)
                //print("s \(positions)")
            case "x":
                let args = move.dropFirst().split(separator: "/").map {Int($0)!}
                positions.swapAt(args[0], args[1])
                //print("x \(positions)")
            case "p":
                let args = move.dropFirst().split(separator: "/").map {positions.index(of: String($0))!}
                positions.swapAt(args[0], args[1])
                //print("p \(positions)")
            default:
                print("Error")
            }
        }
    }
    func getCurrentMillis()->Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
}
