//
//  Day20.swift
//  Advent Of Code 2017
//
//  Created by Rolf Staflin on 2017-12-19.
//  Copyright © 2017 Piro AB. All rights reserved.
//

import Foundation

class Point3d {
    var x = 0
    var y = 0
    var z = 0
    
    init(_ s: String) {
        let vector = s.split(separator: ",").map{Int($0)!}
        x = vector[0]
        y = vector[1]
        z = vector[2]
    }
    init(x: Int, y: Int, z: Int) {
        self.x = x
        self.y = y
        self.z = z
    }

    var magnitude: Int {
        get {
            return abs(x) + abs(y) + abs(z)
        }
    }
    func equals(_ other: Point3d) -> Bool {
        return x == other.x && y == other.y && z == other.z
    }
    
    static func +(lhs:Point3d, rhs:Point3d) -> Point3d {
        return Point3d(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }

}

class Particle {
    var position: Point3d
    var velocity: Point3d
    var acceleration: Point3d
    
    init(_ line: String) {
        let parts = line.split(separator: ">")
        position = Point3d(String(parts[0].split(separator: "<")[1]))
        velocity = Point3d(String(parts[1].split(separator: "<")[1]))
        acceleration = Point3d(String(parts[2].split(separator: "<")[1]))
    }
    
    func move() {
        velocity = velocity + acceleration
        position = position + velocity
    }

    func collidesWith(_ other: Particle) -> Bool {
        return position.equals(other.position)
    }
}


class Day20 {

    var particles: [Particle] = []

    func solve() {
        let lines = Utils.readFileLines("Day20.txt")
/*
        let lines = """
p=<-6,0,0>, v=<3,0,0>, a=<0,0,0>
p=<-4,0,0>, v=<2,0,0>, a=<0,0,0>
p=<-2,0,0>, v=<1,0,0>, a=<0,0,0>
p=<3,0,0>, v=<-1,0,0>, a=<0,0,0>
""".split(separator: "\n").map {String($0)}
 */
        for line in lines {
            particles.append(Particle(line))
        }
        var lowestAcceleration = 999999999
        var lowestVelocity = 999999999
        var lowestIndex = -1
        for i in 0 ..< particles.count {
            if (particles[i].acceleration.magnitude < lowestAcceleration) {
                lowestIndex = i
                lowestAcceleration = particles[i].acceleration.magnitude
                lowestVelocity = particles[i].velocity.magnitude
            } else if (particles[i].acceleration.magnitude == lowestAcceleration && particles[i].velocity.magnitude < lowestVelocity) {
                lowestIndex = i
                lowestAcceleration = particles[i].acceleration.magnitude
                lowestVelocity = particles[i].velocity.magnitude
            }
        }
        print("Part 1: \(lowestIndex)")
        //-------------------------
        var lastCollision = 0
        for t in 0... {
            if t > lastCollision + 100 {
                break
            }
            if collide() {
                lastCollision = t
            }
            particles.forEach { $0.move() }
        }
        print("Part 2: \(particles.count)")
    }
    
    func collide() -> Bool {
        var result = false
        var collidingParticles : Set<Int> = []
        for i in 0 ..< particles.count - 1 {
            for j in i + 1 ..< particles.count {
                if (particles[i].collidesWith(particles[j])) {
                    collidingParticles.insert(i)
                    collidingParticles.insert(j)
                    result = true
                }
            }
        }
        if result {
            let sortedIndexes = collidingParticles.sorted()
            for i in stride(from: sortedIndexes.count - 1, to: -1, by: -1) {
                particles.remove(at: sortedIndexes[i])
            }
        }
        return result
    }
}
