//
//  Day15.swift
//  Advent Of Code 2017
//
//  Created by Rolf Staflin on 2017-12-15.
//  Copyright © 2017 Piro AB. All rights reserved.
//

class Day15 {
    func solve() {
        var a = 516
        var b = 190
        var count = 0
        
        for _ in 0 ..< 40000000 {
            a = (a * 16807) % 2147483647
            b = (b * 48271) % 2147483647
            if (a & 0xffff == b & 0xffff) {
                count += 1
            }
        }
        print("Part 1: \(count)")

        a = 516
        b = 190
        count = 0
        
        for _ in 0 ..< 5000000 {
            repeat {
                a = (a * 16807) % 2147483647
            } while (a % 4) != 0
            repeat {
                b = (b * 48271) % 2147483647
            } while (b % 8) != 0
            if (a & 0xffff == b & 0xffff) {
                count += 1
            }
        }
        print("Part 2: \(count)")
    }
}
