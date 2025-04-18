//
//  ViewController.swift
//  WebServicesAlamofireDemo1
//
//  Created by Deepak Kaligotla on 15/04/25.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController {
    var url: URL?
    var users = [User]()
    @IBOutlet weak var userTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewXib()
        fetchDataUsingAlamofire()
    }
    
    func registerTableViewXib() {
        userTableView.delegate = self
        userTableView.dataSource = self
        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
        self.userTableView.register(nib, forCellReuseIdentifier: "UserCell")
    }
    
    func fetchDataUsingAlamofire() {
        url = URL(string: Constants.urlString)
        AF.request(url!).response { response in
            print("response.result = \(response.result)")
            print("-------------------------------------------------------------------------------------")
            print("response.response = \(response.response!)")
            print("-------------------------------------------------------------------------------------")
            switch(response.result) {
                case .success(let data):
                    print(String(data: data!, encoding: .utf8) ?? "No data")
                    print("-----------------------------------------------------------------------------")
                    for user in try! JSONDecoder().decode(APIResponse.self, from: data!).data {
                        print(user)
                    }
                    print("-----------------------------------------------------------------------------")
                case .failure(let error):
                    print(error)
            }
        }
        
        Task {
            let response = await AF.request(self.url!).serializingDecodable(APIResponse.self).response
            switch response.result {
            case .success(let apiResponse):
                self.users.append(contentsOf: apiResponse.data)
            case .failure(let error):
                print(error)
            }
            DispatchQueue.main.async {
                self.userTableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140.0
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.userTableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserTableViewCell
        cell.userImage.kf.setImage(with: URL(string: self.users[indexPath.row].avatar))
        cell.firstName.text = self.users[indexPath.row].firstName
        cell.lastName.text = self.users[indexPath.row].lastName
        cell.email.text = self.users[indexPath.row].email
        return cell
    }
}
