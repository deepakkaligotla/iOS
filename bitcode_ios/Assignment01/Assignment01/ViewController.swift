//
//  ViewController.swift
//  Assignment01
//
//  Created by Deepak Kaligotla on 07/03/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var txtField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnClick(sender: Any) {
        switch(txtField.text) {
        case "1": label1.backgroundColor = .orange
            label2.backgroundColor = .gray
            label3.backgroundColor = .gray
        case "2": label2.backgroundColor = .white
            label1.backgroundColor = .gray
            label3.backgroundColor = .gray
        case "3": label3.backgroundColor = .green
            label1.backgroundColor = .gray
            label2.backgroundColor = .gray
        default: label1.backgroundColor = .gray
            label2.backgroundColor = .gray
            label3.backgroundColor = .gray
        }
    }
}
