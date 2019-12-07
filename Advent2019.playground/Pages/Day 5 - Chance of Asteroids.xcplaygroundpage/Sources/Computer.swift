import Foundation

public struct Computer {
    public var memory: [Int]
    var pc = 0
    var crashed = false
    var halted = false

    public init(memory: [Int]) {
        self.memory = memory
    }

    var inputLines = [String]()
    public mutating func input(line: String) {
        inputLines.append(line)
    }

    // For given instruction and parameter number, return the addressing mode.
    // Parameters numbered starting at 1.
    func addressingMode(instruction: Int, parameter: Int) -> Int {
        var divisor = 10
        for _ in 0..<parameter {
            divisor *= 10
        }
        return (instruction / divisor) % 10
    }

    mutating func readMem(paramValue: Int, mode: Int) -> Int {
        switch mode {
        case 0:
            return memory[paramValue]
        case 1:
            return paramValue
        default:
            crash("invalid addressing mode \(mode)")
            return .min
        }
    }

    public mutating func step() {
        guard !crashed && !halted else { return }
        let instruction = memory[pc]
        let opcode = instruction % 100
        switch opcode {
        case 1:
            let argument1 = readMem(paramValue: memory[pc + 1], mode: addressingMode(instruction: instruction, parameter: 1))
            let argument2 = readMem(paramValue: memory[pc + 2], mode: addressingMode(instruction: instruction, parameter: 2))
            let sum = argument1 + argument2
            memory[memory[pc + 3]] = sum
            pc += 4
        case 2:
            let argument1 = readMem(paramValue: memory[pc + 1], mode: addressingMode(instruction: instruction, parameter: 1))
            let argument2 = readMem(paramValue: memory[pc + 2], mode: addressingMode(instruction: instruction, parameter: 2))
            let product = argument1 * argument2
            memory[memory[pc + 3]] = product
            pc += 4
        case 3:
            guard !inputLines.isEmpty else {
                crash("no input!")
                return
            }
            let line = inputLines.removeFirst()
            guard let value = Int(line) else {
                crash("illegal input!")
                return
            }
            memory[memory[pc + 1]] = value
            pc += 2
        case 4:
            let value = memory[memory[pc + 1]]
            print("OUTPUT: \(value)")
            pc += 2
        case 99:
            print("HALT")
            halted = true
        default:
            crash("illegal instruction")
        }
    }

    mutating func crash(_ log: String = "") {
        print("crashed! \(log)")
        crashed = true
    }

    public mutating func run() {
        while !crashed && !halted {
            step()
        }
    }

    public static func execute(program: String, inputs: [String] = []) {
        print("START:")
        let numbers = program.split(separator: ",").map(String.init).compactMap(Int.init)
        var computer = Computer(memory: numbers)
        computer.inputLines.append(contentsOf: inputs)
        computer.run()
    }
}
