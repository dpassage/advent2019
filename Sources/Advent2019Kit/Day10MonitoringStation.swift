//
//  Day10MonitoringStation.swift
//  
//
//  Created by David Paschich on 12/5/20.
//

import Foundation


import Foundation
import AdventLib

extension Point {
    // returns a point with the same slope and the lowest possible values
    func normalized() -> Point {
        if self == Point(x: 0, y: 0) { return self }
        if x == 0 {
            let newY = (y < 0 ? -1 : 1)
            return Point(x: 0, y: newY)
        }
        if y == 0 {
            let newX = (x < 0 ? -1 : 1)
            return Point(x: newX, y: 0)
        }

        func gcd(a: Int, b: Int) -> Int {
            if a == b {
                return a
            } else if a > b {
                return gcd(a: a - b, b: b)
            } else { // b < a
                return gcd(a: a, b: b - a)
            }
        }

        let divisor = gcd(a: abs(x), b: abs(y))
        return Point(x: x / divisor, y: y / divisor)
    }

    var quadrant: Int {
        if x >= 0 && y > 0 { return 0 }
        if x > 0 && y <= 0 { return 1 }
        if x <= 0 && y < 0 { return 2 }
        if x < 0 && y >= 0 { return 3 }
        return -1
    }

    var slope: Double {
        if x == 0 { return y > 0 ? Double.infinity : -Double.infinity }
        return Double(y) / Double(x)
    }

    // returns true if self is clockwise of other,
    // starting at the positive y axis
    func clockwiseOf(_ other: Point) -> Bool {
        if self.quadrant == other.quadrant {
            return self.slope < other.slope
        } else {
            return self.quadrant > other.quadrant
        }
    }

    var magnitude: Int {
        return (x * x) + (y * y)
    }
}

struct AsteroidField {
    var grid: Rect<Bool>

    init(text: String) {
        let lines = text.split(separator: "\n")
        let width = lines[0].count
        let height = lines.count
        grid = Rect(width: width, height: height, defaultValue: false)
        for (y, line) in lines.enumerated() {
            for (x, char) in String(line).chars.enumerated() {
                grid[x, y] = (char != ".") ? true : false
            }
        }
    }

    func asteroidsSeen(from origin: Point) -> Int {
        var asteriodSlopes = Set<Rational>()
        for x in 0..<grid.width {
            for y in 0..<grid.height {
                let here = Point(x: x, y: y)
                guard grid[here] else { continue }
                guard here != origin else { continue }
                let difference = here - origin
                let slope = Rational(numerator: difference.y, denominator: difference.x)
                asteriodSlopes.insert(slope)
            }
        }

        return asteriodSlopes.count
    }

    func bestAsteriodsSeen() -> (Point, Int) {
        var bestSoFar = Int.min
        var bestPoint = Point(x: Int.min, y: Int.min)
        for x in 0..<grid.width {
            for y in 0..<grid.height {
                let asteroid = Point(x: x, y: y)
                guard grid[asteroid] else { continue }
                let seen = asteroidsSeen(from: asteroid)
                if seen > bestSoFar {
                    bestSoFar = seen
                    bestPoint = asteroid
                }
            }
        }
        return (bestPoint, bestSoFar)
    }

    func frickinLasers(start: Point, limit: Int) -> [Point] {
        var result = [Point]()

        var asteroids: [Point: [Point]] = [:]

        // first build the array
        for x in 0..<grid.width {
            for y in 0..<grid.height {
                let asteroid = Point(x: x, y: y)
                if asteroid == start { continue }

                let norm = asteroid.normalized()
                asteroids[norm, default: []].append(asteroid)
                asteroids[norm]?.sort(by: { $0.magnitude < $1.magnitude })
            }
        }

        print(asteroids)

        return result
    }
}
