//
//  Day12NBodyProblem.swift
//  
//
//  Created by David Paschich on 12/5/20.
//

import Foundation
import simd
import AdventLib

// 12644 was correct!
public func day12part1() {
    let lines = readlines()
    let result = simulate(lines, steps: 1000)
    print(result)
}

// 290314621566528 was correct!
public func day12part2() {
    let lines = readlines()
    let result = findAllCycles(lines)
    print(result)
}

func simulate(_ lines: [String], steps: Int) -> Int {
    var moons = lines.compactMap(Moon.init)

    for _ in 0..<steps {
        step(moons: &moons)
    }

    return moons.map { $0.energy }.reduce(0, +)
}

func step(moons: inout [Moon]) {
    // apply gravity
    for source in 0..<moons.count {
        for dest in 0..<moons.count {
            if source == dest { continue }
            moons[source].applyGravity(moons[dest])
        }
    }

    // apply velocity

    for i in 0..<moons.count {
        moons[i].applyVelocity()
    }
}

extension SIMD3 where Scalar == Int {
    var energy: Int {
        return abs(x) + abs(y) + abs(z)
    }
}

struct Moon {
    var position: SIMD3<Int>
    var velocity: SIMD3<Int>

    static let regex = try! Regex(pattern: #"<x=(-?\d+), y=(-?\d+), z=(-?\d+)>"#)
    init?(line: String) {
        guard let strings = Moon.regex.match(input: line),
              strings.count == 3,
              let x = Int(strings[0]),
              let y = Int(strings[1]),
              let z = Int(strings[2]) else {
            return nil
        }
        position = [x, y, z]
        velocity = .zero
    }

    mutating func applyGravity(_ other: Moon) {
        if position.x < other.position.x {
            velocity.x += 1
        } else if position.x > other.position.x {
            velocity.x -= 1
        }
        if position.y < other.position.y {
            velocity.y += 1
        } else if position.y > other.position.y {
            velocity.y -= 1
        }
        if position.z < other.position.z {
            velocity.z += 1
        } else if position.z > other.position.z {
            velocity.z -= 1
        }
    }

    mutating func applyVelocity() {
        position = position &+ velocity
    }

    var energy: Int {
        return position.energy * velocity.energy
    }
}

extension Moon: CustomStringConvertible {
    var description: String {
        return "pos=<x=\(position.x), y=\(position.y), z=\(position.z)>, vel=<x=\(velocity.x), y=\(velocity.y), z=\(velocity.z)>"
    }
}

// MARK: - Part 2

func findAllCycles(_ input: [String]) -> Int {
    let moons = input.compactMap(Moon.init(line:))
    // start with x
    let xMoonlets = moons.map { Moonlet(position: $0.position.x, velocity: 0) }
    let xCycle = findCycle(moons: xMoonlets)

    let yMoonlets = moons.map { Moonlet(position: $0.position.y, velocity: 0) }
    let yCycle = findCycle(moons: yMoonlets)

    let zMoonlets = moons.map { Moonlet(position: $0.position.z, velocity: 0) }
    let zCycle = findCycle(moons: zMoonlets)

    return lcm(xCycle, lcm(yCycle, zCycle))
}

func gcd(_ a: Int, _ b: Int) -> Int {
  let r = a % b
  if r != 0 {
    return gcd(b, r)
  } else {
    return b
  }
}

func lcm(_ a: Int, _ b: Int) -> Int {
    let divisor = gcd(a, b)
    return (a * b) / divisor
}

func findCycle(moons: [Moonlet]) -> Int {
    var cycleMoons = moons
    var cycles = 0

    while true {
        cycles += 1
        moonletsStep(moons: &cycleMoons)
        if cycleMoons == moons { break }
    }
    return cycles
}

func moonletsStep(moons: inout [Moonlet]) {
    for i in 0..<moons.count {
        for j in 0..<moons.count {
            if i == j { continue }
            moons[i].applyGravity(other: moons[j])
        }
    }

    for k in 0..<moons.count {
        moons[k].applyVelocity()
    }
}

struct Moonlet: Equatable {
    var position: Int
    var velocity: Int

    mutating func applyGravity(other: Moonlet) {
        if position < other.position {
            velocity += 1
        } else if position > other.position {
            velocity -= 1
        }
    }

    mutating func applyVelocity() {
        position += velocity
    }
}
