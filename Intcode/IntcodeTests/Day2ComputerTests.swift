//
//  ComputerTests.swift
//  IntcodeTests
//
//  Created by David Paschich on 12/7/19.
//  Copyright © 2019 David Paschich. All rights reserved.
//

import XCTest
@testable import Intcode

class Day2ComputerTests: XCTestCase {

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
