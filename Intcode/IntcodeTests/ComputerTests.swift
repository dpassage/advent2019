//
//  ComputerTests.swift
//  IntcodeTests
//
//  Created by David Paschich on 12/7/19.
//  Copyright © 2019 David Paschich. All rights reserved.
//

import XCTest
@testable import Intcode

class ComputerTests: XCTestCase {

    func testDay2MainExample() {
        let program = [1,9,10,3,2,3,11,0,99,30,40,50]
        var computer = Computer(memory: program)
        XCTAssertEqual(computer.pc, 0)
        computer.step()
        XCTAssertEqual(computer.pc, 4)
        XCTAssertEqual(computer.memory[3], 70)
        computer.step()
        XCTAssertEqual(computer.pc, 8)
        XCTAssertEqual(computer.memory[0], 3500)
        computer.step()
        XCTAssertEqual(computer.halted, true)
    }

    func testDay2Examples() {
        let cases = [
            ([1,0,0,0,99], [2,0,0,0,99]),
            ([2,3,0,3,99], [2,3,0,6,99]),
            ([2,4,4,5,99,0], [2,4,4,5,99,9801]),
            ([1,1,1,4,99,5,6,0,99], [30,1,1,4,2,5,6,0,99])
        ]

        for (starting, expected) in cases {
            var computer = Computer(memory: starting)
            computer.run()
            XCTAssertEqual(Array(computer.memory[0..<expected.count]), expected)
            XCTAssertTrue(computer.halted)
            XCTAssertFalse(computer.crashed)
        }
    }
}

class ComputerDay5Tests: XCTestCase {
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
}
