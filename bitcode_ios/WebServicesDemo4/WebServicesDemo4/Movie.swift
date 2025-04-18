//
//  Movie.swift
//  WebServicesDemo4
//
//  Created by Deepak Kaligotla on 07/04/25.
//

struct Movie: Decodable {
    var id: Int
    var title: String
    var year: Int
    var genre: [String]
    var rating: Double
    var director: String
    var actors: [String]
    var plot: String
    var poster: String
    var trailer: String
    var runtime: Int
    var awards: String
    var country: String
    var language: String
    var boxOffice: String
    var production: String
    var website: String
}
