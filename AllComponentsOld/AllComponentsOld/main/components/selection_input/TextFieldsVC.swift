//
//  TextFieldsVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

class TextFieldsVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var plainTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurePlainTextField()
        configureEmailTextField()
        configureNumberTextField()
        configurePasswordTextField()
    }

    private func configurePlainTextField() {
        plainTextField.placeholder = "Enter plain text"
        plainTextField.borderStyle = .roundedRect
        plainTextField.autocapitalizationType = .sentences
        plainTextField.returnKeyType = .done
        plainTextField.clearButtonMode = .whileEditing
        plainTextField.delegate = self
    }
    
    private func configureEmailTextField() {
        emailTextField.placeholder = "Enter email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.returnKeyType = .done
        emailTextField.clearButtonMode = .whileEditing
        emailTextField.delegate = self
    }

    private func configureNumberTextField() {
        numberTextField.placeholder = "Enter number"
        numberTextField.borderStyle = .roundedRect
        numberTextField.keyboardType = .numberPad
        numberTextField.clearButtonMode = .whileEditing
        numberTextField.delegate = self
    }
    
    private func configurePasswordTextField() {
        passwordTextField.placeholder = "Enter password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.returnKeyType = .done
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

