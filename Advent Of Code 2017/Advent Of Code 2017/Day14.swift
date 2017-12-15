//
//  Day14.swift
//  Advent Of Code 2017
//
//  Created by Rolf Staflin on 2017-12-14.
//  Copyright © 2017 Piro AB. All rights reserved.
//

import Foundation

let size = 128

class RegionFinder {
    
    func countRegions(_ squares: inout [[Bool]]) -> Int {
        var regions = 0
        
        for row in 0 ..< size {
            for col in 0 ..< size {
                if squares[row][col] {
                    regions += 1
                    clearRegion(&squares, row: row, col: col)
                }
            }
        }
        return regions
    }
    
    func clearRegion(_ squares: inout [[Bool]], row: Int, col: Int) {
        if (!squares[row][col]) {
            print("Error!")
        }
        squares[row][col] = false
        if row > 0 && squares[row - 1][col] {
            clearRegion(&squares, row: row - 1, col: col)
        }
        if col > 0 && squares[row][col - 1] {
            clearRegion(&squares, row: row, col: col - 1)
        }
        if row + 1 < size && squares[row + 1][col] {
            clearRegion(&squares, row: row + 1, col: col)
        }
        if col + 1 < size && squares[row][col + 1] {
            clearRegion(&squares, row: row, col: col + 1)
        }
    }
}

class Day14 {
    
    let oneCount = [0,1,1,2, 1,2,2,3, 1,2,2,3, 2,3,3,4]
    let bits:[[Bool]] = [[false, false, false, false],
                         [false, false, false,  true],
                         [false, false,  true, false],
                         [false, false,  true,  true],

                         [false,  true, false, false],
                         [false,  true, false,  true],
                         [false,  true,  true, false],
                         [false,  true,  true,  true],

                         [ true, false, false, false],
                         [ true, false, false,  true],
                         [ true, false,  true, false],
                         [ true, false,  true,  true],
                         
                         [ true,  true, false, false],
                         [ true,  true, false,  true],
                         [ true,  true,  true, false],
                         [ true,  true,  true,  true]]

    func solve() {

        let input = "hxtvlmkl"
        let hasher = Day10()

        var totalSquaresUsed = 0
        var squares: [[Bool]] = Array(repeating: [], count: size)
        for row in 0 ..< size {
            let hash = hasher.hashAndCompress("\(input)-\(row)")
            squares[row] = toBits(hash)
            totalSquaresUsed += countBits(hash)
        }
        print("Part 1: \(totalSquaresUsed)")

/*        var squares: [[Bool]] = Array(repeating: [], count: size)
        squares[0] = toBits("d4")
        squares[1] = toBits("55")
        squares[2] = toBits("06")
        squares[3] = toBits("ad")
        squares[4] = toBits("68")
        squares[5] = toBits("c8")
        squares[6] = toBits("80")
        squares[7] = toBits("c0")
        print(squares)
*/
        let finder = RegionFinder()
        print("Part 2: \(finder.countRegions(&squares))")
    }
    
    func countBits(_ hexString: String) -> Int {
        let asciiInput = hexString.unicodeScalars.map { Int($0.value) }
        var sum = 0
        for hex in asciiInput {
            sum += oneCount[toBase10(hex)]
        }
        return sum
    }
    
    func toBits(_ hexString:String) -> [Bool] {
        let asciiInput = hexString.unicodeScalars.map { Int($0.value) }
        var result: [Bool] = []
        for hex in asciiInput {
            result.append(contentsOf:  bits[toBase10(hex)])
        }
        return result
    }
    
    func toBase10(_ ascii:Int) -> Int {
        if ascii < 64 {
            return ascii - 48
        } else {
            return ascii - 87
        }
    }
}






