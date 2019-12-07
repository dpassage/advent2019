//: [Previous](@previous)

import Foundation



print(isValid("111111"))
print(isValid("223450"))
print(isValid("123789"))


print("part2")
print(part2valid("111111"))
print(part2valid("223450"))
print(part2valid("123789"))

print(part2valid("112233"))
print(part2valid("123444"))
print(part2valid("111122"))

var validCount = 0
for password in 353096...843212 {
    if isValid(String(password)) {
        validCount += 1
    }
}
print(validCount)

var part2count = 0
for password in 353096...843212 {
    if part2valid(String(password)) {
        part2count += 1
    }
}

// 327 is too low
print(part2count)

//: [Next](@next)
