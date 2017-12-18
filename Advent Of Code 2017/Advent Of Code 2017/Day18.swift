//
//  Day18.swift
//  Advent Of Code 2017
//
//  Created by Rolf Staflin on 2017-12-18.
//  Copyright © 2017 Piro AB. All rights reserved.
//

import Foundation
class Day18 {
    var registers: [String: Int] = [:]

    func solve() {
        let lines = Utils.readFileLines("Day18.txt")
        var instructions: [[String]] = []
        
        for line in lines {
            let tokens = line.split(separator: " ").map {String($0)}
            instructions.append(tokens)
            if isRegister(tokens[1]) {
                registers[tokens[1]] = 0
            }
        }
        
        var soundPlaying = 0
        var ip = 0
        while ip >= 0 && ip < instructions.count {
            let instruction = instructions[ip]
            let op1 = instruction[1]
            let op2 = (instruction.count > 2) ? instruction[2] : "nil"
            switch (instruction[0]) {
            case "snd":
                soundPlaying = valueOf(op1)
            case "set":
                registers[op1] = valueOf(op2)
            case "add":
                registers[op1] = registers[op1]! + valueOf(op2)
            case "mul":
                registers[op1] = registers[op1]! * valueOf(op2)
            case "mod":
                if (registers[op1]! < 0) {
                    print("Warning – negative modulo! \(instruction): \(registers)")
                }
                registers[op1] = registers[op1]! % valueOf(op2)
            case "rcv":
                if (valueOf(op1) != 0) {
                    print("Part 1: \(soundPlaying)")
                    ip = -2
                }
            case "jgz":
                if (registers[op1]! > 0) {
                    ip += valueOf(op2) - 1
                }
            default:
                print("Error: \(instruction): \(registers)")
            }
            ip += 1
        }
    }
    
    func isRegister(_ s: String) -> Bool {
        return CharacterSet.letters.contains(s.unicodeScalars.first!)
    }
    
    func valueOf(_ operand: String) -> Int {
        return isRegister(operand) ? registers[operand]! : Int(operand)!
    }
}
