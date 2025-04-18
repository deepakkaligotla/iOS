//
//  AdminHome.swift
//  OMS
//
//  Created by Deepak Kaligotla on 31/01/23.
//

import UIKit
import Alamofire
import AVFoundation
import AVKit

class AdminHome: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var MenuList: UITableView!
    @IBOutlet weak var welcomeUserMessage: UILabel!
    
    var loggedInUser : String = "guest"
    var Menu = ["Admins","Sponsors","Childs","Orphanages","Roles"]
    var adminsList: [Admin] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeUserMessage.text = loggedInUser
        MenuList.delegate = self
        MenuList.dataSource = self
        getAdmins()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return Menu.count
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.text = Menu[indexPath.row]
            return cell
        }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            MenuList.deselectRow(at: indexPath, animated: true)
            let menu = Menu[indexPath.row]
            print("Selected Menu: \(menu)")
            
            let alert = UIAlertController(title: "selection", message: "Selected Menu named: \(menu)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                print("ok tapped")
            }))
            present(alert, animated: true)
        }
    
    func getAdmins() {
        
        let url = "http://orphanslife.in:4000/childs"
        AF.request(url, method: .get)
            .responseJSON(completionHandler:{ response in
            switch response.result {
                    case .success(let data):
                        do {
//                            let asJSON = try JSONSerialization.jsonObject(with: data)
                            print(data)
                        } catch {
                            
                        }
                    case .failure(let error):
                        print(error)
                    }
           })
    }

}
