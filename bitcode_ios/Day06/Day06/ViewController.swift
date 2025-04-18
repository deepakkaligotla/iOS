//
//  ViewController.swift
//  Day06
//
//  Created by Deepak Kaligotla on 04/03/25.
//

import UIKit

class ViewController: UIViewController {
    var welcomeLabel: UILabel?
    var textField: UITextField?
    var btnSubmit: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad Called")
        self.welcomeLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 300, height: 50))
        welcomeLabel!.text = "Welcome"
        welcomeLabel!.font = .systemFont(ofSize: 40)
        self.view.addSubview(welcomeLabel!)
        
        textField = UITextField(frame: CGRect(x: 50, y: 120, width: 300, height: 50))
        textField!.backgroundColor = .lightGray
        textField!.placeholder = "Enter your Name"
        textField!.font = .systemFont(ofSize: 40)
        textField!.textColor = .white
        self.view.addSubview(textField!)
        
        btnSubmit = UIButton(frame: CGRect(x: 50, y: 190, width: 300, height: 50))
        btnSubmit?.setTitle("Submit", for: .normal)
        btnSubmit?.titleLabel?.font = .systemFont(ofSize: 25)
        btnSubmit?.titleLabel?.textColor = .white
        btnSubmit?.backgroundColor = .blue
        self.view.addSubview(btnSubmit!)
        btnSubmit?.addTarget(self, action: #selector(btnSubmitClicked), for: .touchUpInside)
    }
    
    @objc func btnSubmitClicked() {
        if let value = textField?.text {
            welcomeLabel?.text = "Welcome " + value
        } else {
            welcomeLabel?.text = "Empty TextField"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear Called")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear Called")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear Called")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear Called")
    }
}
