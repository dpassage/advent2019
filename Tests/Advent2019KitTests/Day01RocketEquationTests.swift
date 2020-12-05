//
//  Day01RocketEquationTests.swift
//  
//
//  Created by David Paschich on 12/5/20.
//

import XCTest
@testable import Advent2019Kit
import AdventLib

class Day01RocketEquationTests: XCTestCase {
    /*
     For a mass of 12, divide by 3 and round down to get 4, then subtract 2 to get 2.
     For a mass of 14, dividing by 3 and rounding down still yields 4, so the fuel required is also 2.
     For a mass of 1969, the fuel required is 654.
     For a mass of 100756, the fuel required is 33583.
     */
    func testFuel() {
        let cases: [(Int, Int)] = [
            (12, 2),
            (14, 2),
            (1969, 654),
            (100756, 33583)
        ]
        for test in cases {
            XCTAssertEqual(fuel(mass: test.0), test.1)
        }
    }
}

