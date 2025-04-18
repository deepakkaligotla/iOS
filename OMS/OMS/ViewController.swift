//
//  ViewController.swift
//  OMS
//
//  Created by Deepak Kaligotla on 30/01/23.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet var imageLoginTop: UIImageView!
    @IBOutlet weak var editLoginEmail:UITextField!
    @IBOutlet weak var editLoginPassword:UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var remeberMe: UISwitch!
    
    @IBAction func forgotPassword(_ sender: UIButton) {
        
        
    }
    
    @IBAction func login() {
        if(editLoginEmail.text! != "") {
            if(editLoginPassword.text! != "") {
                let username = editLoginEmail.text!
                let storyboard = UIStoryboard(name:"Main", bundle:nil)
                let adminHome = storyboard.instantiateViewController(withIdentifier: "AdminHome") as! AdminHome
                adminHome.loggedInUser = username
                present(adminHome, animated: true)
            }
        } else {
            let storyboard = UIStoryboard(name:"Main", bundle:nil)
            let Registration = storyboard.instantiateViewController(withIdentifier: "Registration")
            present(Registration, animated: true)
        }
    }
}

