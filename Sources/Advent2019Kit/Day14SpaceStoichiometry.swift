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

    var heap = Heap<NanoFactory> { (lhs, rhs) -> Bool in
        if lhs.ore == rhs.ore {
            return lhs.total < rhs.total
        }
        return lhs.ore < rhs.ore
    }

    let first = NanoFactory(rules: rules)
    heap.enqueue(first)

    var count = 0
    while let cur = heap.dequeue() {
        count += 1
        if count % 1_000 == 0 { print("\(count) remaining is \(heap.count) cur is \(cur.ore) \(cur.total) \(cur.chemicals)") }
        if cur.finished { return cur.ore }

        if !cur.hasApplicableRule { continue }
        // try to apply each of the remaining rules
        for ruleIndex in 0..<cur.rules.count {
            var newFactory = cur
            let rule = newFactory.rules.remove(at: ruleIndex)
//            print("applying \(rule)")
            if newFactory.apply(rule) {
//                print("applied, enqueueing")
                heap.enqueue(newFactory)
            } else {
//                print("did not apply, dropping")
            }
        }
    }

    return -1
}

struct NanoFactory {
    var chemicals: [String: Int] = ["FUEL": 1]
    var ore: Int = 0
    var total: Int { return ore + chemicals.values.reduce(0, +) }
    var finished: Bool { return chemicals.isEmpty }
    var rules: [OreRule]

    mutating func apply(_ rule: OreRule) -> Bool {
        guard let targetAmount = chemicals.removeValue(forKey: rule.output.1) else {
            return false
        }

        let applications = (targetAmount / rule.output.0) + (targetAmount % rule.output.0 == 0 ? 0 : 1)

        for input in rule.inputs {
            if input.1 == "ORE" {
                ore += (input.0 * applications)
            } else {
                chemicals[input.1, default: 0] += (input.0 * applications)
            }
        }
        return true
    }

    var hasApplicableRule: Bool {
        // if there are fewer rules than chemicals, prune this one
        return rules.count >= chemicals.count
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
