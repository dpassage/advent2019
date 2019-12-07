import Foundation

public func isValid(_ password: String) -> Bool {
    let points = [UInt8](password.utf8)
    var hasDouble = false
    for i in 0..<(points.count - 1) {
        if points[i] > points[i + 1] {
            return false
        }
        if points[i] == points[i + 1] {
            hasDouble = true
        }
    }
    return hasDouble
}

public func part2valid(_ password: String) -> Bool {
    let points = [UInt8](password.utf8)
    var hasDouble = false
    var currentRunLength = 1
    for i in 0..<(points.count - 1) {
        if points[i] > points[i + 1] {
            return false
        }
        if points[i] == points[i + 1] {
            currentRunLength += 1
        } else {
            if currentRunLength == 2 {
                hasDouble = true
            }
            currentRunLength = 1
        }
    }
    if currentRunLength == 2 { return true }
    return hasDouble
}
