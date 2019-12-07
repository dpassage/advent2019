//: [Previous](@previous)

import Foundation
import Intcode

let fileURL = Bundle.main.url(forResource: "day5.input", withExtension: "txt")!
let day5string = try! String(contentsOf: fileURL).trimmingCharacters(in: .whitespacesAndNewlines)
let day5program = day5string.split(separator: ",").map(String.init).compactMap(Int.init)

print(Computer.run(program: day5program, inputs: [1]))

print(Computer.run(program: day5program, inputs: [5])) // 2435224 is too high; 2369720 is corrrect!

//: [Next](@next)
