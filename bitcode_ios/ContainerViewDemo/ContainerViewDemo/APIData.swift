//
//  APIData.swift
//  ContainerViewDemo
//
//  Created by Deepak Kaligotla on 06/05/25.
//

import Foundation

struct Photo: Codable {
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
}

struct Product: Codable {
    var id: Int,
    var title: String,
    var price: Double,
    var description: String,
    var category: String,
    var image: String,
    var rating: Rating
}

struct Rating: Codable {
    var rate: Double
    var count: Int
}

class APIData {
    func getAPIResponse() async -> [Int: [Photo]] {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")!
        do {
            let (data, _) = try await session.data(from: url)
            print("Downloaded: \(data.count) bytes")
            let allPhotos = try JSONDecoder().decode([Photo].self, from: data)
            let grouped = Dictionary(grouping: allPhotos, by: { $0.albumId })
            return grouped
        } catch {
            print("Error fetching or decoding: \(error)")
            return [:]
        }
    }
}
