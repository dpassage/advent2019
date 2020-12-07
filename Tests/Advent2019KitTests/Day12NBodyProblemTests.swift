//
//  Day12NBodyProblemTests.swift
//  
//
//  Created by David Paschich on 12/6/20.
//

import XCTest
@testable import Advent2019Kit

class NBodyProblemTests: XCTestCase {
    func testParseMoon() {
        let input = "<x=-1, y=0, z=2>"
        let moon = Moon(line: input)
        XCTAssertEqual(moon?.position, [-1, 0, 2])
    }

    func testSample() {
        let input =
        """
        <x=-1, y=0, z=2>
        <x=2, y=-10, z=-7>
        <x=4, y=-8, z=8>
        <x=3, y=5, z=-1>
        """
        let lines = input.split(separator: "\n").map(String.init)

        let result = simulate(lines, steps: 10)
        XCTAssertEqual(result, 179)
    }

    func testSample2() {
        let input =
        """
        <x=-8, y=-10, z=0>
        <x=5, y=5, z=10>
        <x=2, y=-7, z=3>
        <x=9, y=-8, z=-3>
        """
        let lines = input.split(separator: "\n").map(String.init)

        let result = simulate(lines, steps: 100)
        XCTAssertEqual(result, 1940)
    }

    // part 2
    func testCycle() {
        let input =
        """
        <x=-1, y=0, z=2>
        <x=2, y=-10, z=-7>
        <x=4, y=-8, z=8>
        <x=3, y=5, z=-1>
        """
        let lines = input.split(separator: "\n").map(String.init)
        let result = findAllCycles(lines)
        XCTAssertEqual(result, 2772)
    }

    func testLongCycle() {
        let input =
        """
        <x=-8, y=-10, z=0>
        <x=5, y=5, z=10>
        <x=2, y=-7, z=3>
        <x=9, y=-8, z=-3>
        """
        let lines = input.split(separator: "\n").map(String.init)
        let result = findAllCycles(lines)
        XCTAssertEqual(result, 4_686_774_924)
    }
}
