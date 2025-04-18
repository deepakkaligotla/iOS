//
//  MathematicalOperations.swift
//  NavigationDemo
//
//  Created by Deepak Kaligotla on 07/03/25.
//

protocol MathematicalOperations {
    var n1: Int? { get set }
    var n2: Int? { get set }
    
    func addition() -> Int
    func subtraction() -> Int
    func multiplication() -> Int
    func division() -> Int
}
