//
//  ViewController.swift
//  WebServicesDemo1
//
//  Created by Deepak Kaligotla on 31/03/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsersFromAPI()
    }
    
    private func fetchUsersFromAPI() {
        UserRepository().fetchUsers { [weak self] model in
            DispatchQueue.main.async {
                guard let self = self, let model = model else {
                    print("Failed to fetch data")
                    return
                }
                
                var userDataText = ""
                for user in model.data {
                    userDataText += "\(user.id): \(user.first_name) \(user.last_name)\n\(user.email)\n\n"
                }
                
                self.label.text = userDataText
                print("Fetched \(model.data.count) users!")
            }
        }
    }
}

