import UIKit

print("-----eNum------")
enum Couses1 {
    case iOS
    case Android
    case Java
    case C
    case Cpp
}

enum Courses2 {
    case iOS, Android, Java, C, Cpp
}

print(Courses2.Android)

//Switch case
print("-----Switch------")
var selectedCourse = Couses1.iOS

switch selectedCourse {
    case .iOS, .Android: print("iOS")
    case .Android: print("Android")
    case .Java: print("Java")
    case .C: print("C")
    default: print("Default selected")
}

print("-----Tuple------")
//Array, tuples are ordered collections, index based
//Dictionaries or unordered
var laptop = ("Mac", 150000, 2022)
var laptopNew = (Name: "Mac", Price: 150000, Year: 2022)
print(laptop.0)
print(laptopNew.Price)


print("-----Class & Struct------")

//Classes are reference types, use if requires OOP, init is mandatory
//Struct are value types, use if no need of OOP, works without init block
//All stored properties in a class should be initialized mandatorily, but in struct it is not required
class BikeClass {
    //Way02 of initializing
    var color: String = ""
    
    //there is concept as constructure in Swift, inside class there is something called init block to initialize
    //Way01 of initializing
    init(color: String) {
        self.color = color
    }
    
    //Deletes the object
    deinit {}
}

var bikeClassObj1: BikeClass = BikeClass(color: "Blue")
var bikeClassObj2 = bikeClassObj1
bikeClassObj1.color = "Red"
print("BikeClassObj1.color: \(bikeClassObj1.color), BikeClassObj2.color: \(bikeClassObj2.color)")

struct BikeStruct {
    var color: String
}

var bikeStructObj1: BikeStruct = BikeStruct(color: "Blue")
var bikeStructObj2 = bikeStructObj1
bikeStructObj1.color = "Red"
print("bikeStructObj1.color: \(bikeStructObj1.color), bikeStructObj2.color: \(bikeStructObj2.color)")

print("-----For-in loop without use of variable------")
//for - in loop
let base = 2
let power = 3
var answer = 1

for _ in 1...power {
    //compressed form of assignment operator
    answer *= base //anser = answer * base
}
print("\(base) to the power of \(power) is \(answer)")

print("-----if, else if, else------")
var tempInFahrenheit = 90

if tempInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf")
} else if tempInFahrenheit >= 86 {
    print("It is warm, do not forget to wear sunscreen")
} else {
    print("It's not that cold, wear a t-shirt")
}

print("-----Switch------")
let character1 = "d"
switch character1 {
    case "a": print("Case \(character1) is selected")
    case "b": print("Case \(character1) is selected")
    case "c": print("Case \(character1) is selected")
    default: print("Case default is selected with \(character1)")
}

//Only in swift we can use comma separated values in cases
let character2 = "a"
switch character2 {
    case "a", "A": print("Case \(character2) is selected")
    case "b", "B": print("Case \(character2) is selected")
    case "c": print("Case \(character2) is selected")
    default: print("Case default is selected with \(character2)")
}

//we can use ranges in cases
let number = 0
switch number {
    case 0...9: print("\(number) is single digit number")
    case 10...99: print("\(number) is double digit number")
    case 100...999: print("\(number) is triple digit number")
    default: print("Default case is selected for \(number)")
}
