//: [Previous](@previous)

import Foundation



print(isValid("111111"))
print(isValid("223450"))
print(isValid("123789"))

var validCount = 0
for password in 353096...843212 {
    if isValid(String(password)) {
        validCount += 1
    }
}
print(validCount)

//: [Next](@next)
