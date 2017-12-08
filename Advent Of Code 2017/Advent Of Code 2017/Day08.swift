//
//  Day08.swift
//  Advent Of Code 2017
//
//  Created by Rolf Staflin on 2017-12-08.
//  Copyright © 2017 Piro AB. All rights reserved.
//

import Foundation

class Day08 {
    
    func readFile(_ name: String) -> [String] {
        let fileURL = URL(fileURLWithPath: name)
        do {
            let fileContents = try String(contentsOf: fileURL, encoding: String.Encoding.utf8)
            let lines = fileContents.split(separator: "\n")
            return lines.map {String($0)}
        } catch let error1 as NSError  {
            print("fail: \(error1)")
            return []
        }
    }

    func solve() {
        var registers:[String:Int] = [:]
        var allTimeHigh = 0
        for line in readFile("Day08.txt") {
            let tokens = line.split(separator: " ").map {String($0)}
            if registers[tokens[0]] == nil {
                registers[tokens[0]] = 0
            }
            if registers[tokens[4]] == nil {
                registers[tokens[4]] = 0
            }
            let operand1 = registers[tokens[4]]!
            let operation = tokens[5]
            let operand2 = Int(tokens[6])!
            
            var result = false
            switch (operation) {
            case "<":
                result = operand1 < operand2
                break
            case ">":
                result = operand1 > operand2
            case "==":
                result = operand1 == operand2
            case "<=":
                result = operand1 <= operand2
            case ">=":
                result = operand1 >= operand2
            case "!=":
                result = operand1 != operand2
            default:
                print("Unknown operator: \(operation)")
            }
            if result {
                var amount = Int(tokens[2])!
                if tokens[1] == "dec" {
                    amount = -amount
                }
                registers[tokens[0]]! += amount
                if (registers[tokens[0]]! > allTimeHigh) {
                    allTimeHigh = registers[tokens[0]]!
                }
            }
        }
        var highest = registers.values.first!
        for value in registers.values {
            if value > highest {
                highest = value
            }
        }
        print("Part 1: \(highest)")
        print("Part 2: \(allTimeHigh)")
    }
}
