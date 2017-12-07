//
//  Day07.swift
//  Advent Of Code 2017
//
//  Created by Rolf Staflin on 2017-12-06.
//  Copyright © 2017 Piro AB. All rights reserved.
//

import Cocoa

class Program: NSObject {
    var name = ""
    var weight = 0
    var namesOfProgramsOnDisk: [String] = []
    var programsOnDisk: [Program] = []
    var towerWeights: [Program:Int] = [:]
    var weightIncludingTowers = 0
    var isBalanced = true
    
    init(_ input: String) {
        let tokens = input.split(separator: " ")
        name = String(tokens[0])
        weight = Int(String(tokens[1].dropFirst().dropLast()))!
        if (tokens.count > 3) {
            for token in tokens[3...] {
                namesOfProgramsOnDisk.append(String(token.last ?? "x" == "," ? token.dropLast() : token))
            }
        }
    }
    
    func calculateTowerWeights() {
       weightIncludingTowers = weight
        for tower in programsOnDisk {
            tower.calculateTowerWeights()
            towerWeights[tower] = tower.weightIncludingTowers
            weightIncludingTowers += tower.weightIncludingTowers
        }
    
        let expectedWeight = towerWeights.values.first ?? 0
        for towerWeight in towerWeights.values {
            if towerWeight != expectedWeight {
                isBalanced = false
            }
        }
    }
}

class Day07: NSObject {

    
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
        let lines = readFile("Day07.txt")//input.split(separator: "\n")
        //print(lines)
        var programs:Set<Program> = []
        var nonBottomPrograms:[String] = []
        for line in lines {
            let program = Program(line)
            programs.insert(program)
            nonBottomPrograms.append(contentsOf: program.namesOfProgramsOnDisk)
        }

        var bottomBot = programs.first!
        programs.forEach { program in
            if (!nonBottomPrograms.contains(program.name)) {
                print("Part 1: \(program.name)")
                bottomBot = program
            }
        }
        
        //----

        for program in programs {
            program.programsOnDisk = programs.filter { program.namesOfProgramsOnDisk.contains($0.name) }
        }
        bottomBot.calculateTowerWeights()

        var currentProgram = bottomBot
        var done = false
        repeat {
            var unbalancedProgram: Program? = nil
            for program in currentProgram.programsOnDisk {
                if !program.isBalanced {
                    unbalancedProgram = program
                    break
                }
            }
            if (unbalancedProgram == nil) {
                // currentProgram is unbalanced, but none of the towers on its disk
                let towers = currentProgram.programsOnDisk
                var neededWeight: Int
                if (towers[0].weightIncludingTowers == towers[1].weightIncludingTowers) {
                    neededWeight = towers[0].weightIncludingTowers
                } else {
                    neededWeight = towers[2].weightIncludingTowers
                }
                let program = towers.filter {$0.weightIncludingTowers != neededWeight}.first!
                let diff = program.weightIncludingTowers - neededWeight
                print("Part 2: \(program.weight - diff)")
                done = true
            } else {
                currentProgram = unbalancedProgram!
            }
        } while !done
        
        print("Bonus: Total weight of the entire tower: \(bottomBot.weightIncludingTowers) 😎")
    }
}
