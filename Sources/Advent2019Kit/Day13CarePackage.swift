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
    var computer = Computer(memory: program)
    computer.run()
    var cabinet = ArcadeCabinet()
    cabinet.startup(computer.output)
    print(cabinet.blockTiles())
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

struct ArcadeCabinet {
    var field = Field<Tile>(defaultValue: .empty)

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
}
