import UIKit

//Dictionary - [key: value]
//Any & AnyObject is the keyword in swift to hold any type of data
//Dictory is unorder collection, it is not indexed base

print("------Dictionary Collections-------")
var student : [Int: String] = [1: "Deepak",
                               2: "Sumit",
                               3: "Pooja",
                               4: "Sakshi"]

var product: [String: Any] = ["productName": "Mixer",
                              "productId": 101,
                              "productCompany":"WonderChef",
                              "productPrice":3454.334]

print("Num of keys in student - \(student.count)")
print("fetch first in student - \(student.first!)")

for (key,value) in product {
    print("\(key) - \(value)")
}

print("------if else - Conditions-------")
//conditional statement
if(12 > 15) {
    print("true")
} else {
    print("false")
}

print("------Range DataType-------")
//Ranges - for - in loop
for i in 1...4 {
    print("5 x \(i) = \(i * 5)")
}

print("-------Reversed Range--------")
//Range DataType
var range: ClosedRange = 1...4
for i in range.reversed() {
    print("5 x \(i) = \(i * 5)")
}

print("-------for in - Stride--------")
//for - in - stride - upper bound is exculded means to: 20 is not taken in count
for i in stride (from: 10, to: 20, by: 2) {
    print(i)
}

print("---------------")
//for - in - stride - upper bound is exculded means through: 20 is taken in count
for i in stride (from: 10, through: 20, by: 2) {
    print(i)
}
print("---------------")
for i in 10..<20 {
    print(i)
}

print("-------Functions--------")
//functions in swift
func add(a: Int, b: Int) -> Int {
    return a + b
}

print("Addition = \(add(a: 2, b: 3))")
func multiplicationTable(number: Double) {
    for i in 1...5 {
        print("\(number) x \(i) = \(Double(i) * number)")
    }
}

multiplicationTable(number: 0.25)
var array = [123,321,5632,1,88]
for eachValue in array {
    if(eachValue%2 == 0) {
        print("Even - \(eachValue)")
    } else {
        print("Odd - \(eachValue)")
    }
}
