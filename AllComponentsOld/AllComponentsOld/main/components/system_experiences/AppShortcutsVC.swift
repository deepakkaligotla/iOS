//
//  AppShortcutsVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

class AppShortcutsVC: UIViewController {
    @IBAction func activityBtn(_ sender: Any) {
        let url = URL(string: "https://kaligotla.in/")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
