//: [Previous](@previous)

import Foundation

struct Computer {
    var memory: [Int]
    var pc = 0
    var crashed = false
    var halted = false

    mutating func step() {
        guard !crashed && !halted else { return }
        let opcode = memory[pc]
        switch opcode {
        case 1:
            let sum = memory[memory[pc + 1]] + memory[memory[pc + 2]]
            memory[memory[pc + 3]] = sum
            pc += 4
        case 2:
            let product = memory[memory[pc + 1]] * memory[memory[pc + 2]]
            memory[memory[pc + 3]] = product
            pc += 4
        case 99:
            halted = true
        default:
            print("crashed!")
            crashed = true
        }
    }

    mutating func run() {
        while !crashed && !halted {
            step()
            print(pc, memory)
        }
        print("done!")
    }
}

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

day2program[1] = 12
day2program[2] = 2

var computer = Computer(memory: day2program)
computer.run()

//: [Next](@next)
