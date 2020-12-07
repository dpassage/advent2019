//
//  File.swift
//  
//
//  Created by David Paschich on 12/6/20.
//

import XCTest
@testable import Intcode

class Day13ComputerTests: XCTestCase {
    func testWaitsForInput() {
        let program = [3]

        var computer = Computer(memory: program)
        computer.runToIO()
        XCTAssertTrue(computer.awaitingInput)
    }
}
