import UIKit

maxmin(a: 10, b: 20)

func maxmin(a: Int, b: Int) {
    let diff = a - b
    let k = (diff >> 31) & 1  // Shift right, extract sign bit

    let max = a - k * diff
    let min = b + k * diff

    print("Maximum: \(max)")
    print("Minimum: \(min)")
}

func sumNumbersWithoutUsingPlus(a: Int, b: Int) -> Int {
    return a+b
}
