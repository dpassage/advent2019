//
//  Day01RocketEquation.swift
//  
//
//  Created by David Paschich on 12/5/20.
//

import Foundation
import AdventLib

// answer is 3216744
public func day01part1() {

    let lines = readlines()

    let result = lines
        .compactMap(Int.init)
        .map(fuel(mass:))
        .reduce(0, +)

    print(result)
}

// answer is 4822249
public func day01part2() {

    let lines = readlines()

    let result = lines
        .compactMap(Int.init)
        .map(allFuel(mass:))
        .reduce(0, +)

    print(result)
}

func readlines() -> [String] {
    var result = [String]()
    while let line = readLine() {
        result.append(line)
    }
    return result
}

func fuel(mass: Int) -> Int {
    return (mass / 3) - 2
}

func allFuel(mass: Int) -> Int {
    let thisFuel = fuel(mass: mass)
    if thisFuel <= 0 { return 0 }
    return thisFuel + allFuel(mass: thisFuel)
}
