import UIKit

//WAY 04 - Optional binding - if let
//adv - checks for nil, if not nil it will unwrap
//disadv - scope of the value

var num: Int? = nil
if let notNil = num {
    print(notNil)
} else {
    print("num is nil")
}

//WAY 05 - guard let
//returns a value, which can be catched inside a func
//there is scope

let colors: [Int: Any?] = [1: "Red", 2: "Green", 3:"Blue", 4: nil]

//Return invalid outside of a func
/*
 guard let studentName = name else {
 return
 }
 */

@MainActor func checkKey(key: Int) -> Any? {
    guard let value = colors[key] else {
        return "Key Not Found"
    }
    return value
}

print(checkKey(key: 4))


//ARRAYS
//traditional for loop is removed from Swift 2.0
//use "for in" loop (or) "for each" method
let numbers: [Int] = [1, 2, 3, 4]
for eachNumber in numbers {
    print(eachNumber)
}

//Closure
let names: [String] = ["Pooja","Deepak","Sakshi"]
names.forEach { name in
    print(name)
}

var prices: [Double?] = [1.1, 2.2, nil, 4.4]
prices.forEach { price in
    guard let priceExist = price else {
        return
    }
    print(priceExist)
}
