import Foundation

public struct Computer {
    public var memory: [Int]
    var pc = 0
    var crashed = false
    var halted = false

    public var output: [Int] = []

    public init(memory: [Int]) {
        self.memory = memory
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
        default:
            crash("invalid addressing mode \(mode)")
            return .min
        }
    }

    mutating func read(param: Int) -> Int {
        let instruction = memory[pc]
        return readMem(paramValue: memory[pc + param], mode: addressingMode(instruction: instruction, parameter: param))
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
            memory[memory[pc + 3]] = sum
            pc += 4
        case 2:
            let argument1 = read(param: 1)
            let argument2 = read(param: 2)
            let product = argument1 * argument2
            memory[memory[pc + 3]] = product
            pc += 4
        case 3:
            guard !inputLines.isEmpty else {
                crash("no input!")
                return
            }
            let line = inputLines.removeFirst()
            memory[memory[pc + 1]] = line
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
            memory[memory[pc + 3]] = result
            pc += 4
        // Opcode 8 is equals: if the first parameter is equal to the second parameter, it stores 1 in the position
        // given by the third parameter. Otherwise, it stores 0.
        case 8:
            let argument1 = read(param: 1)
            let argument2 = read(param: 2)
            let result = (argument1 == argument2) ? 1 : 0
            memory[memory[pc + 3]] = result
            pc += 4
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
        print("MEMORY COUNT: \(memory.count)")
        while !crashed && !halted {
            step()
        }
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
