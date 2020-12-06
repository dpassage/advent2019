//
//  Day10MonitoringStationTests.swift
//  
//
//  Created by David Paschich on 12/5/20.
//

import XCTest
@testable import Advent2019Kit
import AdventLib

class Day10MonitoringStationTests: XCTestCase {
    func testBestLocation() {
        let input =
        """
        .#..#
        .....
        #####
        ....#
        ...##
        """
        let asteroidField = AsteroidField(text: input)
        let (bestPoint, bestSeen) = asteroidField.bestAsteriodsSeen()
        XCTAssertEqual(Point(x: 3, y: 4), bestPoint)
        XCTAssertEqual(8, bestSeen)
    }

    func testLasers() {
        let input =
        """
        .#....#####...#..
        ##...##.#####..##
        ##...#...#.#####.
        ..#.....#...###..
        ..#.#.....#....##
        """

        let field = AsteroidField(text: input)
        let (bestPoint, _) = field.bestAsteriodsSeen()
        XCTAssertEqual(bestPoint, Point(x: 8, y: 3))

        let list = field.frickinLasers(start: bestPoint, limit: 2)
        XCTAssertEqual(list[0], Point(x: 8, y: 1))
        XCTAssertEqual(list[1], Point(x: 9, y: 0))
    }

    func testLargeLasers() {
        let input =
        """
        .#..##.###...#######
        ##.############..##.
        .#.######.########.#
        .###.#######.####.#.
        #####.##.#.##.###.##
        ..#####..#.#########
        ####################
        #.####....###.#.#.##
        ##.#################
        #####.##.###..####..
        ..######..##.#######
        ####.##.####...##..#
        .#####..#.######.###
        ##...#.##########...
        #.##########.#######
        .####.#.###.###.#.##
        ....##.##.###..#####
        .#.#.###########.###
        #.#.#.#####.####.###
        ###.##.####.##.#..##
        """

        let field = AsteroidField(text: input)
        let (bestPoint, _) = field.bestAsteriodsSeen()
        XCTAssertEqual(bestPoint, Point(x: 11, y:13))

        let list = field.frickinLasers(start: bestPoint, limit: 200)
        XCTAssertEqual(list[0], Point(x: 11, y: 12))
        XCTAssertEqual(list[1], Point(x: 12, y: 1))
        XCTAssertEqual(list[199], Point(x: 8, y: 2))
    }
}
