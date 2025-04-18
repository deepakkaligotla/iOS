import UIKit

var numberOne = 12
print(numberOne)

let numberTwo = 24
print(numberTwo)

//numberTwo = 25 //not allowed as let is immutable and can only take constants

/* Explicitly mentioning the data type which is not required becoz of type inference */
var id: Int = 1001
var firstName: String = "Deepak"
var fee: Double = 58400.00
var grade: Character = "A"
var scorePercent: Float = 92.0
var jobPLaced: Bool = false

print("\n\(id), \(firstName), \(fee), \(grade), \(scorePercent), \(jobPLaced)")

var lastName: String = "Kaligotla"

//String interpolation
print("\(firstName) \(lastName)")


//multiline print
var address: String = """
BitCode,
Erandwane,
Pune
"""

print(address)

/*Swift Optionals*/
//CANNOT ASSIGN NILL VALUES TO VARIABLES DIRECTLY, USE SWIFT OPTIONALS
var n: Int? = 10 //optional variable
let m: String? //let optional is allowed

/*
 5 ways of unwrapping an Optional
    * Force unwrapping - using '!'
    * nil coalescing - using '??'
    * if-else
    *
    *
*/

//Optional wrapped is associated with .some and .none enum which helps the compiler to check if the variable is initialized
print(n) //Optional(10)
print(n!) //unwrapping and getting the value from optional variable

m = "String 1"
print(m!) //optional unwrapping - Fatal error: Unexpectedly found nil while unwrapping an Optional value

//WAY 02 - nil coalescing
var num1: Int? = nil
print("\(num1 ?? 45)") //disadv defautl value

//WAY 03 - if-else - disadv addtional code
var num2: Int? = nil
if(num2 != nil) {
    print(num2!)
} else {
    print("num2 is nil")
}

//WAY 04 - Optional binding - if let - tomorrow

//WAY 05 - guard let- tomorrow
