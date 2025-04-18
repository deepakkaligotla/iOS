//
//  HomeViewController.swift
//  NavigationDemo
//
//  Created by Deepak Kaligotla on 07/03/25.
//

import UIKit

class HomeViewController: UIViewController, MathematicalOperations {
    var n1: Int?
    var n2: Int?
    
    func addition() -> Int {
        return n1! + n2!
    }
    
    func subtraction() -> Int {
        return n1! - n2!
    }
    
    func multiplication() -> Int {
        return n1! * n2!
    }
    
    func division() -> Int {
        return n1! / n2!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
