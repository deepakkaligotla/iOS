//
//  ThirdViewController.swift
//  Day06
//
//  Created by Deepak Kaligotla on 06/03/25.
//

import UIKit

class ThirdViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn1.setTitle("Button 1", for: .normal)
        btn2.setTitle("Button 2", for: .normal)
        btn3.setTitle("Button 3", for: .normal)
    }
    
    @IBAction func buttonClickActions(_ sender: UIButton) {
        switch(sender.titleLabel?.text) {
        case "Button 1": welcomeLabel.backgroundColor = .orange
        case "Button 2": welcomeLabel.backgroundColor = .red
        case "Button 3": welcomeLabel.backgroundColor = .systemIndigo
        default: welcomeLabel.backgroundColor = .green
        }
    }
}
    
