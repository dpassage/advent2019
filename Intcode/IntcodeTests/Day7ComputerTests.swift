//
//  Day7ComputerTests.swift
//  IntcodeTests
//
//  Created by David Paschich on 12/8/19.
//  Copyright © 2019 David Paschich. All rights reserved.
//

import XCTest
@testable import Intcode

class Day7ComputerTests: XCTestCase {

    func testRunToOutput() {
        let program = [3,0,4,0,4,0,99]
        var computer1 = Computer(memory: program)
        computer1.input(line: 4)
        computer1.runToOutput()
        XCTAssertEqual(computer1.output, [4])
        XCTAssertEqual(computer1.pc, 4)
        XCTAssertFalse(computer1.halted)
        computer1.resetOutput()
        computer1.runToOutput()
        XCTAssertEqual(computer1.output, [4])
        XCTAssertEqual(computer1.pc, 6)
        XCTAssertFalse(computer1.halted)
        computer1.resetOutput()
        computer1.runToOutput()
        XCTAssertEqual(computer1.output, [])
        XCTAssertEqual(computer1.pc, 6)
        XCTAssertTrue(computer1.halted)
    }
}
