//
//  Model.swift
//  WebServicesDemo1
//
//  Created by Deepak Kaligotla on 31/03/25.
//

struct User: Codable {
    let id: Int
    let email: String
    let first_name: String
    let last_name: String
    let avatar: String
}

struct Support: Codable {
    let url: String
    let text: String
}

struct Model: Codable {
    let page: Int
    let per_page: Int
    let total: Int
    let data: [User]
    let support: Support
}
