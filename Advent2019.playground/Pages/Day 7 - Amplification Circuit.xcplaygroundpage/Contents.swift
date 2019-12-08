//: [Previous](@previous)

import Foundation
import Intcode
import AdventLib

struct Amp {
    var program: [Int]

    func run(input: Int, phase: Int) -> Int {
        return Computer.run(program: program, inputs: [phase, input]).first ?? Int.min
    }
}

var amp = Amp(program: [3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0])
print(amp.run(input: 0, phase: 4))
print(amp.run(input: 4, phase: 3))
print(amp.run(input: 43, phase: 2))
print(amp.run(input: 432, phase: 1))
print(amp.run(input: 4321, phase: 0))

let phases = [0, 1, 2, 3, 4]
let permutations = phases.permute()
print(permutations)

func findBestPhase(program: [Int]) -> Int {
    let amp = Amp(program: program)

    var bestScore = Int.min
    for permutation in permutations {
        var level = 0
        for phase in permutation {
            level = amp.run(input: level, phase: phase)
        }
        bestScore = max(bestScore, level)
    }
    return bestScore
}

//print(findBestPhase(program: [3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0]))
//print(findBestPhase(program: [3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0]))
//print(findBestPhase(program: [3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0]))

let fileURL = Bundle.main.url(forResource: "day7.input", withExtension: "txt")!
let day7string = try! String(contentsOf: fileURL).trimmingCharacters(in: .whitespacesAndNewlines)
let day7program = day7string.split(separator: ",").map(String.init).compactMap(Int.init)

print(findBestPhase(program: day7program))

//     part 2

struct NewAmp {
    var computer: Computer
    init(memory: [Int], phase: Int) {
        self.computer = Computer(memory: memory)
        self.computer.input(line: phase)
    }

    mutating func cycle(input: Int) -> Int? {
        computer.input(line: input)
        computer.runToOutput()
        let result = computer.output.first
        computer.resetOutput()
        return result
    }
}

struct Thruster {
    var amps: [NewAmp]
    var lastOutput = 0
    var finished = false

    init(memory: [Int], phases: [Int]) {
        amps = phases.map { NewAmp(memory: memory, phase: $0) }
    }

    mutating func cycle() {
        var input = lastOutput
        for i in 0..<amps.count {
            guard let nextInput = amps[i].cycle(input: input) else {
                finished = true
                return
            }
            input = nextInput
        }
        lastOutput = input
    }

    mutating func bestOutput() -> Int {
        while !finished {
            cycle()
        }
        return lastOutput
    }
}

func realThruster(program: [Int]) -> Int {
    var bestResult = Int.min
    var bestPhase = [Int]()
    let phases = [9,8,7,6,5]
    let permutations = phases.permute()
    for permutation in permutations {
        var thruster = Thruster(memory: program, phases: permutation)
        let result = thruster.bestOutput()
        if result > bestResult {
            bestResult = result
            bestPhase = permutation
        }
    }
    print("bestPhase: ", bestPhase)
    return bestResult
}

//let thrusterProgram1 = [3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5]
//print(realThruster(program: thrusterProgram1))

//let thrusterProgram2 = [3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,54,
//-5,54,1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,55,53,4,
//53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10]
//print(realThruster(program: thrusterProgram2))

print(realThruster(program: day7program))

//: [Next](@next)
