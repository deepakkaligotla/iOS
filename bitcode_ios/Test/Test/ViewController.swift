//
//  ViewController.swift
//  Test
//
//  Created by Deepak Kaligotla on 17/04/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(reverseNumber(num: 9381640235))
        findDuplicateElementsInArray(inputArray: [9,3,8,1,6,4,0,2,3,5])
    }
    
    func reverseNumber(num: Int) -> Int {
        var inputNum = num
        var reversedNum = 0
        while(inputNum != 0) {
            reversedNum = (reversedNum * 10) + inputNum % 10
            inputNum = inputNum/10 //inputNum/= 10
        }
        return reversedNum
    }
    
    func findDuplicateElementsInArray(inputArray:[Int]) {
        var map = [Int: Int]()
        inputArray.forEach { num in
            map[num, default:0] += 1
        }
        map.forEach { (key, value) in
//            print("\(key): \(value)")
            if(value>1) {
                print(key)
            }
        }
    }
    
    func findSecondHighestSalary() {
//        SELECT DISTINCT salary
//        FROM Employee
//        ORDER BY salary DESC
//        LIMIT 1 OFFSET 1;
        
//        SELECT DISTINCT salary
//        FROM Employee
//        ORDER BY salary DESC
//        LIMIT 2 OFFSET 1;
    }
}

