//
//  ViewController.swift
//  AlertControllerDemo
//
//  Created by Deepak Kaligotla on 02/05/25.
//

import UIKit

class ViewController: UIViewController {
    var uiAlertController: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnSimpleAlert(_ sender: Any) {
        uiAlertController = UIAlertController(
            title: "Submit Exam",
            message: "Are you sure",
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(
            title: "OK",
            style: .default) { action in
                print("Ok")
            }
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel) { action in
                print("cancel")
            }
        
        self.uiAlertController.addAction(okAction)
        self.uiAlertController.addAction(cancelAction)
        self.present(uiAlertController, animated: true)
    }
    
    @IBAction func btnAlertWithTextFields(_ sender: Any) {
        uiAlertController = UIAlertController(
            title: "Submit Exam",
            message: "Enter your score",
            preferredStyle: .alert)
        
        uiAlertController.addTextField { textField in
            textField.placeholder = "Score"
        }
        
        let okAction = UIAlertAction(
            title: "OK",
            style: .default) { action in
                print("Ok \(self.uiAlertController.textFields![0].text ?? "")")
            }
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel) { action in
                print("cancel \(self.uiAlertController.textFields![0].text ?? "")")
            }
        
        self.uiAlertController.addAction(okAction)
        self.uiAlertController.addAction(cancelAction)
        self.present(uiAlertController, animated: true)
    }
    
    @IBAction func btnAlertWithActionSheet(_ sender: Any) {
        uiAlertController = UIAlertController(
            title: "Alert Sheet",
            message: "Enter your score",
            preferredStyle: .actionSheet)
        
        uiAlertController.actions.forEach { $0.isEnabled = false }
        
        let okAction = UIAlertAction(
            title: "OK",
            style: .default) { action in
                print("Ok clicked")
            }
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel) { action in
                print("cancel clicked")
            }
        
        let deleteAction = UIAlertAction(
            title: "Delete",
            style: .destructive) { action in
                print("Delete clicked")
            }
        
        self.uiAlertController.addAction(okAction)
        self.uiAlertController.addAction(cancelAction)
        self.uiAlertController.addAction(deleteAction)
        self.present(uiAlertController, animated: true)
    }
    
    @IBAction func btnSimpleAlert2(_ sender: Any) {
        uiAlertController = UIAlertController(
            title: "Simple Alert 2",
            message: "Alert Message",
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(
            title: "OK",
            style: .default) { action in
                print("Ok clicked")
            }
        
        let deleteAction = UIAlertAction(
            title: "Delete",
            style: .destructive) { action in
                print("delete clicked")
            }
        
        self.uiAlertController.addAction(okAction)
        self.uiAlertController.addAction(deleteAction)
        self.present(uiAlertController, animated: true)
    }
    
    @IBAction func btnCustomAlert1(_ sender: Any) {
        let customAlert = CustomAlertView(title: "Delete File", message: "Are you sure you want to delete this permanently?")
        let deleteAction = CustomAlertAction(title: "Delete", style: .destructive) { _ in
            print("Deleted!")
        }
        let cancelAction = CustomAlertAction(title: "Cancel", style: .cancel)
        customAlert.addAction(deleteAction)
        customAlert.addAction(cancelAction)
        if presentedViewController == nil {
            present(customAlert, animated: true)
        }
    }
    
    @IBAction func btnCustomAlert2(_ sender: Any) {
        let customAlert = CustomAlertView(title: "Submit Exam", message: "Do you really want to submit the exam?")
        let submitAction = CustomAlertAction(title: "Submit", style: .default) { _ in
            print("Exam Submitted!")
        }
        let cancelAction = CustomAlertAction(title: "Cancel", style: .cancel)
        customAlert.addAction(submitAction)
        customAlert.addAction(cancelAction)
        if presentedViewController == nil {
            present(customAlert, animated: true)
        }
    }
}
