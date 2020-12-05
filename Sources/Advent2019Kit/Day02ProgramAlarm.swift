//
//  Day02ProgramAlarm.swift
//  
//
//  Created by David Paschich on 12/5/20.
//

import Foundation
import Intcode

// answer was 6327510
public func day02part1() {
    let lines = readlines()
    let program = lines[0].split(separator: ",").map(String.init).compactMap(Int.init)

    let result = computeResult(program: program, noun: 12, verb: 2)
    print(result)
}

// answer was 4112
public func day02part2() {
    let lines = readlines()
    let program = lines[0].split(separator: ",").map(String.init).compactMap(Int.init)

    for noun in 0..<100 {
        for verb in 0..<100 {
            let result = computeResult(program: program, noun: noun, verb: verb)
            if result == 19690720 {
                print("found it!")
                print("answer is \(100 * noun + verb)")
                return
            }
        }
    }
}

func computeResult(program: [Int], noun: Int, verb: Int) -> Int {
    var thisProgram = program
    thisProgram[1] = noun
    thisProgram[2] = verb
    var computer = Computer(memory: thisProgram)
    computer.run()
    return computer.memory[0]
}
