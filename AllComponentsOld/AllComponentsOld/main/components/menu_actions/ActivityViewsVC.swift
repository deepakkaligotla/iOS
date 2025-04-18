//
//  ActivityViewsVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

class ActivityViewsVC: UIViewController {
    let activityViewController = UIActivityViewController(activityItems: ["Check out this awesome app!"], applicationActivities: nil)
    
    @IBAction func activityBtn(_ sender: Any) {
        present(activityViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityViewController.excludedActivityTypes = [
            .addToReadingList,
            .assignToContact,
            .openInIBooks,
            .print
        ]
    }
}
