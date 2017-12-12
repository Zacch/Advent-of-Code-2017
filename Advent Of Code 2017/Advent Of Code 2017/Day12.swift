//
//  Day12.swift
//  Advent Of Code 2017
//
//  Created by Rolf Staflin on 2017-12-12.
//  Copyright © 2017 Piro AB. All rights reserved.
//

import Foundation

class Program12: NSObject {
    let id: Int
    var connected: [Int] = []
    
    init(_ line: String) {
        let tokens = line.split(separator: " ").map {String($0)}
        id = Int(tokens[0])!
        for token in tokens[2...] {
            let programId = Int(token.split(separator: ",").first!)!
            connected.append(programId)
        }
    }
}

class Day12 {
    var allPrograms: [Program12] = []

    func solve() {
        let lines = Utils.readFileLines("Day12.txt")
        var programGroups: [[Program12]] = []
        var programsWithoutGroup: [Int:Program12] = [:]
        for line in lines {
            let program = Program12(line)
            allPrograms.append(program)
            programsWithoutGroup[program.id] = program
        }
        
        var firstIndex = 0
        while firstIndex >= 0 {
            let group = getGroup(firstIndex)
            programGroups.append(group)
            for program in group {
                programsWithoutGroup.removeValue(forKey: program.id)
            }
            firstIndex = programsWithoutGroup.first?.value.id ?? -1
        }

        print("Part 1: \(programGroups[0].count) programs")
        print("Part 2: \(programGroups.count) groups")
    }
    
    
    func getGroup(_ programId: Int) -> [Program12] {
        var group: [Program12] = [];
        var membersToProcess: Stack<Int> = Stack()
        membersToProcess.push(programId)
        repeat {
            let id = membersToProcess.pop()
            let program = allPrograms[id]
            if (!group.contains(program)) {
                group.append(program)
                membersToProcess.items.append(contentsOf: program.connected)
            }
        } while !membersToProcess.isEmpty
        return group
    }
}
