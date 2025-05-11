//
//  APIService.swift
//  Assignment08
//
//  Created by Deepak Kaligotla on 11/05/25.
//

import Foundation

class NetworkingService {
    static let shared = NetworkingService()
    
    func fetchJSONPlaceholderUsers(completion: @escaping ([JsonplaceholderUser]?, Error?) -> Void) {
        return URLSession.shared.dataTask(with:
                                            URLRequest(url:
                                                        URL(string: "https://jsonplaceholder.typicode.com/users")!
                                                      )
        ) { data, response, error in
            let jsonArray = try! JSONSerialization.jsonObject(with: data!, options: []) as? [[String: Any]]
            var users: [JsonplaceholderUser] = []
            for jsonObject in jsonArray! {
                let id = jsonObject["id"] as! Int
                let name = jsonObject["name"] as! String
                let username = jsonObject["username"] as! String
                let email = jsonObject["email"] as! String
                let phone = jsonObject["phone"] as! String
                let website = jsonObject["website"] as! String
                
                let addressDict = jsonObject["address"] as! [String: Any]
                let street = addressDict["street"] as! String
                let suite = addressDict["suite"] as! String
                let city = addressDict["city"] as! String
                let zipcode = addressDict["zipcode"] as! String
                let geoDict = addressDict["geo"] as! [String: Any]
                let lat = geoDict["lat"] as! String
                let lng = geoDict["lng"] as! String
                
                let companyDict = jsonObject["company"] as! [String: Any]
                let companyName = companyDict["name"] as! String
                let catchPhrase = companyDict["catchPhrase"] as! String
                let bs = companyDict["bs"] as! String
                
                let geo = Geo(lat: lat, lng: lng)
                let address = Address(street: street, suite: suite, city: city, zipcode: zipcode, geo: geo)
                let company = Company(name: companyName, catchPhrase: catchPhrase, bs: bs)
                users.append(JsonplaceholderUser(
                    id: id,
                    name: name,
                    username: username,
                    email: email,
                    address: address,
                    phone: phone,
                    website: website,
                    company: company))
            }
            DispatchQueue.main.async {
                completion(users, nil)
            }
        }.resume()
    }
    
    func fetchReqResUsers(completion: @escaping ([ResReqUser]?, Error?) -> Void) {
        return URLSession.shared.dataTask(with:
                                            URLRequest(url:
                                                        URL(string: "https://reqres.in/api/users?page=2")!
                                                      )
        ) { data, response, error in
            let apiResponse = try! JSONDecoder().decode(APIResponse.self, from: data!)
            DispatchQueue.main.async {
                completion(apiResponse.data, nil)
            }
        }.resume()
    }
}
