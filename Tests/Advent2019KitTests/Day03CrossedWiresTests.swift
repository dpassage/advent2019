//
//  Day03CrossedWiresTests.swift
//  
//
//  Created by David Paschich on 12/5/20.
//

import XCTest
@testable import Advent2019Kit
class CrossedWiresTests: XCTestCase {
    func testNearestDistance() {
        let wires = ["R8,U5,L5,D3", "U7,R6,D4,L4"]
        let result = nearestCrossing(wires: wires)
        XCTAssertEqual(result, 6)
    }

    func testNearestDistance2() {
        let wires = ["R75,D30,R83,U83,L12,D49,R71,U7,L72", "U62,R66,U55,R34,D71,R55,D58,R83"]
        let result = nearestCrossing(wires: wires)
        XCTAssertEqual(result, 159)
    }
    func testNearestDistanc3() {
        let wires = ["R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51", "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"]
        let result = nearestCrossing(wires: wires)
        XCTAssertEqual(result, 135)
    }
}
