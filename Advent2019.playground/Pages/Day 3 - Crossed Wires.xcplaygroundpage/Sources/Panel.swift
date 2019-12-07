import Foundation


// swiftlint:disable identifier_name
public struct Point {
    public var x: Int
    public var y: Int

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    public static let origin = Point(x: 0, y: 0)
}

extension Point: Hashable {}

extension Point: Comparable {
    public static func < (lhs: Point, rhs: Point) -> Bool {
        if lhs.y == rhs.y {
            return lhs.x < rhs.x
        }
        return lhs.y < rhs.y
    }

    public static func + (lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    public static func - (lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
}

extension Point {
    public func adjacents() -> [Point] {
        return [
            Point(x: x + 1, y: y),
            Point(x: x - 1, y: y),
            Point(x: x, y: y + 1),
            Point(x: x, y: y - 1)
        ]
    }

    public func allAdjacents() -> [Point] {
        return [
            Point(x: x + 1, y: y),
            Point(x: x - 1, y: y),
            Point(x: x, y: y + 1),
            Point(x: x, y: y - 1),
            Point(x: x + 1, y: y + 1),
            Point(x: x - 1, y: y + 1),
            Point(x: x + 1, y: y - 1),
            Point(x: x - 1, y: y - 1)
        ]
    }

    public func distance(from other: Point) -> Int {
        return abs(x - other.x) + abs(y - other.y)
    }
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
