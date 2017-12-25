//
//  Day25.swift
//  Advent Of Code 2017
//
//  Created by Rolf Staflin on 2017-12-25.
//  Copyright © 2017 Piro AB. All rights reserved.
//

import Foundation

class Move25 {
    let value: Int
    let direction: Int
    let nextState: Int

    init(_ lines: [String], at index:Int) {
        value = Int(Double(String(lines[index].split(separator: " ").last!))!)
        direction = lines[index + 1].split(separator: " ").last! == "right." ? 1 : -1
        
        let state = lines[index + 2].split(separator: " ").last! as NSString
        nextState = Int(state.character(at: 0)) - 65
    }
}

class State25 {
    let name: String
    let moveIf0: Move25
    let moveIf1: Move25
    
    init(_ lines: [String], at index:Int) {
        name = String(lines[index].split(separator: " ")[2].dropLast())
        assert(lines[index + 1].hasSuffix("0:"))
        moveIf0 = Move25(lines, at: index + 2)
        moveIf1 = Move25(lines, at: index + 6)
    }
}

class Day25 {
    var states: [State25] = []
    var diagnosticAfter: Int = 0
    var stateIndex = 0
    
    func solve() {
        let lines = Utils.readFileLines("Day25.txt")
        stateIndex = Int((lines[0].split(separator: " ")[3] as NSString).character(at: 0)) - 65
        diagnosticAfter = Int(lines[1].split(separator: " ")[5])!
        
        var currentLine = 2
        while currentLine < lines.count {
            let state = State25(lines, at: currentLine)
            states.append(state)
            currentLine += 9
        }

        var tape: [Int] = [0]
        var cursor = 0
        for _ in 0 ..< diagnosticAfter {
            let state = states[stateIndex]
            let move = (tape[cursor] == 0) ? state.moveIf0 : state.moveIf1
            tape[cursor] = move.value
            cursor += move.direction
            if (cursor == tape.count) { tape.append(0) }
            if (cursor < 0) {
                tape.insert(0, at: 0)
                cursor = 0
            }
            stateIndex = move.nextState
        }
        print("Part 1: \(tape.filter{$0 == 1}.count)")
    }
}
