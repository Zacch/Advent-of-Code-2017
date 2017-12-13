//
//  Day13.swift
//  Advent Of Code 2017
//
//  Created by Rolf Staflin on 2017-12-13.
//  Copyright © 2017 Piro AB. All rights reserved.
//

import Foundation

class Layer: NSObject {
    let range: Int
    let cycleLength: Int
    var scannerPosition = 0
    private var scannerDirection = 1
    override var description: String { return "\(range):\(range == 0 ? "_": String(scannerPosition))" }

    init(_ range: Int) {
        self.range = range
        self.cycleLength = (range < 2) ? Int(INT_MAX) : 2 * (range - 2) + 2
    }
    
    init(_ other: Layer) {
        self.range = other.range
        self.cycleLength = other.cycleLength
        self.scannerPosition = other.scannerPosition
        self.scannerDirection = other.scannerDirection
    }
    
    func moveScanner() {
        if range < 2 {
            return
        }
        if (scannerPosition + scannerDirection >= range) ||
           (scannerPosition + scannerDirection < 0) {
            scannerDirection = -scannerDirection
        }
        scannerPosition += scannerDirection
    }
    
    func isCaught() -> Bool {
        return range > 0 && scannerPosition == 0
    }
}

class Firewall: NSObject {
    
    static let depth = 93
    var layers = Array(repeating: Layer(0), count: depth)

    subscript(index:Int) -> Layer {
        get {
            return layers[index]
        }
        set(value) {
            layers[index] = value
        }
    }
    
    func moveScanners() {
        layers.forEach { $0.moveScanner() }
    }

    func wouldBeCaughtAfter(_ picoseconds: Int) -> Bool {
        for i in 0 ..< Firewall.depth {
            if (picoseconds + i) % layers[i].cycleLength == 0 {
                return true
            }
        }
        return false
    }

    override var description: String { return "\(layers)" }
}

class Day13 {
    func solve() {
        let lines = Utils.readFileLines("Day13.txt")
        let firewall = Firewall()
        for line in lines {
            let tokens = line.components(separatedBy: ": ")
            firewall[Int(tokens[0])!] = Layer(Int(tokens[1])!)
        }
        
        var severity = 0
        for depth in 0 ..< Firewall.depth {
            let layer = firewall[depth]
            if layer.isCaught() {
                severity += layer.range * depth
            }
            firewall.moveScanners()
        }
        print("Part 1: \(severity)")

        for delay in 0... {
            if (!firewall.wouldBeCaughtAfter(delay)) {
                print("Part 2: \(delay)")
                exit(0);
            }
        }
    }
}






