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
    var amp = Amp(program: program)

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
//: [Next](@next)
