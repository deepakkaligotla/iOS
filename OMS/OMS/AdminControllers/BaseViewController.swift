//
//  BaseViewController.swift
//  OMS
//
//  Created by Deepak Kaligotla on 01/02/23.
//

import UIKit
import Alamofire

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default
                                      , handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showError(message: String) {
        showAlert(title: "error", message: message)
    }
    
    func showSuccess(message: String) {
        showAlert(title: "success", message: message)
    }
}
