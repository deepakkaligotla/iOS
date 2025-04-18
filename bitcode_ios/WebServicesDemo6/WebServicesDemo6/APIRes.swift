//
//  APIResponse.swift
//  WebServicesDemo6
//
//  Created by Deepak Kaligotla on 09/04/25.
//

struct APIResponse: Decodable {
    var page: Int
    var per_page: Int
    var total: Int
    var total_pages: Int
    var data: [User]
    var support: Support
}

struct APIResponseByUserId: Decodable {
    var data: User
    var support: Support
}
