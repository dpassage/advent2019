//
//  File.swift
//  
//
//  Created by David Paschich on 12/7/20.
//

import XCTest
@testable import Advent2019Kit

class SpaceStoiciometryTests: XCTestCase {
    func testParseRule() {
        let input = "15 XDBXC, 2 LTCX, 1 VRPVC => 6 ZLQW"
        let rule = OreRule(input)!
        XCTAssertEqual(rule.output.0, 6)
        XCTAssertEqual(rule.output.1, "ZLQW")
        XCTAssertEqual(rule.inputs.count, 3)
    }

    func testTopoSort() {
        let input =
            """
            2 VPVL, 7 FWMGM, 2 CXFTF, 11 MNCFX => 1 STKFG
            17 NVRVD, 3 JNWZP => 8 VPVL
            53 STKFG, 6 MNCFX, 46 VJHF, 81 HVMC, 68 CXFTF, 25 GNMV => 1 FUEL
            22 VJHF, 37 MNCFX => 5 FWMGM
            139 ORE => 4 NVRVD
            144 ORE => 7 JNWZP
            5 MNCFX, 7 RFSQX, 2 FWMGM, 2 VPVL, 19 CXFTF => 3 HVMC
            5 VJHF, 7 MNCFX, 9 VPVL, 37 CXFTF => 6 GNMV
            145 ORE => 6 MNCFX
            1 NVRVD => 8 CXFTF
            1 VJHF, 6 MNCFX => 4 RFSQX
            176 ORE => 6 VJHF
            """
        let rules = input.components(separatedBy: "\n").compactMap(OreRule.init)
        let sorted = topoSort(rules)
        XCTAssertEqual(sorted.count, rules.count)
        XCTAssertEqual(sorted.first?.inputs.first?.1, "ORE")
        XCTAssertEqual(sorted.last?.output.1, "FUEL")
    }

    func testSample1() {
        let input =
        """
        10 ORE => 10 A
        1 ORE => 1 B
        7 A, 1 B => 1 C
        7 A, 1 C => 1 D
        7 A, 1 D => 1 E
        7 A, 1 E => 1 FUEL
        """
        let lines = input.components(separatedBy: "\n")
        let result = computeOreForFuel(input: lines)
        XCTAssertEqual(result, 31)
    }

    func testSample2() {
        let input =
        """
        157 ORE => 5 NZVS
        165 ORE => 6 DCFZ
        44 XJWVT, 5 KHKGT, 1 QDVJ, 29 NZVS, 9 GPVTF, 48 HKGWZ => 1 FUEL
        12 HKGWZ, 1 GPVTF, 8 PSHF => 9 QDVJ
        179 ORE => 7 PSHF
        177 ORE => 5 HKGWZ
        7 DCFZ, 7 PSHF => 2 XJWVT
        165 ORE => 2 GPVTF
        3 DCFZ, 7 NZVS, 5 HKGWZ, 10 PSHF => 8 KHKGT
        """
        let lines = input.components(separatedBy: "\n")
        let result = computeOreForFuel(input: lines)
        XCTAssertEqual(result, 13312)
    }
    func testSample3() {
        let input =
        """
        2 VPVL, 7 FWMGM, 2 CXFTF, 11 MNCFX => 1 STKFG
        17 NVRVD, 3 JNWZP => 8 VPVL
        53 STKFG, 6 MNCFX, 46 VJHF, 81 HVMC, 68 CXFTF, 25 GNMV => 1 FUEL
        22 VJHF, 37 MNCFX => 5 FWMGM
        139 ORE => 4 NVRVD
        144 ORE => 7 JNWZP
        5 MNCFX, 7 RFSQX, 2 FWMGM, 2 VPVL, 19 CXFTF => 3 HVMC
        5 VJHF, 7 MNCFX, 9 VPVL, 37 CXFTF => 6 GNMV
        145 ORE => 6 MNCFX
        1 NVRVD => 8 CXFTF
        1 VJHF, 6 MNCFX => 4 RFSQX
        176 ORE => 6 VJHF
        """
        let lines = input.components(separatedBy: "\n")
        let result = computeOreForFuel(input: lines)
        XCTAssertEqual(result, 180697)
    }

}
