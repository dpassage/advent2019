//: [Previous](@previous)

import Foundation

Computer.execute(program: "3,0,4,0,99", inputs: ["2135"])

Computer.execute(program: "1002,4,3,4,33")


let fileURL = Bundle.main.url(forResource: "day5.input", withExtension: "txt")!
let day5string = try! String(contentsOf: fileURL)

Computer.execute(program: day5string, inputs: ["1"])

//: [Next](@next)
