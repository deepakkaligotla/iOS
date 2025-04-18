//
//  AlertsVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

class AlertsVC: UIViewController {
    
    @IBAction func alertBtn(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            print("OK tapped")
        }
        alertController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            print("Cancel tapped")
        }
        alertController.addAction(cancelAction)
        
        let destructiveAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
            print("Delete tapped")
        }
        alertController.addAction(destructiveAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
