//: [Previous](@previous)

import Foundation
import AdventLib

let fileURL = Bundle.main.url(forResource: "day8.input", withExtension: "txt")!
let day8string = try! String(contentsOf: fileURL).trimmingCharacters(in: .whitespacesAndNewlines)


let chars = day8string.chars

func findLayer(input: [Char]) -> Int {
    let length = chars.count
    let chunks = length / 150
    var leastZeros = Int.max
    var onebytwo = 0
    for i in 0..<chunks {
        let chunkStart = i * 150
        let chunkEnd = (i + 1) * 150
        let chunk = input[chunkStart..<chunkEnd]
        let hash: [Char: Int] = chunk.reduce([:], { hash, next in
            var result = hash
            result[next, default: 0] += 1
            return result
        })
        let zeros = hash["0", default: 0]
        if zeros < leastZeros {
            leastZeros = zeros
            onebytwo = hash["1", default: 0] * hash["2", default: 0]
        }
    }

    return onebytwo
}

findLayer(input: chars) // 2016 is too low

func composeImage(width: Int, height: Int, input: [Char]) {
    let layerLength = width * height
    var result = Array<Char>(repeating: "2", count: layerLength)

    let layers = input.count / layerLength

    for layerIndex in (0..<layers).reversed() {
        let layerStart = layerIndex * layerLength

        for i in 0..<layerLength {
            let thisDot = input[layerStart + i]
            if thisDot != "2" {
                result[i] = thisDot
            }
        }
    }

    // print result
    for row in 0..<height {
        for column in 0..<width {
            let char = result[(row * width) + column] == "1" ? "*" : " "
            print(char, terminator: "")
        }
        print("")
    }
}

let test = "0222112222120000".chars
composeImage(width: 2, height: 2, input: test)

composeImage(width: 25, height: 6, input: chars)

//: [Next](@next)
