//
//  Day11.swift
//  Advent Of Code 2017
//
//  Created by Rolf Staflin on 2017-12-11.
//  Copyright © 2017 Piro AB. All rights reserved.
//

import Foundation
/*
  The hex grid is represented with normal coordinates.
  Even-numbered columns are "normal", and odd-numbered
  columns are half a step above the others, so that you
  can northeast from [0,0] is [1,0], and southeast is
  [1, -1]
 */
class Day11 {

    let directions = ["n", "ne", "se", "s", "sw", "nw"]
    let vectorsEven = [Point(x: 0, y:1),
                       Point(x: 1, y:0),
                       Point(x: 1, y:-1),
                       Point(x: 0, y:-1),
                       Point(x: -1, y:-1),
                       Point(x: -1, y:0)]

    let vectorsOdd  = [Point(x: 0, y:1),
                       Point(x: 1, y:1),
                       Point(x: 1, y:0),
                       Point(x: 0, y:-1),
                       Point(x: -1, y:0),
                       Point(x: -1, y:1)]

    func solve() {
       // let input = "n,se,s,sw,nw,n,ne,n,se,se,s,s,sw,sw,nw,nw,n,n,ne,ne,s,s"
        let input = Utils.readFile("Day11.txt")
        let steps = input.split(separator: ",").map {String($0)}
        let origo = Point(x: 0, y: 0)
        var position = origo
        print(position)
        var maxDistance = 0
        for step in steps {
            let index = directions.index(of: step)!
            let vector = (position.x % 2 == 0) ? vectorsEven[index] : vectorsOdd[index]
            position = position + vector
            maxDistance = max(maxDistance, distance(from: origo, to: position))
        }
        print("Part 1: \(distance(from: origo, to: position))")
        print("Part 2: \(maxDistance)")
    }
    
    func distance(from start:Point, to end:Point) -> Int {
        let diff = end - start
        let x = abs(diff.x)

        let y = diff.y
        let potentialDiagonal = ((y < 0) ? x + 1 : x) / 2

        let yDistance = max(0, abs(y) - potentialDiagonal)
        return x + yDistance
    }
}
