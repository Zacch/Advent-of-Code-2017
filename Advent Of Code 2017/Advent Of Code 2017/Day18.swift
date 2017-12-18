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
                    ip = -2 // Exit
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
        
        // ----------------------
        let cpu = Cpu(instructions, registers)
        cpu.run()
    }
    
    func isRegister(_ s: String) -> Bool {
        return CharacterSet.letters.contains(s.unicodeScalars.first!)
    }
    
    func valueOf(_ operand: String) -> Int {
        return isRegister(operand) ? registers[operand]! : Int(operand)!
    }
}

class Cpu {
    var instructions: [[String]]

    var p0: Program18
    var p1: Program18
    var q0 = Queue<Int>()
    var q1 = Queue<Int>()

    init(_ instructions: [[String]], _ registers: [String: Int]) {
        self.instructions = instructions
        var mutableRegisters = registers
        mutableRegisters.keys.forEach { mutableRegisters[$0] = 0 }

        p0 = Program18(mutableRegisters, id: 0)
        mutableRegisters["p"] = 1
        p1 = Program18(mutableRegisters, id: 1)
    }

    func run() {
        p0.cpu = self
        p1.cpu = self
        repeat {
            p0.run()
            p1.run()
        } while p0.isHanging && !q0.isEmpty
        print("Part 2: \(p1.sendCount)")
    }
    
    func push( _ value:Int, programId:Int) {
        if programId == 0 {
            q1.push(value)
        } else {
            q0.push(value)
        }
    }
    
    func pop(_ programId:Int) -> Int {
        return programId == 0 ? q0.pop() : q1.pop()
    }
    
    func queueEmpty(_ programId:Int) -> Bool {
        return programId == 0 ? q0.isEmpty : q1.isEmpty
    }
}

class Program18 {
    var registers: [String: Int]
    let id: Int
    var cpu: Cpu?
    
    var ip = 0
    var isHanging = false
    var sendCount = 0

    init(_ registers: [String: Int], id: Int) {
        self.registers = registers
        self.id = id
    }

    func run() {
        guard let cpu = self.cpu else {
            print("Error! No CPU")
            return
        }

        isHanging = false
        while ip >= 0 && ip < cpu.instructions.count {
            let instruction = cpu.instructions[ip]
            let op1 = instruction[1]
            let op2 = (instruction.count > 2) ? instruction[2] : "nil"
            switch (instruction[0]) {
            case "snd":
                sendCount += 1
                cpu.push(valueOf(op1), programId: id)
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
                if cpu.queueEmpty(id) {
                    isHanging = true
                    return
                }
                registers[op1] = cpu.pop(id)
            case "jgz":
                if (valueOf(op1) > 0) {
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
