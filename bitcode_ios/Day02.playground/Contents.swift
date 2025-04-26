//WAY 04 - Optional binding - if let
//adv - checks for nil, if not nil it will unwrap
//disadv - scope of the value

var num: Int? = nil
if let notNil = num {
    print(notNil)
} else {
    print("num is nil")
}
//print(notNil) //notNil is not available outside of the if let block

//WAY 05 - guard let
//returns a value, which can be catched inside a func
//scope is outside
//direcly cant be used only inside class or file, only inside func because there is a return
let colors = ["1": "Red", "2": "Green", "3":"Blue", "4": nil]
func checkKey(key: String) {
    guard let value = colors[key] else {
        print("key not found or valus is nil")
        return
    }
    print("\(key) - \(value)")
}
checkKey(key: "3")


//Array is collection of similar datatype
//collections - ordered & unordered
//Array is ordered, dictionary is unordered
//traditional for loop is removed from Swift 3.0 onwards
//use "for in" loop (or) "for each" method
let numbers: [Int] = [1, 2, 3, 4]
print(numbers)
for eachNumber in numbers {
    print(eachNumber)
}

var digitCounts = Array(repeating: 1, count: 10)
print(digitCounts)

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
