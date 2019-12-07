import Foundation

public func isValid(_ password: String) -> Bool {
    var points = [UInt8](password.utf8)
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
