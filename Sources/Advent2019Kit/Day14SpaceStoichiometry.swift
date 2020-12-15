//
//  Day14SpaceStoichiometry.swift
//  
//
//  Created by David Paschich on 12/7/20.
//

import Foundation
import AdventLib

// at last! right answer is 1046184
public func day14part1() {
    let lines = readlines()

    let result = computeOreForFuel(input: lines)
    print(result)
}

// 1639374 was right!
public func day14part2() {
    let lines = readlines()
    let input = lines.joined(separator: "\n")
    let result = findFuel(ore: 1000000000000, input: input)
    print(result)
}

func computeOreForFuel(input: [String]) -> Int {
    let rules: [OreRule] = input.compactMap(OreRule.init(_:))

    let sortedRules = [OreRule](topoSort(rules).reversed())

    return computeOreSortedRules(sortedRules, fuel: 1)
}

func computeOreSortedRules(_ sortedRules: [OreRule], fuel: Int) -> Int {
    var factory = NanoFactory(fuel: fuel)

    for rule in sortedRules {
//        print("applying \(rule)")
        factory.apply(rule)
    }

    if !factory.finished {
        print("didn't work!")
        return -1
    }
    return factory.ore
}

// from wikipedia
func topoSort(_ rules: [OreRule]) -> [OreRule] {
    // nodes are "named" by their output chemical
    var permanentMark: Set<String> = []
    var temporaryMark: Set<String> = []
    var result: [OreRule] = []

    func visit(_ rule: OreRule) {
        if permanentMark.contains(rule.output.1) { return }
        if temporaryMark.contains(rule.output.1) { fatalError("not a DAG") }
        temporaryMark.insert(rule.output.1)

        for (_, inputName) in rule.inputs {
            if let nextRule = rules.first(where: { $0.output.1 == inputName}){
                visit(nextRule)
            }
        }

        temporaryMark.remove(rule.output.1)
        permanentMark.insert(rule.output.1)
        result.append(rule)
    }
    while permanentMark.count < rules.count {
        if let nextRule = rules.first(where: { !permanentMark.contains($0.output.1) }) {
            visit(nextRule)
        }
    }
    return result
}

struct NanoFactory {

    init(fuel: Int) {
        chemicals = ["FUEL": fuel]
    }
    var chemicals: [String: Int]
    var ore: Int = 0
    var total: Int { return ore + chemicals.values.reduce(0, +) }
    var finished: Bool { return chemicals.isEmpty }

    mutating func apply(_ rule: OreRule) {
        guard let targetAmount = chemicals.removeValue(forKey: rule.output.1) else {
            fatalError("cannot apply \(rule)")
        }

        let applications = (targetAmount / rule.output.0) + (targetAmount % rule.output.0 == 0 ? 0 : 1)

        for input in rule.inputs {
            if input.1 == "ORE" {
                ore += (input.0 * applications)
            } else {
                chemicals[input.1, default: 0] += (input.0 * applications)
            }
        }
    }
}

struct OreRule {
    var output: (Int, String)
    var inputs: [(Int, String)] = []

    init?(_ input: String) {
        var parts = input.components(separatedBy: " ")
        while parts.first != "=>" {
            let size = Int(parts.removeFirst())!
            let name = parts.removeFirst().trimmingCharacters(in: CharacterSet([","]))
            inputs.append((size, name))
        }
        parts.removeFirst() // drop =>
        let size = Int(parts.removeFirst())!
        let name = parts.removeFirst()
        output = (size, name)
    }
}

// MARK: - Part 1
// We have a function which takes an amount of fuel and gives us ore.
// We want the amount of fuel given 1_000_000_000_000 ore.
// binary search?

func findFuel(ore target: Int, input: String) -> Int {
    let rules = input.components(separatedBy: "\n").compactMap(OreRule.init)
    let sortedRules = [OreRule](topoSort(rules).reversed())

    var low = 1
    var high = 1_000_000_000
    var highestLessThanTarget = 1

    while low < (high - 1) {
        let candidate = (low + high) / 2
        let ore = computeOreSortedRules(sortedRules, fuel: candidate)
        print("tried \(candidate) got \(ore) low \(low) high \(high)")
        if ore == target { return candidate }

        else if ore < target {
            low = candidate
            highestLessThanTarget = candidate
        } else if ore > target {
            high = candidate
        }
    }

    return highestLessThanTarget
}
