//
//  File.swift
//  
//
//  Created by David Paschich on 12/6/20.
//

import Foundation
import AdventLib
import Intcode

// 200 was correct!
public func day13part1() {
    let line = readLine()!
    let program = line.split(separator: ",").map(String.init).compactMap(Int.init)
    var cabinet = ArcadeCabinet(program: program)
    cabinet.run()
    print(cabinet.blockTiles())
    print(cabinet.printScreen())
}

// 9803 was correct!
public func day13part2() {
    guard CommandLine.arguments.count >= 3 else {
        print("give path to program as 2nd argument")
        return
    }
    do {
        let path = CommandLine.arguments[2]
        let input = try String(contentsOfFile: path).trimmingCharacters(in: .whitespacesAndNewlines)
        print(input)
        let program = input.split(separator: ",").map(String.init).compactMap(Int.init)
        print(program)
        var cabinet = ArcadeCabinet(program: program)
        cabinet.insertQuarter()
        cabinet.run()
        print(cabinet.printScreen())
    } catch {
        print("error \(error)!")
    }
}

//0 is an empty tile. No game object appears in this tile.
//1 is a wall tile. Walls are indestructible barriers.
//2 is a block tile. Blocks can be broken by the ball.
//3 is a horizontal paddle tile. The paddle is indestructible.
//4 is a ball tile. The ball moves diagonally and bounces off objects.
enum Tile: Int {
    case empty = 0
    case wall
    case block
    case paddle
    case ball
}

extension Tile: CustomStringConvertible {
    var description: String {
        switch self {
        case .empty: return " "
        case .wall: return "#"
        case .block: return "X"
        case .paddle: return "_"
        case .ball: return "*"
        }
    }
}

struct ArcadeCabinet {
    var field = Field<Tile>(defaultValue: .empty)
    var display = ""
    var computer: Computer
    var outputStack: [Int] = []
    var lastPaddle = Point(x: -1, y: -1)
    var lastBall = Point(x: -1, y: -1)

    init(program: [Int]) {
        computer = Computer(memory: program)
    }

    mutating func insertQuarter() {
        computer.memory[0] = 2
    }

    mutating func run() {
        while !computer.halted {
            computer.runToIO()
            outputStack.append(contentsOf: computer.output)
            computer.resetOutput()
            updateDisplay()
            if computer.awaitingInput {
                if lastPaddle.x < lastBall.x {
                    computer.input(line: 1)
                } else if lastPaddle.x > lastBall.x {
                    computer.input(line: -1)
                } else {
                    computer.input(line: 0)
                }
            }
        }
    }

    mutating func updateDisplay() {
        while outputStack.count >= 3 {
            let x = outputStack.removeFirst()
            let y = outputStack.removeFirst()
            let value = outputStack.removeFirst()

            if x == -1 {
                display = "\(value)"
            } else {
                let tile = Tile(rawValue: value)!
                field[Point(x: x, y: y)] = tile
                if tile == .ball {
                    lastBall = Point(x: x, y: y)
                } else if tile == .paddle {
                    lastPaddle = Point(x: x, y: y)
                }
            }
            print(printScreen())
        }
    }

    mutating func startup(_ output: [Int]) {
        let limit = output.count / 3
        for i in 0..<limit {
            let x = output[i * 3]
            let y = output[(i * 3) + 1]
            let tileID = output[(i * 3) + 2]
            field[Point(x: x, y: y)] = Tile(rawValue: tileID)!
        }
    }

    func ballTiles() -> Int {
        return field.storage.values.filter { $0 == .ball }.count
    }

    func blockTiles() -> Int {
        return field.storage.values.filter { $0 == .block }.count
    }

    func printScreen() -> String {
        var result = ""
        let (lowerLeft, upperRight) = field.extent()
        print(lowerLeft, upperRight)
        result.append("SCORE: \(display)\n")
        for y in ((lowerLeft.y)...(upperRight.y)) {
            for x in (lowerLeft.x)...(upperRight.x) {
                result.append(field[Point(x: x, y: y)].description)
            }
            result.append("\n")
        }
        return result
    }
}
