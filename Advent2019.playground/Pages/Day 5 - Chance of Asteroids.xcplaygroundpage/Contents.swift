//: [Previous](@previous)

import Foundation
import Intcode

let fileURL = Bundle.main.url(forResource: "day5.input", withExtension: "txt")!
let day5string = try! String(contentsOf: fileURL)

Computer.execute(program: day5string, inputs: [1])

Computer.execute(program: day5string, inputs: [5]) // 2435224 is too high

//: [Next](@next)
