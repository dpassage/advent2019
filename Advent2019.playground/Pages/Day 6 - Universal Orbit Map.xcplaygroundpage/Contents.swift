//: [Previous](@previous)

import Foundation

struct OrbitMap {
    // maps an object to the thing it's orbiting (its "parent")
    var orbits: [String: String] = [:]

    mutating func insert(line: String) {
        let parts = line.split(separator: ")").map(String.init)
        let parent = parts[0]
        let child = parts[1]
        orbits[child] = parent
    }

    func countOrbits() -> Int {
        var totalOrbits = 0
        for object in orbits.keys {
            var current: String? = orbits[object]
            while current != nil {
                totalOrbits += 1
                current = orbits[current!]
            }
        }
        return totalOrbits
    }

    func fullPath(object: String) -> [String] {
        var result = [String]()
        var current = object
        while let parent = orbits[current] {
            result.insert(parent, at: 0)
            current = parent
        }
        return result
    }

    func transfers() -> Int {
        var youPath = fullPath(object: "YOU")
        print(youPath)
        var santaPath = fullPath(object: "SAN")
        print(santaPath)
        while !youPath.isEmpty, !santaPath.isEmpty, youPath[0] == santaPath[0] {
            youPath.removeFirst()
            santaPath.removeFirst()
        }
        return youPath.count + santaPath.count
    }
}

var exampleMap = OrbitMap()

let testInput = """
COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
"""

let lines = testInput.split(separator: "\n").map(String.init)
for line in lines {
    exampleMap.insert(line: line)
}
print(exampleMap.countOrbits())
print(exampleMap.fullPath(object: "L"))

exampleMap.insert(line: "K)YOU")
exampleMap.insert(line: "I)SAN")
print(exampleMap.transfers())

let fileURL = Bundle.main.url(forResource: "day6.input", withExtension: "txt")!
let day6string = try! String(contentsOf: fileURL)
let day6lines = day6string.split(separator: "\n").map(String.init)

var fullMap = OrbitMap()
for line in day6lines {
    fullMap.insert(line: line)
}
print(fullMap.countOrbits())
print(fullMap.transfers())

//: [Next](@next)
