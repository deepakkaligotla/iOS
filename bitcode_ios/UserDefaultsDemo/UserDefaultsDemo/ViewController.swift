//
//  ViewController.swift
//  UserDefaultsDemo
//
//  Created by Deepak Kaligotla on 05/05/25.
//

import UIKit

class ViewController: UIViewController {
    var userDefaultsStandard = UserDefaults.standard
    var userDefaultsSuiteName = UserDefaults(suiteName: "user_preferences")
    let book = Book(id: 1, title: "The Alchemist", author: "Paulo Coelho", price: 12.99)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeDataInUserDefaults()
        getDataFromUserDefaults()
        updateDataInUserDefaults()
        deleteDataInUserDefaults()
    }
    
    func storeDataInUserDefaults() {
        userDefaultsStandard.set("Deepak", forKey: "name")
        userDefaultsStandard.set(25, forKey: "age")
        
        userDefaultsSuiteName?.set("Pooja", forKey: "name")
        userDefaultsSuiteName?.set(25, forKey: "age")
        
        userDefaultsStandard.setValue(["empId": 301, "empName": "Sakshi", "empAge": 25], forKey: "employee")
        userDefaultsSuiteName?.setValue(["Deepak", "Pooja", "Sakshi", "Suhan"], forKey: "students")
        
        userDefaultsStandard.setValue(try! JSONEncoder().encode(book), forKey: "book")
        
    }
    
    func getDataFromUserDefaults() {
        userDefaultsStandard.string(forKey: "name")
        userDefaultsStandard.integer(forKey: "age")
        
        userDefaultsSuiteName?.string(forKey: "name")
        userDefaultsSuiteName?.integer(forKey: "age")
        
        if let employeeData = userDefaultsStandard.dictionary(forKey: "employee") as? [String: Any] {
            print("\(employeeData)")
        }
        
        if let studentsData = userDefaultsSuiteName?.array(forKey: "students") as? [String] {
            for student in studentsData {
                print("\(student)")
            }
        }
        
        print(try! JSONDecoder().decode(Book.self, from: userDefaultsStandard.object(forKey: "book") as! Data))
    }
    
    func updateDataInUserDefaults() {
        userDefaultsStandard.set("Rohit", forKey: "name")
        print(userDefaultsStandard.string(forKey: "name")!)
    }
    
    func deleteDataInUserDefaults() {
        userDefaultsStandard.removeObject(forKey: "name")
        print(userDefaultsStandard.string(forKey: "name"))
        userDefaultsStandard.removeSuite(named: "user_preferences")
        if let nameFromSuite = userDefaultsSuiteName?.string(forKey: "name") {
            print(nameFromSuite)
        }
    }
}
