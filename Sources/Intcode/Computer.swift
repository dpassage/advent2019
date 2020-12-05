import Foundation

public struct Computer {
    public var memory: [Int]
    var pc = 0
    var rb = 0
    var crashed = false
    var halted = false

    public var output: [Int] = []

    public init(memory: [Int]) {
        self.memory = memory
        self.memory.append(contentsOf: [Int](repeating: 0, count: 10_000))
    }

    var inputLines = [Int]()
    public mutating func input(line: Int) {
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
            guard memory.indices.contains(paramValue) else {
                crash("invalid address \(paramValue) mode \(mode)")
                return .min
            }
            return memory[paramValue]
        case 1:
            return paramValue
        case 2:
            let location = paramValue + rb
            return memory[location]
        default:
            crash("invalid addressing mode \(mode)")
            return .min
        }
    }

    mutating func read(param: Int) -> Int {
        let instruction = memory[pc]
        return readMem(paramValue: memory[pc + param], mode: addressingMode(instruction: instruction, parameter: param))
    }

    mutating func write(param: Int, value: Int) {
        let instruction = memory[pc]
        let paramValue = memory[pc + param]
        let mode = addressingMode(instruction: instruction, parameter: param)
        switch mode {
        case 0:
            memory[paramValue] = value
        case 1:
            crash("cannot write to immediiate mode parameter")
        case 2:
            memory[rb + paramValue] = value
        default:
            crash("unknown addressing mode \(mode)")
        }
    }

    public mutating func step() {
        guard !crashed && !halted else { return }
        let instruction = memory[pc]
//        print("pc \(pc) instr \(instruction)")
        let opcode = instruction % 100
        switch opcode {
        case 1:
            let argument1 = read(param: 1)
            let argument2 = read(param: 2)
            let sum = argument1 + argument2
            write(param: 3, value: sum)
            pc += 4
        case 2:
            let argument1 = read(param: 1)
            let argument2 = read(param: 2)
            let product = argument1 * argument2
            write(param: 3, value: product)
            pc += 4
        case 3:
            guard !inputLines.isEmpty else {
                crash("no input!")
                return
            }
            let line = inputLines.removeFirst()
            memory[memory[pc + 1]] = line
            write(param: 1, value: line)
            pc += 2
        case 4:
            let value = read(param: 1)
            print("OUTPUT: \(value)")
            output.append(value)
            pc += 2
        // Opcode 5 is jump-if-true: if the first parameter is non-zero, it sets the instruction pointer to the value
        // from the second parameter. Otherwise, it does nothing.
        case 5:
            let argument1 = read(param: 1)
            let argument2 = read(param: 2)
            if argument1 != 0 {
                pc = argument2
            } else {
                pc += 3
            }
        // Opcode 6 is jump-if-false: if the first parameter is zero, it sets the instruction pointer to the value from
        // the second parameter. Otherwise, it does nothing.
        case 6:
            let argument1 = read(param: 1)
            let argument2 = read(param: 2)
            if argument1 == 0 {
                pc = argument2
            } else {
                pc += 3
            }
        // Opcode 7 is less than: if the first parameter is less than the second parameter, it stores 1 in the position
        // given by the third parameter. Otherwise, it stores 0.
        case 7:
            let argument1 = read(param: 1)
            let argument2 = read(param: 2)
            let result = (argument1 < argument2) ? 1 : 0
            write(param: 3, value: result)
            pc += 4
        // Opcode 8 is equals: if the first parameter is equal to the second parameter, it stores 1 in the position
        // given by the third parameter. Otherwise, it stores 0.
        case 8:
            let argument1 = read(param: 1)
            let argument2 = read(param: 2)
            let result = (argument1 == argument2) ? 1 : 0
            write(param: 3, value: result)
            pc += 4
        // Opcode 9 adjusts the relative base by the value of its only parameter. The relative base increases
        // (or decreases, if the value is negative) by the value of the parameter.
        case 9:
            let offset = read(param: 1)
            rb += offset
            pc += 2
        case 99:
            print("HALT")
            halted = true
        default:
            crash("illegal opcode \(opcode)")
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

    public mutating func runToOutput() {
        let outputs = output.count
        while !crashed && !halted && outputs == output.count {
            step()
        }
    }

    public mutating func resetOutput() {
        output = []
    }

    public static func execute(program: String, inputs: [Int] = []) {
        print("START:")
        let numbers = program.split(separator: ",").map(String.init).compactMap(Int.init)
        var computer = Computer(memory: numbers)
        computer.inputLines.append(contentsOf: inputs)
        computer.run()
    }

    public static func run(program: [Int], inputs: [Int] = []) -> [Int] {
        var computer = Computer(memory: program)
        computer.inputLines.append(contentsOf: inputs)
        computer.run()
        return computer.output
    }
}
