//
//  Day5ComputerTests.swift
//  IntcodeTests
//
//  Created by David Paschich on 12/7/19.
//  Copyright © 2019 David Paschich. All rights reserved.
//

import XCTest
@testable import Intcode

class Day5ComputerTests: XCTestCase {
    func testInputOutput() {
        let program = [3,0,4,0,99]
        var computer1 = Computer(memory: program)
        computer1.input(line: 4)
        computer1.run()
        XCTAssertEqual(computer1.output, [4])
    }

    func testImmediateMul() {
        let program = [1002,4,3,4,33]
        var computer = Computer(memory: program)
        computer.run()
        XCTAssertEqual(computer.memory[4], 99)
        XCTAssertTrue(computer.halted)
        XCTAssertFalse(computer.crashed)
    }

    func testPositionEqual() {
        let program = [3,9,8,9,10,9,4,9,99,-1,8]
        XCTAssertEqual(
            Computer.run(program: program, inputs: [1]),
            [0]
        )
        XCTAssertEqual(
            Computer.run(program: program, inputs: [8]),
            [1]
        )
    }

    func testPositionLessThan() {
        let program = [3,9,7,9,10,9,4,9,99,-1,8]
        XCTAssertEqual(
            Computer.run(program: program, inputs: [1]),
            [1]
        )
        XCTAssertEqual(
            Computer.run(program: program, inputs: [8]),
            [0]
        )
    }

    func testImmediateEqual() {
        let program = [3,3,1108,-1,8,3,4,3,99]
        XCTAssertEqual(
            Computer.run(program: program, inputs: [1]),
            [0]
        )
        XCTAssertEqual(
            Computer.run(program: program, inputs: [8]),
            [1]
        )
    }

    func testImmediateLessThan() {
        let program = [3,3,1107,-1,8,3,4,3,99]
        XCTAssertEqual(
            Computer.run(program: program, inputs: [1]),
            [1]
        )
        XCTAssertEqual(
            Computer.run(program: program, inputs: [8]),
            [0]
        )
    }

    func testPositionJump() {
        let program = [3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9]
        XCTAssertEqual(
            Computer.run(program: program, inputs: [1]),
            [1]
        )
        XCTAssertEqual(
            Computer.run(program: program, inputs: [0]),
            [0]
        )
    }

    func testImmediateJump() {
        let program = [3,3,1105,-1,9,1101,0,0,12,4,12,99,1]
        XCTAssertEqual(
            Computer.run(program: program, inputs: [1]),
            [1]
        )
        XCTAssertEqual(
            Computer.run(program: program, inputs: [0]),
            [0]
        )
    }

    func testLargerExample() {
        let program = [3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
                       1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
                       999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99]
        XCTAssertEqual(
            Computer.run(program: program, inputs: [7]),
            [999]
        )
        XCTAssertEqual(
            Computer.run(program: program, inputs: [8]),
            [1000]
        )
        XCTAssertEqual(
            Computer.run(program: program, inputs: [9]),
            [1001]
        )
    }

    func testCountdown() {
        let program = [101,-1,7,7,4,7,1105,11,0,99]
        XCTAssertEqual(
            Computer.run(program: program),
            [10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
        )
    }
}
