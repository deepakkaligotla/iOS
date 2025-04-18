//
//  User.swift
//  WebServicesDemo6
//
//  Created by Deepak Kaligotla on 09/04/25.
//

struct User: Decodable {
    var id: Int
    var email: String
    var first_name: String
    var last_name: String
    var avatar: String
}
