//
//  AuthAPI.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 09/08/24.
//

import Alamofire
import SwiftUI

struct API {
    static func signIn(with request: SignInRequest, completion: @escaping (Result<SignInResponse, Error>) -> Void) {
        let url = "\(APIConfig.baseUrl)/api/v1/auth/signin"
        
        let parameters: [String: Any] = [
            "email": request.email,
            "password": request.password,
            "deviceToken": request.deviceToken,
            "userType": request.userType
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable(of: SignInResponse.self) { response in
                switch response.result {
                case .success(let signInResponse):
                    print("Sign In Response: \(signInResponse)")
                    completion(.success(signInResponse))
                case .failure(let error):
                    print("Sign In Error: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
    }
    
    static func fetchUsers(search: String, dutyStatus: String, fromDate: String, toDate: String, page: Int, limit: Int, completion: @escaping (Result<UserResponse, Error>) -> Void) {
        let url = "\(APIConfig.baseUrl)/api/v1/admin/AllUser"
        
        let parameters: [String: Any] = [
            "search": search,
            "dutyStatus": dutyStatus,
            "fromDate": fromDate,
            "toDate": toDate,
            "page": page,
            "limit": limit
        ]
        
        AF.request(url, method: .get, parameters: parameters)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    if let responseString = String(data: data, encoding: .utf8) {
                        print("Raw Response Data: \(responseString)")
                    }
                    do {
                        let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
                        print("Fetch Users Response: \(userResponse)")
                        completion(.success(userResponse))
                    } catch {
                        print("Decoding Error: \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    print("Fetch Users Error: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
    }
    
    static func removeTruckFromDriverProfile(truckId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let url = "\(APIConfig.baseUrl)/api/v1/admin/removeTruckFromDriverProfile/\(truckId)"
        
        AF.request(url, method: .put, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let responseObject):
                    if let responseBody = responseObject as? [String: Any] {
                        print("Remove Truck Success: \(responseBody)")
                        completion(.success(responseBody))
                    } else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response format"])))
                    }
                case .failure(let error):
                    print("Remove Truck Error: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
    }
    
    static func fetchDiagnosticAndMalfunctionEvents(completion: @escaping (Result<[DiagnosticAndMalfunctionEvent], Error>) -> Void) {
        let url = "\(APIConfig.baseUrl)/api/v1/DiagnosticAndMalfunctionEvents/allDiagnosticAndMalfunctionEvents"
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Raw Response Data: \(responseString)")
                }
                do {
                    let decoder = JSONDecoder()
                    let events = try decoder.decode([DiagnosticAndMalfunctionEvent].self, from: data)
                    completion(.success(events))
                } catch {
                    print("Decoding Error: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Fetch Events Error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
