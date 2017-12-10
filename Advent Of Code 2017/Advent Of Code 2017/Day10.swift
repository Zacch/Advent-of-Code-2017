//
//  Day10.swift
//  Advent Of Code 2017
//
//  Created by Rolf Staflin on 2017-12-10.
//  Copyright © 2017 Piro AB. All rights reserved.
//

import Foundation

class Day10 {
    
    let hexChars = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"]
    var size = 0
    var list:[Int] = []
    var position = 0
    var skip = 0

    func solve() {
        let inputString = "14,58,0,116,179,16,1,104,2,254,167,86,255,55,122,244"

        initialize(256)
        let part1Input = inputString.split(separator: ",").map {Int($0)!}
        hash(part1Input)
        print("Part 1: \(list[0] * list[1])")

        initialize(256)
        var part2Input = inputString.unicodeScalars.map { Int($0.value) }
        part2Input.append(contentsOf: [17, 31, 73, 47, 23])
        for _ in 0..<64 {
            hash(part2Input)
        }
        print("Part 2: \(compressHash())")
    }
 
    func initialize(_ size: Int) {
        self.size = size
        list = []
        for i in 0..<size {
            list.append(i)
        }
        position = 0
        skip = 0
    }

    func hash(_ input:[Int]) {
        for length in input {
            reverse(length)
            position = (position + length + skip) % size
            skip += 1
        }
    }

    func reverse(_ length:Int) {
        if position + length <= size {
            var result = Array(list[0 ..< position])
            result.append(contentsOf: list[position ..< position + length].reversed())
            result.append(contentsOf: list[(position + length)...])
            list = result
        } else {
            var toReverse = Array(list[position...])
            toReverse.append(contentsOf: list[0...((length - 1 + position) % size)])
            let reversed = Array(toReverse.reversed())

            var result = Array(reversed[(size - position)...])
            result.append(contentsOf: list[(position + length) % size ..< position])
            result.append(contentsOf: reversed[0 ... (size - position - 1)])
            if (list.count != result.count) {
                print("error!")
            }
            list = result
        }
    }
    
    func compressHash() -> String {
        var hash: [Int] = []
        for i in 0..<16 {
            var xorResult = list[i * 16]
            for j in 1..<16 {
                xorResult = xorResult ^ list[i * 16 + j]
            }
            hash.append(xorResult)
        }
        return hash.map { "\(hexChars[$0 / 16])\(hexChars[$0 % 16])" }.joined()
    }
}





















