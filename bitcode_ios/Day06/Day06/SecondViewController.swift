//
//  ViewController2.swift
//  Day06
//
//  Created by Deepak Kaligotla on 05/03/25.
//


import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var textField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnSubmitClick(_ sender: Any) {
        if let value = textField?.text {
            welcomeLabel?.text = "Welcome " + value
        } else {
            welcomeLabel?.text = "Empty TextField"
        }
    }
}
