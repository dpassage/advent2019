import Foundation
import AdventLib



public struct AsteroidField {
    var grid: Rect<Bool>

    public init(text: String) {
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

    public func asteroidsSeen(from origin: Point) -> Int {
        var asteriodSlopes = Set<Rational>()
        for x in 0..<grid.width {
            for y in 0..<grid.height {
                let here = Point(x: x, y: y)
                guard grid[here] else { continue }
                guard here != origin else { continue }
                let difference = here - origin
                let slope = Rational(numerator: difference.y, denominator: difference.x)
//                print("point \(here) slope \(slope)")
                asteriodSlopes.insert(slope)
            }
        }

        return asteriodSlopes.count
    }

    public func bestAsteriodsSeen() -> Int {
        var bestSoFar = Int.min
        for x in 0..<grid.width {
            for y in 0..<grid.width {
                let asteroid = Point(x: x, y: y)
                guard grid[asteroid] else { continue }
                let seen = asteroidsSeen(from: asteroid)
//                print("asteroid \(asteroid) sees \(seen)")
                bestSoFar = max(seen, bestSoFar)
            }
        }
        return bestSoFar
    }
}
