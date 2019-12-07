//: [Previous](@previous)

import Foundation
import Intcode

func execute(input: String) {
    let numbers = input.split(separator: ",").map(String.init).compactMap(Int.init)
    var computer = Computer(memory: numbers)
    computer.run()
}

execute(input: "1,9,10,3,2,3,11,0,99,30,40,50")
execute(input: "1,0,0,0,99")
execute(input: "2,3,0,3,99")
execute(input: "2,4,4,5,99,0")
execute(input: "1,1,1,4,99,5,6,0,99")

let fileURL = Bundle.main.url(forResource: "day2.input", withExtension: "txt")!
let day2string = try! String(contentsOf: fileURL)
var day2program = day2string.split(separator: ",").map(String.init).compactMap(Int.init)

func computeResult(noun: Int, verb: Int) -> Int {
    var thisProgram = day2program
    thisProgram[1] = noun
    thisProgram[2] = verb
    var computer = Computer(memory: thisProgram)
    computer.run()
    return computer.memory[0]
}

print(computeResult(noun: 12, verb: 2))

mainLoop: for noun in 0..<100 {
    for verb in 0..<100 {
        let result = computeResult(noun: noun, verb: verb)
        if result == 19690720 {
            print("found it!")
            print("answer is \(100 * noun + verb)")
            break mainLoop
        }
    }
}

//: [Next](@next)
