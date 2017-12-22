//
//  Day22.swift
//  Advent Of Code 2017
//
//  Created by Rolf Staflin on 2017-12-22.
//  Copyright © 2017 Piro AB. All rights reserved.
//

import Foundation

let gridsize = 501

class Day22 {
    var infected:[Set<Int>] = Array(repeatElement([], count: gridsize))
    var infected2:[[Character]] =
        Array(repeatElement(Array(repeatElement(".", count: gridsize)), count: gridsize))

    func solve() {
        let lines = Utils.readFileLines("Day22.txt")
        let offset = (gridsize - lines.count) / 2
        for row in 0 ..< lines.count {
            let characters = Array(lines[row])
            for col in 0 ..< characters.count {
                if characters[col] == "#" {
                    infected[row + offset].insert(col + offset)
                    infected2[row + offset][col + offset] = "#"
                }
            }
        }
        print("Part 1: \(part1())")
        print("Part 2: \(part2())")
    }
    
    func part1() -> Int {
        var infectionCount = 0
        var position = Point(x: gridsize / 2, y: gridsize / 2)
        var direction = Point(x: 0, y: -1)
        for _ in 0 ..< 10000 {
            if infected[position.y].contains(position.x) {
                infected[position.y].remove(position.x)
                direction = direction.turnLeft()
            } else {
                infected[position.y].insert(position.x)
                infectionCount += 1
                direction = direction.turnRight()
            }
            position = position + direction
        }
        return infectionCount
    }
    
    func part2() -> Int {
        var infectionCount = 0
        var position = Point(x: gridsize / 2, y: gridsize / 2)
        var direction = Point(x: 0, y: -1)
        for _ in 0 ..< 10000000 {
            switch infected2[position.y][position.x] {
            case ".":
                direction = direction.turnRight()
                infected2[position.y][position.x] = "W"
            case "W":
                infectionCount += 1
                infected2[position.y][position.x] = "#"
            case "#":
                direction = direction.turnLeft()
                infected2[position.y][position.x] = "F"
            case "F":
                direction = direction.reverse()
                infected2[position.y][position.x] = "."
            default:
                print("Error :P")
            }
            position = position + direction
        }
        return infectionCount
    }
}
