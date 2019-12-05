import Foundation

public struct Computer {
    public var memory: [Int]
    var pc = 0
    var crashed = false
    var halted = false

    public init(memory: [Int]) {
        self.memory = memory
    }
    
    public mutating func step() {
        guard !crashed && !halted else { return }
        let opcode = memory[pc]
        switch opcode {
        case 1:
            let sum = memory[memory[pc + 1]] + memory[memory[pc + 2]]
            memory[memory[pc + 3]] = sum
            pc += 4
        case 2:
            let product = memory[memory[pc + 1]] * memory[memory[pc + 2]]
            memory[memory[pc + 3]] = product
            pc += 4
        case 99:
            halted = true
        default:
            print("crashed!")
            crashed = true
        }
    }

    public mutating func run() {
        while !crashed && !halted {
            step()
//            print(pc, memory)
        }
//        print("done!")
    }
}
