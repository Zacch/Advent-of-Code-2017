//
//  Day06.swift
//  Advent Of Code 2017
//
//  Created by Rolf Staflin on 2017-12-06.
//  Copyright © 2017 Piro AB. All rights reserved.
//

import Cocoa
class State: NSObject {
    var banks:[Int] = []

    init(_ banks:[Int]) {
        self.banks = banks
    }
    
    func redistribute() -> State {
        var position = 0
        var highestNumber = 0
        for i in 0..<banks.count {
            if (banks[i] > highestNumber) {
                position = i
                highestNumber = banks[i]
            }
        }

        var redistributedBanks:[Int] = []
        redistributedBanks.append(contentsOf: banks)
        redistributedBanks[position] = 0
        for _ in 1...highestNumber {
            position = (position + 1) % banks.count
            redistributedBanks[position] += 1
        }
        
        return State(redistributedBanks)
    }

    
    override var description: String { return "\(banks)" }
    
    static func == (lhs: State, rhs: State) -> Bool {
        if (lhs.banks.count != rhs.banks.count) {
            return false
        }
        for i in 0..<lhs.banks.count {
            if (lhs.banks[i] != rhs.banks[i]) {
                return false
            }
        }
        return true
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? State else {
            return false
        }
        return self == other
    }
}

class Day06: NSObject {

    var states: [State] = []

    let input = "5    1    10    0    1    7    13    14    3    12    8    10    7    12    0    6"

    func solve() {
        let start = State(input.split(separator: " ").map {Int($0)!})
        states.append(start)
        var currentState = start
        var done = false
        repeat {
            currentState = currentState.redistribute()
            if states.contains(currentState) {
                done = true
            } else {
                states.append(currentState)
            }
        } while !done
        print("Part 1: \(states.count)")
        
        if let firstIndex = states.index(where: { $0 == currentState }) {
            print("Part 2: \(states.count - firstIndex)")
        }
    }
}
