//
//  Day14SpaceStoichiometry.swift
//  
//
//  Created by David Paschich on 12/7/20.
//

import Foundation
import AdventLib

public func day14part1() {
    let lines = readlines()

    let result = computeOreForFuel(input: lines)
    print(result)
}

func computeOreForFuel(input: [String]) -> Int {
    let rules: [OreRule] = input.compactMap(OreRule.init(_:))

    var inventory: [String: Int] = ["FUEL": 1]
    var oreUsed = 0

    while !inventory.isEmpty {
        print("inventory \(inventory) ore \(oreUsed)")
        let targetName = inventory.keys.first!
        let targetAmount = inventory.removeValue(forKey: targetName)!

        // find the rule which produces this
        let rule = rules.first { $0.output.1 == targetName }!

        print("appluing rule \(rule)")
        // decide how many times to apply it
        let applications = (targetAmount / rule.output.0) + (targetAmount % rule.output.0 == 0 ? 0 : 1)

        for input in rule.inputs {
            if input.1 == "ORE" {
                oreUsed += (input.0 * applications)
            } else {
                inventory[input.1, default: 0] += (input.0 * applications)
            }
        }
    }

    return oreUsed
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
