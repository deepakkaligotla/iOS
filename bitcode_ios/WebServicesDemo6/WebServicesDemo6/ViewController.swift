//
//  ViewController.swift
//  WebServicesDemo6
//
//  Created by Deepak Kaligotla on 09/04/25.
//

import UIKit

class ViewController: UIViewController {
    var url: URL!
    var urlRequest: URLRequest!
    var urlSession: URLSession!
    var users = [User]()
    @IBOutlet weak var usersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonParsingUsingDecoder()
        self.usersTableView.delegate = self
        self.usersTableView.dataSource = self
        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
        self.usersTableView.register(nib, forHeaderFooterViewReuseIdentifier: "UserRow")
    }
    
    private func jsonParsingUsingDecoder() {
        url = URL(string: Constants.urlStringAllUsers)
        urlRequest = URLRequest(url: url!)
        urlSession = URLSession(configuration: .default)
        let dataTask1 = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            self.users = [User]()
            let apiResponse = try! JSONDecoder().decode(APIResponse.self, from: data!) as APIResponse
            self.users = apiResponse.data
            DispatchQueue.main.async {
                self.usersTableView.reloadData()
            }
        }
        dataTask1.resume()
        
        url = URL(string: Constants.urlStringUserById)
        urlRequest = URLRequest(url: url!)
        urlSession = URLSession(configuration: .default)
        let dataTask2 = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            self.users = [User]()
            let apiResponse = try! JSONDecoder().decode(APIResponseByUserId.self, from: data!) as APIResponseByUserId
            self.users.append(apiResponse.data)
        }
        dataTask2.resume()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.usersTableView.dequeueReusableCell(withIdentifier: "UserRow", for: indexPath) as! UsersTableViewCell
        cell.userImageView.image = UIImage(systemName: "star")
        cell.userName.text = "\(users[indexPath.row].first_name) \(users[indexPath.row].last_name)"
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
}
