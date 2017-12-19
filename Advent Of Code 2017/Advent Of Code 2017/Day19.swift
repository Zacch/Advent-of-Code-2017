//
//  Day19.swift
//  Advent Of Code 2017
//
//  Created by Rolf Staflin on 2017-12-19.
//  Copyright © 2017 Piro AB. All rights reserved.
//

import Foundation

class Day19 {
    var route: [[Character]] = []

    func solve() {
        let lines = Utils.readFileLines("Day19.txt")
        route = lines.map { Array("\($0)") }
        var pos = Point(x: route[0].index(of: "|")!, y: 0)
        var direction = Point(x: 0, y: 1)
        var length = 0
        var part1 = ""
        repeat {
            pos = pos + direction
            length += 1
            switch route[pos.y][pos.x] {
            case "+":
                direction = turn(pos, direction)
            case "|":
                break
            case "-":
                break
            default:
                part1.append(route[pos.y][pos.x])
            }
        } while route[pos.y][pos.x] != " "
        print("Part 1: \(part1)")
        print("Part 2: \(length)")
    }
    
    func turn(_ position: Point, _ direction: Point) -> Point {
        if direction.x == 0 {
            if route[position.y][position.x - 1] == " " {
                return Point(x: 1, y: 0)
            }
            return Point(x: -1, y: 0)
        }
        if route[position.y - 1][position.x] == " " {
            return Point(x: 0, y: 1)
        }
        return Point(x: 0, y: -1)
    }
}
