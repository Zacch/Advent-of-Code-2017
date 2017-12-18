//
//  Day17.swift
//  Advent Of Code 2017
//
//  Created by Rolf Staflin on 2017-12-17.
//  Copyright © 2017 Piro AB. All rights reserved.
//

import Foundation

class Day17 {
    func solve() {
        let steps = 382
        
        var buffer = [0]
        var position = 0
        for i in 1...2017 {
            position = (position + steps) % i + 1
            buffer.insert(i, at: position)
        }
        print("Part 1: \(buffer[position + 1])")

        buffer = [0]
        position = 0
        var zeroPosition = 0
        var nextValue = -1
        for i in 1...50000000 {
            position = (position + steps) % i
            if position < zeroPosition {
                zeroPosition += 1
            }
            if position == zeroPosition {
                nextValue = i
            }
            position += 1
            if (i % 100000 == 0) {
                print("\(i): Pos \(position), zero at position \(zeroPosition), value after 0: \(nextValue)")
            }
        }
        print("Pos \(position), zero at position \(zeroPosition), value after 0: \(nextValue)")
    }
}
