//
//  Day9ComputerTests.swift
//  IntcodeTests
//
//  Created by David Paschich on 12/8/19.
//  Copyright © 2019 David Paschich. All rights reserved.
//

import XCTest
@testable import Intcode
class Day9ComputerTests: XCTestCase {


    func testMemoryAfterProgram() {
        let program = [3,1000,4,1000,99]
        let result = Computer.run(program: program, inputs: [42])
        XCTAssertEqual(result, [42])
    }

    func testOpcode9() {
        let program = [109,42,109,-87,99]
        var computer = Computer(memory: program)
        computer.step()
        XCTAssertEqual(computer.pc, 2)
        XCTAssertEqual(computer.rb, 42)
        computer.step()
        XCTAssertEqual(computer.pc, 4)
        XCTAssertEqual(computer.rb, -45)
    }

    func testOutputItself() {
        let program = [109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99]
        let result = Computer.run(program: program, inputs: [])
        XCTAssertEqual(result, program)
    }

    func testOutputLargeNumber() {
        let program = [1102,34915192,34915192,7,4,7,99,0]
        let result = Computer.run(program: program, inputs: [])
        XCTAssertEqual(result, [1_219_070_632_396_864])
    }

    func testOutputAnotherLargeNumber() {
        let program = [104,1125899906842624,99]
        let result = Computer.run(program: program, inputs: [])
        XCTAssertEqual(result, [1125899906842624])
    }
}
