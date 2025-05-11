//
//  ViewController.swift
//  Assignment08
//
//  Created by Deepak Kaligotla on 11/05/25.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkingService.shared.fetchJSONPlaceholderUsers { users, error in
            if let users = users {
                for user in users {
                    print("\(user.name) | \(user.email) | \(user.company.name)")
                }
            }
        }
        
        NetworkingService.shared.fetchReqResUsers { users, error in
            if let users = users {
                for user in users {
                    print("\(user.firstName) \(user.lastName) | \(user.email)")
                }
            }
        }
    }
}
