import UIKit

print("--------------Closure--------------")

//closures are called as shorter way of defining function,
//They can be passed as an argument to another func, and it will be the last argument
//k

var simpleClosure : (Int, Int) -> Int = { (a,b) in
    return a + b
}
print("simpleClosure - \(simpleClosure(20,30))")

func firstWayOfClosure(a:Int, b:Int, completionHandler: ((Int, Int)->Void)) {
    print("First Way of Closure - \(a + b)")
}
firstWayOfClosure(a: 20, b: 30) { a,b in }

func secondWayOfClosure(a:Int, b:Int, completionHandler: ((Int, Int)->Void)) -> Int {
    return a + b
}
print("Second Way of Closure - \(secondWayOfClosure(a: 20, b: 30) { a,b in })")

var thirdWayOfClosure = { (a: Int, b: Int) -> Int in a+b }
print("Third Way of Closure - \(thirdWayOfClosure(20, 30))")

var fourthWayOfClosure = { (a: Int, b: Int) in a+b }
print("Fourth Way of Closure - \(fourthWayOfClosure(20, 30))")

var fifthWayOfClosure = { (a, b) -> Int in
    return a + b
}
print("Fifth Way of Closure - \(fifthWayOfClosure(20, 30))")

var singleLineClosure = { (a: Int, b: Int) in a + b }
print("Single Line Closure - \(singleLineClosure(20, 30))")
