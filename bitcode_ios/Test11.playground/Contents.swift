import UIKit

var number = 1
repeat {
    print(number)
    number += 1
}while(number<=1)

class Vehicle {
    fileprivate var chassisNumber: Int
    init (chassisNumber: Int) {
        self.chassisNumber = chassisNumber
    }
}

let v1 = Vehicle(chassisNumber: 123)
v1.chassisNumber
