//
//  Day12CarePackageTests.swift
//  
//
//  Created by David Paschich on 12/6/20.
//

import XCTest
@testable import Advent2019Kit

class CarePackageTests: XCTestCase {
    func testSampleBoard() {
        let output = [1,2,3,6,5,4]

        var cabinet = ArcadeCabinet(program: [])
        cabinet.startup(output)
        XCTAssertEqual(cabinet.ballTiles(), 1)
    }
}
