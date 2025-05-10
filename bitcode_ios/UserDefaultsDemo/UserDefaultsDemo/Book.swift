//
//  Book.swift
//  UserDefaultsDemo
//
//  Created by Deepak Kaligotla on 05/05/25.
//

import Foundation

struct Book: Codable {
    var id: Int
    var title: String
    var author: String
    var price: Double
}
