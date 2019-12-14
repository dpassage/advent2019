//: [Previous](@previous)

import Foundation
import AdventLib

let firstTest = """
.#..#
.....
#####
....#
...##
"""


let testField = AsteroidField(text: firstTest)
//print(testField.asteroidsSeen(from: Point(x: 1, y: 0)))
//print(testField.asteroidsSeen(from: Point(x: 3, y: 4)))
//print(testField.asteroidsSeen(from: Point(x: 4, y: 2)))
print(testField.bestAsteriodsSeen())

let testTwo = """
......#.#.
#..#.#....
..#######.
.#.#.###..
.#..#.....
..#....#.#
#..#....#.
.##.#..###
##...#..#.
.#....####
"""
let testTwoField = AsteroidField(text: testTwo)
//print(testTwoField.bestAsteriodsSeen())
print(testTwoField.asteroidsSeen(from: Point(x: 5, y: 8)))

let testThree = """
#.#...#.#.
.###....#.
.#....#...
##.#.#.#.#
....#.#.#.
.##..###.#
..#...##..
..##....##
......#...
.####.###.
"""
print(AsteroidField(text: testThree).bestAsteriodsSeen())

let testFour = """
.#..#..###
####.###.#
....###.#.
..###.##.#
##.##.#.#.
....###..#
..#.#..#.#
#..#.#.###
.##...##.#
.....#.#..
"""
print(AsteroidField(text: testFour).bestAsteriodsSeen())

let testFive = """
.#..##.###...#######
##.############..##.
.#.######.########.#
.###.#######.####.#.
#####.##.#.##.###.##
..#####..#.#########
####################
#.####....###.#.#.##
##.#################
#####.##.###..####..
..######..##.#######
####.##.####...##..#
.#####..#.######.###
##...#.##########...
#.##########.#######
.####.#.###.###.#.##
....##.##.###..#####
.#.#.###########.###
#.#.#.#####.####.###
###.##.####.##.#..##
"""
print(AsteroidField(text: testFive).bestAsteriodsSeen())

let fileURL = Bundle.main.url(forResource: "day10.input", withExtension: "txt")!
let day10string = try! String(contentsOf: fileURL)
print(AsteroidField(text: day10string).bestAsteriodsSeen())

//: [Next](@next)
