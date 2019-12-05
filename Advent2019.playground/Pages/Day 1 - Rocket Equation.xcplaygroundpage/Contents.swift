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


func allFuel(mass: Int) -> Int {
    let thisFuel = fuel(mass: mass)
    if thisFuel <= 0 { return 0 }
    return thisFuel + allFuel(mass: thisFuel)
}

print(allFuel(mass: 14))
print(allFuel(mass: 1969))
print(allFuel(mass: 100756))

let part2 = day1lines
    .compactMap(Int.init)
    .map(allFuel(mass:))
    .reduce(0, +)

print(part2)

//: [Next](@next)
