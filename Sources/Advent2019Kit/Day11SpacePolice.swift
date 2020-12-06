//
//  Day11SpacePolice.swift
//  
//
//  Created by David Paschich on 12/5/20.
//

import Foundation
import AdventLib
import Intcode

// 2293 was right!
public func day11part1() {
    let line = readLine()!
    let program = line.split(separator: ",").map(String.init).compactMap(Int.init)
    var robot = PaintingRobot(program: program)
    let result = robot.run()
    print(result)
}

// AHLCPRAL was right!
public func day11part2() {
    let line = readLine()!
    let program = line.split(separator: ",").map(String.init).compactMap(Int.init)
    var robot = PaintingRobot(program: program)
    robot.hull[Point(x: 0, y: 0)] = .white
    _ = robot.run()

    var output: String = ""
    let (bottomLeft, upperRight) = robot.hull.extent()
    print(bottomLeft, upperRight)
    for y in ((bottomLeft.y)...(upperRight.y)).reversed() {
        for x in (bottomLeft.x)...(upperRight.x) {
            let panel = robot.hull[Point(x: x, y: y)]
            if panel == .white {
                output.append("#")
            } else {
                output.append(".")
            }
        }
        output.append("\n")
    }
    print(output)
}

enum Panel: Int {
    case empty = -1
    case black = 0
    case white = 1

    var input: Int {
        switch self {
        case .empty, .black: return 0
        case .white: return 1
        }
    }
}

enum Direction {
    case up
    case right
    case down
    case left

    func turnLeft() -> Direction {
        switch self {
        case .up: return .left
        case .right: return .up
        case .down: return .right
        case .left: return .down
        }
    }

    func turnRight() -> Direction {
        switch self {
        case .up: return .right
        case .right: return .down
        case .down: return .left
        case .left: return .up
        }
    }

    // assumes y is up
    func move(_ point: Point) -> Point {
        switch self {
        case .up: return point + Point(x: 0, y: 1)
        case .right: return point + Point(x: 1, y: 0)
        case .down: return point + Point(x: 0, y: -1)
        case .left: return point + Point(x: -1, y: 0)
        }
    }
}

struct PaintingRobot {
    var hull = Field<Panel>(defaultValue: .empty)
    var position = Point(x: 0, y: 0)
    var direction: Direction = .up
    var computer: Computer
    init(program: [Int]) {
        computer = Computer(memory: program)
    }

    mutating func run() -> Int {
        while !computer.halted {
            step()
        }
        return hull.storage.count
    }

    mutating func step() {
        let current = hull[position].input
        computer.input(line: current)
        computer.runToOutput()
        guard !computer.halted else { return }
        // first output is new color
        let newColor = Panel(rawValue: computer.output.last!)
        hull[position] = newColor!
        // second is direction to move
        computer.runToOutput()
        guard !computer.halted else { return }
        let turn = computer.output.last!

        switch turn {
        case 0: direction = direction.turnLeft()
        case 1: direction = direction.turnRight()
        default: fatalError("unexpected direction \(turn)")
        }

        position = direction.move(position)
    }
}
