//: [Previous](@previous)

import Foundation
import Intcode

Computer.execute(program: "3,0,4,0,99", inputs: [2135])

Computer.execute(program: "1002,4,3,4,33")


let fileURL = Bundle.main.url(forResource: "day5.input", withExtension: "txt")!
let day5string = try! String(contentsOf: fileURL)

Computer.execute(program: day5string, inputs: [1])

//Here are some jump tests that take an input, then output 0 if the input was zero or 1 if the input was non-zero:
//
//3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9 (using position mode)
Computer.execute(program: "3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9", inputs: [1])
Computer.execute(program: "3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9", inputs: [0])

//3,3,1105,-1,9,1101,0,0,12,4,12,99,1 (using immediate mode)
Computer.execute(program: "3,3,1105,-1,9,1101,0,0,12,4,12,99,1", inputs: [1])
Computer.execute(program: "3,3,1105,-1,9,1101,0,0,12,4,12,99,1", inputs: [0])

let largerExample = """
3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99
"""
Computer.execute(program: largerExample, inputs: [7])
Computer.execute(program: largerExample, inputs: [8])
Computer.execute(program: largerExample, inputs: [9])

Computer.execute(program: day5string, inputs: [5]) // 2435224 is too high

//Computer.execute(program: "101,-1,7,7,4,7,1105,11,0,99")


//: [Next](@next)
