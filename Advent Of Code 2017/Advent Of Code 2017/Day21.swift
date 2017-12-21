//
//  Day21.swift
//  Advent Of Code 2017
//
//  Created by Rolf Staflin on 2017-12-21.
//  Copyright © 2017 Piro AB. All rights reserved.
//

import Foundation

class Rule {
    let size: Int
    let pattern: [Character]
    let bitPatterns: Set<Int>
    let output: [Character]
    
    init(_ line: String) {
        let parts = line.components(separatedBy: " => ")
        size = (parts[0].count == 5 ? 2 : 3)
        pattern = parts[0].filter {$0 != "/"}
        output = parts[1].filter {$0 != "/"}
        bitPatterns = Rule.calculateBitPatterns(pattern)
    }
    
    func matches(_ input: [Character]) -> Bool {
        return input.count == pattern.count &&
            bitPatterns.contains(Rule.getBits(input))
    }

    static func calculateBitPatterns(_ chars: [Character]) -> Set<Int> {
        var current = chars
        var result: Set<Int> = []
        for _ in 0 ... 3 {
            result.insert(getBits(current))
            result.insert(getBits(flip(current)))
            current = rotate(current)
        }
        return result
    }

    static func getBits(_ chars: [Character]) -> Int {
        var result = 0
        for char in chars {
            result = result * 2 + (char == "#" ? 1 : 0)
        }
        return result
    }
    
    static func flip(_ matrix: [Character]) -> [Character] {
        if (matrix.count == 4) {
            return [matrix[1], matrix[0],
                    matrix[3], matrix[2]]
        }
        return [matrix[2], matrix[1], matrix[0],
                matrix[5], matrix[4], matrix[3],
                matrix[8], matrix[7], matrix[6]]
    }

    static func rotate(_ matrix: [Character]) -> [Character] {
        if (matrix.count == 4) {
            return [matrix[2], matrix[0],
                    matrix[3], matrix[1]]
        }
        return [matrix[6], matrix[3], matrix[0],
                matrix[7], matrix[4], matrix[1],
                matrix[8], matrix[5], matrix[2]]
    }
}

class Day21 {
    var rules: [Rule] = []
    var grid: [[Character]] = [[".", "#", "."], [".", ".", "#"], ["#", "#", "#"]]

    func solve() {
        rules = Utils.readFileLines("Day21.txt").map { Rule($0) }
        var gridSize = 3

        for i in 1 ... 18 {
            let squareSize = (gridSize % 2 == 0) ? 2 : 3
            let squaresPerRow = gridSize / squareSize
            let newGridSize = squaresPerRow * (squareSize + 1)
            var newGrid = Array(repeating: Array(repeating: Character(" "), count: newGridSize), count: newGridSize)
            for row in 0 ..< squaresPerRow {
                for col in 0 ..< squaresPerRow {
                    let bits = makePatternBits(squareSize, row: row, col: col)
                    for rule in rules {
                        if rule.bitPatterns.contains(bits) {
                            writeOutput(rule, to: &newGrid, row: row, col: col)
                            break;
                        }
                    }
                }
            }
            gridSize = newGridSize
            grid = newGrid
            if i == 5 {
                print("Part 1: \(grid.map{$0.filter{ $0 == "#"}}.joined().count)")
            }
        }
        print("Part 2: \(grid.map{$0.filter{ $0 == "#"}}.joined().count)")
    }
    
    func makePatternBits(_ size: Int, row: Int, col: Int) -> Int {
        var pattern: [Character] = []
        for r in row * size ..< (row + 1) * size {
            for c in col * size ..< (col + 1) * size {
                pattern.append(grid[r][c])
            }
        }
        return Rule.getBits(pattern)
    }
    
    func writeOutput(_ rule: Rule, to grid:inout [[Character]], row: Int, col: Int) {
        let newSize = rule.size + 1
        for r in 0 ..< newSize {
            for c in 0 ..< newSize {
                grid[row * newSize + r][col * newSize + c] = rule.output[r * newSize + c]
            }
        }
    }
}
