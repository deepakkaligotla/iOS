//
//  ViewController.swift
//  AlamofireDemo1
//
//  Created by Deepak Kaligotla on 28/04/25.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var jobTextField: UITextField!
    @IBOutlet weak var responseDataLabel: UILabel!
    @IBOutlet weak var putResponseLabel: UILabel!
    @IBOutlet weak var deleteResponseLabel: UILabel!
    
    var postUrl: URL?
    var putUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postUrl = URL(string: "https://reqres.in/api/users")
        putUrl = URL(string: "https://reqres.in/api/users/2")
    }
    
    
    @IBAction func createBtn(_ sender: Any) {
        Task {
            let response = await AF.request(postUrl!,
                                            method: .post,
                                            parameters: [
                                                "name": nameTextField.text!,
                                                "job": jobTextField.text!
                                            ],
                                            encoding: JSONEncoding.default,
                                            headers: [
                                                "x-api-key": "reqres-free-v1"
                                            ])
                .serializingDecodable(UserPostResponse.self).response
            
            switch response.result {
            case .success(let data):
                print(data)
                DispatchQueue.main.async {
                    self.responseDataLabel.text = "Created\nName: \(data.name)\nJob: \(data.job)\nID: \(data.id)\nCreated At: \(data.createdAt)"
                    self.responseDataLabel.textColor = .green
                }
            case .failure(let error):
                print("Error: \(error)")
                DispatchQueue.main.async {
                    self.responseDataLabel.text = "Error: \(error.localizedDescription)"
                    self.responseDataLabel.textColor = .red
                }
            }
        }
    }
    
    @IBAction func updateBtn(_ sender: Any) {
        Task {
            let response = await AF.request(putUrl!,
                                            method: .put,
                                            parameters: [
                                                "name": nameTextField.text!,
                                                "job": jobTextField.text!
                                            ],
                                            encoding: JSONEncoding.default,
                                            headers: [
                                                "x-api-key": "reqres-free-v1"
                                            ])
                .serializingDecodable(UserPutResponse.self).response
            
            switch response.result {
            case .success(let data):
                print(data)
                DispatchQueue.main.async {
                    self.putResponseLabel.text = "Updated\nName: \(data.name)\nJob: \(data.job)\nUpdated At: \(data.updatedAt)"
                    self.putResponseLabel.textColor = .green
                }
            case .failure(let error):
                print("Error: \(error)")
                DispatchQueue.main.async {
                    self.putResponseLabel.text = "Error: \(error.localizedDescription)"
                    self.putResponseLabel.textColor = .red
                }
            }
        }
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        Task {
            let response = AF.request(putUrl!,
                                      method: .delete,
                                      headers: [
                                        "x-api-key": "reqres-free-v1"
                                      ]).response { response in
                                          if(response.response?.statusCode == 204) {
                                              DispatchQueue.main.async {
                                                  self.deleteResponseLabel.text = "Deleted"
                                              }
                                          } else {
                                              self.deleteResponseLabel.text = "Failed to Delete"
                                          }
                                      }
            
        }
    }
}
