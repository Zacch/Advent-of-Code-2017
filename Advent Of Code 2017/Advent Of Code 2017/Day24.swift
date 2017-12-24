//
//  Day24.swift
//  Advent Of Code 2017
//
//  Created by Rolf Staflin on 2017-12-24.
//  Copyright © 2017 Piro AB. All rights reserved.
//

import Foundation

class Component: NSObject {
    let endA: Int
    let end1: Int
    var strength: Int {
        return end1 + endA
    }


    let desc: String
    override public var description: String {
        return desc
    }
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? Component else { return false }
        return desc == other.desc
    }
    
    init(_ line: String) {
        desc = line
        let ends = line.split(separator: "/").map {Int($0)!}
        endA = ends[0]
        end1 = ends[1]
    }
    
    func matches(_ end: Int) -> Bool {
        return end1 == end || endA == end
    }
    
    func otherEnd(_ end: Int) -> Int {
        return end == endA ? end1 : endA
    }
}

class Bridge {
    var components: [Component] = []
    var end = 0
    var strength: Int {
        return components.reduce(0) { $0 + $1.strength}
    }
    
    func append(_ component: Component) -> Bridge {
        let result = Bridge()
        result.components = components
        result.components.append(component)
        result.end = component.otherEnd(self.end)
        return result
    }
}

class Day24 {
    
    func solve() {
        let components = Utils.readFileLines("Day24.txt").map {Component($0)}
        print("Part 1: \(findStrongestBridge(Bridge(), components).strength)")
        print("Part 2: \(findLongestBridge(Bridge(), components).strength)")
    }

    func findStrongestBridge(_ bridge: Bridge, _ components: [Component])  -> Bridge {
        let matching = components.filter {$0.matches(bridge.end)}
        if matching.isEmpty {
            return bridge
        }
        var strongestBridge = bridge
        for match in matching {
            let builtBridge = findStrongestBridge(bridge.append(match), components.filter { $0 != match })
            if (builtBridge.strength > strongestBridge.strength) {
                strongestBridge = builtBridge
            }
        }
        return strongestBridge
    }

    func findLongestBridge(_ bridge: Bridge, _ components: [Component])  -> Bridge {
        let matching = components.filter {$0.matches(bridge.end)}
        if matching.isEmpty {
            return bridge
        }
        var longestBridge = bridge
        for match in matching {
            let builtBridge = findLongestBridge(bridge.append(match), components.filter { $0 != match })
            if (builtBridge.components.count > longestBridge.components.count ||
                (builtBridge.components.count == longestBridge.components.count &&
                 builtBridge.strength > longestBridge.strength)) {
                longestBridge = builtBridge
            }
        }
        return longestBridge
    }
}
