//
//  Day23.swift
//  Advent Of Code 2017
//
//  Created by Rolf Staflin on 2017-12-23.
//  Copyright © 2017 Piro AB. All rights reserved.
//

import Foundation

class Day23 {
    var registers: [String: Int] = [:]
    
    func solve() {
        let lines = Utils.readFileLines("Day23.txt")
        var instructions: [[String]] = []
        
        for line in lines {
            let tokens = line.split(separator: " ").map {String($0)}
            instructions.append(tokens)
            if isRegister(tokens[1]) {
                registers[tokens[1]] = 0
            }
        }
        
        var multiplyCount = 0
        var ip = 0
        while ip >= 0 && ip < instructions.count {
            let instruction = instructions[ip]
            let op1 = instruction[1]
            let op2 = (instruction.count > 2) ? instruction[2] : "nil"
            switch (instruction[0]) {
            case "set":
                registers[op1] = valueOf(op2)
            case "sub":
                registers[op1] = registers[op1]! - valueOf(op2)
            case "mul":
                multiplyCount += 1
                registers[op1] = registers[op1]! * valueOf(op2)
            case "jnz":
                if (valueOf(op1) != 0) {
                    ip += valueOf(op2) - 1
                }
            default:
                print("Error: \(instruction): \(registers)")
            }
            ip += 1
        }
        print("Part 1: \(multiplyCount)")
        
        // ----------------------
/*
        registers.keys.forEach { registers[$0] = ($0 == "a" ? 1 : 0)}
        ip = 0
        var count = 0
        while ip >= 0 && ip < instructions.count {
            let instruction = instructions[ip]
            let op1 = instruction[1]
            let op2 = (instruction.count > 2) ? instruction[2] : "nil"
            switch (instruction[0]) {
            case "set":
                registers[op1] = valueOf(op2)
            case "sub":
                registers[op1] = registers[op1]! - valueOf(op2)
                if op1 == "h" {
                    print("h is now \(registers["h"]!)")
                }
            case "mul":
                registers[op1] = registers[op1]! * valueOf(op2)
            case "jnz":
                if (valueOf(op1) != 0) {
                    ip += valueOf(op2) - 1
                }
            default:
                print("Error: \(instruction): \(registers)")
            }
            ip += 1
            count += 1
            if (count % 10000000 == 0) {
                print(count)
            }
        }
        print("Part 2: \(registers["h"]!)")
*/
        var b = 0, c = 0, h = 0
        b = 57 * 100 + 100000
        c = b + 17000
        repeat {
            var f = 1
            for d in 2 ..< b {
/*
                for e in 2 ..< b {
                    if d * e == b {
                        f = 0
                    }
                }
 */
                if b % d == 0 {
                    f = 0
                    break
                }
            }
            if (f == 0) {
                h += 1
            }

            if ( b == c) {
                print("Part 2: \(h)")
                exit(0)
            }
            b += 17
        } while true

    }
    
    func isRegister(_ s: String) -> Bool {
        return CharacterSet.letters.contains(s.unicodeScalars.first!)
    }
    
    func valueOf(_ operand: String) -> Int {
        return isRegister(operand) ? registers[operand]! : Int(operand)!
    }
}

