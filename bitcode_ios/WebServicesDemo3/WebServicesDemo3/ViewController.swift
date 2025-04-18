//
//  ViewController.swift
//  WebServicesDemo3
//
//  Created by Deepak Kaligotla on 04/04/25.
//

import UIKit

class ViewController: UIViewController {
    var photos: [Photo] = []
    var loginResponse: LoginResponse!

    override func viewDidLoad() {
        super.viewDidLoad()
//        jsonSerializationPhotos(url: URL(string: Constants.photosUrlString)!)
        jsonSerializationLogin(url: URL(string: Constants.loginUrlString)!)
    }

    func jsonSerializationPhotos(url: URL) {
        var urlRequest = URLRequest(url: url)
        var urlSession = URLSession(configuration: .default)
        let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
            let jsonResponse = try! JSONSerialization.jsonObject(with: data!) as! [[String: Any]]
            for eachPhoto in jsonResponse {
                self.photos.append(
                    Photo(
                        albumId: eachPhoto["albumId"] as! Int,
                        id: eachPhoto["id"] as! Int,
                        title: eachPhoto["title"] as! String,
                        url: eachPhoto["url"] as! String,
                        thumbnailUrl: eachPhoto["thumbnailUrl"] as! String
                    )
                )
            }
            self.photos.forEach { photo in
                print("\(photo)\n")
            }
        }
        dataTask.resume()
    }
    
    func jsonSerializationLogin(url: URL) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: [
            "email": "john@mail.com",
            "password": "changeme"
        ])
        let urlSession = URLSession(configuration: .default)
        let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
            let jsonResponse = try! JSONSerialization.jsonObject(with: data!) as! [String: Any]
            self.loginResponse = LoginResponse(
                access_token: jsonResponse["access_token"] as! String,
                refresh_token: jsonResponse["refresh_token"] as! String
            )
            
            var profileUrlRequest = URLRequest(url: URL(string: Constants.profileUrlString)!)
            print(self.loginResponse!.access_token)
            profileUrlRequest.setValue("Bearer \(self.loginResponse!.access_token)", forHTTPHeaderField: "Authorization")
            let profileUrlSession = URLSession(configuration: .default)
            let profileDataTask = profileUrlSession.dataTask(with: profileUrlRequest) { data, response, error in
                let jsonResponse = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                print(jsonResponse)
            }
            profileDataTask.resume()
        }
        dataTask.resume()
    }
}

