//
//  APIResponse.swift
//  Test3
//
//  Created by Deepak Kaligotla on 05/05/25.
//

struct APIResponse: Decodable {
    var comments: [Comment]
    var total: Int
    var skip: Int
    var limit: Int
}
