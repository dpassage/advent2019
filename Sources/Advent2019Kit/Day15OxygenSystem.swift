//
//  File.swift
//  
//
//  Created by David Paschich on 12/15/20.
//

import Foundation
import Intcode
import AdventLib

// 250 was correct!
public func day15part1() {
    let input = readlines()
    let program = input[0].components(separatedBy: ",").compactMap(Int.init)

    let (result, _, tankLocation) = buildMap(program)
    print(result, tankLocation)
}

// 332 was correct!
public func day15part2() {
    let input = readlines()
    let program = input[0].components(separatedBy: ",").compactMap(Int.init)

    let (_, field, tankLocation) = buildMap(program)
    let result = fillMap(field: field, startingPosition: tankLocation)
    print(result)
}

func buildMap(_ program: [Int]) -> (Int, Field<Cell>, Point) {
    var heap = Heap<RobotState> { $0.commandsSoFar.count < $1.commandsSoFar.count }
    var field = Field<Cell>(defaultValue: .unknown)
    var shortestPath = 0
    var tankLocation = Point(x: Int.min, y: Int.min)

    defer { print(field.printGrid()) }

    let start = RobotState(program: program)
    heap.enqueue(start)

    while let current = heap.dequeue() {
        // we try all 4 directions, only inserting those that work
        for move in 1...4 {
            var new = current

            // only try to move places we haven't been
            let nextPosition = new.nextPosition(move)
            guard field[nextPosition] == .unknown else { continue }

            let result = new.move(move)
            field[new.position] = result
            switch result {
            case .floor: heap.enqueue(new)
            case .wall: break
            case .oxygen:
                heap.enqueue(new)
                shortestPath = new.commandsSoFar.count
                tankLocation = new.position
            case .unknown: fatalError("unexpected result .unknown")
            }
        }
    }

    return (shortestPath, field, tankLocation)
}

func fillMap(field: Field<Cell>, startingPosition: Point) -> Int {
    var field = field

    var heap = Heap<FillState> { $0.moves < $1.moves }
    var longestPath = -1

    let start = FillState(position: startingPosition)
    heap.enqueue(start)

    precondition(field[startingPosition] == .oxygen)

    while let current = heap.dequeue() {
        for adjacent in current.position.adjacents() {
            switch field[adjacent] {
            case .floor:
                field[adjacent] = .oxygen
                var new = current
                new.position = adjacent
                new.moves += 1
                longestPath = max(longestPath, new.moves)
                heap.enqueue(new)
            default: break
            }
        }
    }
    print(field.printGrid())
    return longestPath
}

enum Cell: Character {
    case unknown = " "
    case floor = "."
    case wall = "#"
    case oxygen = "O"
}

struct RobotState {
    var computer: Computer
    var commandsSoFar: [Int] = []
    var position = Point(x: 0, y: 0)

    init(program: [Int]) {
        self.computer = Computer(memory: program)
    }

    func nextPosition(_ command: Int) -> Point {
        var result = position
        switch command {
        case 1: result.y += 1
        case 2: result.y -= 1
        case 3: result.x -= 1
        case 4: result.x += 1
        default: fatalError("illegal move \(command)")
        }

        return result
    }
    // tries to perform the move, returning the result
    mutating func move(_ command: Int) -> Cell {
        position = nextPosition(command)

        commandsSoFar.append(command)
        computer.input(line: command)
        computer.runToOutput()
        let result = computer.output.first!
        computer.resetOutput()
        switch result {
        case 0: return .wall
        case 1: return .floor
        case 2: return .oxygen
        default: fatalError("unexpected output \(result)")
        }
    }
}

struct FillState {
    var position: Point
    var moves: Int = 0
}

