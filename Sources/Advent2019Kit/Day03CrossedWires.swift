//
//  Day03CrossedWires.swift
//  
//
//  Created by David Paschich on 12/5/20.
//

import Foundation
import AdventLib

// answer was 316
public func day03part1() {
    let input = readlines()
    print(nearestCrossing(wires: input))
}

// answer was 16368
public func day03part2() {
    let input = readlines()
    print(shortestCrossing(wires: input))
}

func nearestCrossing(wires: [String]) -> Int {
    var panel = Panel()
    for (index, wire) in wires.enumerated() {
        panel.addWire(wire, index: index)
    }
    return  panel.nearestCrossingDistance()
}

func shortestCrossing(wires: [String]) -> Int {
    var panel = Panel()
    for (index, wire) in wires.enumerated() {
        panel.addWire(wire, index: index)
    }
    return panel.shortestCrossingDistance()
}

// A Field is a 2-dimensional "array" of infinite extent.
struct Field<Element> {
    var defaultValue: Element
    var storage: [Point: Element] = [:]
    init(defaultValue: Element) {
        self.defaultValue = defaultValue
    }

    subscript(position: Point) -> Element {
        get {
            return storage[position] ?? defaultValue
        }
        set {
            storage[position] = newValue
        }
    }

    // rectangle containing all values which have been set
    func extent() -> (Point, Point) {
        var lowest = Int.max
        var highest = Int.min
        var leftmost = Int.max
        var rightmost = Int.min
        for key in storage.keys {
            lowest = min(lowest, key.y)
            highest = max(highest, key.y)
            leftmost = min(leftmost, key.x)
            rightmost = max(rightmost, key.x)
        }
        return (Point(x: leftmost, y: lowest), Point(x: rightmost, y: highest))
    }
}

public struct Panel {
    var field: Field<Int> = Field(defaultValue: 0)
    var wirePoints: [[Point]] = []
    var crossings: [Point] = []
    public init() {}

    public mutating func addWire(_ wire: String, index: Int) {
        let segments = wire.split(separator: ",").map(String.init)
        var position = Point.origin
        var points = [Point]()
        loop: for var segment in segments {
            let direction = segment.removeFirst()
            let distance = Int(segment)!
            print(direction, distance)
            let delta: Point
            switch direction {
            case "R":
                delta = Point(x: 1, y: 0)
            case "L":
                delta = Point(x: -1, y: 0)
            case "U":
                delta = Point(x: 0, y: 1)
            case "D":
                delta = Point(x: 0, y: -1)
            default:
                print("bad direction \(direction)")
                continue loop
            }

            for _ in 0..<distance {
                position = position + delta
                field[position] |= (1 << index)
                points.append(position)
            }
        }
        wirePoints.append(points)
    }

    mutating func computeCrossings() {
        guard crossings.isEmpty else { return }
        for (point, value) in field.storage {
            if value > 2 {
                print("crossing at \(point) value \(value)")
                crossings.append(point)
            }
        }
    }
    func printField() {
        let (lowerLeft, upperRight) = field.extent()
        for y in ((lowerLeft.y)...(upperRight.y)).reversed() {
            for x in (lowerLeft.x)...(upperRight.x) {
                print(field[Point(x: x, y: y)], terminator: "")
            }
            print()
        }
    }

    // Manhattan distance to crossing nearest the origin
    public mutating func nearestCrossingDistance() -> Int {
        computeCrossings()
        var result = Int.max
        for point in crossings {
            let distance = point.distance(from: .origin)
            print("crossing at \(point) distance \(distance)")
            result = min(result, distance)
        }
        return result
    }

    // Sum of distances along both wires to the nearest intersection
    public mutating func shortestCrossingDistance() -> Int {
        computeCrossings()
        var result = Int.max
        for point in crossings {
            print("crossing \(point)")
            var totalDistance = 0
            for (wireIndex, wire) in wirePoints.enumerated() {
                for (pointIndex, wirePoint) in wire.enumerated() {
                    if point == wirePoint {
                        print("wire \(wireIndex) distance \(pointIndex + 1)")
                        totalDistance += (pointIndex + 1)
                    }
                }
            }
            result = min(result, totalDistance)
        }

        return result
    }
}
