//
//  UserRepository.swift
//  WebServicesDemo1
//
//  Created by Deepak Kaligotla on 31/03/25.
//

import Foundation

class UserRepository {
    func fetchUsers(completion: @escaping (Model?) -> Void) {
        guard let url = URL(string: "https://reqres.in/api/users?page=1") else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            do {
                let model = try JSONDecoder().decode(Model.self, from: data)
                completion(model)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }
        task.resume()
    }
}
