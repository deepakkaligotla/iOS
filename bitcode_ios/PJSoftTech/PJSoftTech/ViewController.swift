//
//  ViewController.swift
//  PJSoftTech
//
//  Created by Deepak Kaligotla on 07/05/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        if(email.text! != "" && password.text! != "") {
            let url = "https://pjsofttech.in:1044/signin?email="+email.text!+"&password="+password.text!
            
            var urlRequest = URLRequest(url: URL(string: url)!)
            
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("text/plain", forHTTPHeaderField: "Accept")
            
            let urlSession = URLSession(configuration: .default)
            
            let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
                DispatchQueue.main.async {
                    if let httpResponse = response as? HTTPURLResponse {
                        if(httpResponse.statusCode == 200) {
                            self.loginStatus.text = "Login Successful"
                            self.loginStatus.textColor = .green
                        } else if(httpResponse.statusCode == 401) {
                            self.loginStatus.text = "Incorrect email or password"
                            self.loginStatus.textColor = .red
                        }
                    }
                    if let error = error {
                        print(error)
                        self.loginStatus.text = "Network issue"
                        self.loginStatus.textColor = .red
                        return
                    }
                }
            }
            dataTask.resume()
        }
    }
    
}

