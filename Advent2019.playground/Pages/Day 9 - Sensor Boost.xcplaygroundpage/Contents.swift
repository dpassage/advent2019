//: [Previous](@previous)

import Foundation
import Intcode

let fileURL = Bundle.main.url(forResource: "day9.input", withExtension: "txt")!
let day9string = try! String(contentsOf: fileURL).trimmingCharacters(in: .whitespacesAndNewlines)
let day9program = day9string.split(separator: ",").map(String.init).compactMap(Int.init)

Computer.run(program: day9program, inputs: [1])
Computer.run(program: day9program, inputs: [2])

//: [Next](@next)
