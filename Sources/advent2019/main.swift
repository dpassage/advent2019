import Advent2019Kit
import Darwin

if CommandLine.arguments.count < 2 {
    print("Specify a day")
    exit(1)
}

let command = CommandLine.arguments[1]

switch command {
case "day01part1":
    day01part1()
case "day01part2":
    day01part2()
case "day02part1":
    day02part1()
case "day02part2":
    day02part2()
case "day03part1":
    day03part1()
case "day03part2":
    day03part2()
case "day10part1":
    day10part1()
case "day10part2":
    day10part2()
case "day11part1":
    day11part1()
case "day11part2":
    day11part2()
case "day12part1":
    day12part1()
case "day12part2":
    day12part2()
case "day13part1":
    day13part1()
case "day13part2":
    day13part2()
case "day14part1":
    day14part1()
case "day14part2":
    day14part2()
case "day15part1":
    day15part1()
case "day15part2":
    day15part2()
default:
    print("Unknown command")
    exit(1)
}
