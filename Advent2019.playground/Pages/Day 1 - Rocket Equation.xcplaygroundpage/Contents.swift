//: [Previous](@previous)

import Foundation
import AdventLib

func fuel(mass: Int) -> Int {
    return (mass / 3) - 2
}

print(fuel(mass: 12))
print(fuel(mass: 14))
print(fuel(mass: 1969))
print(fuel(mass: 100756))


let fileURL = Bundle.main.url(forResource: "day1.input", withExtension: "txt")!
let day1 = try! String(contentsOf: fileURL)
let day1lines = day1.components(separatedBy: "\n")

let result = day1lines
    .compactMap(Int.init)
    .map(fuel(mass:))
    .reduce(0, +)

print(result)

//: [Next](@next)
