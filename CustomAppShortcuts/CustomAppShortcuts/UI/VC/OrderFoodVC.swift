//
//  OrderFoodVC.swift
//  CustomAppShortcuts
//
//  Created by Deepak Kaligotla on 27/06/24.
//

import UIKit

class OrderFoodVC: UIViewController {
    @IBOutlet weak var orderedDetails: UILabel!
    
    var selectedFoodItem: String? {
        didSet {
            updateScreenDetails()
        }
    }
    
    var foodQuantity: Int? {
        didSet {
            updateScreenDetails()
        }
    }
    
    var selectedPayment: String? {
        didSet {
            updateScreenDetails()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateScreenDetails()
    }
    
    func updateScreenDetails() {
        self.orderedDetails?.text = "Order - \(selectedFoodItem ?? "") x \(foodQuantity ?? 0) using \(selectedPayment ?? "") placed successfully, and it is on way."
    }
}
